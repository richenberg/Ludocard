ludusavi = Ludusavi

language = Language
game-name = Name
total-games = Games
file-size = Size
file-location = Location
overall = Overall
status = Status

cli-unrecognized-games = No info for these games:
cli-unable-to-request-confirmation = Unable to request confirmation.
    .winpty-workaround = If you are using a Bash emulator (like Git Bash), try running winpty.
cli-backup-id-with-multiple-games = Cannot specify backup ID when restoring multiple games.
cli-invalid-backup-id = Invalid backup ID.

badge-failed = FAILED
badge-duplicates = DUPLICATES
badge-duplicated = DUPLICATED
badge-ignored = IGNORED
badge-redirected-from = FROM: {$path}
badge-redirecting-to = TO: {$path}

some-entries-failed = Some entries failed to process; look for {badge-failed} in the output for details. Double check whether you can access those files or whether their paths are very long.

cli-game-line-item-redirected = Redirected from: {$path}
cli-game-line-item-redirecting = Redirecting to: {$path}

button-backup = Back up
button-preview = Preview
button-restore = Restore
button-nav-backup = BACKUP MODE
button-nav-restore = RESTORE MODE
button-nav-custom-games = CUSTOM GAMES
button-nav-other = OTHER
button-add-game = Add game
button-continue = Continue
button-cancel = Cancel
button-cancelling = Cancelling...
button-okay = Okay
button-select-all = Select all
button-deselect-all = Deselect all
button-enable-all = Enable all
button-disable-all = Disable all
button-customize = Customize
button-exit = Exit
button-comment = Comment
button-lock = Lock
button-unlock = Unlock
# This opens a download page.
button-get-app = Get {$app}
button-validate = Validate
button-override-manifest = Override manifest
button-extend-manifest = Extend manifest
button-sort = Sort
button-download = Download
button-upload = Upload
button-ignore = Ignore

no-roots-are-configured = Add some roots to back up even more data.

config-is-invalid = Error: The config file is invalid.
manifest-is-invalid = Error: The manifest file is invalid.
manifest-cannot-be-updated = Error: Unable to check for an update to the manifest file. Is your Internet connection down?
cannot-prepare-backup-target = Error: Unable to prepare backup target (either creating or emptying the folder). If you have the folder open in your file browser, try closing it: {$path}
restoration-source-is-invalid = Error: The restoration source is invalid (either doesn't exist or isn't a directory). Please double check the location: {$path}
registry-issue = Error: Some registry entries were skipped.
unable-to-browse-file-system = Error: Unable to browse on your system.
unable-to-open-directory = Error: Unable to open directory:
unable-to-open-url = Error: Unable to open URL:
unable-to-configure-cloud = Unable to configure cloud.
unable-to-synchronize-with-cloud = Unable to synchronize with cloud.
cloud-synchronize-conflict = Your local and cloud backups are in conflict. Perform an upload or download to resolve this.

command-unlaunched = Command did not launch: {$command}
command-terminated = Command terminated abruptly: {$command}
command-failed = Command failed with code {$code}: {$command}

processed-games = {$total-games} {$total-games ->
    [one] game
    *[other] games
}
processed-games-subset = {$processed-games} of {$total-games} {$total-games ->
    [one] game
    *[other] games
}
processed-size-subset = {$processed-size} of {$total-size}

field-backup-target = Back up to:
field-restore-source = Restore from:
field-custom-files = Paths:
field-custom-registry = Registry:
field-sort = Sort:
field-redirect-source =
    .placeholder = Source (original location)
field-redirect-target =
    .placeholder = Target (new location)
field-roots = Roots:
field-backup-excluded-items = Backup exclusions:
field-redirects = Redirects:
# This appears next to the number of full backups that you'd like to keep.
# A full backup includes all save files for a game.
field-retention-full = Full:
# This appears next to the number of differential backups that you'd like to keep.
# A differential backup includes only the files that have changed since the last full backup.
field-retention-differential = Differential:
field-backup-format = Format:
field-backup-compression = Compression:
# The compression level determines how much compresison we perform.
field-backup-compression-level = Level:

label-manifest = Manifest
# This shows the time when we checked for an update to the manifest.
label-checked = Checked
# This shows the time when we found an update to the manifest.
label-updated = Updated
label-new = New
label-removed = Removed
label-comment = Comment
label-unchanged = Unchanged
label-backup = Backup
label-scan = Scan
label-filter  = Filter
label-unique = Unique
label-complete = Complete
label-partial = Partial
label-enabled = Enabled
label-disabled = Disabled
# https://en.wikipedia.org/wiki/Thread_(computing)
label-threads = Threads
label-cloud = Cloud
# A "remote" is what Rclone calls cloud systems like Google Drive.
label-remote = Remote
label-remote-name = Remote name
label-folder = Folder
# An executable file
label-executable = Executable
# Options given to a command line program
label-arguments = Arguments
label-url = URL
# https://en.wikipedia.org/wiki/Host_(network)
label-host = Host
# https://en.wikipedia.org/wiki/Port_(computer_networking)
label-port = Port
label-username = Username
label-password = Password
# This is a specific website or service that provides some cloud functionality.
# For example, Nextcloud and Owncloud are providers of WebDAV services.
label-provider = Provider
label-custom = Custom
label-none = None
label-change-count = Changes: {$total}
label-unscanned = Unscanned
# This refers to a local file on the computer
label-file = File
label-game = Game
# Aliases are alternative titles for the same game.
label-alias = Alias
label-original-name = Original name
# Which manifest a game's data came from
label-source = Source
# This refers to the main Ludusavi manifest: https://github.com/mtkennerly/ludusavi-manifest
label-primary-manifest = Primary manifest
# This refers to how we integrate a custom game with the manifest data.
label-integration = Integration
# This is a folder name where a specific game is installed
label-installed-name = Installed name

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
store-other-home = Home folder
# This would be a folder acting as a virtual C: drive, created by Wine.
store-other-wine = Wine prefix
# This would be a folder with typical Windows system folders,
# like "Program Files (x86)" and "Users".
store-other-windows = Windows drive
# This would be a folder with typical Linux system folders,
# like "home" and "opt".
store-other-linux = Linux drive
# This would be a folder with typical Mac system folders,
# like "Applications" and "Users".
store-other-mac = Mac drive
store-other = Other

backup-format-simple = Simple
backup-format-zip = Zip

compression-none = None
# "Deflate" is a proper noun: https://en.wikipedia.org/wiki/Deflate
compression-deflate = Deflate
compression-bzip2 = Bzip2
compression-zstd = Zstd

theme = Theme
theme-light = Light
theme-dark = Dark

redirect-bidirectional = Bidirectional
reverse-redirects-when-restoring = Reverse sequence of redirects when restoring

show-disabled-games = Show disabled games
show-unchanged-games = Show unchanged games
show-unscanned-games = Show unscanned games
override-max-threads = Override max threads
synchronize-automatically = Synchronize automatically
prefer-alias-display = Display alias instead of original name
skip-unconstructive-backups = Skip backup when data would be removed, but not added or updated

explanation-for-exclude-store-screenshots =
    In backups, exclude store-specific screenshots

explanation-for-exclude-cloud-games =
    Do not back up games with cloud support on these platforms

consider-doing-a-preview =
    If you haven't already, consider doing a preview first so that there
    are no surprises.

confirm-backup =
    Are you sure you want to proceed with the backup? {$path-action ->
        [merge] New save data will be merged into the target folder:
        *[create] The target folder will be created:
    }

confirm-restore =
    Are you sure you want to proceed with the restoration?
    This will overwrite any current files with the backups from here:

confirm-cloud-upload =
    Do you want to replace your cloud files with your local files?
    Your cloud files ({$cloud-path}) will become an exact copy of your local files ({$local-path}).
    Files in the cloud will be updated or deleted as necessary.

confirm-cloud-download =
    Do you want to replace your local files with your cloud files?
    Your local files ({$local-path}) will become an exact copy of your cloud files ({$cloud-path}).
    Local files will be updated or deleted as necessary.

confirm-add-missing-roots = Add these roots?
no-missing-roots = No additional roots found.
loading = Loading...
preparing-backup-target = Preparing backup directory...
updating-manifest = Updating manifest...
no-cloud-changes = No changes to synchronize
backups-are-valid =
    Your backups are valid.
backups-are-invalid =
    These games' backups appear to be invalid.
    Do you want to create new full backups for these games?

saves-found = Save data found.
no-saves-found = No save data found.

# This is tacked on to form something like "Back up (no confirmation)",
# meaning we would perform an action without asking the user if they're sure.
suffix-no-confirmation = no confirmation

# This is shown when a setting will only take effect after closing and reopening Ludusavi.
suffix-restart-required = restart required

