import { useState } from "react"
import { ArrowUpToLine, Loader2 } from "lucide-react"
import { AppShell } from "@/components/app-shell"
import { Button } from "@/components/ui/button"
import { LibraryClient } from "@/components/dashboard/library-client"
import { useLibrary } from "@/lib/library-context"
import { toast } from "sonner"
import { useI18n } from "@/lib/i18n"

const isTauri = typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;

export default function Dashboard() {
  const { games, loadGames } = useLibrary()
  const { t } = useI18n()
  const [selected, setSelected] = useState<Record<string, boolean>>({})
  const [backingUp, setBackingUp] = useState(false)

  const selectedCount = Object.values(selected).filter(Boolean).length

  const handleBackupSelected = async () => {
    const gamesToBackup = selectedCount > 0 ? games.filter(g => selected[g.id]) : games;
    if (gamesToBackup.length === 0) return;

    setBackingUp(true);
    const toastId = toast.loading(t("ludocard-toast-backing-up", "Fazendo backup de saves..."));
    try {
      if (isTauri) {
        const { invoke } = await import("@tauri-apps/api/core");
        for (const game of gamesToBackup) {
          await invoke("backup_game", { gameTitle: game.title });
        }
        toast.success(
          selectedCount > 0
            ? t("ludocard-toast-backup-selected-success", "Backup concluído para os jogos selecionados!")
            : t("ludocard-toast-backup-all-success", "Backup concluído para todos os jogos!"),
          { id: toastId }
        );
        loadGames(true);
      } else {
        await new Promise(resolve => setTimeout(resolve, 1500));
        toast.success(
          selectedCount > 0
            ? `[Mock] ${t("ludocard-toast-backup-selected-success", "Backup concluído para os jogos selecionados!")}`
            : `[Mock] ${t("ludocard-toast-backup-all-success", "Backup concluído para todos os jogos!")}`,
          { id: toastId }
        );
      }
      setSelected({}); // Clear selection after backup
    } catch (err) {
      toast.error(`${t("ludocard-toast-backup-failed", "Falha no backup:")} ${err}`, { id: toastId });
    } finally {
      setBackingUp(false);
    }
  };

  return (
    <AppShell
      title={t("ludocard-library", "Biblioteca")}
      description={t("ludocard-dashboard-desc", "Gerencie e proteja os saves dos seus jogos")}
      actions={
        <Button
          disabled={backingUp || games.length === 0}
          onClick={handleBackupSelected}
          variant="default"
        >
          {backingUp ? (
            <Loader2 className="size-4 animate-spin" data-icon="inline-start" />
          ) : (
            <ArrowUpToLine data-icon="inline-start" />
          )}
          {selectedCount > 0
            ? `${t("button-backup", "Fazer backup")} (${selectedCount}/${games.length})`
            : `${t("ludocard-backup-all", "Fazer backup de todos")} (${games.length}/${games.length})`}
        </Button>
      }
    >
      <LibraryClient selected={selected} setSelected={setSelected} />
    </AppShell>
  )
}

