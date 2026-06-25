"use client"

import { toast } from "sonner"
import {
  ArrowUpToLine,
  ArrowDownToLine,
  Cloud,
  CloudOff,
  FolderOpen,
  RotateCcw,
  Trash2,
  Clock,
  Zap,
  HardDrive,
  Copy,
} from "lucide-react"
import { Button } from "@/components/ui/button"
import { Switch } from "@/components/ui/switch"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription } from "@/components/ui/empty"
import { PlatformBadge } from "@/components/platform-badge"
import { cn } from "@/lib/utils"
import { type Game, type BackupKind, formatSize } from "@/lib/mock-data"

const kindColors: Record<BackupKind, string> = {
  Automático: "text-primary",
  Manual: "text-sky-300",
  "Antes de fechar": "text-amber-300",
  Restauração: "text-violet-300",
}

function StatusPill({
  active,
  label,
  onIcon: OnIcon,
  offIcon: OffIcon,
}: {
  active: boolean
  label: string
  onIcon: typeof Cloud
  offIcon: typeof CloudOff
}) {
  return (
    <div className="flex items-center justify-between rounded-lg border border-border bg-muted/40 px-3 py-2.5">
      <span className="flex items-center gap-2 text-sm">
        {active ? (
          <OnIcon className="size-4 text-primary" />
        ) : (
          <OffIcon className="size-4 text-muted-foreground" />
        )}
        {label}
      </span>
      <span
        className={cn(
          "text-xs font-medium",
          active ? "text-primary" : "text-muted-foreground",
        )}
      >
        {active ? "Ativo" : "Desativado"}
      </span>
    </div>
  )
}

