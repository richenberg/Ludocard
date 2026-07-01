ludusavi = Ludusavi
language = Sprache
game-name = Name
total-games = Spiele
file-size = Größe
file-location = Ort
overall = Insgesamt
status = Status
cli-unrecognized-games = Keine Informationen für diese Spiele:
cli-unable-to-request-confirmation = Bestätigung konnte nicht angefordert werden.
    .winpty-workaround = Falls du einen Bash-Emulator (wie Git Bash) verwendest, versuche winpty auszuführen.
cli-backup-id-with-multiple-games = Sicherungs-ID kann nicht angegeben werden, wenn mehrere Spiele wiederhergestellt werden.
cli-invalid-backup-id = Ungültige Sicherungs-ID.
badge-failed = FEHLGESCHLAGEN
badge-duplicates = DUPLIKATE
badge-duplicated = DUPLIZIERT
badge-ignored = IGNORIERT
badge-redirected-from = VON: { $path }
badge-redirecting-to = AN: { $path }
some-entries-failed = Einige Einträge konnten nicht verarbeitet werden. Suche innerhalb der Ausgabe nach { badge-failed } für Details. Überprüfe, ob du auf diese Dateien zugreifen kannst oder ob deren Pfade sehr lang sind.
cli-game-line-item-redirected = Umgeleitet von: { $path }
cli-game-line-item-redirecting = Umleiten an: { $path }
button-backup = Sichern
button-preview = Vorschau
button-restore = Wiederherstellen
button-nav-backup = SICHERUNGSMODUS
button-nav-restore = WIEDERHERSTELLUNGSMODUS
button-nav-custom-games = BENUTZERDEFINIERTE SPIELE
button-nav-other = ANDERE
button-add-game = Spiel hinzufügen
button-continue = Weiter
button-cancel = Abbrechen
button-cancelling = Abbrechen...
button-okay = Okay
button-select-all = Alle auswählen
button-deselect-all = Alle abwählen
button-enable-all = Alle aktivieren
button-disable-all = Alle deaktivieren
button-customize = Anpassen
button-exit = Verlassen
button-comment = Kommentieren
button-lock = Sperren
button-unlock = Entsperren
# This opens a download page.
button-get-app = { $app } holen
button-validate = Überprüfen
button-override-manifest = Manifest überschreiben
button-extend-manifest = Manifest erweitern
button-sort = Sortieren
button-download = Herunterladen
button-upload = Hochladen
button-ignore = Ignorieren
no-roots-are-configured = Füge einige Wurzelverzeichnisse hinzu, um weitere Daten zu sichern.
config-is-invalid = Fehler: Die Konfigurationsdatei ist ungültig.
manifest-is-invalid = Fehler: Die Manifest-Datei ist ungültig.
manifest-cannot-be-updated = Fehler: Die Manifest-Datei konnte nicht auf eine Aktualisierung überprüft werden. Besteht eine Internetverbindung?
cannot-prepare-backup-target = Fehler: Das Sicherungsziel kann nicht vorbereitet werden (entweder beim Erstellen oder Leeren des Ordners). Falls du den Ordner in deinem Dateibrowser geöffnet hast, versuche diesen zu schließen: { $path }
restoration-source-is-invalid = Fehler: Die Wiederherstellungsquelle ist ungültig (entweder sie existiert nicht oder ist kein Verzeichnis). Bitte überprüfe den Speicherort: { $path }
registry-issue = Fehler: Einige Registrierungseinträge wurden übersprungen.
unable-to-browse-file-system = Fehler: Dateisystem kann nicht durchsucht werden.
unable-to-open-directory = Fehler: Verzeichnis konnte nicht geöffnet werden:
unable-to-open-url = Fehler: Kann URL nicht öffnen:
unable-to-configure-cloud = Cloud konnte nicht konfiguriert werden.
unable-to-synchronize-with-cloud = Cloud konnte nicht synchronisiert werden.
cloud-synchronize-conflict = Deine lokalen und Cloud-Backups stehen im Konflikt. Führe einen Upload oder Download durch, um das Problem zu lösen.
command-unlaunched = Befehl wurde nicht gestartet: { $command }
command-terminated = Befehl wurde abrupt beendet: { $command }
command-failed = Befehl fehlgeschlagen mit Code { $code }: { $command }
processed-games =
    { $total-games } { $total-games ->
        [one] Spiel
       *[other] Spiele
    }
