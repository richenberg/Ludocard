import { useState, useEffect } from "react"
import { toast } from "sonner"
import { 
  Cloud, 
  Check, 
  LinkIcon, 
  Unlink, 
  HardDrive, 
  ArrowUpFromLine, 
  ArrowDownToLine, 
  Loader2, 
  Sparkles, 
  Download, 
  AlertTriangle, 
  FolderOpen,
  ArrowRight,
  RefreshCw,
  CheckCircle2,
  XCircle,
  HelpCircle,
  Folder
} from "lucide-react"
import { Button } from "@/components/ui/button"
import { Separator } from "@/components/ui/separator"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Switch } from "@/components/ui/switch"
import { Progress } from "@/components/ui/progress"
import { Input } from "@/components/ui/input"
import { cn } from "@/lib/utils"
import { useI18n } from "@/lib/i18n"

type CloudProvider = "Google Drive" | "OneDrive" | "Dropbox" | "WebDAV" | "FTP"

interface ProviderInfo {
  provider: CloudProvider
  initials: string
  color: string
}

const providersList: ProviderInfo[] = [
  { provider: "Google Drive", initials: "GD", color: "bg-sky-500/15 text-sky-300 border-sky-500/30" },
  { provider: "OneDrive", initials: "OD", color: "bg-blue-500/15 text-blue-300 border-blue-500/30" },
  { provider: "Dropbox", initials: "DB", color: "bg-indigo-500/15 text-indigo-300 border-indigo-500/30" },
  { provider: "WebDAV", initials: "WD", color: "bg-teal-500/15 text-teal-300 border-teal-500/30" },
  { provider: "FTP", initials: "FTP", color: "bg-amber-500/15 text-amber-300 border-amber-500/30" },
]

const isTauri = typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;