prefix-error = Error: {$message}
prefix-warning = Warning: {$message}

cloud-app-unavailable = Cloud backups are disabled because {$app} is not available.
cloud-not-configured = Cloud backups are disabled because no cloud system is configured.
cloud-path-invalid = Cloud backups are disabled because the backup path is invalid.

game-is-unrecognized = Ludusavi does not recognize this game.
game-has-nothing-to-restore = This game does not have a backup to restore.
launch-game-after-error = Launch the game anyway?
game-did-not-launch = Game failed to launch.
backup-is-newer-than-current-data = The existing backup is newer than the current data.
backup-is-older-than-current-data = The existing backup is older than the current data.

back-up-specific-game =
    .confirm = Back up save data for {$game}?
    .failed = Failed to back up save data for {$game}
restore-specific-game =
    .confirm = Restore save data for {$game}?
    .failed = Failed to restore save data for {$game}

new-version-check = Check for application updates automatically
new-version-available = An application update is available: {$version}. Would you like to view the release notes?

custom-game-will-override = This custom game overrides a manifest entry
custom-game-will-extend = This custom game extends a manifest entry

operation-will-only-include-listed-games = This will only process the games that are currently listed

ludocard-library = Library
ludocard-scan-and-add = Scan & Add
ludocard-cloud-and-sync = Cloud & Sync
ludocard-save-share-hub = Save Share HUB
ludocard-preset-share-hub = Preset Share HUB
ludocard-settings = Settings
ludocard-support-project = Support the Project
ludocard-library-status = Library Status
ludocard-games = Games
ludocard-language = Language
ludocard-language-desc = Interface language.
ludocard-sidebar-subtitle = Save Backups
ludocard-navigation = Navigation
ludocard-stored-saves = Stored Saves
ludocard-pending-saves = Pending
ludocard-downloading-covers = Downloading covers...
ludocard-settings-desc = App preferences and behavior
ludocard-dashboard-desc = Manage and protect your game saves

ludocard-file-watcher = File Watcher
ludocard-file-watcher-desc = Monitors save changes and backs up automatically when the game closes.
ludocard-start-with-windows = Start with Windows
ludocard-start-with-windows-desc = Open minimized in the system tray when starting the PC.
ludocard-system-tray = Run in System Tray
ludocard-system-tray-desc = Minimize the application to the system tray near the clock instead of closing.
ludocard-portable = Portable Mode
ludocard-portable-desc = Save all configurations, manifests, and backups in the executable folder (ideal for USB drives).
ludocard-theme = Theme
ludocard-theme-desc = Interface appearance.
ludocard-theme-dark = Dark
ludocard-theme-light = Light
ludocard-theme-system = System
ludocard-backup-dir = Backup Directory
ludocard-backup-dir-desc = Where game saves will be stored locally.

ludocard-rclone-path = Rclone executable path
ludocard-rclone-path-desc = Path to the rclone executable used for uploading to the cloud.
ludocard-cloud-folder = Remote Cloud Folder
ludocard-cloud-folder-desc = Name of the remote folder to synchronize the files.
ludocard-rclone-args = Extra Rclone arguments
ludocard-rclone-args-desc = Optional commands and flags passed directly to rclone.
ludocard-supabase-url = Supabase URL (Community Repository)
ludocard-supabase-url-desc = API URL of your Supabase project for the community tab.
ludocard-supabase-key = Supabase Anon Key
ludocard-supabase-key-desc = Public (anon) key used for anonymous authentication on tables.
ludocard-btn-save-settings = Save Settings

ludocard-tab-general = General
ludocard-tab-schedule = Schedule
ludocard-tab-notifications = Notifications
ludocard-general-preferences = General preferences
ludocard-general-preferences-desc = Application paths and basic behavior.

