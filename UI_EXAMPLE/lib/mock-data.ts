export type Platform = "Steam" | "Epic" | "GOG" | "Emulador" | "Origin"

export type BackupStatus = "ok" | "pending" | "never"

export type BackupKind = "Automático" | "Manual" | "Antes de fechar" | "Restauração"

export interface BackupVersion {
  id: string
  date: string // ex: "Hoje", "Ontem", "12 jun 2026"
  time: string // ex: "14:00"
  kind: BackupKind
  sizeMB: number
  cloud: boolean
}

export interface Game {
  id: string
  title: string
  cover: string
  platform: Platform
  savePath: string
  sizeMB: number
  lastBackup: string
  status: BackupStatus
  autoBackup: boolean
  cloudSync: boolean
  backups: BackupVersion[]
}

export const platformColors: Record<Platform, string> = {
  Steam: "bg-sky-500/15 text-sky-300 border-sky-500/30",
  Epic: "bg-zinc-400/15 text-zinc-200 border-zinc-400/30",
  GOG: "bg-violet-500/15 text-violet-300 border-violet-500/30",
  Emulador: "bg-amber-500/15 text-amber-300 border-amber-500/30",
  Origin: "bg-orange-500/15 text-orange-300 border-orange-500/30",
}

export const games: Game[] = []

export function getGame(id: string): Game | undefined {
  return games.find((g) => g.id === id)
}

export interface ScanResult {
  id: string
  title: string
  platform: Platform
  path: string
  sizeMB: number
  isNew: boolean
}

export const scanResults: ScanResult[] = []

export const watchedFolders: any[] = []

export type CloudProvider = "Google Drive" | "OneDrive" | "Dropbox" | "WebDAV" | "FTP"

export interface CloudInfo {
  provider: CloudProvider
  connected: boolean
  account?: string
  usedGB?: number
  totalGB?: number
}

export const cloudProviders: CloudInfo[] = [
  { provider: "Google Drive", connected: false },
  { provider: "OneDrive", connected: false },
  { provider: "Dropbox", connected: false },
  { provider: "WebDAV", connected: false },
  { provider: "FTP", connected: false },
]

export const libraryStats = {
  totalGames: games.length,
  totalSizeMB: games.reduce((acc, g) => acc + g.sizeMB, 0),
  cloudSynced: games.filter((g) => g.cloudSync).length,
  pending: games.filter((g) => g.status === "pending" || g.status === "never").length,
}

export function formatSize(mb: number): string {
  if (mb < 1) return `${Math.round(mb * 1000)} KB`
  if (mb >= 1024) return `${(mb / 1024).toFixed(1)} GB`
  return `${mb.toFixed(1)} MB`
}