export function CloudClient() {
  const { t } = useI18n()
  
  // Real backend settings
  const [rclonePath, setRclonePath] = useState("")
  const [cloudPath, setCloudPath] = useState("luducard-backup")
  const [cloudSync, setCloudSync] = useState(false)
  const [activeProvider, setActiveProvider] = useState<CloudProvider>("Google Drive")
  const [remoteConnected, setRemoteConnected] = useState(() => typeof window !== "undefined" && localStorage.getItem("luducard_has_cloud_remote") === "true")
  const [cloudEmail, setCloudEmail] = useState("")
  
  // Wizard flow states
  const [currentStep, setCurrentStep] = useState<1 | 2 | 3 | 4 | 5>(1)
  const [isDownloading, setIsDownloading] = useState(false)
  const [isLinking, setIsLinking] = useState(false)
  const [isTesting, setIsTesting] = useState(false)
  const [testError, setTestError] = useState("")
  const [showDashboard, setShowDashboard] = useState(() => typeof window !== "undefined" && localStorage.getItem("luducard_has_cloud_remote") === "true")
  
  // Test steps progress
  const [testSteps, setTestSteps] = useState([
    { id: 1, label: "Criar arquivo temporário de teste", status: "idle" as "idle" | "running" | "success" | "error" },
    { id: 2, label: "Fazer upload do arquivo de teste para a nuvem", status: "idle" as "idle" | "running" | "success" | "error" },
    { id: 3, label: "Baixar e verificar o arquivo de teste", status: "idle" as "idle" | "running" | "success" | "error" },
    { id: 4, label: "Limpar os arquivos temporários", status: "idle" as "idle" | "running" | "success" | "error" },
  ])
  
  // Other settings
  const [autoUpload, setAutoUpload] = useState(true)
  const [autoDownload, setAutoDownload] = useState(true)

  // Load settings on startup
  const loadSettings = async () => {
    if (!isTauri) {
      setRclonePath("")
      return
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const s = await invoke<{
        backupPath: string;
        rclonePath: string;
        cloudPath: string;
        cloudSync: boolean;
        rcloneArguments: string;
        fileWatcher: boolean;
        systemTray: boolean;
        startWithWindows: boolean;
        portable: boolean;
        supabaseUrl: string;
        supabaseAnonKey: string;
        language: string;
        hasSetLanguage: boolean;
        hasCloudRemote: boolean;
        cloudEmail?: string;
      }>("get_settings")
      
      const hasRemote = s.hasCloudRemote || false;
      setRclonePath(s.rclonePath || "")
      setCloudPath(s.cloudPath || "luducard-backup")
      setCloudSync(s.cloudSync || false)
      setRemoteConnected(hasRemote)
      setCloudEmail(s.cloudEmail || "")
      localStorage.setItem("luducard_has_cloud_remote", hasRemote ? "true" : "false")
      
      if (hasRemote) {
        setShowDashboard(true)
      } else if (s.rclonePath) {
        setCurrentStep(2) // Go to login if rclone is installed
      } else {
        setCurrentStep(1) // Otherwise start at installer
      }
    } catch (err) {
      console.error("Failed to load settings:", err)
    }
  }

  useEffect(() => {
    loadSettings()
  }, [])

  // Action: Download Rclone
  const handleDownloadRclone = async () => {
    setIsDownloading(true)
    const id = toast.loading("Baixando Rclone... Isso pode levar alguns segundos.")
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const path = await invoke<string>("download_rclone")
      setRclonePath(path)
      toast.success("Rclone baixado e instalado com sucesso!", { id })
      setCurrentStep(2)
    } catch (err) {
      toast.error(`Falha no download do Rclone: ${err}`, { id })
    } finally {
      setIsDownloading(false)
    }
  }

  // Action: Select Rclone Path manually
  const handleSelectRcloneManual = async () => {
    if (!isTauri) {
      toast.info("[Mock] Seleção manual de diretório")
      setRclonePath("/mock/rclone/path/rclone.exe")
      setCurrentStep(2)
      return
    }
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      const folder = await invoke<string | null>("select_folder")
      if (folder) {
        const separator = folder.includes("\\") ? "\\" : "/"
        const path = `${folder}${separator}${navigator.userAgent.includes("Windows") ? "rclone.exe" : "rclone"}`
        
        const s = await invoke<any>("get_settings")
        await invoke("save_settings", {
          settings: {
            ...s,
            rclonePath: path
          }
        })
        setRclonePath(path)
        toast.success("Caminho do Rclone atualizado!")
        setCurrentStep(2)
      }
    } catch (err) {
      toast.error(`Erro ao selecionar pasta: ${err}`)
    }
  }

  // Action: Link account via OAuth (no email required)
  const handleLinkAccount = async () => {
    setIsLinking(true)
    const id = toast.loading("Abrindo navegador para autenticação. Por favor, autorize no navegador...")
    try {
      if (!isTauri) {
        await new Promise((resolve) => setTimeout(resolve, 2000))
        setRemoteConnected(true)
        toast.success("Conta vinculada com sucesso!", { id })
        setCurrentStep(3)
        return
      }
      const { invoke } = await import("@tauri-apps/api/core")
      // Pass a placeholder email/ID since Rclone config create will manage oauth
      await invoke("configure_cloud_remote", { provider: activeProvider, email: "cloud_user" })
      setRemoteConnected(true)
      localStorage.setItem("luducard_has_cloud_remote", "true")
      toast.success("Conta vinculada com sucesso!", { id })
      setCurrentStep(3)
    } catch (err) {
      toast.error(`Falha ao vincular conta: ${err}`, { id })
    } finally {
      setIsLinking(false)
    }
  }

  // Action: Save Cloud Folder Path (Step 3)
  const handleSaveCloudFolder = async () => {
    if (!cloudPath.trim()) {
      toast.error("O nome da pasta não pode ser vazio.")
      return
    }
    const id = toast.loading("Salvando pasta da nuvem...")
    try {
      if (isTauri) {
        const { invoke } = await import("@tauri-apps/api/core")
        const s = await invoke<any>("get_settings")
        await invoke("save_settings", {
          settings: {
            ...s,
            cloudPath: cloudPath.trim()
          }
        })
      }
      toast.success("Pasta de backup configurada!", { id })
      setCurrentStep(4)
    } catch (err) {
      toast.error(`Erro ao salvar pasta: ${err}`, { id })
    }
  }

  // Action: Unlink Account / Reset Wizard
  const handleUnlink = async () => {
    const id = toast.loading("Desconectando conta...")
    try {
      if (isTauri) {
        const { invoke } = await import("@tauri-apps/api/core")
        const s = await invoke<any>("get_settings")
        await invoke("save_settings", {
          settings: {
            ...s,
            cloudPath: "",
            cloudSync: false
          }
        })
      }
      setRemoteConnected(false)
      setCloudSync(false)
      setCloudPath("luducard-backup")
      setShowDashboard(false)
      localStorage.setItem("luducard_has_cloud_remote", "false")
      setCurrentStep(2)
      toast.success("Conta desconectada com sucesso!", { id })
    } catch (err) {
      toast.error(`Erro ao desconectar: ${err}`, { id })
    }
  }

  // Action: Test Cloud sync connection
  const handleTestConnection = async () => {
    setIsTesting(true)
    setTestError("")
    
    setTestSteps((steps) => steps.map((s) => ({ ...s, status: "idle" })))
    
    const updateStepStatus = (id: number, status: "running" | "success" | "error") => {
      setTestSteps((steps) => steps.map((s) => (s.id === id ? { ...s, status } : s)))
    }
    
    try {
      updateStepStatus(1, "running")
      await new Promise((resolve) => setTimeout(resolve, 800))
      
      if (!isTauri) {
        updateStepStatus(1, "success")
        updateStepStatus(2, "running")
        await new Promise((resolve) => setTimeout(resolve, 1000))
        updateStepStatus(2, "success")
        updateStepStatus(3, "running")
        await new Promise((resolve) => setTimeout(resolve, 1000))
        updateStepStatus(3, "success")
        updateStepStatus(4, "running")
        await new Promise((resolve) => setTimeout(resolve, 800))
        updateStepStatus(4, "success")
        
        toast.success("Teste de conexão concluído com sucesso!")
        return
      }
      
      updateStepStatus(1, "success")
      updateStepStatus(2, "running")
      const { invoke } = await import("@tauri-apps/api/core")
      
      await invoke("test_cloud_connection")
      
      updateStepStatus(2, "success")
      updateStepStatus(3, "running")
      await new Promise((resolve) => setTimeout(resolve, 300))
      updateStepStatus(3, "success")
      updateStepStatus(4, "running")
      await new Promise((resolve) => setTimeout(resolve, 300))
      updateStepStatus(4, "success")
      
      toast.success("Teste de ida e volta concluído com sucesso!")
    } catch (err) {
      setTestSteps((steps) =>
        steps.map((s) => (s.status === "running" ? { ...s, status: "error" } : s))
      )
      setTestError(String(err))
      toast.error(`Falha no teste de conexão: ${err}`)
    } finally {
      setIsTesting(false)
    }
  }

  // Action: Enable global sync
  const handleEnableGlobalSync = async (checked: boolean) => {
    setCloudSync(checked)
    if (isTauri) {
      try {
        const { invoke } = await import("@tauri-apps/api/core")
        const s = await invoke<any>("get_settings")
        await invoke("save_settings", {
          settings: {
            ...s,
            cloudSync: checked
          }
        })
        toast.success(checked ? "Sincronização global ativada!" : "Sincronização global desativada.")
      } catch (err) {
        toast.error(`Falha ao salvar configuração: ${err}`)
      }
    } else {
      toast.success(checked ? "[Mock] Sincronização global ligada!" : "[Mock] Sincronização global desligada.")
    }
  }

  // Finish wizard and save
  const handleFinishWizard = async () => {
    try {
      if (isTauri) {
        const { invoke } = await import("@tauri-apps/api/core")
        const s = await invoke<any>("get_settings")
        await invoke("save_settings", {
          settings: {
            ...s,
            cloudSync: true
          }
        })
      }
      setCloudSync(true)
      setShowDashboard(true)
      localStorage.setItem("luducard_has_cloud_remote", "true")
      toast.success("Configuração de Nuvem ativada com sucesso!")
    } catch (err) {
      toast.error(`Falha ao finalizar: ${err}`)
    }
  }

  const isStepComplete = (step: number) => {
    if (step === 1) return !!rclonePath
    if (step === 2) return remoteConnected
    if (step === 3) return !!cloudPath.trim()
    if (step === 4) return testSteps.every((s) => s.status === "success")
    return false
  }

  // RENDER STATIC DASHBOARD (If wizard is completed)
  if (showDashboard) {
    return (
      <div className="flex flex-col gap-6 animate-in fade-in-50 duration-300">
        <Card className={cn(
          "transition-all duration-300",
          cloudSync
            ? "border-emerald-500/25 bg-emerald-500/5"
            : "border-amber-500/25 bg-amber-500/5"
        )}>
          <CardContent className="pt-6 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
            <div className="flex items-start gap-3 text-left">
              {cloudSync ? (
                <CheckCircle2 className="size-6 text-emerald-400 shrink-0 mt-0.5" />
              ) : (
                <AlertTriangle className="size-6 text-amber-400 shrink-0 mt-0.5" />
              )}
              <div className="flex flex-col gap-0.5">
                <span className={cn(
                  "text-base font-semibold",
                  cloudSync ? "text-emerald-400" : "text-amber-400"
                )}>
                  {cloudSync
                    ? t("luducard-cloud-active", "Sincronização em Nuvem Ativa e Saudável")
                    : t("luducard-cloud-paused", "Sincronização em Nuvem Pausada")}
                </span>
                <span className="text-xs text-muted-foreground">
                  {cloudSync
                    ? t("luducard-cloud-active-desc", "Seus backups locais serão enviados e sincronizados automaticamente na nuvem.")
                    : t("luducard-cloud-paused-desc", "O envio para a nuvem está pausado. Ative para sincronizar seus saves.")}
                </span>
              </div>
            </div>
            <div className="flex items-center gap-3">
              <Switch checked={cloudSync} onCheckedChange={handleEnableGlobalSync} />
              <Button variant="destructive" size="sm" onClick={handleUnlink}>
                <Unlink className="size-4 mr-2" />
                {t("luducard-cloud-disconnect", "Desconectar Conta")}
              </Button>
            </div>
          </CardContent>
        </Card>

        <div className={cn(
          "grid grid-cols-1 md:grid-cols-2 gap-6 transition-all duration-300",
          !cloudSync && "opacity-40 grayscale pointer-events-none"
        )}>
          {/* Details */}
          <Card className="border-primary/10">
            <CardHeader>
              <CardTitle className="text-sm font-semibold flex items-center gap-2">
                <Cloud className="size-4 text-primary" />
                {t("luducard-cloud-details-title", "Detalhes da Conta")}
              </CardTitle>
            </CardHeader>
            <CardContent className="flex flex-col gap-3 text-left text-sm">
              <div className="flex justify-between py-1.5 border-b border-border/40">
                <span className="text-muted-foreground">{t("luducard-cloud-provider", "Provedor Conectado:")}</span>
                <span className="font-medium text-foreground">{activeProvider}</span>
              </div>
              {cloudEmail && (
                <div className="flex justify-between py-1.5 border-b border-border/40">
                  <span className="text-muted-foreground">{t("luducard-cloud-email", "E-mail da Conta:")}</span>
                  <span className="font-medium text-foreground">{cloudEmail}</span>
                </div>
              )}
              <div className="flex justify-between py-1.5 border-b border-border/40">
                <span className="text-muted-foreground">{t("luducard-cloud-destination", "Pasta de Destino:")}</span>
                <span className="font-mono text-xs">{cloudPath}</span>
              </div>
              <div className="flex justify-between py-1.5 border-b border-border/40">
                <span className="text-muted-foreground">{t("luducard-cloud-engine", "Motor do Backup:")}</span>
                <span className="font-medium text-foreground">Rclone</span>
              </div>
              <div className="flex justify-between py-1.5">
                <span className="text-muted-foreground">{t("luducard-cloud-path", "Caminho Executável:")}</span>
                <span className="font-mono text-xs max-w-[200px] truncate" title={rclonePath}>{rclonePath}</span>
              </div>
            </CardContent>
          </Card>

          {/* Settings / Rules */}
          <Card className="border-primary/10">
            <CardHeader>
              <CardTitle className="text-sm font-semibold flex items-center gap-2">
                <Sparkles className="size-4 text-primary" />
                {t("luducard-cloud-rules-title", "Regras de Sincronização")}
              </CardTitle>
            </CardHeader>
            <CardContent className="flex flex-col gap-4">
              <div className="flex items-center justify-between">
                <div className="flex flex-col gap-0.5 text-left">
                  <span className="text-xs font-semibold">{t("luducard-cloud-upload-auto", "Upload Automático")}</span>
                  <span className="text-[10px] text-muted-foreground">{t("luducard-cloud-upload-auto-desc", "Upar saves assim que o backup local for gerado.")}</span>
                </div>
                <Switch checked={autoUpload} onCheckedChange={(c) => {
                  setAutoUpload(c)
                  toast.success(c ? t("luducard-cloud-toast-upload-enabled", "Upload automático ativado") : t("luducard-cloud-toast-upload-disabled", "Upload automático desativado"))
                }} />
              </div>
              <Separator className="bg-border/40" />
              <div className="flex items-center justify-between">
                <div className="flex flex-col gap-0.5 text-left">
                  <span className="text-xs font-semibold">{t("luducard-cloud-download-latest", "Baixar mais Recente")}</span>
                  <span className="text-[10px] text-muted-foreground">{t("luducard-cloud-download-latest-desc", "Dar prioridade aos arquivos mais novos na nuvem.")}</span>
                </div>
                <Switch checked={autoDownload} onCheckedChange={(c) => {
                  setAutoDownload(c)
                  toast.success(c ? t("luducard-cloud-toast-download-enabled", "Download automático ativado") : t("luducard-cloud-toast-download-disabled", "Download automático desativado"))
                }} />
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  // RENDER WIZARD FLOW
  return (
    <div className="flex flex-col gap-6 animate-in fade-in-50 duration-300">
      {/* Wizard Header Stepper */}
      <Card className="border-primary/10 bg-card/40 backdrop-blur-sm">
        <CardContent className="pt-6">
          <div className="flex items-center justify-between">
            {[
              { num: 1, name: "Motor (Rclone)", desc: "Instalar rclone" },
              { num: 2, name: "Provedor (Login)", desc: "Fazer Login" },
              { num: 3, name: "Pasta Destino", desc: "Configurar pasta" },
              { num: 4, name: "Validação", desc: "Testar conexão" },
              { num: 5, name: "Ativação", desc: "Finalizar" },
            ].map((step, idx) => (
              <div key={step.num} className="flex flex-1 items-center last:flex-initial">
                <button
                  onClick={() => {
                    if (step.num < currentStep || isStepComplete(step.num - 1) || (step.num === 2 && rclonePath)) {
                      setCurrentStep(step.num as any)
                    }
                  }}
                  className="flex flex-col items-center gap-1.5 focus:outline-none group text-left sm:text-center animate-fade-in"
                >
                  <span
                    className={cn(
                      "flex size-8 items-center justify-center rounded-full text-xs font-bold transition-all border",
                      currentStep === step.num
                        ? "bg-primary border-primary text-primary-foreground shadow-md shadow-primary/30"
                        : isStepComplete(step.num)
                        ? "bg-emerald-500/20 border-emerald-500 text-emerald-400"
                        : "bg-muted border-border text-muted-foreground group-hover:border-primary/50"
                    )}
                  >
                    {isStepComplete(step.num) ? <Check className="size-4" /> : step.num}
                  </span>
                  <span className="hidden sm:flex flex-col text-xs">
                    <span className={cn("font-medium", currentStep === step.num ? "text-primary" : "text-foreground/80")}>
                      {step.name}
                    </span>
                    <span className="text-[10px] text-muted-foreground">{step.desc}</span>
                  </span>
                </button>
                {idx < 4 && (
                  <div
                    className={cn(
                      "mx-4 h-0.5 flex-1 rounded-full bg-border transition-colors hidden sm:block",
                      isStepComplete(step.num) ? "bg-emerald-500/40" : ""
                    )}
                  />
                )}
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* STEP 1: Rclone Installation */}
      {currentStep === 1 && (
        <Card className="border-primary/10 bg-card/60">
          <CardHeader>
            <div className="flex items-center gap-3">
              <span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary">
                <Download className="size-5" />
              </span>
              <div>
                <CardTitle className="text-base">Passo 1: Instalação do Motor Rclone</CardTitle>
                <CardDescription>O Rclone é o motor de código aberto seguro usado para fazer o upload e download de arquivos em nuvem.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="flex flex-col gap-6">
            {rclonePath ? (
              <div className="rounded-lg border border-emerald-500/25 bg-emerald-500/5 p-5 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="size-5 text-emerald-400 shrink-0 mt-0.5" />
                  <div className="flex flex-col gap-0.5 text-left">
                    <span className="text-sm font-semibold text-emerald-400">Rclone Detectado e Pronto!</span>
                    <span className="text-xs text-muted-foreground font-mono break-all">{rclonePath}</span>
                  </div>
                </div>
                <div className="flex gap-2">
                  <Button variant="outline" size="sm" onClick={handleSelectRcloneManual}>
                    Alterar Executável
                  </Button>
                  <Button size="sm" onClick={() => setCurrentStep(2)}>
                    Avançar
                    <ArrowRight className="size-4 ml-1" />
                  </Button>
                </div>
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center border border-dashed border-border rounded-xl p-8 text-center gap-4 bg-muted/10">
                <span className="flex size-14 items-center justify-center rounded-2xl bg-amber-500/10 text-amber-300">
                  <AlertTriangle className="size-7" />
                </span>
                <div className="max-w-md flex flex-col gap-1">
                  <span className="text-sm font-semibold">Nenhum executável Rclone encontrado</span>
                  <p className="text-xs text-muted-foreground">
                    Para que a sincronização funcione, precisamos baixar o executável do Rclone ou indicar o caminho de um já instalado.
                  </p>
                </div>
                <div className="flex flex-col sm:flex-row gap-3 w-full max-w-sm justify-center">
                  <Button 
                    className="flex-1 font-semibold"
                    onClick={handleDownloadRclone}
                    disabled={isDownloading}
                  >
                    {isDownloading ? (
                      <>
                        <Loader2 className="size-4 mr-2 animate-spin" />
                        Baixando Rclone...
                      </>
                    ) : (
                      <>
                        <Sparkles className="size-4 mr-2 text-yellow-300 animate-bounce" />
                        Instalar Automaticamente
                      </>
                    )}
                  </Button>
                  <Button 
                    variant="outline" 
                    onClick={handleSelectRcloneManual}
                    disabled={isDownloading}
                  >
                    <FolderOpen className="size-4 mr-2" />
                    Selecionar Pasta
                  </Button>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {/* STEP 2: Provider & Login */}
      {currentStep === 2 && (
        <Card className="border-primary/10 bg-card/60">
          <CardHeader>
            <div className="flex items-center gap-3">
              <span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary">
                <LinkIcon className="size-5" />
              </span>
              <div>
                <CardTitle className="text-base">Passo 2: Vincular Conta de Nuvem</CardTitle>
                <CardDescription>Escolha o seu provedor de nuvem de preferência e faça login.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="flex flex-col gap-6">
            {/* Provider Grid */}
            <div className="flex flex-col gap-2">
              <span className="text-xs font-semibold text-muted-foreground text-left">Selecione o Provedor:</span>
              <div className="grid grid-cols-2 gap-3 sm:grid-cols-5">
                {providersList.map((p) => (
                  <button
                    key={p.provider}
                    disabled={remoteConnected}
                    onClick={() => setActiveProvider(p.provider)}
                    className={cn(
                      "relative flex flex-col items-center gap-2.5 rounded-xl border p-4 transition-all focus:outline-none",
                      activeProvider === p.provider
                        ? "border-primary bg-primary/5 shadow-md shadow-primary/5 scale-105"
                        : "border-border bg-muted/20 hover:border-primary/30",
                      remoteConnected ? "opacity-50 cursor-not-allowed" : ""
                    )}
                  >
                    <span className={cn("flex size-10 items-center justify-center rounded-lg text-xs font-bold", p.color)}>
                      {p.initials}
                    </span>
                    <span className="text-xs font-medium">{p.provider}</span>
                  </button>
                ))}
              </div>
            </div>

            {remoteConnected ? (
              <div className="rounded-lg border border-emerald-500/20 bg-emerald-500/5 p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="size-5 text-emerald-400 shrink-0 mt-0.5 animate-bounce" />
                  <div className="flex flex-col gap-0.5 text-left">
                    <span className="text-sm font-semibold text-emerald-400">Conta Vinculada!</span>
                    <span className="text-xs text-muted-foreground">
                      Conexão via <strong className="text-foreground">{activeProvider}</strong> estabelecida com sucesso.
                    </span>
                  </div>
                </div>
                <div className="flex gap-2">
                  <Button variant="destructive" size="sm" onClick={handleUnlink}>
                    <Unlink className="size-4 mr-1.5" />
                    {t("luducard-cloud-disconnect-btn", "Desconectar")}
                  </Button>
                  <Button size="sm" onClick={() => setCurrentStep(3)}>
                    Avançar
                    <ArrowRight className="size-4 ml-1" />
                  </Button>
                </div>
              </div>
            ) : (
              <div className="flex flex-col gap-4 max-w-md border border-border p-5 rounded-xl bg-muted/10 text-left">
                <div className="flex flex-col gap-1">
                  <span className="text-sm font-semibold">Autenticação do Provedor</span>
                  <p className="text-xs text-muted-foreground">
                    Ao clicar no botão abaixo, abriremos o seu navegador web para que você possa escolher sua conta e fazer o login com segurança.
                  </p>
                </div>

                <div className="flex flex-col gap-3">
                  <Button
                    disabled={isLinking}
                    onClick={handleLinkAccount}
                    className="w-full font-semibold"
                  >
                    {isLinking ? (
                      <>
                        <Loader2 className="size-4 mr-2 animate-spin" />
                        Aguardando Login...
                      </>
                    ) : (
                      <>
                        <LinkIcon className="size-4 mr-2" />
                        Fazer Login / Vincular Conta
                      </>
                    )}
                  </Button>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {/* STEP 3: Cloud Folder Destination Config */}
      {currentStep === 3 && (
        <Card className="border-primary/10 bg-card/60">
          <CardHeader>
            <div className="flex items-center gap-3">
              <span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary">
                <Folder className="size-5" />
              </span>
              <div>
                <CardTitle className="text-base">Passo 3: Pasta de Destino na Nuvem</CardTitle>
                <CardDescription>Escolha a pasta do seu provedor onde seus backups de save serão guardados.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="flex flex-col gap-6">
            <div className="flex flex-col gap-4 max-w-md border border-border p-5 rounded-xl bg-muted/10 text-left">
              <div className="flex flex-col gap-1.5">
                <label className="text-xs font-semibold text-muted-foreground">Nome da Pasta Remota:</label>
                <Input
                  type="text"
                  placeholder="luducard-backup"
                  value={cloudPath}
                  onChange={(e) => setCloudPath(e.target.value)}
                />
                <span className="text-[10px] text-muted-foreground">
                  Se você já tem uma pasta de backups no {activeProvider}, digite o nome exato dela aqui para reutilizá-la. Caso contrário, digite um novo nome e ela será criada automaticamente.
                </span>
              </div>
              <Button onClick={handleSaveCloudFolder} className="font-semibold">
                Salvar e Avançar
                <ArrowRight className="size-4 ml-2" />
              </Button>
            </div>
          </CardContent>
        </Card>
      )}

      {/* STEP 4: Real Round-Trip Connection Test */}
      {currentStep === 4 && (
        <Card className="border-primary/10 bg-card/60">
          <CardHeader>
            <div className="flex items-center gap-3">
              <span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary animate-pulse">
                <RefreshCw className="size-5" />
              </span>
              <div>
                <CardTitle className="text-base">Passo 4: Validação de Conexão (Ida & Volta)</CardTitle>
                <CardDescription>Fazemos um teste real escrevendo e lendo um arquivo de teste na sua pasta de nuvem para validar as permissões.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="flex flex-col gap-6">
            <div className="flex flex-col gap-3 max-w-lg border border-border p-5 rounded-xl bg-muted/10">
              <div className="flex flex-col gap-2">
                {testSteps.map((step) => (
                  <div key={step.id} className="flex items-center justify-between border-b border-border/40 pb-2 last:border-0 last:pb-0">
                    <span className="text-xs font-medium text-foreground/80 flex items-center gap-2">
                      <span className="text-muted-foreground font-semibold">{step.id}.</span>
                      {step.label}
                    </span>
                    <span>
                      {step.status === "idle" && (
                        <span className="text-[10px] text-muted-foreground bg-muted border border-border px-2 py-0.5 rounded-full font-medium">Aguardando</span>
                      )}
                      {step.status === "running" && (
                        <span className="text-[10px] text-primary bg-primary/10 border border-primary/20 px-2 py-0.5 rounded-full font-medium flex items-center gap-1">
                          <Loader2 className="size-3 animate-spin" /> Executando
                        </span>
                      )}
                      {step.status === "success" && (
                        <span className="text-[10px] text-emerald-400 bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 rounded-full font-medium flex items-center gap-1 animate-scale-up">
                          <CheckCircle2 className="size-3 text-emerald-400" /> Sucesso
                        </span>
                      )}
                      {step.status === "error" && (
                        <span className="text-[10px] text-destructive bg-destructive/10 border border-destructive/20 px-2 py-0.5 rounded-full font-medium flex items-center gap-1">
                          <XCircle className="size-3 text-destructive" /> Falhou
                        </span>
                      )}
                    </span>
                  </div>
                ))}
              </div>

              {testError && (
                <div className="rounded-lg border border-destructive/25 bg-destructive/5 p-3 text-xs text-destructive flex items-start gap-2 mt-3 font-mono text-left">
                  <AlertTriangle className="size-4 shrink-0 mt-0.5" />
                  <span>Erro de Teste: {testError}</span>
                </div>
              )}

              {testSteps.every((s) => s.status === "success") && (
                <div className="rounded-lg border border-emerald-500/30 bg-emerald-500/10 p-4 text-emerald-400 text-sm flex items-start gap-3 mt-3 shadow-md shadow-emerald-500/5 text-left">
                  <CheckCircle2 className="size-5 shrink-0 mt-0.5 text-emerald-400 animate-bounce" />
                  <div className="flex flex-col gap-0.5">
                    <span className="font-semibold text-emerald-400">Sincronização configurada com sucesso e pronta para uso!</span>
                    <span className="text-xs text-emerald-500/80 font-medium">O teste de upload e download do arquivo temporário funcionou perfeitamente.</span>
                  </div>
                </div>
              )}

              <div className="flex gap-3 mt-4">
                <Button 
                  onClick={handleTestConnection} 
                  disabled={isTesting}
                  className="flex-1 font-semibold"
                >
                  {isTesting ? (
                    <>
                      <Loader2 className="size-4 mr-2 animate-spin" />
                      Testando Conexão...
                    </>
                  ) : (
                    <>
                      <RefreshCw className="size-4 mr-2" />
                      Testar Conexão Real
                    </>
                  )}
                </Button>
                {testSteps.every((s) => s.status === "success") && (
                  <Button 
                    variant="outline" 
                    onClick={() => setCurrentStep(5)}
                  >
                    Avançar
                    <ArrowRight className="size-4 ml-1" />
                  </Button>
                )}
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      {/* STEP 5: Rule settings & finish */}
      {currentStep === 5 && (
        <Card className="border-primary/10 bg-card/60">
          <CardHeader>
            <div className="flex items-center gap-3">
              <span className="flex size-10 items-center justify-center rounded-xl bg-primary/10 text-primary">
                <Cloud className="size-5" />
              </span>
              <div>
                <CardTitle className="text-base">Passo 5: Regras de Sincronização & Ativação</CardTitle>
                <CardDescription>Ajuste os gatilhos automáticos para que a nuvem trabalhe por você.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="flex flex-col gap-6">
            {/* Master Switch */}
            <div className="flex items-center justify-between p-4 rounded-xl border border-primary/20 bg-primary/5 max-w-xl text-left">
              <div className="flex flex-col gap-0.5">
                <span className="text-sm font-semibold flex items-center gap-1.5">
                  <Cloud className="size-4 text-primary" />
                  Ativar Sincronização em Nuvem Global
                </span>
                <span className="text-xs text-muted-foreground">Quando desativado, o envio para a nuvem fica em pausa.</span>
              </div>
              <Switch checked={cloudSync} onCheckedChange={handleEnableGlobalSync} />
            </div>

            {/* Sync Rules switches */}
            <div className="flex flex-col gap-1 max-w-xl border border-border rounded-xl p-3 bg-muted/10 text-left">
              <label className="flex items-center justify-between gap-3 rounded-lg px-2 py-3 border-b border-border/40 last:border-0">
                <span className="flex items-center gap-3 text-left">
                  <ArrowUpFromLine className="size-4 text-primary shrink-0" />
                  <span className="flex flex-col">
                    <span className="text-xs font-semibold">Upload automático após backup local</span>
                    <span className="text-[10px] text-muted-foreground">
                      Envia para a nuvem imediatamente após cada backup.
                    </span>
                  </span>
                </span>
                <Switch 
                  checked={autoUpload} 
                  onCheckedChange={(c) => {
                    setAutoUpload(c)
                    toast.message(c ? "Upload automático ligado" : "Upload automático desligado")
                  }} 
                />
              </label>

              <label className="flex items-center justify-between gap-3 rounded-lg px-2 py-3">
                <span className="flex items-center gap-3 text-left">
                  <ArrowDownToLine className="size-4 text-primary shrink-0" />
                  <span className="flex flex-col">
                    <span className="text-xs font-semibold">Baixar se o save remoto for mais recente</span>
                    <span className="text-[10px] text-muted-foreground">
                      Resolve conflitos priorizando a versão mais nova da nuvem.
                    </span>
                  </span>
                </span>
                <Switch 
                  checked={autoDownload} 
                  onCheckedChange={(c) => {
                    setAutoDownload(c)
                    toast.message(c ? "Download automático ligado" : "Download automático desligado")
                  }} 
                />
              </label>
            </div>

            <div className="flex gap-3 max-w-xl justify-end">
              <Button onClick={handleFinishWizard} className="font-semibold">
                Finalizar e Fechar
              </Button>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
