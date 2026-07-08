# Changelog - Luducard

All notable changes to the **Luducard** project will be documented in this file.

This project is a new application based on the core of Ludosavi. The change history of Luducard starts with this release.

## [0.2.0] - 2026-07-08
### Fixed
- **Notes I/O Performance**: Optimized campaign and backup notes loading by reading and parsing `luducard.json` once per API call, significantly improving the loading speed of game lists and scans.
- **Scan Page Layout Flashing**: Introduced loading spinners for Monitored Folders and Emulators sections to prevent layout flashing and layout shifting during the initial backend fetch.
- **Library Synchronization**: Integrated automatic context reloading (`loadGames`) on critical game details screen events (such as manual backup creation, restore operations, save profiles, and preset imports), keeping the main library list perfectly up to date.
- **UI Flickering**: Eliminated UI flickers on layout transitions.
- **Access Control List (ACL)**: Fixed ACL permissions issues in backend operations.

### Added
- **Logbook Toggle Preference**: Added a "Show Logbook in Library" option under General Settings (supporting localization in English and Portuguese) to easily show or hide the quick notes field directly from game cards and rows.
- **Discord Community Link**: Added direct integration and community links to Discord on the support page.
- **Cloud Sync Configuration**: Enabled auto-fetching of the cloud email on settings load.

## [0.1.0] - 2026-07-01
### Added
- Fully redesigned UI developed in React + Tailwind CSS v4 + Vite.
- Desktop integration using Tauri v2 framework (Rust-based core).
- **Save Share Hub**: Cloud repository to compress, share, and auto-install game saves/checkpoints.
- **Settings & Graphic Presets**: System to share optimal graphics configurations with safety backups and automatic hardware spec attachment.
- **Active Game Detections**: Executable checks to verify game installations and prevent library clutter.
- **Background File Watcher**: Active background monitoring to backup saves instantly on game exit.
- **System Tray Integration**: Minimize application to the tray.
- **Global Emergency Shortcut**: Customize key shortcuts (like `Ctrl + Shift + S`) for manual quick-saving without switching tabs.
- **Emulator Support**: Auto-detect and group saves from major platforms (Yuzu, Ryujinx, Dolphin, etc.) using Title ID or ROM names.
- **Campaign Notes**: Quick note taking for each game card.