processed-games-subset =
    { $processed-games } von { $total-games } { $total-games ->
        [one] Spiel
       *[other] Spiele
    }
processed-size-subset = { $processed-size } von { $total-size }
field-backup-target = Sichern nach:
field-restore-source = Wiederherstellen von:
field-custom-files = Pfade:
field-custom-registry = Registry:
field-sort = Sortierung:
field-redirect-source =
    .placeholder = Quelle (Originalort)
field-redirect-target =
    .placeholder = Ziel (neuer Ort)
field-roots = Wurzelverzeichnisse:
field-backup-excluded-items = Sicherungsausschlüsse:
field-redirects = Umleitungen:
# This appears next to the number of full backups that you'd like to keep.
# A full backup includes all save files for a game.
field-retention-full = Komplett:
# This appears next to the number of differential backups that you'd like to keep.
# A differential backup includes only the files that have changed since the last full backup.
field-retention-differential = Differenz:
field-backup-format = Format:
field-backup-compression = Komprimierung:
# The compression level determines how much compresison we perform.
field-backup-compression-level = Stufe:
label-manifest = Manifest
# This shows the time when we checked for an update to the manifest.
label-checked = Überprüft
# This shows the time when we found an update to the manifest.
label-updated = Aktualisiert
label-new = Neu
label-removed = Entfernt
label-comment = Kommentar
label-unchanged = Unverändert
label-backup = Sicherung
label-scan = Scan
label-filter = Filter
label-unique = Einzigartig
label-complete = Vollständig
label-partial = Teilweise
label-enabled = Aktiviert
label-disabled = Deaktiviert
# https://en.wikipedia.org/wiki/Thread_(computing)
label-threads = Threads
label-cloud = Cloud
# A "remote" is what Rclone calls cloud systems like Google Drive.
label-remote = Remote
label-remote-name = Remote-Name
label-folder = Ordner
# An executable file
label-executable = Ausführbare Datei
# Options given to a command line program
label-arguments = Argumente
label-url = URL
# https://en.wikipedia.org/wiki/Host_(network)
label-host = Host
# https://en.wikipedia.org/wiki/Port_(computer_networking)
label-port = Port
label-username = Nutzername
label-password = Passwort
# This is a specific website or service that provides some cloud functionality.
# For example, Nextcloud and Owncloud are providers of WebDAV services.
label-provider = Provider
label-custom = Benutzerdefiniert
label-none = Keiner
label-change-count = Änderungen: { $total }
label-unscanned = Ungescannt
# This refers to a local file on the computer
label-file = Datei
label-game = Spiel
# Aliases are alternative titles for the same game.
label-alias = Alias
label-original-name = Originalname
# Which manifest a game's data came from
label-source = Quelle
# This refers to the main Ludusavi manifest: https://github.com/mtkennerly/ludusavi-manifest
label-primary-manifest = Primäres Manifest
# This refers to how we integrate a custom game with the manifest data.
label-integration = Integration
# This is a folder name where a specific game is installed
label-installed-name = Installation
store-ea = EA
store-epic = Epic
store-gog = GOG
store-gog-galaxy = GOG Galaxy
store-heroic = Heroic
store-legendary = Legendary
store-lutris = Lutris
store-microsoft = Microsoft
store-origin = Origin
store-prime = Prime Gaming
store-steam = Steam
store-uplay = Uplay
store-other-home = Home-Ordner
# This would be a folder acting as a virtual C: drive, created by Wine.
store-other-wine = Wine-Präfix
# This would be a folder with typical Windows system folders,
# like "Program Files (x86)" and "Users".
store-other-windows = Windows-Laufwerk
# This would be a folder with typical Linux system folders,
# like "home" and "opt".
store-other-linux = Linux-Laufwerk
# This would be a folder with typical Mac system folders,
# like "Applications" and "Users".
store-other-mac = Mac-Laufwerk
store-other = Sonstiges
backup-format-simple = Einfach
backup-format-zip = Zip
compression-none = Keiner
# "Deflate" is a proper noun: https://en.wikipedia.org/wiki/Deflate
compression-deflate = Deflate
compression-bzip2 = Bzip2
compression-zstd = Zstd
theme = Aussehen
theme-light = Hell
theme-dark = Dunkel
redirect-bidirectional = Bidirektional
reverse-redirects-when-restoring = Beim Wiederherstellen die Reihenfolge der Umleitungen umkehren
show-disabled-games = Deaktivierte Spiele anzeigen
show-unchanged-games = Unveränderte Spiele anzeigen
show-unscanned-games = Ungescannte Spiele anzeigen
override-max-threads = Max. Threads übergehen
synchronize-automatically = Automatisch synchronisieren
prefer-alias-display = Alias statt Originalnamen anzeigen
skip-unconstructive-backups = Backup überspringen, wenn nur Daten entfernt werden würden, anstatt hinzugefügt oder geändert zu werden
explanation-for-exclude-store-screenshots = Storespezifische Bildschirmfotos aus Datensicherungen ausschießen
explanation-for-exclude-cloud-games = Auf diesen Plattformen keine Spiele mit Cloud-Unterstützung sichern
consider-doing-a-preview =
    Falls du es noch nicht getan hast, erwäge zuerst eine Vorschau zu machen, damit
    keine Überraschungen gibt.
