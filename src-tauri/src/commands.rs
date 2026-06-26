use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::sync::{LazyLock, Mutex};
use std::path::{Path, PathBuf};
use base64::Engine;
use tauri::Emitter;
use tauri::Manager;
use ludusavi::{
    api::{Ludusavi, parameters},
    prelude::{Finality, SyncDirection, StrictPath},
    report::ApiGame,
    resource::{SaveableResourceFile, config::Root, manifest::Store},
};

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FrontendBackupVersion {
    pub id: String,
    pub date: String,
    pub time: String,
    pub kind: String,
    #[serde(rename = "sizeMB")]
    pub size_mb: f64,
    pub cloud: bool,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FrontendGame {
    pub id: String,
    pub title: String,
    pub cover: String,
    pub platform: String,
    pub save_path: String,
    #[serde(rename = "sizeMB")]
    pub size_mb: f64,
    pub last_backup: String,
    pub status: String, // "ok" | "pending" | "never"
    pub auto_backup: bool,
    pub cloud_sync: bool,
    pub backups: Vec<FrontendBackupVersion>,
    pub installed: bool,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FrontendSettings {
    pub backup_path: String,
    pub rclone_path: String,
    pub cloud_path: String,
    pub cloud_sync: bool,
    pub rclone_arguments: String,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FrontendRoot {
    pub id: String,
    pub path: String,
    pub store: String,
}

// --- Scan cache: stores results of the last full filesystem scan ---
#[derive(Clone, Debug, Serialize, Deserialize)]
struct CachedScanInfo {
    save_path: String,
    size_bytes: u64,
    has_changes: bool,
}

static SCAN_CACHE: LazyLock<Mutex<HashMap<String, CachedScanInfo>>> =
    LazyLock::new(|| Mutex::new(HashMap::new()));

fn save_scan_cache(app_dir: &Path, cache: &HashMap<String, CachedScanInfo>) {
    let path = app_dir.join("scan_cache.json");
    if let Ok(content) = serde_json::to_string(cache) {
        let _ = std::fs::write(path, content);
    }
}

fn load_scan_cache(app_dir: &Path) -> HashMap<String, CachedScanInfo> {
    let path = app_dir.join("scan_cache.json");
    if let Ok(content) = std::fs::read_to_string(path) {
        if let Ok(cache) = serde_json::from_str(&content) {
            return cache;
        }
    }
    HashMap::new()
}

static COVER_CACHE: LazyLock<Mutex<HashMap<String, String>>> =
    LazyLock::new(|| Mutex::new(HashMap::new()));

fn slugify(name: &str) -> String {
    name.to_lowercase()
        .chars()
        .map(|c| if c.is_alphanumeric() { c } else { '-' })
        .collect::<String>()
        .split('-')
        .filter(|s| !s.is_empty())
        .collect::<Vec<_>>()
        .join("-")
}

fn get_game_cover(app_data_dir: Option<&Path>, slug: &str) -> String {
    let mock_slugs = [
        "aether-frontier",
        "ironclad-legion",
        "neon-drift",
        "hollow-pines",
        "starforge",
        "shadowveil",
        "pixel-knights",
    ];
    if mock_slugs.contains(&slug) {
        return format!("/covers/{}.png", slug);
    }

    {
        let cache = COVER_CACHE.lock().unwrap();
        if let Some(cached) = cache.get(slug) {
            return cached.clone();
        }
    }

    if let Some(dir) = app_data_dir {
        for ext in &["jpg", "png"] {
            let file_path = dir.join("covers").join(format!("{}.{}", slug, ext));
            if file_path.exists() {
                if let Ok(bytes) = std::fs::read(&file_path) {
                    let encoded = base64::engine::general_purpose::STANDARD.encode(&bytes);
                    let mime = if *ext == "png" { "image/png" } else { "image/jpeg" };
                    let base64_uri = format!("data:{};base64,{}", mime, encoded);

                    let mut cache = COVER_CACHE.lock().unwrap();
                    cache.insert(slug.to_string(), base64_uri.clone());
                    return base64_uri;
                }
            }
        }
    }

    "/placeholder.svg".to_string()
}

fn search_steam_app_id(client: &reqwest::blocking::Client, title: &str) -> Result<u32, String> {
    let resp = client
        .get("https://store.steampowered.com/api/storesearch/")
        .query(&[("term", title), ("l", "english"), ("cc", "US")])
        .send()
        .map_err(|e| e.to_string())?;

    if !resp.status().is_success() {
        return Err("Steam API search failed".to_string());
    }

    #[derive(Deserialize)]
    struct SteamSearchItem {
        id: u32,
    }

    #[derive(Deserialize)]
    struct SteamSearchResponse {
        items: Vec<SteamSearchItem>,
    }

    let result: SteamSearchResponse = resp.json().map_err(|e| e.to_string())?;
    if let Some(first) = result.items.first() {
        Ok(first.id)
    } else {
        Err("No matching steam game found".to_string())
    }
}

fn start_cover_downloads(
    app: &tauri::AppHandle,
    games_to_download: Vec<(String, String, Option<u32>)>,
) {
    if games_to_download.is_empty() {
        return;
    }

    static IS_DOWNLOADING: LazyLock<Mutex<bool>> = LazyLock::new(|| Mutex::new(false));

    let mut is_downloading = IS_DOWNLOADING.lock().unwrap();
    if *is_downloading {
        return;
    }
    *is_downloading = true;

    let app = app.clone();
    tokio::task::spawn_blocking(move || {
        let total = games_to_download.len();

        let _ = app.emit(
            "cover-download-progress",
            serde_json::json!({
                "downloading": true,
                "current": 0,
                "total": total,
                "percentage": 0,
            }),
        );

        let app_data_dir = match app.path().app_data_dir() {
            Ok(p) => p,
            Err(_) => {
                let mut active = IS_DOWNLOADING.lock().unwrap();
                *active = false;
                return;
            }
        };

        let covers_dir = app_data_dir.join("covers");
        if let Err(e) = std::fs::create_dir_all(&covers_dir) {
            println!("Failed to create covers dir: {:?}", e);
            let mut active = IS_DOWNLOADING.lock().unwrap();
            *active = false;
            return;
        }

        let client = reqwest::blocking::Client::builder()
            .timeout(std::time::Duration::from_secs(10))
            .build()
            .unwrap_or_default();

        for (i, (slug, title, steam_id)) in games_to_download.iter().enumerate() {
            let mut app_id = *steam_id;
            if app_id.is_none() {
                if let Ok(search_res) = search_steam_app_id(&client, title) {
                    app_id = Some(search_res);
                }
            }

            let mut downloaded = false;
            let mut base64_uri = String::new();

            if let Some(id) = app_id {
                let url = format!(
                    "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/{}/library_600x900.jpg",
                    id
                );
                if let Ok(resp) = client.get(&url).send() {
                    if resp.status().is_success() {
                        if let Ok(bytes) = resp.bytes() {
                            if bytes.len() > 1000 {
                                let file_path = covers_dir.join(format!("{}.jpg", slug));
                                if std::fs::write(&file_path, &bytes).is_ok() {
                                    let encoded = base64::engine::general_purpose::STANDARD.encode(&bytes);
                                    base64_uri = format!("data:image/jpeg;base64,{}", encoded);

                                    let mut cache = COVER_CACHE.lock().unwrap();
                                    cache.insert(slug.clone(), base64_uri.clone());
                                    downloaded = true;
                                }
                            }
                        }
                    }
                }
            }

            if downloaded {
                let _ = app.emit(
                    "cover-downloaded",
                    serde_json::json!({
                        "gameId": slug,
                        "cover": base64_uri,
                    }),
                );
            }

            let current = i + 1;
            let percentage = (current * 100) / total;
            let _ = app.emit(
                "cover-download-progress",
                serde_json::json!({
                    "downloading": current < total,
                    "current": current,
                    "total": total,
                    "percentage": percentage,
                }),
            );
        }

        let mut active = IS_DOWNLOADING.lock().unwrap();
        *active = false;
    });
}

/// Build a FrontendGame from a combination of scan data, backup data, and cached scan info.
fn build_frontend_game(
    app_data_dir: Option<&Path>,
    api: &Ludusavi,
    name: &str,
    scan_game: Option<&ApiGame>,
    backup_game: Option<&ApiGame>,
    cached_scan: Option<&CachedScanInfo>,
) -> FrontendGame {
    let display_title = api.config.display_name(name).to_string();
    let slug = slugify(name);

    let mut save_path = String::new();
    let mut size_bytes = 0u64;
    let mut has_changes = false;

    // Priority: live scan data > cached scan data
    if let Some(ApiGame::Operative { change, files, .. }) = scan_game {
        has_changes = change.is_changed();
        if let Some(first_path) = files.keys().next() {
            save_path = first_path.clone();
        }
        size_bytes = files.values().map(|f| f.bytes).sum();
    } else if let Some(cached) = cached_scan {
        save_path = cached.save_path.clone();
        size_bytes = cached.size_bytes;
        has_changes = cached.has_changes;
    }

    let mut backups_list = Vec::new();

    if let Some(ApiGame::Stored { backups, .. }) = backup_game {
        for b in backups {
            let local_time = b.when.with_timezone(&chrono::Local);
            let date_str = local_time.format("%d %b %Y").to_string();
            let time_str = local_time.format("%H:%M").to_string();

            backups_list.push(FrontendBackupVersion {
                id: b.name.clone(),
                date: date_str,
                time: time_str,
                kind: if b.locked { "Manual (Bloqueado)" } else { "Automático" }.to_string(),
                size_mb: 0.0,
                cloud: api.config.cloud.synchronize,
            });
        }
    }

    // Sort backups: latest first
    backups_list.reverse();

    let last_backup_str = if let Some(latest) = backups_list.first() {
        format!("{}, {}", latest.date, latest.time)
    } else {
        "Nunca".to_string()
    };

    let cover_path = get_game_cover(app_data_dir, &slug);

    // Determine platform from manifest metadata
    let mut platform = "Steam".to_string();
    if let Some(game_meta) = api.manifest.0.get(name) {
        if game_meta.steam.id.is_some() {
            platform = "Steam".to_string();
        } else if game_meta.gog.id.is_some() {
            platform = "GOG".to_string();
        } else if !game_meta.files.is_empty() {
            platform = "Epic".to_string();
        }
    }

    let auto_backup = api.config.is_game_enabled_for_backup(name);
    let cloud_sync = api.config.cloud.synchronize;

    let status = if backups_list.is_empty() {
        "never".to_string()
    } else if has_changes {
        "pending".to_string()
    } else {
        "ok".to_string()
    };

    let installed = !save_path.is_empty();

    FrontendGame {
        id: slug,
        title: display_title,
        cover: cover_path,
        platform,
        save_path,
        size_mb: (size_bytes as f64) / (1024.0 * 1024.0),
        last_backup: last_backup_str,
        status,
        auto_backup,
        cloud_sync,
        backups: backups_list,
        installed,
    }
}

/// Fast load: only reads backup directory structure + merges cached scan data.
/// Does NOT scan the filesystem for saves (that's what scan_games does).
#[tauri::command]
pub async fn get_games(app: tauri::AppHandle) -> Result<Vec<FrontendGame>, String> {
    tokio::task::spawn_blocking(move || {
        let api = Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        let backups_output = api
            .list_backups(parameters::ListBackups { games: vec![] })
            .map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        let app_data_dir = app.path().app_data_dir().ok();
        let mut cache = SCAN_CACHE.lock().unwrap();
        if cache.is_empty() {
            if let Some(ref dir) = app_data_dir {
                *cache = load_scan_cache(dir);
            }
        }

        // Collect all known game names from backups + scan cache
        let mut all_names: std::collections::BTreeSet<String> = std::collections::BTreeSet::new();
        for name in backups_output.games.keys() {
            all_names.insert(name.clone());
        }
        for name in cache.keys() {
            all_names.insert(name.clone());
        }

        let mut frontend_games = Vec::new();
        let mut games_to_download = Vec::new();

        for name in &all_names {
            let backup_game = backups_output.games.get(name);
            let cached_scan = cache.get(name);
            let fg = build_frontend_game(
                app_data_dir.as_deref(),
                &api,
                name,
                None, // no live scan data
                backup_game,
                cached_scan,
            );

            if fg.cover == "/placeholder.svg" {
                let mut steam_id = None;
                if let Some(game_meta) = api.manifest.0.get(name) {
                    if let Some(sid) = game_meta.steam.id {
                        steam_id = Some(sid);
                    }
                }
                games_to_download.push((fg.id.clone(), name.clone(), steam_id));
            }

            frontend_games.push(fg);
        }

        if !games_to_download.is_empty() {
            start_cover_downloads(&app, games_to_download);
        }

        Ok(frontend_games)
    })
    .await
    .map_err(|e| e.to_string())?
}

/// Full filesystem scan: scans all save paths from the manifest.
/// Caches scan results and returns the merged game list.
/// This is the slow operation - only call on user demand.
#[tauri::command]
pub async fn scan_games(app: tauri::AppHandle) -> Result<Vec<FrontendGame>, String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        // Full preview backup scan (reads all save paths on disk)
        let scan_output = api
            .back_up(parameters::BackUp {
                games: vec![],
                finality: Finality::Preview,
                resolve_cloud_conflict: None,
                wine_prefix: None,
                include_disabled: true,
                skip_downgrade: false,
            })
            .map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        // Also get backup info
        let backups_output = api
            .list_backups(parameters::ListBackups { games: vec![] })
            .map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        let app_data_dir = app.path().app_data_dir().ok();

        // Update the scan cache with live data
        {
            let mut cache = SCAN_CACHE.lock().unwrap();
            cache.clear();
            for (name, game_data) in &scan_output.games {
                if let ApiGame::Operative {
                    change, files, ..
                } = game_data
                {
                    let first_path = files.keys().next().cloned().unwrap_or_default();
                    let total_bytes: u64 = files.values().map(|f| f.bytes).sum();
                    cache.insert(
                        name.clone(),
                        CachedScanInfo {
                            save_path: first_path,
                            size_bytes: total_bytes,
                            has_changes: change.is_changed(),
                        },
                    );
                }
            }
            if let Some(ref dir) = app_data_dir {
                save_scan_cache(dir, &cache);
            }
        }

        // Build combined results
        let mut all_names: std::collections::BTreeSet<String> = std::collections::BTreeSet::new();
        for name in scan_output.games.keys() {
            all_names.insert(name.clone());
        }
        for name in backups_output.games.keys() {
            all_names.insert(name.clone());
        }

        let cache = SCAN_CACHE.lock().unwrap();
        let mut frontend_games = Vec::new();
        let mut games_to_download = Vec::new();

        for name in &all_names {
            let scan_game = scan_output.games.get(name);
            let backup_game = backups_output.games.get(name);
            let cached_scan = cache.get(name);
            let fg = build_frontend_game(
                app_data_dir.as_deref(),
                &api,
                name,
                scan_game,
                backup_game,
                cached_scan,
            );

            if fg.cover == "/placeholder.svg" {
                let mut steam_id = None;
                if let Some(game_meta) = api.manifest.0.get(name) {
                    if let Some(sid) = game_meta.steam.id {
                        steam_id = Some(sid);
                    }
                }
                games_to_download.push((fg.id.clone(), name.clone(), steam_id));
            }

            frontend_games.push(fg);
        }

        if !games_to_download.is_empty() {
            start_cover_downloads(&app, games_to_download);
        }

        Ok(frontend_games)
    })
    .await
    .map_err(|e| e.to_string())?
}