ludocard-status-synchronized = Synchronized
ludocard-status-pending = Backup pending
ludocard-status-none = No backup
ludocard-backup = Backup
ludocard-restore = Restore
ludocard-current-save = Active Save
ludocard-last-backup = Last Backup
ludocard-manual-backup = Manual Backup
ludocard-loading-library = Loading game library...
ludocard-monitored-games = Monitored Games
ludocard-cloud-synced = Cloud Synced
ludocard-pending-saves-plural = Pending Backups
ludocard-search-games = Search games...
ludocard-clear-search = Clear search
ludocard-select-all = Select all
ludocard-platform = Platform
ludocard-all-platforms = All Platforms
ludocard-sort-by = Sort by
ludocard-sort-name = Name (A-Z)
ludocard-sort-recent = Recently played
ludocard-sort-size = Save size
ludocard-installed = Installed
ludocard-pending = Pending
ludocard-grid-view = Grid view
ludocard-list-view = List view
ludocard-showing = Showing
ludocard-of = of
ludocard-game = game
ludocard-games-plural = games
ludocard-no-games-found = No games found
ludocard-adjust-filters-desc = Adjust the filters or scan your folders to add new games.
ludocard-starting-backup-for = Starting backup for
ludocard-backup-completed-for = Backup for
ludocard-completed = completed!
ludocard-completed-fem = completed!
ludocard-backup-failed-for = Backup failed for
ludocard-restoring-backup-for = Restoring backup for
ludocard-restore-completed-for = Restore for
ludocard-restore-failed-for = Restore failed for
ludocard-never = Never

ludocard-scan-title = Scan & Add
ludocard-scan-desc = Find game saves on your computer
ludocard-auto-search = Automatic search
ludocard-auto-search-desc = Scans system common folders (Steam, Epic, Documents, AppData) and custom folders for new saves or changes.
ludocard-scanning = Scanning...
ludocard-start-scan = Start search for changes
ludocard-scan-completed = Scan completed
ludocard-scan-completed-desc = Change detection finished.
ludocard-scan-error = Error performing scan.
ludocard-custom-folder = Custom
ludocard-default-folder = Default
ludocard-folder-added = Folder added to monitoring
ludocard-folder-added-success = Folder added successfully!
ludocard-folder-select-error = Error selecting/adding folder.
ludocard-emulator-detected = The selected folder belongs to emulator { $emulator }.\n\nDo you want to add it as an Emulator to track game saves automatically?
ludocard-adding-emulator = Adding emulator and scanning saves...
ludocard-emulator-added-success = Emulator { $emulator } added successfully! { $count } game(s) detected in saves folder.
ludocard-emulator-added-empty = Emulator { $emulator } added! No game saves detected in folder.
ludocard-emulator-add-failed = Failed to add emulator: { $error }
ludocard-emulator-added-mock = Emulator added successfully! (Mock)
ludocard-emulator-select-error = Error selecting/adding emulator.
ludocard-emulator-removed = Emulator removed
ludocard-emulator-remove-error = Error removing emulator.
ludocard-folder-removed = Folder removed from monitoring
ludocard-folder-remove-error = Error removing folder.
ludocard-monitored-folders = Monitored folders
ludocard-monitored-folders-desc = Root directories continuously observed for new saves.
ludocard-add-folder = Add folder
ludocard-no-folders-detected = No game folder automatically detected.
ludocard-click-add-folder-desc = Click "Add folder" to select a library folder or emulators.
ludocard-monitoring-active = Active monitoring
ludocard-remove-folder = Remove folder
ludocard-select-new-root = Select new root folder
ludocard-monitored-emulators = Monitored emulators
ludocard-monitored-emulators-desc = Emulator directories observed for console save auto-detection.
ludocard-add-emulator = Add emulator
ludocard-no-emulators-configured = No emulator configured.
ludocard-click-add-emulator-desc = Click "Add emulator" to import saves from Switch, Wii, Wii U, GBA, PS2, etc.
ludocard-saves-integrated = Saves integrated to library
ludocard-remove-emulator = Remove emulator
ludocard-add-other-emulator = Add another emulator
ludocard-scan-results = Scan results
ludocard-scan-results-desc = Select which games with new or changed saves you want to backup.
ludocard-starting-batch-backup = Starting batch backup for { $count } games...
ludocard-batch-backup-completed = Backup of selected games completed!
ludocard-batch-backup-failed = Batch backup failed.
ludocard-backup-selected = Backup Selected
ludocard-no-new-saves-detected = No new saves or changes detected. All games are synchronized!
ludocard-new-game = New Game
ludocard-changed-save = Changed