confirm-backup =
    Bist du sicher, dass du mit der Sicherung fortfahren möchtest? { $path-action ->
        [merge] Neue Spielstanddaten werden mit dem Zielordner zusammengeführt:
       *[create] Der Zielordner wird erstellt:
    }
confirm-restore =
    Bist du sicher, dass du mit der Wiederherstellung fortfahren möchtest?
    Dies überschreibt alle aktuellen Dateien mit den Sicherungen von hier:
confirm-cloud-upload =
    Möchtest du deine Cloud-Dateien mit deinen lokalen Dateien ersetzen?
    Deine Cloud-Dateien ({ $cloud-path }) werden zu einer exakten Kopie deiner lokalen Dateien ({ $local-path }).
    Dateien in der Cloud werden bei Bedarf aktualisiert oder gelöscht.
confirm-cloud-download =
    Möchtest du deine lokalen Dateien mit deinen Cloud-Dateien ersetzen?
    Deine lokalen Dateien ({ $local-path }) werden zu einer exakten Kopie deiner Cloud-Dateien ({ $cloud-path }).
    Lokale Dateien werden bei Bedarf aktualisiert oder gelöscht.
confirm-add-missing-roots = Diese Wurzelverzeichnisse hinzufügen?
no-missing-roots = Keine weiteren Wurzelverzeichnisse gefunden.
loading = Lädt …
preparing-backup-target = Sicherungsverzeichnis wird vorbereitet...
updating-manifest = Manifest wird aktualisiert...
no-cloud-changes = Keine zu sychronisierenden Änderungen
backups-are-valid = Deine Sicherungen sind gültig.
backups-are-invalid =
    Die Sicherungen dieser Spiele scheinen ungültig zu sein.
    Möchtest du für diese Spiele neue vollständige Sicherungen erstellen?
saves-found = Spielstanddaten gefunden.
no-saves-found = Keine Spielstanddaten gefunden.
# This is tacked on to form something like "Back up (no confirmation)",
# meaning we would perform an action without asking the user if they're sure.
suffix-no-confirmation = ohne Bestätigung
# This is shown when a setting will only take effect after closing and reopening Ludusavi.
suffix-restart-required = Neustart erforderlich
prefix-error = Fehler: { $message }
prefix-warning = Warnung: { $message }
cloud-app-unavailable = Cloud-Backups sind deaktiviert, da { $app } nicht verfügbar ist.
cloud-not-configured = Cloud-Backups sind deaktiviert, da kein Cloudsystem konfiguriert ist.
cloud-path-invalid = Cloud-Backups sind deaktiviert, da der Backup-Pfad ungültig ist.
game-is-unrecognized = Ludusavi erkennt dieses Spielt nicht.
game-has-nothing-to-restore = Dieses Spiel hat keine wiederherzustellende Sicherungskopie.
launch-game-after-error = Spiel trotzdem starten?
game-did-not-launch = Spiel konnte nicht gestartet werden.
backup-is-newer-than-current-data = The existing backup is newer than the current data.
backup-is-older-than-current-data = The existing backup is older than the current data.
back-up-specific-game =
    .confirm = Spielstanddaten für { $game } sichern?
    .failed = Spielstanddaten für { $game } konnten nicht gesichert werden.
restore-specific-game =
    .confirm = Spielstanddaten für { $game } wiederherstellen?
    .failed = Spielstanddaten für { $game } konnten nicht wiederhergestellt werden.
