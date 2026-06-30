import { useState, useEffect } from "react"
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
  Folder,
  FolderSync,
  Package,
  Pin,
  Share2,
  FileArchive,
  X,
  SlidersHorizontal,
  Cpu,
  ThumbsUp,
  ThumbsDown,
  AlertTriangle,
  Sparkles,
  Check,
  Info,
  RefreshCw,
  Download,
  Gamepad2,
} from "lucide-react"

import { Button } from "@/components/ui/button"
import { Switch } from "@/components/ui/switch"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription } from "@/components/ui/empty"
import { PlatformBadge } from "@/components/platform-badge"
import { cn } from "@/lib/utils"
import { type Game, type BackupKind, formatSize } from "@/lib/mock-data"
import { cleanGameTitle } from "@/components/dashboard/library-client"

interface TagInfo {
  name: string
  description: string
}

const PREDEFINED_PRESET_TAGS: TagInfo[] = [
  { name: "Performance", description: "Otimizações focadas em ganho de FPS e fluidez." },
  { name: "Qualidade / Visual", description: "Otimizações focadas em qualidade gráfica máxima." },
  { name: "Balanced", description: "Equilíbrio ideal entre fidelidade visual e taxa de FPS." },
  { name: "Steam Deck", description: "Perfil otimizado especificamente para a tela e bateria do Steam Deck/portáteis." },
  { name: "Potato Mode", description: "Para rodar em PCs super antigos e notebooks modestos." },
  { name: "Controles / Layout", description: "Mapeamento customizado de controles, gamepad ou hotkeys." },
  { name: "Ray Tracing Opt", description: "Configuração refinada com traçado de raio ativo, visando boa taxa de quadros." },
  { name: "4K Ready", description: "Otimizações focadas em TVs e monitores 4K de alta definição." },
  { name: "VR Ready", description: "Configurações ajustadas para taxa de FPS ideal em realidade virtual." }
]

const kindColors: Record<BackupKind | string, string> = {
  Automático: "text-primary",
  Manual: "text-sky-300",
  "Antes de fechar": "text-amber-300",
  Restauração: "text-violet-300",
}

const isTauri = typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;

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

interface GameDetailClientProps {
  game: Game
  onRefresh?: () => void
}

