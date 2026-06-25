"use client"

import { useState } from "react"
import { toast } from "sonner"
import {
  Radar,
  FolderPlus,
  Folder,
  Trash2,
  Loader2,
  CheckCircle2,
  Plus,
  Sparkles,
} from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Checkbox } from "@/components/ui/checkbox"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import { Separator } from "@/components/ui/separator"
import { PlatformBadge } from "@/components/platform-badge"
import { cn } from "@/lib/utils"
import { scanResults, watchedFolders, formatSize } from "@/lib/mock-data"

export function ScanClient() {
  const [scanning, setScanning] = useState(false)
  const [progress, setProgress] = useState(0)
  const [hasResults, setHasResults] = useState(false)
  const [selected, setSelected] = useState<Record<string, boolean>>(
    Object.fromEntries(scanResults.filter((r) => r.isNew).map((r) => [r.id, true])),
  )
  const [folders, setFolders] = useState(watchedFolders)

  function startScan() {
    setScanning(true)
    setProgress(0)
    setHasResults(false)
    const interval = setInterval(() => {
      setProgress((p) => {
        if (p >= 100) {
          clearInterval(interval)
          setScanning(false)
          setHasResults(true)
          toast.success("Varredura concluída", {
            description: `${scanResults.filter((r) => r.isNew).length} novos jogos encontrados.`,
          })
          return 100
        }
        return p + 10
      })
    }, 180)
  }

  function addFolder() {
    const path = `D:/Nova Pasta ${folders.length + 1}`
    setFolders((f) => [
      ...f,
      { id: `f${Date.now()}`, path, type: "Personalizada", games: 0 },
    ])
    toast.success("Pasta adicionada ao monitoramento")
  }

  function removeFolder(id: string) {
    setFolders((f) => f.filter((x) => x.id !== id))
  }

  const selectedCount = Object.values(selected).filter(Boolean).length

  return (
    <div className="flex flex-col gap-6">
      {/* Auto scan */}
      <Card className="overflow-hidden">
        <CardContent className="flex flex-col items-center gap-4 py-8 text-center">
          <div className="flex size-16 items-center justify-center rounded-2xl bg-primary/10 text-primary">
            <Radar className={cn("size-8", scanning && "animate-spin")} />
          </div>
          <div className="flex flex-col gap-1">
            <h2 className="text-xl font-semibold">Busca automática</h2>
            <p className="max-w-md text-balance text-sm text-muted-foreground">
              Varre as pastas comuns do sistema (Steam, Epic, Documentos e AppData)
              em busca de saves de jogos.
            </p>
          </div>
          {scanning ? (
            <div className="flex w-full max-w-sm flex-col gap-2">
              <Progress value={progress} />
              <span className="text-xs text-muted-foreground">
                Escaneando... {progress}%
              </span>
            </div>
          ) : (
            <Button size="lg" onClick={startScan}>
              <Sparkles data-icon="inline-start" />
              Iniciar varredura padrão
            </Button>
          )}
        </CardContent>
      </Card>

      {/* Custom folders */}
      <Card>
        <CardHeader className="flex-row items-center justify-between">
          <div className="flex flex-col gap-1">
            <CardTitle className="text-base">Pastas monitoradas</CardTitle>
            <CardDescription>
              Diretórios raiz observados continuamente para novos saves.
            </CardDescription>
          </div>
          <Button variant="outline" size="sm" onClick={addFolder}>
            <Plus data-icon="inline-start" />
            Adicionar pasta
          </Button>
        </CardHeader>
        <CardContent className="flex flex-col gap-2">
          {folders.map((folder) => (
            <div
              key={folder.id}
              className="flex items-center gap-3 rounded-lg border border-border bg-muted/30 p-3"
            >
              <Folder className="size-5 shrink-0 text-primary" />
              <div className="flex min-w-0 flex-1 flex-col">
                <span className="truncate font-mono text-sm">{folder.path}</span>
                <span className="text-xs text-muted-foreground">
                  {folder.games} jogos detectados
                </span>
              </div>
              <Badge variant={folder.type === "Personalizada" ? "secondary" : "outline"}>
                {folder.type}
              </Badge>
              <Button
                size="icon-sm"
                variant="ghost"
                onClick={() => removeFolder(folder.id)}
                title="Remover pasta"
              >
                <Trash2 />
                <span className="sr-only">Remover pasta</span>
              </Button>
            </div>
          ))}
          <button
            onClick={addFolder}
            className="flex items-center justify-center gap-2 rounded-lg border border-dashed border-border py-3 text-sm text-muted-foreground transition-colors hover:border-primary/50 hover:text-foreground"
          >
            <FolderPlus className="size-4" />
            Selecionar nova pasta raiz
          </button>
        </CardContent>
      </Card>

      {/* Results */}
      {hasResults && (
        <Card>
          <CardHeader className="flex-row items-center justify-between">
            <div className="flex flex-col gap-1">
              <CardTitle className="text-base">Resultados da varredura</CardTitle>
              <CardDescription>
                Selecione quais jogos adicionar à sua biblioteca.
              </CardDescription>
            </div>
            <Button
              disabled={selectedCount === 0}
              onClick={() => {
                toast.success(`${selectedCount} jogos adicionados à biblioteca`)
                setHasResults(false)
              }}
            >
              <CheckCircle2 data-icon="inline-start" />
              Adicionar {selectedCount > 0 ? `(${selectedCount})` : ""}
            </Button>
          </CardHeader>
          <CardContent className="flex flex-col gap-2">
            {scanResults.map((r) => (
              <label
                key={r.id}
                className={cn(
                  "flex items-center gap-3 rounded-lg border p-3 transition-colors",
                  r.isNew
                    ? "cursor-pointer border-border bg-muted/30 hover:border-primary/40"
                    : "border-border/60 bg-muted/10 opacity-70",
                )}
              >
                <Checkbox
                  checked={!!selected[r.id]}
                  disabled={!r.isNew}
                  onCheckedChange={(c) =>
                    setSelected((s) => ({ ...s, [r.id]: c === true }))
                  }
                />
                <div className="flex min-w-0 flex-1 flex-col">
                  <span className="flex items-center gap-2 truncate font-medium">
                    {r.title}
                    {!r.isNew && (
                      <Badge variant="outline" className="text-muted-foreground">
                        Já na biblioteca
                      </Badge>
                    )}
                  </span>
                  <span className="truncate font-mono text-xs text-muted-foreground">
                    {r.path}
                  </span>
                </div>
                <Separator orientation="vertical" className="hidden h-8 sm:block" />
                <div className="hidden w-16 shrink-0 text-right text-xs text-muted-foreground sm:block">
                  {formatSize(r.sizeMB)}
                </div>
                <PlatformBadge platform={r.platform} />
              </label>
            ))}
          </CardContent>
        </Card>
      )}
    </div>
  )
}