new-version-check = Automatisch nach Aktualisierungen der Anwendung suchen
new-version-available = Eine Anwendungsaktualisierung ist verfügbar: { $version }. Möchtest du die Versionshinweise ansehen?
custom-game-will-override = Dieses benutzerdefinierte Spiel überschreibt einen Manifest-Eintrag
custom-game-will-extend = Dieses benutzerdefinierte Spiel erweitert einen Manifest-Eintrag
operation-will-only-include-listed-games = Hiermit werden nur die derzeit aufgelisteten Spiele verarbeitet

ludocard-community-title = Save Share HUB
ludocard-community-desc = Teile und lade Community-Spielstände herunter
ludocard-btn-share-checkpoint = Spielstand teilen
ludocard-repo-disconnected = Community-Repository nicht verbunden
ludocard-repo-disconnected-desc = Um Community-Spielstände zu laden und deine eigenen zu teilen, musst du deine Supabase-URL und den öffentlichen Anon-Key in den Einstellungen konfigurieren.
ludocard-how-to-config = Konfiguration:
ludocard-config-step-1 = Erstelle ein kostenloses Projekt auf Supabase.
ludocard-config-step-2 = Erstelle die Tabellen durch Ausführen des SQL-Skripts in supabase/schema.sql.
ludocard-config-step-3 = Trage die API-URL und den Anon-Key in den Ludocard-Einstellungen ein.
ludocard-checkpoints = Checkpoints
ludocard-contributors = Mitwirkende
ludocard-search-placeholder = Nach Spiel oder Checkpoint suchen...
ludocard-sort-popular = Beliebt
ludocard-sort-recent-hub = Neueste
ludocard-sort-size-hub = Größe
ludocard-syncing-repo = Synchronisiere mit dem öffentlichen Repository...
ludocard-no-checkpoints-found = Keine Checkpoints gefunden
ludocard-no-checkpoints-available = Keine Checkpoints verfügbar
ludocard-search-terms-desc = Versuche es mit anderen Suchbegriffen.
ludocard-be-first-desc = Sei der Erste, der einen Community-Spielstand teilt!
ludocard-no-desc-provided = Keine detaillierte Beschreibung vorhanden.
ludocard-author-by = von
ludocard-zstd-verified = Enthält verifizierte zstd-Metadaten
ludocard-btn-install = Installieren
ludocard-btn-installing = Installiere...
ludocard-security-sandbox-title = Automatische Safe-Crash- und Sandbox-Sicherheit
ludocard-security-sandbox-desc = Beim Installieren eines Community-Spielstands erstellt Ludocard automatisch ein Backup deines aktuellen Spielstands. Falls etwas schiefgeht, kannst du das vorherige Backup aus dem Verlauf wiederherstellen.
ludocard-share-checkpoint-modal = Checkpoint teilen
ludocard-publish-progress-desc = Veröffentliche deine Spielstandsdatei für die Community.
ludocard-save-game-label = Spielstand *
ludocard-search-installed-game = Tippe, um nach einem installierten Spiel zu suchen...
ludocard-backup-version-label = Backup-Version *
ludocard-no-local-backups-desc = Für dieses Spiel wurden noch keine lokalen Backups erstellt. Erstelle zuerst ein Backup in der Spielkarte.
ludocard-checkpoint-title-label = Checkpoint-Titel *
ludocard-checkpoint-title-placeholder = Z. B. Vor Malenia oder Level 100 100% abgeschlossen
ludocard-checkpoint-author-label = Name des Autors
ludocard-checkpoint-author-placeholder = Z. B. Anonym
ludocard-checkpoint-desc-label = Beschreibung / Zusätzliche Hinweise
ludocard-checkpoint-desc-placeholder = Beschreibe Details wie Build, Level, wichtige Items oder den Fortschrittspunkt.
ludocard-checkpoint-tags-label = Checkpoint-Tags
ludocard-btn-cancel = Abbrechen
ludocard-btn-publishing = Veröffentliche...
ludocard-btn-publish = Checkpoint veröffentlichen
ludocard-detail-modal-desc = Zeige vollständige Checkpoint-Metadaten an.
ludocard-btn-close = Schließen
ludocard-btn-download-install = Herunterladen & Installieren
ludocard-detail-title-label = Checkpoint-Titel:
ludocard-detail-desc-label = Fortschrittsbeschreibung:
ludocard-detail-tags-label = Tags:
ludocard-detail-size-label = Komprimierte Größe:
ludocard-detail-downloads-label = Downloads gesamt:
ludocard-detail-author-label = Hochgeladen von:
ludocard-detail-date-label = Hochgeladen am:
ludocard-date-today = Heute
ludocard-date-yesterday = Gestern
ludocard-date-days-ago = Tage zuvor
ludocard-date-weeks-ago = Wochen zuvor
ludocard-date-locale = de-DE