/// Fetch detailed info for a single game. Runs a targeted scan (very fast).
#[tauri::command]
pub async fn get_game_details(app: tauri::AppHandle, game_title: String) -> Result<Option<FrontendGame>, String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        // Scan only this specific game (fast, ~100ms)
        let scan_output = api
            .back_up(parameters::BackUp {
                games: vec![game_title.clone()],
                finality: Finality::Preview,
                resolve_cloud_conflict: None,
                wine_prefix: None,
                include_disabled: true,
                skip_downgrade: false,
            })
            .ok();

        let backups_output = api
            .list_backups(parameters::ListBackups {
                games: vec![game_title],
            })
            .ok();

        // Find the resolved game name from either output
        let name = scan_output
            .as_ref()
            .and_then(|o| o.games.keys().next())
            .or_else(|| backups_output.as_ref().and_then(|o| o.games.keys().next()));

        let Some(name) = name else {
            return Ok(None);
        };

        let name = name.clone();
        let scan_game = scan_output.as_ref().and_then(|o| o.games.get(&name));
        let backup_game = backups_output.as_ref().and_then(|o| o.games.get(&name));

        let app_data_dir = app.path().app_data_dir().ok();

        let fg = build_frontend_game(
            app_data_dir.as_deref(),
            &api,
            &name,
            scan_game,
            backup_game,
            None,
        );

        if fg.cover == "/placeholder.svg" {
            let mut steam_id = None;
            if let Some(game_meta) = api.manifest.0.get(&name) {
                if let Some(sid) = game_meta.steam.id {
                    steam_id = Some(sid);
                }
            }
            start_cover_downloads(&app, vec![(fg.id.clone(), name.clone(), steam_id)]);
        }

        Ok(Some(fg))
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn backup_game(game_title: String) -> Result<String, String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        let result = api
            .back_up(parameters::BackUp {
                games: vec![game_title],
                finality: Finality::Final,
                resolve_cloud_conflict: Some(SyncDirection::Upload),
                wine_prefix: None,
                include_disabled: true,
                skip_downgrade: false,
            })
            .map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        Ok(serde_json::to_string(&result).unwrap_or_default())
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn restore_game(game_title: String, backup_id: Option<String>) -> Result<String, String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        let result = api
            .restore(parameters::Restore {
                games: vec![game_title],
                finality: Finality::Final,
                backup: backup_id,
                resolve_cloud_conflict: Some(SyncDirection::Download),
                include_disabled: true,
                skip_downgrade: false,
            })
            .map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        Ok(serde_json::to_string(&result).unwrap_or_default())
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn get_settings() -> Result<FrontendSettings, String> {
    tokio::task::spawn_blocking(|| {
        let api = Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;
        Ok(FrontendSettings {
            backup_path: api.config.backup.path.raw().to_string(),
            rclone_path: api.config.apps.rclone.path.raw().to_string(),
            cloud_path: api.config.cloud.path.clone(),
            cloud_sync: api.config.cloud.synchronize,
            rclone_arguments: api.config.apps.rclone.arguments.clone(),
        })
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn save_settings(settings: FrontendSettings) -> Result<(), String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;

        api.config.backup.path = StrictPath::new(settings.backup_path);
        api.config.apps.rclone.path = StrictPath::new(settings.rclone_path);
        api.config.cloud.path = settings.cloud_path;
        api.config.cloud.synchronize = settings.cloud_sync;
        api.config.apps.rclone.arguments = settings.rclone_arguments;

        api.config.save();
        Ok(())
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn get_roots() -> Result<Vec<FrontendRoot>, String> {
    tokio::task::spawn_blocking(|| {
        let mut api = Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;
        
        // Autodetect roots if the list is empty
        if api.config.roots.is_empty() {
            let detected = autodetect_launchers();
            if !detected.is_empty() {
                for (path, store) in detected {
                    api.config.roots.push(Root::new(path, store));
                }
                let _ = api.config.save();
            }
        }

        let mut roots = Vec::new();
        for (i, r) in api.config.roots.iter().enumerate() {
            roots.push(FrontendRoot {
                id: format!("r{}", i),
                path: r.path().raw().to_string(),
                store: format!("{:?}", r.store()),
            });
        }
        Ok(roots)
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn open_game_folder(
    game_title: String,
    folder_type: String,
    save_path: String,
) -> Result<(), String> {
    tokio::task::spawn_blocking(move || {
        let api = Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;
        
        let path_to_open = match folder_type.as_str() {
            "save" => {
                if save_path.is_empty() {
                    return Err("Nenhum caminho de save disponível para abrir.".to_string());
                }
                let path = PathBuf::from(save_path);
                if path.is_file() || (path.extension().is_some() && path.parent().is_some()) {
                    path.parent().map(|p| p.to_path_buf()).unwrap_or(path)
                } else {
                    path
                }
            }
            "backup" => {
                let backup_base = api.config.backup.path.raw();
                if backup_base.is_empty() {
                    return Err("Diretório de backup não configurado.".to_string());
                }
                // Ludosavi stores game backups in {backup_base}/games/{game_title}
                let game_backup_path = Path::new(&backup_base).join("games").join(&game_title);
                game_backup_path
            }
            "game" => {
                let mut resolved_path = None;
                
                // Heuristic A: check configured roots
                for root in &api.config.roots {
                    let root_path = Path::new(root.path().raw());
                    if root_path.exists() {
                        let direct = root_path.join(&game_title);
                        if direct.exists() && direct.is_dir() {
                            resolved_path = Some(direct);
                            break;
                        }
                        let slug = slugify(&game_title);
                        let slugified = root_path.join(&slug);
                        if slugified.exists() && slugified.is_dir() {
                            resolved_path = Some(slugified);
                            break;
                        }
                    }
                }
                
                // Heuristic B: Check Steam Registry (Windows only)
                if resolved_path.is_none() {
                    #[cfg(target_os = "windows")]
                    {
                        use winreg::enums::*;
                        use winreg::RegKey;
                        let hkcu = RegKey::predef(HKEY_CURRENT_USER);
                        if let Ok(steam_key) = hkcu.open_subkey("Software\\Valve\\Steam") {
                            if let Ok(steam_path) = steam_key.get_value::<String, _>("SteamPath") {
                                let path = Path::new(&steam_path).join("steamapps").join("common").join(&game_title);
                                if path.exists() && path.is_dir() {
                                    resolved_path = Some(path);
                                }
                            }
                        }
                    }
                }
                
                match resolved_path {
                    Some(p) => p,
                    None => return Err(format!("Não foi possível localizar a pasta de instalação para: {}.", game_title)),
                }
            }
            _ => return Err("Tipo de pasta inválido.".to_string()),
        };
        
        if !path_to_open.exists() {
            return Err(format!("O diretório especificado não existe ou ainda não foi criado: {:?}", path_to_open));
        }
        
        opener::open(&path_to_open).map_err(|e| e.to_string())?;
        Ok(())
    })
    .await
    .map_err(|e| e.to_string())?
}

fn autodetect_launchers() -> Vec<(StrictPath, Store)> {
    let mut detected = Vec::new();

    #[cfg(target_os = "windows")]
    {
        use winreg::enums::*;
        use winreg::RegKey;

        // 1. Steam
        let hkcu = RegKey::predef(HKEY_CURRENT_USER);
        if let Ok(steam_key) = hkcu.open_subkey("Software\\Valve\\Steam") {
            if let Ok(steam_path) = steam_key.get_value::<String, _>("SteamPath") {
                let path = Path::new(&steam_path).join("steamapps").join("common");
                if path.exists() {
                    detected.push((StrictPath::new(path.to_string_lossy().to_string()), Store::Steam));
                }
            }
        }

        // 2. GOG Galaxy
        let hklm = RegKey::predef(HKEY_LOCAL_MACHINE);
        if let Ok(gog_key) = hklm.open_subkey("SOFTWARE\\WOW6432Node\\GOG.com\\GalaxyClient\\paths") {
            if let Ok(gog_path) = gog_key.get_value::<String, _>("client") {
                let path = Path::new(&gog_path);
                if path.exists() {
                    detected.push((StrictPath::new(path.to_string_lossy().to_string()), Store::Gog));
                }
            }
        }

        for path in &["C:\\Program Files (x86)\\GOG Galaxy\\Games", "C:\\GOG Games"] {
            let p = Path::new(path);
            if p.exists() {
                detected.push((StrictPath::new(p.to_string_lossy().to_string()), Store::Gog));
            }
        }

        // 3. Epic Games
        for path in &["C:\\Program Files\\Epic Games", "C:\\Program Files (x86)\\Epic Games"] {
            let p = Path::new(path);
            if p.exists() {
                detected.push((StrictPath::new(p.to_string_lossy().to_string()), Store::Epic));
            }
        }
    }

    detected
}

#[tauri::command]
pub async fn add_root(path: String) -> Result<(), String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;
        let strict_path = StrictPath::new(path);
        let new_root = Root::new(strict_path, Store::Other);
        api.config.roots.push(new_root);
        api.config.save();
        Ok(())
    })
    .await
    .map_err(|e| e.to_string())?
}

#[tauri::command]
pub async fn remove_root(path: String) -> Result<(), String> {
    tokio::task::spawn_blocking(move || {
        let mut api =
            Ludusavi::load().map_err(|e| ludusavi::lang::TRANSLATOR.handle_error(&e))?;
        api.config.roots.retain(|r| r.path().raw() != path);
        api.config.save();
        Ok(())
    })
    .await
    .map_err(|e| e.to_string())?
}

/// Opens the native OS folder picker dialog.
/// Uses a dedicated OS thread (not the Tokio runtime) to ensure proper
/// COM STA (Single Threaded Apartment) threading on Windows.
#[tauri::command]
pub async fn select_folder() -> Result<Option<String>, String> {
    let handle = std::thread::spawn(|| rfd::FileDialog::new().pick_folder());
    let result = handle
        .join()
        .map_err(|_| "Falha ao abrir o seletor de pastas".to_string())?;
    Ok(result.map(|f| f.to_string_lossy().to_string()))
}