export function GameDetailClient({ game }: { game: Game }) {
  function copyPath() {
    navigator.clipboard?.writeText(game.savePath)
    toast.success("Caminho copiado")
  }

  return (
    <div className="flex flex-col gap-6">
      {/* Banner */}
      <div className="relative overflow-hidden rounded-xl border border-border">
        <div className="absolute inset-0">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={game.cover || "/placeholder.svg"}
            alt=""
            aria-hidden="true"
            className="size-full scale-110 object-cover blur-2xl"
          />
          <div className="absolute inset-0 bg-background/75" />
        </div>
        <div className="relative flex flex-col gap-4 p-4 sm:flex-row sm:items-end sm:p-6">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={game.cover || "/placeholder.svg"}
            alt={`Capa de ${game.title}`}
            className="h-40 w-30 shrink-0 rounded-lg border border-border object-cover shadow-xl"
          />
          <div className="flex min-w-0 flex-1 flex-col gap-3">
            <div className="flex flex-wrap items-center gap-2">
              <PlatformBadge platform={game.platform} />
              <span className="text-xs text-muted-foreground">
                {game.backups.length} versões salvas
              </span>
            </div>
            <h2 className="text-balance text-2xl font-bold leading-tight sm:text-3xl">
              {game.title}
            </h2>
            <button
              onClick={copyPath}
              className="group flex w-fit max-w-full items-center gap-2 rounded-md border border-border bg-background/60 px-2.5 py-1.5 font-mono text-xs text-muted-foreground transition-colors hover:text-foreground"
            >
              <FolderOpen className="size-3.5 shrink-0 text-primary" />
              <span className="truncate">{game.savePath}</span>
              <Copy className="size-3 shrink-0 opacity-0 transition-opacity group-hover:opacity-100" />
            </button>
            <div className="flex flex-wrap gap-2">
              <Button onClick={() => toast.success(`Backup de "${game.title}" criado`)}>
                <ArrowUpToLine data-icon="inline-start" />
                Fazer backup agora
              </Button>
              <Button
                variant="secondary"
                onClick={() => toast.info("Restaurando versão mais recente")}
              >
                <ArrowDownToLine data-icon="inline-start" />
                Restaurar última
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-3">
        {/* Status panel */}
        <div className="flex flex-col gap-4 lg:col-span-1">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Status</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-col gap-2.5">
              <StatusPill
                active={game.autoBackup}
                label="Backup automático"
                onIcon={Zap}
                offIcon={Zap}
              />
              <StatusPill
                active={game.cloudSync}
                label="Sincronização na nuvem"
                onIcon={Cloud}
                offIcon={CloudOff}
              />
              <div className="flex items-center justify-between rounded-lg border border-border bg-muted/40 px-3 py-2.5">
                <span className="flex items-center gap-2 text-sm">
                  <HardDrive className="size-4 text-muted-foreground" />
                  Tamanho do save
                </span>
                <span className="text-xs font-medium">{formatSize(game.sizeMB)}</span>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Preferências rápidas</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-col gap-4">
              <label className="flex items-center justify-between gap-2">
                <span className="text-sm">Backup automático</span>
                <Switch
                  defaultChecked={game.autoBackup}
                  onCheckedChange={(c) =>
                    toast.message(c ? "Backup automático ligado" : "Backup automático desligado")
                  }
                />
              </label>
              <label className="flex items-center justify-between gap-2">
                <span className="text-sm">Enviar para a nuvem</span>
                <Switch
                  defaultChecked={game.cloudSync}
                  onCheckedChange={(c) =>
                    toast.message(c ? "Sincronização na nuvem ligada" : "Sincronização desligada")
                  }
                />
              </label>
            </CardContent>
          </Card>
        </div>

        {/* Timeline */}
        <Card className="lg:col-span-2">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <Clock className="size-4 text-primary" />
              Histórico de versões
            </CardTitle>
          </CardHeader>
          <CardContent>
            {game.backups.length === 0 ? (
              <Empty>
                <EmptyHeader>
                  <EmptyMedia variant="icon">
                    <CloudOff />
                  </EmptyMedia>
                  <EmptyTitle>Nenhum backup ainda</EmptyTitle>
                  <EmptyDescription>
                    Faça o primeiro backup deste jogo para começar a linha do tempo.
                  </EmptyDescription>
                </EmptyHeader>
              </Empty>
            ) : (
              <ol className="relative flex flex-col">
                {game.backups.map((b, i) => (
                  <li key={b.id} className="relative flex gap-4 pb-6 last:pb-0">
                    {/* line */}
                    {i < game.backups.length - 1 && (
                      <span className="absolute left-[7px] top-5 h-full w-px bg-border" />
                    )}
                    <span
                      className={cn(
                        "relative z-10 mt-1 size-3.5 shrink-0 rounded-full border-2 border-background",
                        i === 0 ? "bg-primary" : "bg-muted-foreground/50",
                      )}
                    />
                    <div className="flex min-w-0 flex-1 flex-col gap-2 rounded-lg border border-border bg-muted/30 p-3 sm:flex-row sm:items-center sm:justify-between">
                      <div className="flex min-w-0 flex-col gap-0.5">
                        <div className="flex flex-wrap items-center gap-2">
                          <span className="font-medium">
                            {b.date} às {b.time}
                          </span>
                          {b.cloud ? (
                            <Cloud className="size-3.5 text-primary" />
                          ) : (
                            <CloudOff className="size-3.5 text-muted-foreground" />
                          )}
                        </div>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground">
                          <span className={cn("font-medium", kindColors[b.kind])}>
                            {b.kind}
                          </span>
                          <span>•</span>
                          <span>{formatSize(b.sizeMB)}</span>
                        </div>
                      </div>
                      <div className="flex shrink-0 items-center gap-1.5">
                        <Button
                          size="sm"
                          variant="outline"
                          onClick={() => toast.info(`Restaurando versão de ${b.date} ${b.time}`)}
                        >
                          <RotateCcw data-icon="inline-start" />
                          Restaurar
                        </Button>
                        <Button
                          size="icon-sm"
                          variant="ghost"
                          onClick={() => toast.error("Versão removida")}
                          title="Deletar versão"
                        >
                          <Trash2 />
                          <span className="sr-only">Deletar versão</span>
                        </Button>
                      </div>
                    </div>
                  </li>
                ))}
              </ol>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