ludocard-cloud-title = Cloud & Sync
ludocard-cloud-desc = Configure remote backup of your saves
ludocard-cloud-provider = Cloud provider
ludocard-cloud-provider-desc = Choose where your backups will be stored remotely.
ludocard-auth-status = Authentication and storage status.
ludocard-connected-as = Connected as { $account }
ludocard-oauth-authorized = Account authorized via OAuth
ludocard-disconnect = Disconnect
ludocard-space-used = Space used
ludocard-connect-desc = Connect your { $provider } account to enable remote backup of your saves.
ludocard-connect-btn = Connect account
ludocard-sync-rules = Sync rules
ludocard-sync-rules-desc = How saves move between the PC and the cloud.
ludocard-auto-upload = Automatic upload after local backup
ludocard-auto-upload-desc = Uploads to the cloud immediately after each backup.
ludocard-auto-upload-enabled = Automatic upload enabled
ludocard-auto-upload-disabled = Automatic upload disabled
ludocard-download-if-newer = Download if remote save is newer
ludocard-download-if-newer-desc = Resolves conflicts by prioritizing the newer version.
ludocard-auto-download-enabled = Automatic download enabled
ludocard-auto-download-disabled = Automatic download disabled
ludocard-disconnected-provider = { $provider } disconnected
ludocard-connected-provider = { $provider } connected

ludocard-loading = Loading...
ludocard-fetching-details = Fetching game details
ludocard-loading-details = Loading game details...
ludocard-details-desc = Backup details and history
ludocard-back = Back
ludocard-select = Select
ludocard-saved-versions = saved versions
ludocard-backup-now = Backup now
ludocard-restore-latest = Restore latest
ludocard-open-game-folder-desc = Open game installation folder in Windows Explorer
ludocard-game-folder = Game Folder
ludocard-open-save-folder-desc = Open folder where active saves are stored
ludocard-save-folder = Save Folder
ludocard-open-backup-folder-desc = Open Ludocard save backup folder
ludocard-backup-folder = Backups Folder
ludocard-export-save-desc = Export save as compressed .ludocard file to share
ludocard-export-save = Export Save (.ludocard)
ludocard-status = Status
ludocard-saves-on-pc = Saves on PC
ludocard-total-backups = Total in backups
ludocard-quick-preferences = Quick preferences
ludocard-save-history = Saves History
ludocard-config-presets = Config Presets
ludocard-saves-timeline = Saves Timeline
ludocard-presets-configs = Presets & Configs
ludocard-no-backups-yet = No backups yet
ludocard-do-first-backup-desc = Create the first backup of this game to start the timeline.
ludocard-active = Active
ludocard-disabled = Disabled

ludocard-support-title = Support the Project
ludocard-support-desc = Help keep community save and preset servers online
ludocard-support-intro-title = Ludocard is completely free!
ludocard-support-intro-desc = Our cloud features (Save Share Hub and Presets) generate monthly server and traffic costs. If the app is useful to you, please consider supporting to help keep them online!
ludocard-how-to-support = How to Support the Project
ludocard-how-to-support-desc = Choose your preferred method of contribution. Stripe supports credit cards and PIX.
ludocard-support-itch = Support on Itch.io
ludocard-support-stripe = Card / PIX via Stripe
ludocard-support-dest-desc = All contributions are fully directed towards the maintenance of cloud servers (hosting and data traffic).

