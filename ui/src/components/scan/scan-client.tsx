import { useState, useEffect } from "react"
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
import { formatSize } from "@/lib/mock-data"
import { useLibrary } from "@/lib/library-context"

const isTauri = typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;

export function ScanClient() {
  const { games, loadGames, scanGames } = useLibrary()
  const [scanning, setScanning] = useState(false)
  const [progress, setProgress] = useState(0)
  const [hasResults, setHasResults] = useState(false)
  const [folders, setFolders] = useState<{ id: string; path: string; type: string; games: number }[]>([])
  
  // Scanned games are games that are not backed up or have pending changes
  const scanResultsList = games.filter(g => g.status === "never" || g.status === "pending")

  const [selected, setSelected] = useState<Record<string, boolean>>({})

  useEffect(() => {
    // Select all new games by default
    setSelected(
      Object.fromEntries(scanResultsList.map((r) => [r.id, true]))
    )
  }, [games])

  const loadRoots = async () => {
    if (!isTauri) {
      setFolders([]);
      return;
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core");
      const list = await invoke<{ id: string; path: string; store: string }[]>("get_roots");
      setFolders(
        list.map((r) => ({
          id: r.id,
          path: r.path,
          type: r.store === "Other" ? "Personalizada" : "Padrão",
          games: 0, // In backend, these are scanned automatically
        }))
      );
    } catch (err) {
      console.error("Failed to load roots:", err);
    }
  };

  useEffect(() => {
    loadRoots();
  }, []);

  async function startScan() {
    setScanning(true)
    setProgress(10)
    // Animate progress while waiting for the full backend scan
    const progressInterval = setInterval(() => {
      setProgress((prev) => Math.min(prev + 3, 90))
    }, 500)
    try {
      await scanGames()
      clearInterval(progressInterval)
      setProgress(100)
      setHasResults(true)
      toast.success("Varredura concluída", {
        description: `Detecção de alterações finalizada.`,
      })
    } catch (err) {
      clearInterval(progressInterval)
      toast.error("Erro ao realizar varredura.")
    } finally {
      setScanning(false)
    }
  }

  async function addFolder() {
    if (!isTauri) {
      const path = `D:/Nova Pasta ${folders.length + 1}`
      setFolders((f) => [
        ...f,
        { id: `f${Date.now()}`, path, type: "Personalizada", games: 0 },
      ])
      toast.success("Pasta adicionada ao monitoramento")
      return;
    }

    try {
      const { invoke } = await import("@tauri-apps/api/core");
      const selected = await invoke<string | null>("select_folder");
      if (selected) {
        await invoke("add_root", { path: selected });
        toast.success("Pasta adicionada com sucesso!");
        loadRoots();
      }
    } catch (err) {
      console.error("Failed to add folder root:", err);
      toast.error("Erro ao selecionar/adicionar pasta.");
    }
  }

  async function removeFolder(path: string) {
    if (!isTauri) {
      setFolders((f) => f.filter((x) => x.path !== path))
      return;
    }

    try {
      const { invoke } = await import("@tauri-apps/api/core");
      await invoke("remove_root", { path });
      toast.success("Pasta removida do monitoramento");
      loadRoots();
    } catch (err) {
      console.error("Failed to remove folder root:", err);
      toast.error("Erro ao remover pasta.");
    }
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
              e suas pastas customizadas em busca de novos saves ou alterações.
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
              Iniciar varredura de alterações
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
          {folders.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-8 text-center text-muted-foreground">
              <FolderPlus className="size-8 text-muted-foreground/30 mb-2.5" />
              <p className="text-sm font-medium">Nenhuma pasta de jogos detectada automaticamente.</p>
              <p className="text-xs text-muted-foreground/80 mt-0.5">Clique em "Adicionar pasta" para selecionar uma pasta de biblioteca ou emuladores.</p>
            </div>
          ) : (
            folders.map((folder) => (
              <div
                key={folder.id}
                className="flex items-center gap-3 rounded-lg border border-border bg-muted/30 p-3"
              >
                <Folder className="size-5 shrink-0 text-primary" />
                <div className="flex min-w-0 flex-1 flex-col">
                  <span className="truncate font-mono text-sm">{folder.path}</span>
                  <span className="text-xs text-muted-foreground">
                    Monitoramento ativo
                  </span>
                </div>
                <Badge variant={folder.type === "Personalizada" ? "secondary" : "outline"}>
                  {folder.type}
                </Badge>
                <Button
                  size="icon-sm"
                  variant="ghost"
                  onClick={() => removeFolder(folder.path)}
                  title="Remover pasta"
                >
                  <Trash2 />
                  <span className="sr-only">Remover pasta</span>
                </Button>
              </div>
            ))
          )}
          {folders.length > 0 && (
            <button
              onClick={addFolder}
              className="flex items-center justify-center gap-2 rounded-lg border border-dashed border-border py-3 text-sm text-muted-foreground transition-colors hover:border-primary/50 hover:text-foreground"
            >
              <FolderPlus className="size-4" />
              Selecionar nova pasta raiz
            </button>
          )}
        </CardContent>
      </Card>

      {/* Results */}
      {hasResults && (
        <Card>
          <CardHeader className="flex-row items-center justify-between">
            <div className="flex flex-col gap-1">
              <CardTitle className="text-base">Resultados da varredura</CardTitle>
              <CardDescription>
                Selecione quais jogos com saves novos ou alterados você deseja fazer backup.
              </CardDescription>
            </div>
            <Button
              disabled={selectedCount === 0}
              onClick={async () => {
                const gamesToBackup = scanResultsList.filter(r => selected[r.id]);
                const id = toast.loading(`Iniciando backup em lote para ${gamesToBackup.length} jogos...`);
                try {
                  const { invoke } = await import("@tauri-apps/api/core");
                  for (const game of gamesToBackup) {
                    await invoke("backup_game", { gameTitle: game.title });
                  }
                  toast.success(`Backup dos jogos selecionados concluído!`, { id });
                  loadGames(true);
                  setHasResults(false);
                } catch (err) {
                  toast.error(`Falha no backup em lote.`, { id });
                }
              }}
            >
              <CheckCircle2 data-icon="inline-start" />
              Fazer Backup Selecionados {selectedCount > 0 ? `(${selectedCount})` : ""}
            </Button>
          </CardHeader>
          <CardContent className="flex flex-col gap-2">
            {scanResultsList.length === 0 ? (
              <div className="py-6 text-center text-sm text-muted-foreground">
                Nenhum novo save ou alteração detectada. Todos os jogos estão sincronizados!
              </div>
            ) : (
              <>
                <div className="flex items-center gap-3 px-3 py-2 bg-muted/20 rounded-lg border border-border">
                  <Checkbox
                    id="select-all-scan"
                    checked={scanResultsList.length > 0 && selectedCount === scanResultsList.length}
                    onCheckedChange={(c) => {
                      const allSelected = c === true;
                      setSelected(
                        Object.fromEntries(scanResultsList.map((r) => [r.id, allSelected]))
                      );
                    }}
                  />
                  <label htmlFor="select-all-scan" className="text-xs font-medium cursor-pointer select-none text-muted-foreground">
                    Selecionar todos
                  </label>
                </div>
                {scanResultsList.map((r) => (
                  <label
                    key={r.id}
                    className="flex items-center gap-3 rounded-lg border cursor-pointer border-border bg-muted/30 hover:border-primary/40 p-3 transition-colors"
                  >
                    <Checkbox
                      checked={!!selected[r.id]}
                      onCheckedChange={(c) =>
                        setSelected((s) => ({ ...s, [r.id]: c === true }))
                      }
                    />
                  <div className="flex min-w-0 flex-1 flex-col">
                    <span className="flex items-center gap-2 truncate font-medium">
                      {r.title}
                      {r.status === "never" ? (
                        <Badge variant="outline" className="text-rose-400 border-rose-400/30 bg-rose-500/10">
                          Novo Jogo
                        </Badge>
                      ) : (
                        <Badge variant="outline" className="text-amber-400 border-amber-400/30 bg-amber-500/10">
                          Alterado
                        </Badge>
                      )}
                    </span>
                    <span className="truncate font-mono text-xs text-muted-foreground">
                      {r.savePath}
                    </span>
                  </div>
                  <Separator orientation="vertical" className="hidden h-8 sm:block" />
                  <div className="hidden w-16 shrink-0 text-right text-xs text-muted-foreground sm:block">
                    {formatSize(r.sizeMB)}
                  </div>
                  <PlatformBadge platform={r.platform} />
                </label>
              ))}
            </>
          )}
          </CardContent>
        </Card>
      )}
    </div>
  )
}