export function GameDetailClient({ game, onRefresh }: GameDetailClientProps) {
  // Tabs & safety backup check
  const [activeTab, setActiveTab] = useState<"saves" | "presets">("saves")
  const [hasCrashSafetyBackup, setHasCrashSafetyBackup] = useState(false)

  // Presets states
  const [presets, setPresets] = useState<any[]>([])
  const [loadingPresets, setLoadingPresets] = useState(false)
  const [clientUuid, setClientUuid] = useState("")
  const [supabaseUrl, setSupabaseUrl] = useState("")
  const [supabaseAnonKey, setSupabaseAnonKey] = useState("")
  const [isConfigured, setIsConfigured] = useState(false)

  // Local Presets states
  const [localPresets, setLocalPresets] = useState<any[]>([])
  const [presetSubTab, setPresetSubTab] = useState<"local" | "community">("local")
  const [isCreateLocalPresetModalOpen, setIsCreateLocalPresetModalOpen] = useState(false)
  const [selectedLocalPresetForShare, setSelectedLocalPresetForShare] = useState<any | null>(null)
  const [importingPreset, setImportingPreset] = useState<string | null>(null)
  const [selectedDetailPreset, setSelectedDetailPreset] = useState<any | null>(null)
  
  // Create Local Preset Form State
  const [newLocalTitle, setNewLocalTitle] = useState("")
  const [newLocalDesc, setNewLocalDesc] = useState("")

  // Share Preset Modal state
  const [isSharePresetModalOpen, setIsSharePresetModalOpen] = useState(false)
  const [configFiles, setConfigFiles] = useState<string[]>([])
  const [selectedConfigFiles, setSelectedConfigFiles] = useState<string[]>([])
  const [loadingHardware, setLoadingHardware] = useState(false)
  const [loadingConfigs, setLoadingConfigs] = useState(false)

  // Share Preset Form
  const [presetTitle, setPresetTitle] = useState("")
  const [presetDesc, setPresetDesc] = useState("")
  const [authorName, setAuthorName] = useState("")
  const [cpu, setCpu] = useState("")
  const [gpu, setGpu] = useState("")
  const [ram, setRam] = useState("")
  const [selectedTags, setSelectedTags] = useState<string[]>([])
  const [publishing, setPublishing] = useState(false)

  // Local Save Detail Modal State
  const [selectedLocalBackup, setSelectedLocalBackup] = useState<any | null>(null)
  const [localNote, setLocalNote] = useState("")

  const handleOpenLocalBackupModal = (b: any) => {
    setSelectedLocalBackup(b)
    setLocalNote(b.note || "")
  }

  const handleSaveNote = async () => {
    if (!selectedLocalBackup) return
    const id = toast.loading("Salvando nota do backup...")
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      await invoke("save_backup_note", {
        gameId: game.id,
        backupId: selectedLocalBackup.id,
        note: localNote,
      })
      toast.success("Nota salva com sucesso!", { id })
      setSelectedLocalBackup(null)
      if (onRefresh) onRefresh()
    } catch (err) {
      toast.error(`Falha ao salvar nota: ${err}`, { id })
    }
  }

  function copyPath() {
    navigator.clipboard?.writeText(game.savePath)
    toast.success("Caminho copiado")
  }

  const handleBackup = async () => {
    if (isTauri) {
      const id = toast.loading(`Fazendo backup manual de "${game.title}"...`);
      try {
        const { invoke } = await import("@tauri-apps/api/core");
        await invoke("backup_game", { gameTitle: game.title });
        toast.success(`Backup de "${game.title}" criado com sucesso!`, { id });
        if (onRefresh) onRefresh();
      } catch (err) {
        toast.error(`Falha no backup: ${err}`, { id });
      }
    } else {
      toast.success(`[Mock] Backup de "${game.title}" criado`);
    }
  };

  const handleRestoreLatest = async () => {
    if (isTauri) {
      const id = toast.loading(`Restaurando backup mais recente de "${game.title}"...`);
      try {
        const { invoke } = await import("@tauri-apps/api/core");
        await invoke("restore_game", { gameTitle: game.title, backupId: null });
        toast.success(`Versão mais recente de "${game.title}" restaurada!`, { id });
        if (onRefresh) onRefresh();
      } catch (err) {
        toast.error(`Falha ao restaurar: ${err}`, { id });
      }
    } else {
      toast.info(`[Mock] Restaurando versão mais recente de "${game.title}"`);
    }
  };

  const handleRestoreVersion = async (versionId: string, versionDate: string) => {
    if (isTauri) {
      const id = toast.loading(`Restaurando versão "${versionId}" de "${game.title}"...`);
      try {
        const { invoke } = await import("@tauri-apps/api/core");
        await invoke("restore_game", { gameTitle: game.title, backupId: versionId });
        toast.success(`Versão de ${versionDate} restaurada!`, { id });
        if (onRefresh) onRefresh();
      } catch (err) {
        toast.error(`Falha ao restaurar versão: ${err}`, { id });
      }
    } else {
      toast.info(`[Mock] Restaurando versão de ${versionDate}`);
    }
  };

  const handleExportBackupVersion = async (backupId: string, backupDate: string, backupTime: string) => {
    if (!isTauri) {
      toast.info(`[Mock] Exportando backup de "${game.title}" (${backupDate}) como .ludocard`);
      return;
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core");

      const slugName = game.id.replace(/[^a-z0-9-]/gi, "-");
      const formattedDate = backupDate.replace(/[^a-z0-9-]/gi, "-");
      const formattedTime = backupTime.replace(/[^a-z0-9-]/gi, "-");
      const destPath = await invoke<string | null>("save_ludocard_dialog", {
        defaultName: `${slugName}_backup_${formattedDate}_${formattedTime}.ludocard`,
      });
      if (!destPath) return;

      const toastId = toast.loading(`Compactando backup de "${game.title}"...`);
      const metadata = await invoke<any>("export_ludocard_backup", {
        gameTitle: game.title,
        gameId: game.id,
        checkpointTitle: `Backup de ${game.title} - ${backupDate} ${backupTime}`,
        description: `Exportado a partir do backup local realizado em ${backupDate} às ${backupTime}.`,
        backupPath: game.backupPath || "",
        backupId: backupId,
        savePath: game.savePath,
        destPath: destPath,
      });

      const compressedMB = (metadata.compressedSizeBytes / (1024 * 1024)).toFixed(1);
      const originalMB = (metadata.totalSizeBytes / (1024 * 1024)).toFixed(1);
      toast.success(
        `Exportado com sucesso! ${originalMB} MB → ${compressedMB} MB compactado`,
        { id: toastId }
      );
    } catch (err) {
      toast.error(`Falha ao exportar backup: ${err}`);
    }
  };

  const handleToggleLocked = async (versionId: string, currentLocked: boolean) => {
    if (isTauri) {
      const nextLocked = !currentLocked;
      const id = toast.loading(
        nextLocked
          ? `Bloqueando versão "${versionId}"...`
          : `Desbloqueando versão "${versionId}"...`
      );
      try {
        const { invoke } = await import("@tauri-apps/api/core");
        await invoke("toggle_backup_locked", {
          gameTitle: game.title,
          backupId: versionId,
          locked: nextLocked,
        });
        toast.success(
          nextLocked
            ? "Versão bloqueada com sucesso! Ela não será deletada automaticamente."
            : "Versão desbloqueada com sucesso.",
          { id }
        );
        if (onRefresh) onRefresh();
      } catch (err) {
        toast.error(`Falha ao alterar status da versão: ${err}`, { id });
      }
    } else {
      toast.info(`[Mock] Alterado bloqueio da versão "${versionId}" para ${!currentLocked}`);
    }
  };

  const handleOpenFolder = async (folderType: "game" | "save" | "backup") => {
    if (!isTauri) {
      toast.info(`[Mock] Abrindo pasta de ${folderType === "game" ? "instalação" : folderType === "save" ? "saves" : "backups"} para ${game.title}`);
      return;
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core");
      await invoke("open_game_folder", {
        gameTitle: game.title,
        folderType,
        savePath: game.savePath,
      });
    } catch (err) {
      console.error(err);
      toast.error(`Erro ao abrir pasta: ${err}`);
    }
  };

  const handleExportSave = async () => {
    if (!isTauri) {
      toast.info(`[Mock] Exportando save de "${game.title}" como .ludocard`);
      return;
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core");

      const slugName = game.id.replace(/[^a-z0-9-]/gi, "-");
      const destPath = await invoke<string | null>("save_ludocard_dialog", {
        defaultName: `${slugName}.ludocard`,
      });
      if (!destPath) return;

      const toastId = toast.loading(`Compactando save de "${game.title}"...`);
      const metadata = await invoke<any>("export_ludocard_save", {
        gameTitle: game.title,
        gameId: game.id,
        checkpointTitle: `Save de ${game.title}`,
        description: "",
        sourcePath: game.savePath,
        destPath: destPath,
      });

      const compressedMB = (metadata.compressedSizeBytes / (1024 * 1024)).toFixed(1);
      const originalMB = (metadata.totalSizeBytes / (1024 * 1024)).toFixed(1);
      toast.success(
        `Exportado com sucesso! ${originalMB} MB → ${compressedMB} MB compactado`,
        { id: toastId }
      );
    } catch (err) {
      toast.error(`Falha ao exportar: ${err}`);
    }
  };

  // Preset sharing database fetch
  const fetchGamePresets = async () => {
    setLoadingPresets(true)
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const settings = await invoke<any>("get_settings")
      const uuid = await invoke<string>("get_client_uuid")
      
      const url = settings.supabaseUrl || ""
      const key = settings.supabaseAnonKey || ""
      
      setSupabaseUrl(url)
      setSupabaseAnonKey(key)
      setClientUuid(uuid)

      if (url && key) {
        setIsConfigured(true)
        const response = await fetch(`${url}/rest/v1/public_presets?game_id=eq.${game.id}&select=*`, {
          headers: {
            "apikey": key,
            "Authorization": `Bearer ${key}`
          }
        })
        if (response.ok) {
          const data = await response.json()
          const mapped = data.map((item: any) => ({
            id: item.id,
            gameName: item.game_name,
            gameId: item.game_id,
            title: item.title,
            fileName: item.file_name,
            r2Path: item.r2_path,
            fileSize: Number(item.file_size || 0),
            description: item.description || "",
            authorName: item.author_name || "Anônimo",
            userUuid: item.user_uuid,
            cpu: item.cpu || "",
            gpu: item.gpu || "",
            ram: item.ram || "",
            isOfficial: item.is_official || false,
            upvotes: Number(item.upvotes || 0),
            downvotes: Number(item.downvotes || 0),
            reportsCount: Number(item.reports_count || 0),
            downloadsCount: Number(item.downloads_count || 0),
            tags: item.tags || [],
            createdAt: item.created_at
          }))
          setPresets(mapped)
        } else {
          toast.error("Erro ao carregar presets comunitários.")
        }
      } else {
        setIsConfigured(false)
        // Load mock presets
        const { mockPresets } = await import("@/lib/mock-data")
        const gamePresets = mockPresets.filter(p => p.gameId === game.id)
        setPresets(gamePresets)
      }
    } catch (err) {
      console.error(err)
      setIsConfigured(false)
    } finally {
      setLoadingPresets(false)
    }
  }

  // Load local presets
  const fetchLocalPresets = async () => {
    if (!isTauri) {
      setLocalPresets([
        {
          id: "local-mock-1",
          gameId: game.id,
          gameTitle: game.title,
          title: "Meu Perfil - Ultra Performance",
          description: "Desativa sombras volumétricas e reduz resolução de texturas secundárias. Perfeito para manter 60fps constantes.",
          cpu: "Intel Core i5-10400F",
          gpu: "NVIDIA GeForce GTX 1660 Super",
          ram: "16 GB",
          createdAt: "2026-06-28T10:00:00Z",
          files: ["GameUserSettings.ini"]
        }
      ])
      return
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const list = await invoke<any[]>("list_local_presets", {
        gameId: game.id
      })
      setLocalPresets(list)
    } catch (err) {
      console.error("Erro ao listar presets locais:", err)
    }
  }

  // Load safety backup status & presets
  useEffect(() => {
    const safety = localStorage.getItem(`ludocard_preset_safety_${game.id}`)
    setHasCrashSafetyBackup(safety === "true")
    if (activeTab === "presets") {
      fetchGamePresets()
      fetchLocalPresets()
    }
  }, [game.id, activeTab])

  // Save Local Preset
  const handleSaveLocalPreset = async (title: string, description: string, files: string[]) => {
    if (files.length === 0) {
      toast.error("Selecione pelo menos um arquivo de configuração.")
      return
    }
    const id = toast.loading("Salvando configurações locais como preset...")
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      if (isTauri) {
        await invoke("save_local_preset", {
          gameId: game.id,
          gameTitle: game.title,
          title,
          description,
          files,
        })
      }
      toast.success("Preset local criado com sucesso!", { id })
      fetchLocalPresets()
      setIsCreateLocalPresetModalOpen(false)
      setNewLocalTitle("")
      setNewLocalDesc("")
    } catch (err) {
      toast.error(`Falha ao salvar preset local: ${err}`, { id })
    }
  }

  // Apply Local Preset
  const handleApplyLocalPreset = async (preset: any) => {
    const id = toast.loading(`Iniciando Seguro-Crash para configurações de ${game.title}...`)
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      if (isTauri) {
        await invoke("apply_local_preset", {
          gameTitle: game.title,
          gameId: game.id,
          presetId: preset.id,
        })
        localStorage.setItem(`ludocard_preset_safety_${game.id}`, "true")
        setHasCrashSafetyBackup(true)
      } else {
        await new Promise(r => setTimeout(r, 1000))
      }
      toast.success(`Preset local "${preset.title}" injetado com sucesso!`, { id })
    } catch (err) {
      toast.error(`Falha ao aplicar preset local: ${err}`, { id })
    }
  }

  // Delete Local Preset
  const handleDeleteLocalPreset = async (presetId: string) => {
    if (!confirm("Deseja realmente deletar este preset local permanentemente?")) return
    const id = toast.loading("Excluindo preset local...")
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      if (isTauri) {
        await invoke("delete_local_preset", {
          gameId: game.id,
          presetId,
        })
      }
      toast.success("Preset local deletado com sucesso!", { id })
      fetchLocalPresets()
    } catch (err) {
      toast.error(`Erro ao deletar preset: ${err}`, { id })
    }
  }

  // Open Share Local Preset community wizard
  const handleShareLocalPreset = (preset: any) => {
    setSelectedLocalPresetForShare(preset)
    setIsSharePresetModalOpen(true)
    setPresetTitle(preset.title)
    setPresetDesc(preset.description)
    setCpu(preset.cpu || "")
    setGpu(preset.gpu || "")
    setRam(preset.ram || "")
    setConfigFiles(preset.files || [])
    setSelectedConfigFiles(preset.files || [])
  }

  // Apply Preset (Community)
  const handleApplyPreset = async (preset: any) => {
    const toastId = toast.loading("Iniciando Seguro-Crash para salvaguardar configurações...")
    try {
      const { invoke } = await import("@tauri-apps/api/core")

      // Step 1: Create safety backup of configs only
      if (isTauri) {
        await invoke("create_preset_safety_backup", {
          gameTitle: game.title,
          gameId: game.id,
        })
        localStorage.setItem(`ludocard_preset_safety_${game.id}`, "true")
        setHasCrashSafetyBackup(true)
      }

      toast.loading("Baixando e aplicando preset de configurações otimizadas...", { id: toastId })

      // Step 2: Get download url
      let downloadUrl = ""
      if (isTauri && isConfigured) {
        const edgeRes = await fetch(`${supabaseUrl}/functions/v1/get-download-url`, {
          method: "POST",
          headers: {
            "apikey": supabaseAnonKey,
            "Authorization": `Bearer ${supabaseAnonKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ r2_path: preset.r2Path })
        })

        if (edgeRes.ok) {
          const resData = await edgeRes.json()
          downloadUrl = resData.downloadUrl
        }
      }

      // Step 3: Inject files (falls back to mock if not configured)
      if (isTauri && downloadUrl) {
        await invoke("download_and_import_ludocard", {
          downloadUrl,
          targetSaveDir: game.savePath,
        })

        // Save preset metadata locally so it is registered in "Meus Presets"
        await invoke("save_local_preset", {
          gameId: game.id,
          gameTitle: game.title,
          title: preset.title,
          description: `${preset.description} (Baixado da comunidade - Autor: ${preset.authorName})`,
          files: preset.tags,
        }).catch(err => console.error(err))

        // Step 4: Increment download count in Supabase
        await fetch(`${supabaseUrl}/rest/v1/rpc/increment_preset_downloads`, {
          method: "POST",
          headers: {
            "apikey": supabaseAnonKey,
            "Authorization": `Bearer ${supabaseAnonKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ preset_id: preset.id })
        })
      } else {
        // Mock download duration
        await new Promise(r => setTimeout(r, 1500))
      }

      toast.success("Preset comunitário injetado com sucesso! Salvo na sua biblioteca local.", { id: toastId })
      fetchGamePresets()
      fetchLocalPresets()
    } catch (err) {
      console.error(err)
      toast.error(`Falha ao aplicar preset: ${err}`, { id: toastId })
    }
  }

  // Restore Original Configurations (Undo)
  const handleUndoPreset = async () => {
    const toastId = toast.loading("Restaurando arquivos de configurações originais do Seguro-Crash...")
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      if (isTauri) {
        await invoke("restore_preset_safety_backup", {
          gameId: game.id,
        })
      } else {
        await new Promise(r => setTimeout(r, 1200))
      }

      localStorage.removeItem(`ludocard_preset_safety_${game.id}`)
      setHasCrashSafetyBackup(false)
      toast.success("Configuração original restaurada com sucesso! Saves intocados.", { id: toastId })
    } catch (err) {
      console.error(err)
      toast.error(`Falha ao restaurar backup Seguro-Crash: ${err}`, { id: toastId })
    }
  }

  // Vote on Preset
  const handleVote = async (presetId: string, isUpvote: boolean) => {
    try {
      if (isConfigured) {
        await fetch(`${supabaseUrl}/rest/v1/rpc/vote_preset`, {
          method: "POST",
          headers: {
            "apikey": supabaseAnonKey,
            "Authorization": `Bearer ${supabaseAnonKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ preset_id: presetId, is_upvote: isUpvote })
        })
      }
      toast.success("Voto computado com sucesso! Obrigado.")
      
      // Update local state
      setPresets(prev => prev.map(p => {
        if (p.id === presetId) {
          return {
            ...p,
            upvotes: isUpvote ? p.upvotes + 1 : p.upvotes,
            downvotes: !isUpvote ? p.downvotes + 1 : p.downvotes
          }
        }
        return p
      }))
    } catch (err) {
      toast.error("Falha ao computar voto.")
    }
  }

  // Report Preset
  const handleReport = async (presetId: string) => {
    try {
      if (isConfigured) {
        await fetch(`${supabaseUrl}/rest/v1/rpc/report_preset`, {
          method: "POST",
          headers: {
            "apikey": supabaseAnonKey,
            "Authorization": `Bearer ${supabaseAnonKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ preset_id: presetId })
        })
      }
      toast.success("Denúncia enviada! Preset será ocultado da comunidade se receber 3 denúncias.")
      
      // Update local state and hide if reports count reaches 3
      setPresets(prev => prev.map(p => {
        if (p.id === presetId) {
          return { ...p, reportsCount: p.reportsCount + 1 }
        }
        return p
      }).filter(p => p.id !== presetId || p.reportsCount < 3))
    } catch (err) {
      toast.error("Falha ao enviar denúncia.")
    }
  }

  // Open Share Preset Modal & Load Hardware + Config Files
  const handleOpenSharePreset = async () => {
    setIsSharePresetModalOpen(true)
    setLoadingHardware(true)
    setLoadingConfigs(true)
    setSelectedTags([])
    setPresetTitle("")
    setPresetDesc("")

    try {
      const { invoke } = await import("@tauri-apps/api/core")

      // 1. Get detected config files
      if (isTauri) {
        const files = await invoke<string[]>("detect_game_config_files", {
          gameTitle: game.title
        })
        setConfigFiles(files)
        setSelectedConfigFiles(files) // check all by default
      } else {
        setConfigFiles(["C:/Users/Player/AppData/Roaming/AetherFrontier/Saves/config.ini"])
        setSelectedConfigFiles(["C:/Users/Player/AppData/Roaming/AetherFrontier/Saves/config.ini"])
      }
      setLoadingConfigs(false)

      // 2. Detect System Hardware Info
      if (isTauri) {
        const hardware = await invoke<any>("get_system_hardware_info")
        setCpu(hardware.cpu)
        setGpu(hardware.gpu)
        setRam(hardware.ram)
      } else {
        setCpu("Intel Core i5-10400F")
        setGpu("NVIDIA GeForce GTX 1660 Super")
        setRam("16 GB")
      }
      setLoadingHardware(false)

    } catch (err) {
      console.error("Error fetching preset requirements:", err)
      setLoadingConfigs(false)
      setLoadingHardware(false)
    }
  }

  // Publish Preset Form handler
  const handlePublishPreset = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!presetTitle) {
      toast.error("Por favor, preencha o título do preset.")
      return
    }

    setPublishing(true)
    let tempPath = ""
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const toastId = toast.loading("Empacotando arquivos de configuração...")

      // Step 1: Export preset files to a temporary .ludocard archive
      if (isTauri) {
        let presetInfo;
        if (selectedLocalPresetForShare) {
          presetInfo = await invoke<any>("export_local_preset_archive", {
            gameId: game.id,
            presetId: selectedLocalPresetForShare.id,
            savePath: game.savePath,
          });
        } else {
          if (selectedConfigFiles.length === 0) {
            toast.error("Selecione pelo menos um arquivo de configuração.")
            setPublishing(false)
            return
          }
          presetInfo = await invoke<any>("export_temp_ludocard_preset", {
            gameTitle: game.title,
            gameId: game.id,
            presetTitle: presetTitle,
            description: presetDesc,
            savePath: game.savePath,
            files: selectedConfigFiles,
          });
        }
        tempPath = presetInfo.filePath
        const fileSize = presetInfo.fileSize
        const fileName = presetInfo.fileName

        if (isConfigured) {
          toast.loading("Requisitando upload seguro para o storage R2...", { id: toastId })
          
          // Step 2: Get pre-signed upload URL from Edge Function
          const edgeRes = await fetch(`${supabaseUrl}/functions/v1/get-upload-url`, {
            method: "POST",
            headers: {
              "apikey": supabaseAnonKey,
              "Authorization": `Bearer ${supabaseAnonKey}`,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              file_name: fileName,
              file_size: fileSize,
              user_uuid: clientUuid,
              game_id: game.id,
              is_preset: true,
            })
          })

          if (!edgeRes.ok) {
            const errData = await edgeRes.json().catch(() => ({}))
            throw new Error(errData.error || `Erro de cota ou limite no repositório.`);
          }

          const { uploadUrl, r2Path } = await edgeRes.json()

          toast.loading("Realizando upload seguro dos arquivos...", { id: toastId })

          // Step 3: Run Rust direct upload
          await invoke("upload_file_to_url", {
            filePath: tempPath,
            uploadUrl: uploadUrl,
          })

          toast.loading("Publicando metadados do preset na comunidade...", { id: toastId })

          // Step 4: Write record to public_presets table
          const dbRes = await fetch(`${supabaseUrl}/rest/v1/public_presets`, {
            method: "POST",
            headers: {
              "apikey": supabaseAnonKey,
              "Authorization": `Bearer ${supabaseAnonKey}`,
              "Content-Type": "application/json",
              "Prefer": "return=minimal"
            },
            body: JSON.stringify({
              game_name: game.title,
              game_id: game.id,
              title: presetTitle,
              file_name: fileName,
              r2_path: r2Path,
              file_size: fileSize,
              description: presetDesc,
              author_name: authorName || "Anônimo",
              user_uuid: clientUuid,
              cpu,
              gpu,
              ram,
              tags: selectedTags,
              is_official: false,
            })
          })

          if (!dbRes.ok) {
            const errText = await dbRes.text()
            if (errText.includes("enforce_user_preset_quota_trigger")) {
              throw new Error("Você atingiu o limite de 5 presets ativos na nuvem.")
            }
            throw new Error(`Falha ao registrar preset: ${errText}`)
          }
        }

        toast.success("Preset compartilhado na comunidade com sucesso!", { id: toastId })
      } else {
        await new Promise(r => setTimeout(r, 2000))
        toast.success("[Mock] Preset publicado com sucesso!")
      }

      setIsSharePresetModalOpen(false)
      fetchGamePresets()
      fetchLocalPresets()
    } catch (err: any) {
      console.error(err)
      toast.error(err.message || `Erro ao publicar preset: ${err}`)
    } finally {
      setPublishing(false)
      setSelectedLocalPresetForShare(null)
      if (tempPath && isTauri) {
        const { invoke } = await import("@tauri-apps/api/core")
        const _ = invoke("delete_temp_file", { filePath: tempPath })
      }
    }
  }

  // Toggle Tag in Preset Creation
  const handleToggleTag = (tag: string) => {
    if (selectedTags.includes(tag)) {
      setSelectedTags(prev => prev.filter(t => t !== tag))
    } else {
      setSelectedTags(prev => [...prev, tag])
    }
  }

  return (
    <div className="flex flex-col gap-6">
      {/* Banner */}
      <div className="relative overflow-hidden rounded-xl border border-border">
        <div className="absolute inset-0">
          <img
            src={game.cover || "/placeholder.svg"}
            alt=""
            aria-hidden="true"
            className="size-full scale-110 object-cover blur-2xl"
          />
          <div className="absolute inset-0 bg-background/75" />
        </div>
        <div className="relative flex flex-col gap-4 p-4 sm:flex-row sm:items-end sm:p-6">
          <img
            src={game.cover || "/placeholder.svg"}
            alt={`Capa de ${cleanGameTitle(game.title)}`}
            className="h-40 w-30 shrink-0 rounded-lg border border-border object-cover shadow-xl"
          />
          <div className="flex min-w-0 flex-1 flex-col gap-3">
            <div className="flex flex-wrap items-center gap-2">
              <PlatformBadge platform={game.platform} emulator={game.emulator} />
              <span className="text-xs text-muted-foreground">
                {game.backups.length} versões salvas
              </span>
            </div>
            <h2 className="text-balance text-2xl font-bold leading-tight sm:text-3xl">
              {cleanGameTitle(game.title)}
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
              <Button onClick={handleBackup}>
                <ArrowUpToLine data-icon="inline-start" />
                Fazer backup agora
              </Button>
              <Button
                variant="secondary"
                onClick={handleRestoreLatest}
              >
                <ArrowDownToLine data-icon="inline-start" />
                Restaurar última
              </Button>
            </div>
            <div className="flex flex-wrap gap-2 mt-1">
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleOpenFolder("game")}
                title="Abrir pasta de instalação do jogo no Windows Explorer"
              >
                <Folder className="size-3.5" data-icon="inline-start" />
                Pasta do Jogo
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleOpenFolder("save")}
                title="Abrir pasta onde os saves ativos ficam armazenados"
              >
                <FolderSync className="size-3.5" data-icon="inline-start" />
                Pasta do Save
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleOpenFolder("backup")}
                title="Abrir pasta de backup de saves do Ludocard"
              >
                <Package className="size-3.5" data-icon="inline-start" />
                Pasta de Backups
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={handleExportSave}
                title="Exportar save como arquivo .ludocard compactado para compartilhar"
                className="border-primary/30 text-primary hover:bg-primary/10"
              >
                <Share2 className="size-3.5" data-icon="inline-start" />
                Exportar Save (.ludocard)
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
                  Saves no PC
                </span>
                <span className="text-xs font-medium">{formatSize(game.sizeMB)}</span>
              </div>
              <div className="flex items-center justify-between rounded-lg border border-border bg-muted/40 px-3 py-2.5">
                <span className="flex items-center gap-2 text-sm">
                  <Package className="size-4 text-muted-foreground" />
                  Total em backups
                </span>
                <span className="text-xs font-medium">{formatSize(game.backupsSizeMB || 0)}</span>
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
                  checked={game.autoBackup}
                  disabled={true} /* Controlled by main settings config */
                />
              </label>
              <label className="flex items-center justify-between gap-2">
                <span className="text-sm">Enviar para a nuvem</span>
                <Switch
                  checked={game.cloudSync}
                  disabled={true} /* Controlled by main settings config */
                />
              </label>
            </CardContent>
          </Card>
        </div>

        {/* Tabbed view: Timeline or Presets */}
        <Card className="lg:col-span-2">
          <CardHeader className="pb-3 border-b border-border/50">
            <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
              <div className="flex items-center gap-2">
                {activeTab === "saves" ? (
                  <Clock className="size-4 text-primary" />
                ) : (
                  <SlidersHorizontal className="size-4 text-primary" />
                )}
                <CardTitle className="text-sm font-bold uppercase tracking-wider text-muted-foreground/90">
                  {activeTab === "saves" ? "Histórico de Saves" : "Presets de Configuração"}
                </CardTitle>
              </div>

              {/* Selector Tabs */}
              <div className="flex items-center gap-1 rounded-xl bg-muted/80 p-1 border border-border w-fit shadow-xs">
                <button
                  onClick={() => setActiveTab("saves")}
                  className={cn(
                    "rounded-lg px-4 py-2 text-xs font-bold transition-all duration-150",
                    activeTab === "saves"
                      ? "bg-background text-foreground shadow-sm border border-border/10"
                      : "text-muted-foreground hover:text-foreground"
                  )}
                >
                  Linha do Tempo (Saves)
                </button>
                <button
                  onClick={() => setActiveTab("presets")}
                  className={cn(
                    "rounded-lg px-4 py-2 text-xs font-bold transition-all duration-150",
                    activeTab === "presets"
                      ? "bg-background text-foreground shadow-sm border border-border/10"
                      : "text-muted-foreground hover:text-foreground"
                  )}
                >
                  Presets & Configurações
                </button>
              </div>
            </div>
          </CardHeader>

          <CardContent className="pt-6">
            {activeTab === "saves" ? (
              /* Saves Timeline */
              game.backups.length === 0 ? (
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
                      <div 
                        className="flex min-w-0 flex-1 flex-col gap-2 rounded-lg border border-border bg-muted/30 p-3 sm:flex-row sm:items-center sm:justify-between cursor-pointer hover:bg-muted/50 transition-colors"
                        onClick={() => handleOpenLocalBackupModal(b)}
                      >
                        <div className="flex min-w-0 flex-1 flex-col gap-0.5">
                          <div className="flex flex-wrap items-center gap-2">
                            <span className="font-medium">
                              {b.date} às {b.time}
                            </span>
                            {b.cloud ? (
                              <Cloud className="size-3.5 text-primary" />
                            ) : (
                              <CloudOff className="size-3.5 text-muted-foreground" />
                            )}
                            {b.locked && (
                              <span className="inline-flex items-center gap-1 rounded bg-amber-500/10 px-1.5 py-0.5 text-[10px] font-semibold text-amber-500 border border-amber-500/20">
                                <Pin className="size-2.5 fill-current" />
                                Alfinetado
                              </span>
                            )}
                          </div>
                          <div className="flex flex-col gap-1 text-xs text-muted-foreground">
                            <div className="flex items-center gap-2">
                              <span className={cn("font-medium", kindColors[b.kind] || "text-muted-foreground")}>
                                {b.kind}
                              </span>
                              <span>•</span>
                              <span>{formatSize(b.sizeMB)}</span>
                            </div>
                            
                            {/* Note preview */}
                            {b.note && (
                              <p className="mt-0.5 line-clamp-1 text-[10px] italic text-muted-foreground/80 bg-primary/5 rounded px-2 py-0.5 border border-primary/10 w-fit">
                                "{b.note}"
                              </p>
                            )}
                          </div>
                        </div>
                        <div 
                          className="flex shrink-0 items-center gap-1.5"
                          onClick={(e) => e.stopPropagation()}
                        >
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleRestoreVersion(b.id, `${b.date} ${b.time}`)}
                          >
                            <RotateCcw data-icon="inline-start" />
                            Restaurar
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleExportBackupVersion(b.id, b.date, b.time)}
                          >
                            <Share2 data-icon="inline-start" />
                            Exportar
                          </Button>
                          <Button
                            size="icon-sm"
                            variant={b.locked ? "secondary" : "ghost"}
                            onClick={() => handleToggleLocked(b.id, !!b.locked)}
                            title={b.locked ? "Desafixar versão (permitir exclusão automática)" : "Fixar/Alfinetar versão (impedir exclusão automática)"}
                            className={cn(
                              b.locked ? "text-amber-500 hover:text-amber-600 hover:bg-amber-500/10" : "text-muted-foreground hover:text-foreground"
                            )}
                          >
                            <Pin className={cn("size-4", b.locked && "fill-current")} />
                            <span className="sr-only">{b.locked ? "Desafixar" : "Fixar"}</span>
                          </Button>
                          <Button
                            size="icon-sm"
                            variant="ghost"
                            onClick={() => toast.error("Por favor, gerencie exclusões de backups pelo app central")}
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
              )
            ) : (
              /* Presets view */
              <div className="flex flex-col gap-6">
                {/* Segmented Sub Tabs Selector */}
                <div className="flex items-center gap-1 rounded-lg bg-muted p-1 border border-border/80 w-fit self-start">
                  <button
                    onClick={() => setPresetSubTab("local")}
                    className={cn(
                      "rounded-md px-3 py-1.5 text-xs font-semibold transition-all",
                      presetSubTab === "local"
                        ? "bg-background text-foreground shadow-xs border border-border/10"
                        : "text-muted-foreground hover:text-foreground"
                    )}
                  >
                    Meus Presets (Locais & Baixados)
                  </button>
                  <button
                    onClick={() => setPresetSubTab("community")}
                    className={cn(
                      "rounded-md px-3 py-1.5 text-xs font-semibold transition-all",
                      presetSubTab === "community"
                        ? "bg-background text-foreground shadow-xs border border-border/10"
                        : "text-muted-foreground hover:text-foreground"
                    )}
                  >
                    Presets da Comunidade
                  </button>
                </div>

                {presetSubTab === "local" ? (
                  /* Local Presets list */
                  <div className="flex flex-col gap-5">
                    <div className="flex flex-wrap items-center justify-between gap-3 bg-muted/20 border border-border p-3.5 rounded-xl">
                      <div className="flex items-center gap-2">
                        <SlidersHorizontal className="size-4.5 text-primary" />
                        <div>
                          <h4 className="text-sm font-semibold">Salvar Configuração Atual</h4>
                          <p className="text-xs text-muted-foreground">Crie um preset local a partir das configurações ativas do seu jogo.</p>
                        </div>
                      </div>
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={async () => {
                          setLoadingConfigs(true);
                          setIsCreateLocalPresetModalOpen(true);
                          if (isTauri) {
                            try {
                              const { invoke } = await import("@tauri-apps/api/core");
                              const files = await invoke<string[]>("detect_game_config_files", {
                                gameTitle: game.title
                              });
                              setConfigFiles(files);
                              setSelectedConfigFiles(files);
                            } catch (err) {
                              console.error(err);
                            }
                          } else {
                            setConfigFiles(["C:/Users/Player/AppData/Roaming/AetherFrontier/Saves/config.ini"]);
                            setSelectedConfigFiles(["C:/Users/Player/AppData/Roaming/AetherFrontier/Saves/config.ini"]);
                          }
                          setLoadingConfigs(false);
                        }}
                        className="border-primary/40 hover:bg-primary/5 text-primary flex items-center gap-1.5 font-medium"
                      >
                        <HardDrive className="size-3.5" />
                        Salvar Nova Config
                      </Button>
                    </div>

                    {localPresets.length === 0 ? (
                      <div className="flex flex-col items-center justify-center p-8 text-center border border-dashed border-border rounded-xl bg-card/20">
                        <Info className="size-8 text-muted-foreground/60 mb-2" />
                        <h5 className="font-semibold text-sm">Nenhum preset local</h5>
                        <p className="text-xs text-muted-foreground mt-1 max-w-sm">
                          Capture suas configurações de gráficos e controles locais para salvá-las como um preset ou compartilhá-las.
                        </p>
                      </div>
                    ) : (
                      <div className="grid gap-3">
                        {localPresets.map((lp) => (
                          <div key={lp.id} className="flex flex-col gap-3 rounded-xl border border-border p-4 bg-muted/10">
                            <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3">
                              <div 
                                className="flex flex-col gap-1 cursor-pointer hover:bg-muted/5 p-1 rounded transition-colors flex-1 min-w-0"
                                onClick={() => setSelectedDetailPreset({
                                  ...lp,
                                  gameName: game.title,
                                  fileSize: 0,
                                  downloadsCount: 0,
                                  tags: []
                                })}
                              >
                                <h5 className="font-bold text-sm leading-tight text-foreground truncate">{lp.title}</h5>
                                <p className="line-clamp-1 text-xs text-muted-foreground leading-relaxed mt-0.5">{lp.description || "Sem descrição."}</p>
                              </div>
                              <div className="flex items-center gap-1.5 shrink-0 self-end sm:self-center">
                                <Button
                                  size="sm"
                                  onClick={() => handleApplyLocalPreset(lp)}
                                  className="bg-primary hover:bg-primary/95 text-primary-foreground font-semibold flex items-center gap-1"
                                >
                                  <Zap className="size-3 fill-current" />
                                  Aplicar
                                </Button>
                                <Button
                                  size="sm"
                                  variant="outline"
                                  onClick={() => handleShareLocalPreset(lp)}
                                  className="flex items-center gap-1 text-xs"
                                >
                                  <Share2 className="size-3 text-primary" />
                                  Upar Pro HUB
                                </Button>
                                <Button
                                  size="icon-sm"
                                  variant="ghost"
                                  onClick={() => handleDeleteLocalPreset(lp.id)}
                                  className="text-red-400 hover:text-red-500 hover:bg-red-500/10"
                                >
                                  <Trash2 className="size-3.5" />
                                </Button>
                              </div>
                            </div>
                            <div className="flex flex-wrap items-center gap-2 border-t border-border/40 pt-2 text-[10px] text-muted-foreground">
                              <span className="flex items-center gap-1 font-mono text-[9px] bg-muted px-1.5 py-0.5 rounded border border-border">
                                <Cpu className="size-2.5" />
                                {lp.cpu ? `${lp.cpu} | ` : ""}{lp.gpu ? `${lp.gpu} | ` : ""}{lp.ram || ""}
                              </span>
                              <span>•</span>
                              <span>Criado em: {new Date(lp.createdAt).toLocaleDateString("pt-BR")}</span>
                              <span>•</span>
                              <span>{lp.files.length} arquivos mapeados</span>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                ) : (
                  /* Community Presets list */
                  <div className="flex flex-col gap-5">
                    {/* Revert Safety Backup Info */}
                    {hasCrashSafetyBackup && (
                      <div className="flex items-center justify-between p-3.5 rounded-xl bg-red-500/5 border border-red-500/10">
                        <div className="flex items-center gap-2">
                          <AlertTriangle className="size-4.5 text-red-400 animate-pulse" />
                          <div className="text-xs text-red-400">
                            <span className="font-semibold block">Seguro-Crash Ativo</span>
                            Você aplicou um preset recentemente. Se houver falhas, restaure as configs originais.
                          </div>
                        </div>
                        <Button
                          variant="destructive"
                          size="sm"
                          onClick={handleUndoPreset}
                          className="h-8 text-xs font-semibold flex items-center gap-1.5"
                        >
                          <RotateCcw className="size-3.5" />
                          Desfazer e Voltar ao Original
                        </Button>
                      </div>
                    )}

                    {loadingPresets ? (
                      <div className="flex h-[150px] flex-col items-center justify-center gap-2">
                        <Clock className="size-7 animate-spin text-primary" />
                        <span className="text-xs text-muted-foreground">Buscando presets na nuvem...</span>
                      </div>
                    ) : presets.length === 0 ? (
                      <div className="flex flex-col items-center justify-center p-8 text-center border border-dashed border-border rounded-xl bg-card/20">
                        <Info className="size-8 text-muted-foreground/60 mb-2" />
                        <h5 className="font-semibold text-sm">Nenhum preset comunitário</h5>
                        <p className="text-xs text-muted-foreground mt-1 max-w-sm">
                          Não há presets publicados para este jogo na nuvem. Crie um local e compartilhe!
                        </p>
                      </div>
                    ) : (
                      <div className="grid gap-4">
                        {presets.map((preset) => {
                          const approvalRatio = preset.upvotes + preset.downvotes > 0
                            ? Math.round((preset.upvotes / (preset.upvotes + preset.downvotes)) * 100)
                            : 100

                          return (
                            <div
                              key={preset.id}
                              className={cn(
                                "flex flex-col gap-3 rounded-xl border border-border p-4 bg-muted/10 hover:bg-muted/20 transition-all",
                                preset.isOfficial && "border-primary/25 bg-primary/2"
                              )}
                            >
                              <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3">
                                <div 
                                  className="flex flex-col gap-1 cursor-pointer hover:bg-muted/5 p-1 rounded transition-colors flex-1 min-w-0"
                                  onClick={() => setSelectedDetailPreset(preset)}
                                >
                                  <h5 className="font-bold text-sm leading-tight flex items-center gap-1.5 truncate">
                                    {preset.title}
                                    {preset.isOfficial && (
                                      <span className="inline-flex items-center gap-0.5 rounded bg-primary/20 border border-primary/30 px-1.5 py-0.5 text-[9px] font-bold text-primary uppercase shrink-0">
                                        <Sparkles className="size-2.5 fill-current" />
                                        Oficial
                                      </span>
                                    )}
                                  </h5>
                                  
                                  {preset.tags && preset.tags.length > 0 && (
                                    <div className="flex flex-wrap gap-1 mt-1">
                                      {preset.tags.map((tag: string) => (
                                        <span key={tag} className="inline-flex items-center rounded bg-primary/10 border border-primary/25 px-1.5 py-0.2 text-[9px] font-semibold text-primary select-none shrink-0">
                                          {tag}
                                        </span>
                                      ))}
                                    </div>
                                  )}
                                  
                                  <p className="line-clamp-1 text-xs text-muted-foreground leading-relaxed mt-0.5">
                                    {preset.description}
                                  </p>
                                </div>
                                <Button
                                  size="sm"
                                  disabled={importingPreset === preset.id}
                                  onClick={() => handleApplyPreset(preset)}
                                  className="self-start sm:self-center bg-primary hover:bg-primary/95 text-primary-foreground font-semibold flex items-center gap-1 shrink-0"
                                >
                                  {importingPreset === preset.id ? (
                                    <>
                                      <RefreshCw className="size-3 animate-spin" />
                                      Instalando...
                                    </>
                                  ) : (
                                    <>
                                      <Download className="size-3" />
                                      Baixar & Aplicar
                                    </>
                                  )}
                                </Button>
                              </div>

                              <div className="flex flex-wrap items-center justify-between gap-3 border-t border-border/50 pt-2 text-[10px] text-muted-foreground">
                                <div className="flex flex-wrap items-center gap-2">
                                  <span className="flex items-center gap-1 font-mono text-[9px] bg-muted px-1.5 py-0.5 rounded border border-border">
                                    <Cpu className="size-3" />
                                    {preset.cpu ? `${preset.cpu} | ` : ""}{preset.gpu ? `${preset.gpu} | ` : ""}{preset.ram || ""}
                                  </span>
                                  <span>Por: <strong className="text-foreground">{preset.authorName}</strong></span>
                                </div>
                                <div className="flex items-center gap-3">
                                  <div className="flex items-center gap-1" title="Aprovação">
                                    <ThumbsUp className="size-3 text-primary" />
                                    <span className="font-semibold text-foreground">{approvalRatio}%</span>
                                  </div>
                                  <div className="flex items-center gap-0.5 border border-border rounded overflow-hidden bg-background">
                                    <button
                                      onClick={() => handleVote(preset.id, true)}
                                      className="p-1 hover:bg-primary/10 hover:text-primary transition-colors border-r border-border"
                                    >
                                      <ThumbsUp className="size-3" />
                                    </button>
                                    <button
                                      onClick={() => handleVote(preset.id, false)}
                                      className="p-1 hover:bg-red-500/10 hover:text-red-500 transition-colors"
                                    >
                                      <ThumbsDown className="size-3" />
                                    </button>
                                  </div>
                                  <button
                                    onClick={() => handleReport(preset.id)}
                                    className="p-0.5 text-muted-foreground hover:text-red-400"
                                  >
                                    <AlertTriangle className="size-3" />
                                  </button>
                                  <span>Downloads: <strong className="text-foreground">{preset.downloadsCount}</strong></span>
                                </div>
                              </div>
                            </div>
                          )
                        })}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Local Backup Details Modal */}
      {selectedLocalBackup && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 p-4 backdrop-blur-xs">
          <Card className="w-full max-w-md shadow-2xl border border-border animate-in fade-in zoom-in-95 duration-200">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3 border-b border-border">
              <div>
                <CardTitle className="text-base">Detalhes do Backup Local</CardTitle>
                <CardDescription className="text-xs">Informações da versão e notas de campanha.</CardDescription>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setSelectedLocalBackup(null)}
                className="h-8 w-8 text-muted-foreground hover:text-foreground"
              >
                <X className="size-4" />
              </Button>
            </CardHeader>
            <CardContent className="pt-4 flex flex-col gap-4">
              <div className="flex flex-col gap-1.5 bg-muted/20 border border-border p-3.5 rounded-xl text-xs">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Data e Hora:</span>
                  <span className="font-semibold text-foreground">{selectedLocalBackup.date} às {selectedLocalBackup.time}</span>
                </div>
                <div className="flex justify-between mt-1">
                  <span className="text-muted-foreground">Tipo de Backup:</span>
                  <span className={cn("font-semibold", kindColors[selectedLocalBackup.kind] || "text-foreground")}>
                    {selectedLocalBackup.kind}
                  </span>
                </div>
                <div className="flex justify-between mt-1">
                  <span className="text-muted-foreground">Tamanho do Arquivo:</span>
                  <span className="font-semibold text-foreground">{formatSize(selectedLocalBackup.sizeMB)}</span>
                </div>
              </div>

              <div className="flex flex-col gap-1.5">
                <label htmlFor="local-backup-note" className="text-xs font-semibold text-muted-foreground">
                  Notas de Campanha / Descrição do Progresso
                </label>
                <textarea
                  id="local-backup-note"
                  rows={4}
                  placeholder="Ex: Parei após derrotar o dragão. Nível 45, build de destreza..."
                  value={localNote}
                  onChange={(e) => setLocalNote(e.target.value)}
                  className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary whitespace-pre-wrap leading-relaxed"
                />
              </div>

              <div className="flex justify-end gap-2 border-t border-border pt-4 mt-2">
                <Button
                  variant="ghost"
                  onClick={() => setSelectedLocalBackup(null)}
                >
                  Cancelar
                </Button>
                <Button
                  onClick={handleSaveNote}
                  className="bg-primary hover:bg-primary/95 text-primary-foreground font-medium"
                >
                  Salvar Notas
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      )}

      {/* Share Preset Modal */}
      {isSharePresetModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/75 p-4 backdrop-blur-xs">
          <Card className="w-full max-w-lg shadow-2xl border border-border animate-in fade-in zoom-in-95 duration-200 overflow-hidden">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3 border-b border-border bg-card">
              <div>
                <CardTitle className="text-base flex items-center gap-1.5">
                  <Share2 className="size-4.5 text-primary" />
                  Compartilhar Preset de Configuração
                </CardTitle>
                <CardDescription className="text-xs">
                  Salve e envie suas otimizações locais para a comunidade.
                </CardDescription>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setIsSharePresetModalOpen(false)}
                className="h-8 w-8 text-muted-foreground hover:text-foreground"
              >
                <X className="size-4" />
              </Button>
            </CardHeader>
            <form onSubmit={handlePublishPreset}>
              <CardContent className="pt-4 flex flex-col gap-4 max-h-[500px] overflow-y-auto">
                
                {/* Config files list */}
                <div className="flex flex-col gap-1.5 border border-border rounded-xl p-3 bg-muted/10">
                  <label className="text-xs font-semibold text-muted-foreground flex items-center gap-1">
                    <FolderSync className="size-3.5 text-primary" />
                    Arquivos de Configuração Detectados:
                  </label>
                  {loadingConfigs ? (
                    <div className="flex items-center gap-2 py-2 text-xs text-muted-foreground">
                      <Clock className="size-3.5 animate-spin text-primary" />
                      Mapeando arquivos locais...
                    </div>
                  ) : configFiles.length === 0 ? (
                    <div className="text-xs text-red-400 bg-red-500/5 border border-red-500/10 p-2.5 rounded-lg flex items-start gap-1.5">
                      <AlertTriangle className="size-4 shrink-0" />
                      Não foi possível detectar arquivos de configuração usando o mapeamento do Ludosavi.
                    </div>
                  ) : (
                    <div className="flex flex-col gap-1.5 max-h-[100px] overflow-y-auto border border-border/60 rounded bg-background p-2">
                      {configFiles.map(path => {
                        const name = path.split(/[\\/]/).pop()
                        const isChecked = selectedConfigFiles.includes(path)
                        return (
                          <label key={path} className="flex items-center gap-2 text-[11px] cursor-pointer hover:text-foreground select-none">
                            <input
                              type="checkbox"
                              checked={isChecked}
                              onChange={() => {
                                if (isChecked) {
                                  setSelectedConfigFiles(prev => prev.filter(p => p !== path))
                                } else {
                                  setSelectedConfigFiles(prev => [...prev, path])
                                }
                              }}
                              className="rounded border-border bg-muted text-primary focus:ring-primary size-3"
                            />
                            <span className="font-semibold text-foreground shrink-0">{name}</span>
                            <span className="truncate text-muted-foreground text-[10px]" title={path}>({path})</span>
                          </label>
                        )
                      })}
                    </div>
                  )}
                </div>

                {/* Form fields */}
                <div className="grid gap-3.5 sm:grid-cols-2">
                  <div className="flex flex-col gap-1.5 sm:col-span-2">
                    <label htmlFor="preset-title" className="text-xs font-semibold text-muted-foreground">
                      Título do Preset *
                    </label>
                    <input
                      id="preset-title"
                      type="text"
                      placeholder="Ex: Potato Mode (Max Performance) ou Balanced DF Specs"
                      value={presetTitle}
                      onChange={(e) => setPresetTitle(e.target.value)}
                      required
                      className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary"
                    />
                  </div>

                  <div className="flex flex-col gap-1.5">
                    <label htmlFor="preset-author" className="text-xs font-semibold text-muted-foreground">
                      Seu Nome / Nickname
                    </label>
                    <input
                      id="preset-author"
                      type="text"
                      placeholder="Ex: Anônimo"
                      value={authorName}
                      onChange={(e) => setAuthorName(e.target.value)}
                      className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary"
                    />
                  </div>

                  {/* Tags */}
                  <div className="flex flex-col gap-1.5">
                    <label className="text-xs font-semibold text-muted-foreground">
                      Tags do Preset
                    </label>
                    <div className="flex flex-wrap gap-1 max-h-24 overflow-y-auto border border-border/80 p-2.5 rounded-md bg-muted/10">
                      {PREDEFINED_PRESET_TAGS.map(tag => {
                        const active = selectedTags.includes(tag.name)
                        return (
                          <button
                            key={tag.name}
                            type="button"
                            onClick={() => handleToggleTag(tag.name)}
                            title={tag.description}
                            className={cn(
                              "px-2 py-0.5 rounded text-[10px] font-medium border transition-all select-none",
                              active
                                ? "bg-primary/10 border-primary text-primary"
                                : "bg-background border-border text-muted-foreground hover:text-foreground"
                            )}
                          >
                            {tag.name}
                          </button>
                        )
                      })}
                    </div>
                  </div>
                </div>

                <div className="flex flex-col gap-1.5">
                  <label htmlFor="preset-desc" className="text-xs font-semibold text-muted-foreground">
                    Descrição (Versão do jogo, melhorias de FPS estimadas, etc.)
                  </label>
                  <textarea
                    id="preset-desc"
                    rows={2}
                    placeholder="Ex: Aumenta cerca de 15% do FPS na cidade. Testado na versão 1.63."
                    value={presetDesc}
                    onChange={(e) => setPresetDesc(e.target.value)}
                    className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary whitespace-pre-wrap"
                  />
                </div>

                {/* Hardware details prefilled */}
                <div className="flex flex-col gap-2.5 border border-border rounded-xl p-3 bg-muted/10">
                  <span className="text-xs font-semibold text-muted-foreground flex items-center gap-1">
                    <Cpu className="size-3.5 text-primary" />
                    Hardware Detectado (Especificações do Autor):
                  </span>
                  {loadingHardware ? (
                    <div className="flex items-center gap-2 py-1 text-xs text-muted-foreground">
                      <Clock className="size-3.5 animate-spin text-primary" />
                      Detectando hardware local...
                    </div>
                  ) : (
                    <div className="grid gap-3 sm:grid-cols-3">
                      <div className="flex flex-col gap-1">
                        <label htmlFor="hw-cpu" className="text-[10px] font-semibold text-muted-foreground">Processador (CPU)</label>
                        <input
                          id="hw-cpu"
                          type="text"
                          value={cpu}
                          onChange={(e) => setCpu(e.target.value)}
                          className="w-full rounded border border-border bg-background px-2 py-1 text-xs font-mono focus:outline-none focus:ring-1 focus:ring-primary"
                        />
                      </div>
                      <div className="flex flex-col gap-1">
                        <label htmlFor="hw-gpu" className="text-[10px] font-semibold text-muted-foreground">Placa de Vídeo (GPU)</label>
                        <input
                          id="hw-gpu"
                          type="text"
                          value={gpu}
                          onChange={(e) => setGpu(e.target.value)}
                          className="w-full rounded border border-border bg-background px-2 py-1 text-xs font-mono focus:outline-none focus:ring-1 focus:ring-primary"
                        />
                      </div>
                      <div className="flex flex-col gap-1">
                        <label htmlFor="hw-ram" className="text-[10px] font-semibold text-muted-foreground">Memória RAM</label>
                        <input
                          id="hw-ram"
                          type="text"
                          value={ram}
                          onChange={(e) => setRam(e.target.value)}
                          className="w-full rounded border border-border bg-background px-2 py-1 text-xs font-mono focus:outline-none focus:ring-1 focus:ring-primary"
                        />
                      </div>
                    </div>
                  )}
                </div>

              </CardContent>
              <div className="flex justify-end gap-2 border-t border-border p-4 bg-muted/10">
                <Button
                  type="button"
                  variant="ghost"
                  onClick={() => setIsSharePresetModalOpen(false)}
                >
                  Cancelar
                </Button>
                <Button
                  type="submit"
                  disabled={publishing || configFiles.length === 0}
                  className="bg-primary hover:bg-primary/95 text-primary-foreground font-medium"
                >
                  {publishing ? "Publicando..." : "Publicar Preset"}
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}

      {/* Detail Preset Modal overlay */}
      {selectedDetailPreset && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 p-4 backdrop-blur-xs">
          <Card className="w-full max-w-md shadow-2xl border border-border animate-in fade-in zoom-in-95 duration-200">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3 border-b border-border bg-card">
              <div>
                <CardTitle className="text-base flex items-center gap-1.5 font-semibold">
                  <Gamepad2 className="size-4.5 text-primary" />
                  {selectedDetailPreset.gameName}
                </CardTitle>
                <CardDescription className="text-xs">Visualizando metadados completos do preset.</CardDescription>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setSelectedDetailPreset(null)}
                className="h-8 w-8 text-muted-foreground hover:text-foreground"
              >
                <X className="size-4" />
              </Button>
            </CardHeader>
            <CardContent className="pt-4 flex flex-col gap-4">
              <div className="flex flex-col gap-1.5">
                <span className="text-xs text-muted-foreground font-semibold">Título do Preset:</span>
                <span className="text-sm font-bold text-foreground leading-snug">{selectedDetailPreset.title}</span>
              </div>

              {selectedDetailPreset.description && (
                <div className="flex flex-col gap-1 bg-muted/20 border border-border p-3 rounded-lg">
                  <span className="text-[11px] text-muted-foreground font-semibold">Descrição / Otimizações:</span>
                  <div className="max-h-[160px] overflow-y-auto pr-1.5 scrollbar-thin">
                    <p className="text-xs leading-relaxed text-muted-foreground mt-0.5 whitespace-pre-wrap">{selectedDetailPreset.description}</p>
                  </div>
                </div>
              )}

              {selectedDetailPreset.tags && selectedDetailPreset.tags.length > 0 && (
                <div className="flex flex-col gap-1.5">
                  <span className="text-[11px] text-muted-foreground font-semibold">Marcadores:</span>
                  <div className="flex flex-wrap gap-1">
                    {selectedDetailPreset.tags.map((t: string) => {
                      const info = PREDEFINED_PRESET_TAGS.find(pt => pt.name === t)
                      return (
                        <span
                          key={t}
                          title={info?.description}
                          className="inline-flex items-center rounded bg-primary/10 border border-primary/25 px-1.5 py-0.2 text-[9px] font-semibold text-primary select-none cursor-help"
                        >
                          {t}
                        </span>
                      )
                    })}
                  </div>
                </div>
              )}

              <div className="grid grid-cols-2 gap-3 bg-muted/20 border border-border p-3.5 rounded-xl text-xs">
                <div className="flex flex-col gap-0.5 col-span-2">
                  <span className="text-muted-foreground font-semibold">Especificações do Autor:</span>
                  <span className="font-mono text-foreground mt-0.5 leading-relaxed">
                    {selectedDetailPreset.cpu ? `${selectedDetailPreset.cpu} | ` : ""}{selectedDetailPreset.gpu ? `${selectedDetailPreset.gpu} | ` : ""}{selectedDetailPreset.ram || ""}
                  </span>
                </div>
                <div className="flex flex-col gap-0.5 mt-1">
                  <span className="text-muted-foreground">Tamanho Comprimido:</span>
                  <span className="font-semibold text-foreground">{formatSize(selectedDetailPreset.fileSize)}</span>
                </div>
                <div className="flex flex-col gap-0.5 mt-1">
                  <span className="text-muted-foreground">Total Downloads:</span>
                  <span className="font-semibold text-foreground">{selectedDetailPreset.downloadsCount.toLocaleString("pt-BR")}</span>
                </div>
                <div className="flex flex-col gap-0.5 mt-1">
                  <span className="text-muted-foreground font-medium">Enviado por:</span>
                  <span className="font-semibold text-foreground">{selectedDetailPreset.authorName || "Local"}</span>
                </div>
                <div className="flex flex-col gap-0.5 mt-1">
                  <span className="text-muted-foreground font-medium">Enviado em:</span>
                  <span className="font-semibold text-foreground">
                    {new Date(selectedDetailPreset.createdAt).toLocaleDateString("pt-BR", { day: "2-digit", month: "short", year: "numeric" })}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      )}
      {/* Create Local Preset Modal */}
      {isCreateLocalPresetModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/75 p-4 backdrop-blur-xs">
          <Card className="w-full max-w-md shadow-2xl border border-border animate-in fade-in zoom-in-95 duration-200">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3 border-b border-border">
              <div>
                <CardTitle className="text-base flex items-center gap-1.5">
                  <SlidersHorizontal className="size-4.5 text-primary" />
                  Criar Preset Local
                </CardTitle>
                <CardDescription className="text-xs">
                  Salve as configurações atuais deste jogo em um perfil local.
                </CardDescription>
              </div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setIsCreateLocalPresetModalOpen(false)}
                className="h-8 w-8 text-muted-foreground hover:text-foreground"
              >
                <X className="size-4" />
              </Button>
            </CardHeader>
            <CardContent className="pt-4 flex flex-col gap-4">
              <div className="flex flex-col gap-1.5">
                <label htmlFor="local-preset-title" className="text-xs font-semibold text-muted-foreground">Título do Preset *</label>
                <input
                  id="local-preset-title"
                  type="text"
                  placeholder="Ex: Minha Otimização 60fps ou Controles de Voo"
                  value={newLocalTitle}
                  onChange={(e) => setNewLocalTitle(e.target.value)}
                  className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary"
                />
              </div>
              <div className="flex flex-col gap-1.5">
                <label htmlFor="local-preset-desc" className="text-xs font-semibold text-muted-foreground">Descrição</label>
                <textarea
                  id="local-preset-desc"
                  rows={2.5}
                  placeholder="Descreva o que este preset altera (ex: reduz sombras volumétricas para melhor performance)."
                  value={newLocalDesc}
                  onChange={(e) => setNewLocalDesc(e.target.value)}
                  className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-primary"
                />
              </div>
              
              <div className="flex flex-col gap-1.5">
                <span className="text-xs font-semibold text-muted-foreground flex items-center gap-1">
                  <FolderSync className="size-3.5 text-primary" />
                  Arquivos Incluídos (Detectados automaticamente):
                </span>
                {loadingConfigs ? (
                  <div className="text-xs text-muted-foreground py-1">Mapeando arquivos...</div>
                ) : configFiles.length === 0 ? (
                  <div className="text-xs text-red-400 bg-red-500/5 p-2 rounded-lg border border-red-500/10">Nenhum arquivo detectado pelo Ludosavi.</div>
                ) : (
                  <div className="flex flex-col gap-1 max-h-24 overflow-y-auto border border-border/80 bg-muted/10 p-2 rounded-md">
                    {configFiles.map(c => {
                      const name = c.split(/[\\/]/).pop()
                      return (
                        <span key={c} className="text-[10px] text-muted-foreground font-mono truncate" title={c}>
                          • {name}
                        </span>
                      )
                    })}
                  </div>
                )}
              </div>

              <div className="flex justify-end gap-2 border-t border-border pt-4 mt-2">
                <Button
                  variant="ghost"
                  onClick={() => setIsCreateLocalPresetModalOpen(false)}
                >
                  Cancelar
                </Button>
                <Button
                  disabled={loadingConfigs || configFiles.length === 0 || !newLocalTitle}
                  onClick={() => handleSaveLocalPreset(newLocalTitle, newLocalDesc, configFiles)}
                  className="bg-primary hover:bg-primary/95 text-primary-foreground font-medium"
                >
                  Criar Preset
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  )
}