ludocard-community-title = Save Share HUB
ludocard-community-desc = Share and download community save checkpoints
ludocard-btn-share-checkpoint = Share Checkpoint
ludocard-repo-disconnected = Community Repository Disconnected
ludocard-repo-disconnected-desc = To load community checkpoints and share yours, you need to configure your Supabase URL and public Anon Key in Settings.
ludocard-how-to-config = How to configure:
ludocard-config-step-1 = Create a free project on Supabase.
ludocard-config-step-2 = Create tables by running the SQL script in supabase/schema.sql.
ludocard-config-step-3 = Insert the API URL and public Anon Key in Ludocard Settings.
ludocard-checkpoints = Checkpoints
ludocard-contributors = Contributors
ludocard-search-placeholder = Search by game or checkpoint...
ludocard-sort-popular = Popular
ludocard-sort-recent-hub = Recent
ludocard-sort-size-hub = Size
ludocard-syncing-repo = Syncing with the public repository...
ludocard-no-checkpoints-found = No checkpoints found
ludocard-no-checkpoints-available = No checkpoints available
ludocard-search-terms-desc = Try searching with other terms.
ludocard-be-first-desc = Be the first to share a community save!
ludocard-no-desc-provided = No detailed description provided.
ludocard-author-by = by
ludocard-zstd-verified = Contains verified zstd metadata
ludocard-btn-install = Install
ludocard-btn-installing = Installing...
ludocard-security-sandbox-title = Automatic Safe-Crash and Sandbox Security
ludocard-security-sandbox-desc = When installing a community checkpoint, Ludocard automatically creates a safety backup of your current save before overwriting. If anything goes wrong, just restore the previous backup from history.
ludocard-share-checkpoint-modal = Share Checkpoint
ludocard-publish-progress-desc = Publish your progress file to the community.
ludocard-save-game-label = Save Game *
ludocard-search-installed-game = Type to search an installed game...
ludocard-backup-version-label = Backup Version *
ludocard-no-local-backups-desc = No local backups made for this game yet. Create a backup in the game card first.
ludocard-checkpoint-title-label = Checkpoint Title *
ludocard-checkpoint-title-placeholder = E.g. Before Malenia or Level 100 100% Complete
ludocard-checkpoint-author-label = Author Name
ludocard-checkpoint-author-placeholder = E.g. Anonymous
ludocard-checkpoint-desc-label = Description / Additional Notes
ludocard-checkpoint-desc-placeholder = Describe details like build, level, important items or progress point.
ludocard-checkpoint-tags-label = Checkpoint Tags
ludocard-btn-cancel = Cancel
ludocard-btn-publishing = Publishing...
ludocard-btn-publish = Publish Checkpoint
ludocard-detail-modal-desc = Viewing complete checkpoint metadata.
ludocard-btn-close = Close
ludocard-btn-download-install = Download & Install
ludocard-detail-title-label = Checkpoint Title:
ludocard-detail-desc-label = Progress Description:
ludocard-detail-tags-label = Tags:
ludocard-detail-size-label = Compressed Size:
ludocard-detail-downloads-label = Total Downloads:
ludocard-detail-author-label = Uploaded by:
ludocard-detail-date-label = Uploaded on:
ludocard-date-today = Today
ludocard-date-yesterday = Yesterday
ludocard-date-days-ago = days ago
ludocard-date-weeks-ago = weeks ago
ludocard-date-locale = en-US

ludocard-presethub-title = Preset Share HUB
ludocard-presethub-desc = Discover and share graphics and controller optimizations from the community
ludocard-btn-share-preset = Share Preset
ludocard-presethub-disconnected = Preset Repository Disconnected
ludocard-presethub-disconnected-desc = To load community presets and share yours, you need to configure your Supabase URL and public Anon Key in Settings.
ludocard-presets = Presets
ludocard-preset-search-placeholder = Search by game, title, or hardware (e.g. RTX 4070)...
ludocard-syncing-presets = Syncing presets...
ludocard-no-presets-found = No graphic presets found
ludocard-search-terms-desc-preset = Try resetting your search terms.
ludocard-badge-official = Official
ludocard-gpu = GPU
ludocard-approval = Approval
ludocard-useful = Useful
ludocard-useless = Useless
ludocard-report-preset = Report preset
ludocard-btn-undo = Undo
ludocard-btn-inject = Inject
ludocard-btn-injecting = Injecting...
ludocard-not-installed = Not Installed
ludocard-security-safety-title = Safety Guaranteed by Safe-Crash
ludocard-security-safety-desc = When downloading any graphic preset from the HUB, Ludocard backs up your previous settings. Your progress saves remain untouched.
ludocard-share-preset-modal-title = Share Graphic Preset
ludocard-share-preset-modal-desc = Send a local graphic preset to the community.
ludocard-preset-game-label = Preset Game *
ludocard-search-installed-game-preset = Search installed game...
ludocard-choose-local-preset-label = Choose Local Preset *
ludocard-no-local-presets-desc = No local preset saved for this game. Go to the game tab and create a local preset first!
ludocard-preset-title-label = Preset Title *
ludocard-preset-creator-label = Author / Creator
ludocard-preset-desc-label = Description / Preset Notes
ludocard-preset-tags-label = Preset Tags
ludocard-preset-hardware-label = Author Hardware (Auto-filled from local preset):
ludocard-cpu = CPU
ludocard-ram = RAM
ludocard-btn-publish-preset = Publish Preset
ludocard-detail-preset-title = Preset Title:
ludocard-detail-preset-desc = Description / Optimizations:
ludocard-detail-author-specs = Author Specs:

