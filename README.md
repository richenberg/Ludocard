# 🎮 Ludocard

**Ludocard** is a lightweight, modern, and beautiful game save manager for PC. It began as a simple fork of **Ludosavi**, but it has evolved tremendously into a feature-rich, community-driven backup and share hub.

Join our community on [Discord](https://discord.gg/U2DEbDqgm)!

> ℹ️ **Developer's Note & AI-Assisted Development**
> This project was created by a non-programmer who wanted a better visual, and add more modern features to the game save manager. The entire application, including its Rust backend, Tauri integrations, and React/Tailwind frontend, was built, refactored, and optimized using advanced Artificial Intelligence (such as Gemini). It stands as a testament to what AI collaboration can achieve!

---

## 🌟 Highlighted Features

### 🌍 Save Share Hub (Sharing Saves)
No more hunting through sketchy forums or manually emailing files to share progress. Ludocard features an integrated sharing ecosystem:
- **One-Click Share**: Instantly package and upload your current save slot of any game directly to the public share hub.
- **Brutal Compression**: Built in Rust, the app uses modern compression algorithms (like `zstd` or `lzma`) to shrink large save folders down to minimal files before upload.
- **Ironclad Cloud Security**: For security, no cloud master keys are embedded inside the client app. Instead, it requests secure, short-lived **Presigned URLs** from a Supabase Edge Function to perform direct, encrypted uploads/downloads to Cloudflare R2 storage.
- **Community Checkpoint Repository**: Download and automatically install checkpoints uploaded by the community (e.g., *"Before the final boss"*, *"100% completion"*, *"Skip tutorial"*).
- **Capped & Clean**: Features auto-delete rules for inactive files (deletes saves after 90 days of no downloads), storage limits per user, and abuse prevention.

### 🎛️ Preset & Graphics Configuration Sharing
Tired of manually tweaking `.ini` and `.cfg` files to optimize your game's graphics or controls?
- **Crash-Safe "Seguro-Crash" Flow**: When you apply a community configuration preset, Ludocard automatically takes a backup of your original settings. If the game crashes or has issues, you can restore your original files with one click.
- **Hardware-Attached Presets**: When sharing a preset, the app automatically fetches and attaches your system specs (CPU, GPU, and RAM) using Rust, helping other users find the perfect configuration for their hardware.
- **Potato Mode Presets**: Easily find and inject ultra-low configs designed to disable heavy shadows and maximize FPS for low-end or older computers.
- **Community Voting & Moderation**: Integrated upvote/downvote system (👍/👎) to measure performance gains, and a reporting system (🚨) that auto-hides presets with 3 or more reports for safety.

---

## 🛠️ Complete Feature Roadmap & Status

### 🟢 1. Core Mechanics & Frontend (Completed)
- **Modern UI (React + Tailwind v4 + Vite)**: A premium-looking dashboard with a sidebar, fluid navigation, and responsive sections (Library, Scan, Cloud, Settings, Support).
- **Tauri Commands (Rust Bridge)**: Performance-oriented Rust commands to list libraries (`get_games`), backup/restore saves (`backup_game` / `restore_game`), and manage settings.
- **Smart Active Detection**: Prevents false-positive game detections by checking if the game's executable (`.exe`) is actually present in game store installation folders (Steam, Epic, GOG, Heroic, Lutris, etc.).
- **Smart Library Sorting**: Sort your library by "Recently Played" (based on save file write times), "Size", or alphabetical "A-Z".
- **Local or Cloud Backup Selection**: Flexible backup button with a dropdown selector to choose between local backups or cloud syncing.

### 🟢 2. Automation & System Integration (Completed)
- **File Watcher (Active Save Monitor)**: Monitors save folders in real-time. When you close a game, it triggers a silent backup in the background.
- **System Tray Integration**: Clicking the close window button minimizes Ludocard to the Windows system tray (near the clock), continuing background monitoring with close to zero RAM/CPU consumption.
- **Run at Windows Startup**: Toggle option in settings to launch the app automatically with Windows.

### 🟢 3. Advanced Backup Features (Completed)
- **Version Pinning (Pin Backup)**: "Pin" or lock specific backups in your timeline (e.g., before making a major choice in an RPG) to prevent them from being auto-deleted when the backup retention limit is reached.
- **Portable Mode**: Save all backups and configuration files inside the executable's folder, allowing you to run Ludocard entirely from a USB drive or external hard disk.
- **Game Settings Backup**: Go beyond saves and back up graphic/control configuration folders (often located in separate AppData or Documents folders).
- **Multiple Save Profiles**: Separate your gameplay styles (e.g., Modded vs. Vanilla, Character A vs. Character B). Switch active folders instantly.
- **Visual Conflict Assistant**: Side-by-side comparison screen (e.g., *"This PC (Older - 10MB)"* vs. *"Cloud (Newer - 12MB)"*) when local and cloud saves drift.

### 🟢 4. Gamer Tools & UX (Completed)
- **Global Emergency Quick-Save**: A customizable keyboard shortcut (e.g., `Ctrl + Shift + S`) that performs an instant save-state of your active game, accompanied by a subtle Steam-like toast notification and chime.
- **Campaign Notes (The Captain's Log)**: An editable text field inside each game card to write down notes about your build, objectives, or current checklist.
- **Automatic Cover Downloads**: Automatically fetches vertical game cover art from Steam's API or SteamGridDB, eliminating boring placeholders.

### 🟢 5. Emulator Support & Title Detection (Completed)
- **Emulator Integration**: Automatically detects and manages saves from major emulators (Yuzu, Ryujinx, Dolphin, PCSX2, RetroArch, mGBA, Citra, etc.).
- **Smart Rom & Title ID Mapping**: Reads Switch/Wii Title IDs or GBA/PS2 Rom file names to register them under friendly names (e.g., `[Yuzu] The Legend of Zelda: Tears of the Kingdom`).
- **Premium Emulation Badges**: Visual tags with custom-colored branding for each emulator platform.

### 🟢 6. Project Support & Administration (Completed)
- **Support Page (`/support`)**: Integrated donation screen showing server costs (Cloudflare R2, Supabase) with quick links for Itch.io and PIX support.
- **Admin Control Panel**: Hidden/password-protected dashboard to manage cloud saves, delete corrupted or offensive presets, and monitor Cloudflare R2 quota usage.
- **Multi-language Support (Fluent)**: Fully localized into English, Portuguese, Spanish, Russian, and Simplified Chinese.

---

## 🚀 Running & Developing Locally

Ludocard is built with [Tauri v2](https://tauri.app/), [React](https://react.dev/), [Tailwind CSS v4](https://tailwindcss.com/), and [Rust](https://www.rust-lang.org/).

### Prerequisites
- Node.js & npm / pnpm
- Rust compiler and toolchain

### Setup & Run
1. Install frontend dependencies:
   ```bash
   cd ui
   pnpm install
   ```
2. Run in development mode:
   ```bash
   # In the root directory:
   npm run tauri dev
   ```
3. Build standalone production binary (`Ludocard.exe`):
   ```bash
   npm run tauri build
   ```

---

## 📄 License
This project is open-source. For details on permissions and redistribution, see [LICENSE](./LICENSE).
