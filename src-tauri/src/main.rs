// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

mod commands;

fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .invoke_handler(tauri::generate_handler![
            commands::get_games,
            commands::scan_games,
            commands::get_game_details,
            commands::backup_game,
            commands::restore_game,
            commands::get_settings,
            commands::save_settings,
            commands::get_roots,
            commands::add_root,
            commands::remove_root,
            commands::select_folder,
            commands::open_game_folder,
        ])
        .run(tauri::generate_context!())
        .expect("error while running Ludocard");
}