ludocard-tag-desc-100 = Game 100% completed with all achievements, items and collectibles unlocked.
ludocard-tag-desc-dlc1 = Progress focused on or ready to start the first DLC.
ludocard-tag-desc-dlc2 = Progress focused on or ready to start the second DLC.
ludocard-tag-desc-ngplus = Game ready to start or already started in New Game+ mode.
ludocard-tag-desc-vanilla = Base game progress completely clean, without modifiers, mods or cheats.
ludocard-tag-desc-modded = Progress obtained using modifications (mods) that can alter gameplay.
ludocard-tag-desc-bossprep = Save strategically positioned right before a major game boss.
ludocard-tag-desc-starter = Save at the beginning of the game, with accumulated resources or skipped tutorial.
ludocard-tag-desc-cleanstart = Savegame right after character creation or introduction, ready to play straight from the real start.
ludocard-tag-desc-midgame = Save positioned in the middle of the main campaign (great for those who lost progress).
ludocard-tag-desc-postgame = Campaign completed, ideal for exploring secret bosses, pending achievements or side activities.
ludocard-tag-desc-opbuild = Savegame focused on a character with extremely strong equipment, level and builds (Overpowered).
ludocard-tag-desc-unlimitedcash = Save focused on having max or infinite cash, coins or upgrade resources.
ludocard-tag-desc-allcollectibles = Save focusing on secondary achievements and tedious collectibles fully unlocked.
ludocard-tag-desc-hardcore = Saves in extreme difficulties or with permanent death enabled (extreme survival).
ludocard-tag-desc-speedrunready = Save ideal for training speedrun segments or positioned on the fastest routes.
ludocard-tag-desc-legit = Progress obtained cleanly, without cheats, cheat codes or exploiting bugs (glitches).
ludocard-preset-tag-desc-perf = Optimizations focused on FPS gain and smoothness.
ludocard-preset-tag-desc-quality = Optimizations focused on maximum graphic quality.
ludocard-preset-tag-desc-balanced = Ideal balance between visual fidelity and FPS rate.
ludocard-preset-tag-desc-deck = Profile optimized specifically for Steam Deck/handheld screen and battery.
ludocard-preset-tag-desc-potato = To run on super old PCs and modest laptops.
ludocard-preset-tag-desc-controls = Customized mapping of controls, gamepad or hotkeys.
ludocard-preset-tag-desc-rt = Fine-tuned configuration with active ray tracing, aiming for good frame rate.
ludocard-preset-tag-desc-4k = Optimizations focused on 4K high-definition TVs and monitors.
ludocard-preset-tag-desc-vr = Settings adjusted for ideal FPS rate in virtual reality.

ludocard-schedule-auto-routine = Automatic backup routine
ludocard-schedule-auto-routine-desc = Define when backups should happen automatically.
ludocard-schedule-by-interval = By interval
ludocard-schedule-by-days = Days of the week
ludocard-schedule-backup-every = Backup every
ludocard-schedule-1-hour = 1 hour
ludocard-schedule-3-hours = 3 hours
ludocard-schedule-6-hours = 6 hours
ludocard-schedule-12-hours = 12 hours
ludocard-schedule-24-hours = 24 hours
ludocard-schedule-at-time = At time
ludocard-schedule-games-in-schedule = Games in schedule
ludocard-schedule-games-in-schedule-desc = Select which games follow this automatic routine.
ludocard-schedule-btn-save = Save schedule
ludocard-schedule-saved-toast = Schedule saved successfully

ludocard-day-sun = Sun
ludocard-day-mon = Mon
ludocard-day-tue = Tue
ludocard-day-wed = Wed
ludocard-day-thu = Thu
ludocard-day-fri = Fri
ludocard-day-sat = Sat

ludocard-notification-alerts = Alerts & Notifications
ludocard-notification-alerts-desc = Choose how you want to be notified about backups.
ludocard-notification-windows = Windows Notifications
ludocard-notification-windows-desc = Notify when a backup completes successfully.
ludocard-notification-toast-enabled = Notifications enabled
ludocard-notification-toast-disabled = Notifications disabled
ludocard-notification-fail-alerts = Failure alerts
ludocard-notification-fail-alerts-desc = Notify immediately when a backup fails.
ludocard-notification-toast-fail-enabled = Failure alerts enabled
ludocard-notification-toast-fail-disabled = Failure alerts disabled
ludocard-notification-sounds = Alert sounds
ludocard-notification-sounds-desc = Play a sound when a backup completes or fails.
ludocard-notification-toast-sounds-enabled = Alert sounds enabled
ludocard-notification-toast-sounds-disabled = Alert sounds disabled


