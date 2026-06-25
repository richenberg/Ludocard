"use client"

import { useMemo, useState } from "react"
import Link from "next/link"
import { toast } from "sonner"
import {
  Search,
  LayoutGrid,
  List,
  ArrowUpToLine,
  ArrowDownToLine,
  Cloud,
  CloudOff,
  AlertTriangle,
  CheckCircle2,
  CircleSlash,
  HardDrive,
  Gamepad2,
  TimerReset,
} from "lucide-react"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectGroup,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription } from "@/components/ui/empty"
import { PlatformBadge } from "@/components/platform-badge"
import { cn } from "@/lib/utils"
import {
  games,
  libraryStats,
  formatSize,
  type Game,
  type Platform,
  type BackupStatus,
} from "@/lib/mock-data"

const statusConfig: Record<
  BackupStatus,
  { label: string; icon: typeof CheckCircle2; className: string }
> = {
  ok: { label: "Sincronizado", icon: CheckCircle2, className: "text-emerald-400" },
  pending: { label: "Backup pendente", icon: AlertTriangle, className: "text-amber-400" },
  never: { label: "Sem backup", icon: CircleSlash, className: "text-rose-400" },
}

function handleBackup(title: string) {
  toast.success(`Backup manual de "${title}" criado`, {
    description: "Versão salva localmente e enviada para a nuvem.",
  })
}

function handleRestore(title: string) {
  toast.info(`Restaurando "${title}"`, {
    description: "O save mais recente foi restaurado.",
  })
}

function StatCard({
  icon: Icon,
  label,
  value,
  accent,
}: {
  icon: typeof HardDrive
  label: string
  value: string
  accent?: string
}) {
  return (
    <div className="flex items-center gap-3 rounded-lg border border-border bg-card p-4">
      <div className={cn("flex size-10 items-center justify-center rounded-md bg-muted", accent)}>
        <Icon className="size-5" />
      </div>
      <div className="flex flex-col">
        <span className="text-xs text-muted-foreground">{label}</span>
        <span className="text-lg font-semibold leading-tight">{value}</span>
      </div>
    </div>
  )
}

function GameCard({ game }: { game: Game }) {
  const status = statusConfig[game.status]
  return (
    <div className="group relative overflow-hidden rounded-xl border border-border bg-card transition-colors hover:border-primary/50">
      <Link href={`/game/${game.id}`} className="block">
        <div className="relative aspect-[3/4] overflow-hidden">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={game.cover || "/placeholder.svg"}
            alt={`Capa de ${game.title}`}
            className="size-full object-cover transition-transform duration-300 group-hover:scale-105"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-card via-card/10 to-transparent" />
          <div className="absolute left-2 top-2">
            <PlatformBadge platform={game.platform} />
          </div>
          <div className="absolute right-2 top-2 flex items-center gap-1.5 rounded-md bg-background/70 px-1.5 py-1 backdrop-blur">
            {game.cloudSync ? (
              <Cloud className="size-3.5 text-primary" />
            ) : (
              <CloudOff className="size-3.5 text-muted-foreground" />
            )}
            <status.icon className={cn("size-3.5", status.className)} />
          </div>
        </div>
      </Link>

      <div className="flex flex-col gap-1 p-3">
        <Link href={`/game/${game.id}`} className="truncate font-medium hover:text-primary">
          {game.title}
        </Link>
        <div className="flex items-center justify-between text-xs text-muted-foreground">
          <span>{formatSize(game.sizeMB)}</span>
          <span className="truncate">{game.lastBackup}</span>
        </div>
      </div>

      {/* Hover quick actions */}
      <div className="pointer-events-none absolute inset-x-0 bottom-[68px] flex items-center justify-center gap-2 opacity-0 transition-opacity group-hover:pointer-events-auto group-hover:opacity-100">
        <Button
          size="sm"
          onClick={() => handleBackup(game.title)}
          className="shadow-lg"
        >
          <ArrowUpToLine data-icon="inline-start" />
          Backup
        </Button>
        <Button
          size="sm"
          variant="secondary"
          onClick={() => handleRestore(game.title)}
          className="shadow-lg"
        >
          <ArrowDownToLine data-icon="inline-start" />
          Restaurar
        </Button>
      </div>
    </div>
  )
}