ludocard-presethub-title = Preset Share HUB
ludocard-presethub-desc = Entdecke und teile Grafik- und Steuerungsoptimierungen aus der Community
ludocard-btn-share-preset = Preset teilen
ludocard-presethub-disconnected = Preset-Repository nicht verbunden
ludocard-presethub-disconnected-desc = Um Community-Presets zu laden und deine eigenen zu teilen, musst du deine Supabase-URL und den Anon-Key in den Einstellungen konfigurieren.
ludocard-presets = Presets
ludocard-preset-search-placeholder = Suche nach Spiel, Titel oder Hardware (z. B. RTX 4070)...
ludocard-syncing-presets = Synchronisiere Presets...
ludocard-no-presets-found = Keine Grafik-Presets gefunden
ludocard-search-terms-desc-preset = Versuche, deine Suchbegriffe zurückzusetzen.
ludocard-badge-official = Offiziell
ludocard-gpu = GPU
ludocard-approval = Bewertung
ludocard-useful = Nützlich
ludocard-useless = Unnütz
ludocard-report-preset = Preset melden
ludocard-btn-undo = Rückgängig
ludocard-btn-inject = Injizieren
ludocard-btn-injecting = Injiziere...
ludocard-not-installed = Nicht installiert
ludocard-security-safety-title = Sicherheit durch Safe-Crash garantiert
ludocard-security-safety-desc = Beim Herunterladen eines Grafik-Presets aus dem HUB sichert Ludocard deine vorherigen Einstellungen. Deine Spielstände bleiben unberührt.
ludocard-share-preset-modal-title = Grafik-Preset teilen
ludocard-share-preset-modal-desc = Sende ein lokales Grafik-Preset an die Community.
ludocard-preset-game-label = Spiel des Presets *
ludocard-search-installed-game-preset = Installiertes Spiel suchen...
ludocard-choose-local-preset-label = Lokales Preset auswählen *
ludocard-no-local-presets-desc = Keine lokalen Presets für dieses Spiel gespeichert. Erstelle zuerst ein lokales Preset in der Spielkarte!
ludocard-preset-title-label = Preset-Titel *
ludocard-preset-creator-label = Autor / Ersteller
ludocard-preset-desc-label = Beschreibung / Preset-Notizen
ludocard-preset-tags-label = Preset-Tags
ludocard-preset-hardware-label = Hardware des Autors (automatisch ausgefüllt):
ludocard-cpu = CPU
ludocard-ram = RAM
ludocard-btn-publish-preset = Preset veröffentlichen
ludocard-detail-preset-title = Preset-Titel:
ludocard-detail-preset-desc = Beschreibung / Optimierungen:
ludocard-detail-author-specs = Hardware des Autors:

ludocard-tag-desc-100 = Spiel zu 100% abgeschlossen mit allen Errungenschaften, Gegenständen und Sammelobjekten freigeschaltet.
ludocard-tag-desc-dlc1 = Fokus auf oder bereit für den ersten DLC.
ludocard-tag-desc-dlc2 = Fokus auf oder bereit für den zweiten DLC.
ludocard-tag-desc-ngplus = Bereit für oder bereits gestartet im Modus Neues Spiel+.
ludocard-tag-desc-vanilla = Fortschritt des Originalspiels komplett sauber, ohne Modifikatoren, Mods oder Cheats.
ludocard-tag-desc-modded = Fortschritt mit Modifikationen (Mods) erzielt, die das Gameplay verändern können.
ludocard-tag-desc-bossprep = Spielstand strategisch direkt vor einem wichtigen Boss platziert.
ludocard-tag-desc-starter = Spielstand am Anfang des Spiels, mit angesammelten Ressourcen oder übersprungenem Tutorial.
ludocard-tag-desc-cleanstart = Spielstand direkt nach der Charaktererstellung oder Einführung, bereit zum direkten Start.
ludocard-tag-desc-midgame = Spielstand in der Mitte der Hauptkampagne (ideal bei Fortschrittsverlust).
ludocard-tag-desc-postgame = Kampagne abgeschlossen, ideal zum Erkunden geheimer Bosse, ausstehender Errungenschaften oder Nebenaktivitäten.
ludocard-tag-desc-opbuild = Spielstand fokussiert auf einen Charakter mit extrem starker Ausrüstung, Level und Builds (Overpowered).
ludocard-tag-desc-unlimitedcash = Spielstand fokussiert auf maximales oder unendliches Geld, Münzen oder Upgrade-Ressourcen.
ludocard-tag-desc-allcollectibles = Spielstand mit Fokus auf sekundäre Errungenschaften und mühsame Sammelobjekte komplett freigeschaltet.
ludocard-tag-desc-hardcore = Spielstände auf extremem Schwierigkeitsgrad oder mit permanentem Tod aktiviert (Überleben).
ludocard-tag-desc-speedrunready = Spielstand ideal zum Trainieren von Speedrun-Abschnitten oder auf den schnellsten Routen platziert.
ludocard-tag-desc-legit = Fortschritt sauber erzielt, ohne Cheats, Cheat-Codes oder das Ausnutzen von Fehlern (Glitches).
ludocard-preset-tag-desc-perf = Optimierungen fokussiert auf FPS-Gewinn und Flüssigkeit.
ludocard-preset-tag-desc-quality = Optimierungen fokussiert auf maximale Grafikqualität.
ludocard-preset-tag-desc-balanced = Ideale Balance zwischen visueller Treue und FPS-Rate.
ludocard-preset-tag-desc-deck = Speziell für Bildschirm und Akku des Steam Decks/Handhelds optimiertes Profil.
ludocard-preset-tag-desc-potato = Zum Ausführen auf sehr alten PCs und bescheidenen Laptops.
ludocard-preset-tag-desc-controls = Benutzerdefiniertes Mapping von Steuerung, Gamepad oder Hotkeys.
ludocard-preset-tag-desc-rt = Verfeinerte Konfiguration mit aktivem Raytracing, ausgerichtet auf eine gute Bildrate.
ludocard-preset-tag-desc-4k = Optimierungen fokussiert auf 4K-Fernseher und -Monitore mit hoher Auflösung.
ludocard-preset-tag-desc-vr = Optimierte Einstellungen für eine ideale FPS-Rate in der virtuellen Realität.

ludocard-schedule-auto-routine = Automatische Backup-Routine
ludocard-schedule-auto-routine-desc = Lege fest, wann automatische Backups durchgeführt werden sollen.
ludocard-schedule-by-interval = Nach Intervall
ludocard-schedule-by-days = Wochentage
ludocard-schedule-backup-every = Backup erstellen alle
ludocard-schedule-1-hour = 1 Stunde
ludocard-schedule-3-hours = 3 Stunden
ludocard-schedule-6-hours = 6 Stunden
ludocard-schedule-12-hours = 12 Stunden
ludocard-schedule-24-hours = 24 Stunden
ludocard-schedule-at-time = Zur Uhrzeit
ludocard-schedule-games-in-schedule = Spiele im Zeitplan
ludocard-schedule-games-in-schedule-desc = Wähle aus, welche Spiele diesem automatischen Ablauf folgen sollen.
ludocard-schedule-btn-save = Zeitplan speichern
ludocard-schedule-saved-toast = Zeitplan erfolgreich gespeichert

ludocard-day-sun = So
ludocard-day-mon = Mo
ludocard-day-tue = Di
ludocard-day-wed = Mi
ludocard-day-thu = Do
ludocard-day-fri = Fr
ludocard-day-sat = Sa

ludocard-notification-alerts = Benachrichtigungen & Alarme
ludocard-notification-alerts-desc = Wähle aus, wie du über Backups informiert werden möchtest.
ludocard-notification-windows = Windows-Benachrichtigungen
ludocard-notification-windows-desc = Benachrichtigen, wenn ein Backup erfolgreich abgeschlossen wurde.
ludocard-notification-toast-enabled = Benachrichtigungen aktiviert
ludocard-notification-toast-disabled = Benachrichtigungen deaktiviert
ludocard-notification-fail-alerts = Fehlermeldungen
ludocard-notification-fail-alerts-desc = Sofort benachrichtigen, wenn ein Backup fehlschlägt.
ludocard-notification-toast-fail-enabled = Fehlermeldungen aktiviert
ludocard-notification-toast-fail-disabled = Fehlermeldungen deaktiviert
ludocard-notification-sounds = Hinweistöne
ludocard-notification-sounds-desc = Einen Ton abspielen, wenn ein Backup abgeschlossen wird oder fehlschlägt.
ludocard-notification-toast-sounds-enabled = Töne aktiviert
ludocard-notification-toast-sounds-disabled = Töne deaktiviert