function GameRow({ game }: { game: Game }) {
  const status = statusConfig[game.status]
  return (
    <div className="group flex items-center gap-3 rounded-lg border border-border bg-card p-2.5 transition-colors hover:border-primary/50 sm:gap-4">
      <Link href={`/game/${game.id}`} className="shrink-0">
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={game.cover || "/placeholder.svg"}
          alt={`Capa de ${game.title}`}
          className="h-16 w-12 rounded-md object-cover"
        />
      </Link>
      <div className="flex min-w-0 flex-1 flex-col gap-1">
        <Link href={`/game/${game.id}`} className="truncate font-medium hover:text-primary">
          {game.title}
        </Link>
        <div className="flex flex-wrap items-center gap-2 text-xs text-muted-foreground">
          <PlatformBadge platform={game.platform} />
          <span className="inline-flex items-center gap-1">
            <status.icon className={cn("size-3.5", status.className)} />
            {status.label}
          </span>
        </div>
      </div>
      <div className="hidden w-24 shrink-0 flex-col items-end text-xs sm:flex">
        <span className="font-medium text-foreground">{formatSize(game.sizeMB)}</span>
        <span className="text-muted-foreground">Save atual</span>
      </div>
      <div className="hidden w-28 shrink-0 flex-col items-end text-xs md:flex">
        <span className="font-medium text-foreground">{game.lastBackup}</span>
        <span className="text-muted-foreground">Último backup</span>
      </div>
      <div className="flex shrink-0 items-center gap-1.5">
        <Button size="icon-sm" variant="ghost" onClick={() => handleBackup(game.title)} title="Backup manual">
          <ArrowUpToLine />
          <span className="sr-only">Backup manual</span>
        </Button>
        <Button size="icon-sm" variant="ghost" onClick={() => handleRestore(game.title)} title="Restaurar">
          <ArrowDownToLine />
          <span className="sr-only">Restaurar</span>
        </Button>
      </div>
    </div>
  )
}

export function LibraryClient() {
  const [view, setView] = useState<"grid" | "list">("grid")
  const [query, setQuery] = useState("")
  const [platform, setPlatform] = useState<Platform | "all">("all")
  const [onlyPending, setOnlyPending] = useState(false)

  const filtered = useMemo(() => {
    return games.filter((g) => {
      if (query && !g.title.toLowerCase().includes(query.toLowerCase())) return false
      if (platform !== "all" && g.platform !== platform) return false
      if (onlyPending && g.status === "ok") return false
      return true
    })
  }, [query, platform, onlyPending])

  return (
    <div className="flex flex-col gap-6">
      {/* Stats */}
      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
        <StatCard
          icon={Gamepad2}
          label="Jogos monitorados"
          value={String(libraryStats.totalGames)}
          accent="text-primary"
        />
        <StatCard
          icon={HardDrive}
          label="Saves armazenados"
          value={formatSize(libraryStats.totalSizeMB)}
        />
        <StatCard
          icon={Cloud}
          label="Sincronizados na nuvem"
          value={`${libraryStats.cloudSynced}/${libraryStats.totalGames}`}
          accent="text-primary"
        />
        <StatCard
          icon={TimerReset}
          label="Backups pendentes"
          value={String(libraryStats.pending)}
          accent="text-amber-400"
        />
      </div>

      {/* Toolbar */}
      <div className="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
        <div className="relative w-full lg:max-w-xs">
          <Search className="absolute left-3 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
          <Input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Pesquisar jogos..."
            className="pl-9"
          />
        </div>

        <div className="flex flex-wrap items-center gap-2">
          <Select value={platform} onValueChange={(v) => setPlatform(v as Platform | "all")}>
            <SelectTrigger className="w-[150px]">
              <SelectValue placeholder="Plataforma" />
            </SelectTrigger>
            <SelectContent>
              <SelectGroup>
                <SelectItem value="all">Todas plataformas</SelectItem>
                <SelectItem value="Steam">Steam</SelectItem>
                <SelectItem value="Epic">Epic</SelectItem>
                <SelectItem value="GOG">GOG</SelectItem>
                <SelectItem value="Origin">Origin</SelectItem>
                <SelectItem value="Emulador">Emulador</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>

          <Button
            variant={onlyPending ? "default" : "outline"}
            onClick={() => setOnlyPending((p) => !p)}
          >
            <AlertTriangle data-icon="inline-start" />
            Pendentes
          </Button>

          <ToggleGroup
            value={[view]}
            onValueChange={(val) => {
              const next = val[0] as "grid" | "list" | undefined
              if (next) setView(next)
            }}
            variant="outline"
            spacing={0}
          >
            <ToggleGroupItem value="grid" aria-label="Visualização em grade">
              <LayoutGrid />
            </ToggleGroupItem>
            <ToggleGroupItem value="list" aria-label="Visualização em lista">
              <List />
            </ToggleGroupItem>
          </ToggleGroup>
        </div>
      </div>

      {/* Results */}
      {filtered.length === 0 ? (
        <Empty>
          <EmptyHeader>
            <EmptyMedia variant="icon">
              <Search />
            </EmptyMedia>
            <EmptyTitle>Nenhum jogo encontrado</EmptyTitle>
            <EmptyDescription>
              Ajuste os filtros ou escaneie suas pastas para adicionar novos jogos.
            </EmptyDescription>
          </EmptyHeader>
        </Empty>
      ) : view === "grid" ? (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
          {filtered.map((game) => (
            <GameCard key={game.id} game={game} />
          ))}
        </div>
      ) : (
        <div className="flex flex-col gap-2">
          {filtered.map((game) => (
            <GameRow key={game.id} game={game} />
          ))}
        </div>
      )}
    </div>
  )
}
