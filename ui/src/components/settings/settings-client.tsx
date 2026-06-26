import { useState, useEffect } from "react"
import { toast } from "sonner"
import {
  Settings2,
  CalendarClock,
  Bell,
  Power,
  Monitor,
  Languages,
  Clock,
  HardDrive,
  Cloud,
  FileCode,
  Eye,
} from "lucide-react"
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Switch } from "@/components/ui/switch"
import { Checkbox } from "@/components/ui/checkbox"
import { Button } from "@/components/ui/button"
import { Separator } from "@/components/ui/separator"
import { Input } from "@/components/ui/input"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectGroup,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group"
import { PlatformBadge } from "@/components/platform-badge"
import { games } from "@/lib/mock-data"

const isTauri = typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;

function SettingRow({
  icon: Icon,
  title,
  description,
  control,
}: {
  icon: any
  title: string
  description: string
  control: React.ReactNode
}) {
  return (
    <div className="flex items-center justify-between gap-3 py-3">
      <span className="flex items-center gap-3">
        <Icon className="size-4 text-primary" />
        <span className="flex flex-col">
          <span className="text-sm font-medium">{title}</span>
          <span className="text-xs text-muted-foreground">{description}</span>
        </span>
      </span>
      {control}
    </div>
  )
}

export function SettingsClient() {
  const [scheduleMode, setScheduleMode] = useState<"interval" | "days">("interval")
  const [scheduledGames, setScheduledGames] = useState<Record<string, boolean>>(
    Object.fromEntries(games.filter((g) => g.autoBackup).map((g) => [g.id, true])),
  )

  const weekDays = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"]
  const [activeDays, setActiveDays] = useState<string[]>(["Seg", "Qua", "Sex"])

  // Real backend settings state
  const [backupPath, setBackupPath] = useState("")
  const [rclonePath, setRclonePath] = useState("")
  const [cloudPath, setCloudPath] = useState("")
  const [cloudSync, setCloudSync] = useState(false)
  const [rcloneArguments, setRcloneArguments] = useState("")
  const [fileWatcher, setFileWatcher] = useState(false)

  const loadSettings = async () => {
    if (!isTauri) return;
    try {
      const { invoke } = await import("@tauri-apps/api/core");
      const s = await invoke<{
        backupPath: string;
        rclonePath: string;
        cloudPath: string;
        cloudSync: boolean;
        rcloneArguments: string;
        fileWatcher: boolean;
      }>("get_settings");
      setBackupPath(s.backupPath);
      setRclonePath(s.rclonePath);
      setCloudPath(s.cloudPath);
      setCloudSync(s.cloudSync);
      setRcloneArguments(s.rcloneArguments);
      setFileWatcher(s.fileWatcher);
    } catch (err) {
      console.error("Failed to load settings from Tauri:", err);
    }
  }

  useEffect(() => {
    loadSettings();
  }, []);

  const handleSaveSettings = async () => {
    if (isTauri) {
      const id = toast.loading("Salvando configurações...");
      try {
        const { invoke } = await import("@tauri-apps/api/core");
        await invoke("save_settings", {
          settings: {
            backupPath,
            rclonePath,
            cloudPath,
            cloudSync,
            rcloneArguments,
            fileWatcher,
          }
        });
        toast.success("Configurações salvas no backend!", { id });
        loadSettings();
      } catch (err) {
        toast.error(`Erro ao salvar: ${err}`, { id });
      }
    } else {
      toast.success("[Mock] Configurações salvas com sucesso!");
    }
  }

  return (
    <Tabs defaultValue="general" className="gap-6">
      <TabsList>
        <TabsTrigger value="general">
          <Settings2 data-icon="inline-start" />
          Geral
        </TabsTrigger>
        <TabsTrigger value="schedule">
          <CalendarClock data-icon="inline-start" />
          Agendamento
        </TabsTrigger>
        <TabsTrigger value="notifications">
          <Bell data-icon="inline-start" />
          Notificações
        </TabsTrigger>
      </TabsList>

      {/* General */}
      <TabsContent value="general">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Preferências gerais</CardTitle>
            <CardDescription>Caminhos e comportamento básico do aplicativo.</CardDescription>
          </CardHeader>
          <CardContent className="flex flex-col">
            <SettingRow
              icon={Eye}
              title="Monitor de Saves (File Watcher)"
              description="Monitora alterações nos saves e faz backup automático quando o jogo fechar."
              control={<Switch checked={fileWatcher} onCheckedChange={(c) => { setFileWatcher(c); toast.message(c ? "File Watcher ativado" : "File Watcher desativado") }} />}
            />
            <Separator />
            <SettingRow
              icon={Power}
              title="Iniciar com o Windows"
              description="Abre minimizado na bandeja do sistema ao ligar o PC."
              control={<Switch defaultChecked onCheckedChange={(c) => toast.message(c ? "Inicialização automática ligada" : "Desligada")} />}
            />
            <Separator />
            <SettingRow
              icon={Monitor}
              title="Tema"
              description="Aparência da interface do aplicativo."
              control={
                <Select defaultValue="dark">
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectItem value="dark">Escuro</SelectItem>
                      <SelectItem value="light">Claro</SelectItem>
                      <SelectItem value="system">Sistema</SelectItem>
                    </SelectGroup>
                  </SelectContent>
                </Select>
              }
            />
            <Separator />
            <SettingRow
              icon={Languages}
              title="Idioma"
              description="Idioma da interface."
              control={
                <Select defaultValue="pt">
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectGroup>
                      <SelectItem value="pt">Português</SelectItem>
                      <SelectItem value="en">English</SelectItem>
                      <SelectItem value="es">Español</SelectItem>
                    </SelectGroup>
                  </SelectContent>
                </Select>
              }
            />
            
            {/* Real Paths configuration when running under Tauri */}
            <Separator />
            <div className="flex flex-col gap-2.5 py-3">
              <span className="flex items-center gap-2 text-sm font-medium">
                <HardDrive className="size-4 text-primary" />
                Diretório de Backup
              </span>
              <span className="text-xs text-muted-foreground">Onde os saves dos seus jogos serão guardados localmente.</span>
              <Input
                value={backupPath}
                onChange={(e) => setBackupPath(e.target.value)}
                placeholder="Ex: C:/Users/Player/LudocardBackups"
                className="max-w-md font-mono text-xs"
              />
            </div>

            <Separator />
            <div className="flex flex-col gap-2.5 py-3">
              <span className="flex items-center gap-2 text-sm font-medium">
                <FileCode className="size-4 text-primary" />
                Caminho do executável Rclone
              </span>
              <span className="text-xs text-muted-foreground">Caminho para o executável rclone usado no envio para nuvem.</span>
              <Input
                value={rclonePath}
                onChange={(e) => setRclonePath(e.target.value)}
                placeholder="rclone"
                className="max-w-md font-mono text-xs"
              />
            </div>

            <Separator />
            <div className="flex flex-col gap-2.5 py-3">
              <span className="flex items-center gap-2 text-sm font-medium">
                <Cloud className="size-4 text-primary" />
                Pasta Remota na Nuvem
              </span>
              <span className="text-xs text-muted-foreground">Nome da pasta remota para sincronizar os arquivos.</span>
              <Input
                value={cloudPath}
                onChange={(e) => setCloudPath(e.target.value)}
                placeholder="ludusavi"
                className="max-w-md font-mono text-xs"
              />
            </div>

            <Separator />
            <div className="flex flex-col gap-2.5 py-3">
              <span className="flex items-center gap-2 text-sm font-medium">
                <Cloud className="size-4 text-primary" />
                Argumentos extras do Rclone
              </span>
              <span className="text-xs text-muted-foreground">Comandos e flags opcionais passados diretamente ao rclone.</span>
              <Input
                value={rcloneArguments}
                onChange={(e) => setRcloneArguments(e.target.value)}
                placeholder="Ex: --fast-list"
                className="max-w-md font-mono text-xs"
              />
            </div>

            <Separator />
            <div className="flex justify-end pt-4">
              <Button onClick={handleSaveSettings}>Salvar Configurações</Button>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      {/* Schedule */}
      <TabsContent value="schedule">
        <div className="flex flex-col gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Rotina de saves automáticos</CardTitle>
              <CardDescription>Defina quando os backups acontecem.</CardDescription>
            </CardHeader>
            <CardContent className="flex flex-col gap-5">
              <ToggleGroup
                value={[scheduleMode]}
                onValueChange={(v) => {
                  const next = v[0] as "interval" | "days" | undefined
                  if (next) setScheduleMode(next)
                }}
                variant="outline"
                spacing={0}
              >
                <ToggleGroupItem value="interval">Por intervalo</ToggleGroupItem>
                <ToggleGroupItem value="days">Dias da semana</ToggleGroupItem>
              </ToggleGroup>

              {scheduleMode === "interval" ? (
                <div className="flex items-center gap-3 rounded-lg border border-border bg-muted/30 p-4">
                  <Clock className="size-4 text-primary" />
                  <span className="text-sm">Fazer backup a cada</span>
                  <Select defaultValue="6">
                    <SelectTrigger className="w-28">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectGroup>
                        <SelectItem value="1">1 hora</SelectItem>
                        <SelectItem value="3">3 horas</SelectItem>
                        <SelectItem value="6">6 horas</SelectItem>
                        <SelectItem value="12">12 horas</SelectItem>
                        <SelectItem value="24">24 horas</SelectItem>
                      </SelectGroup>
                    </SelectContent>
                  </Select>
                </div>
              ) : (
                <div className="flex flex-col gap-3 rounded-lg border border-border bg-muted/30 p-4">
                  <div className="flex flex-wrap gap-1.5">
                    {weekDays.map((d) => (
                      <button
                        key={d}
                        onClick={() =>
                          setActiveDays((prev) =>
                            prev.includes(d) ? prev.filter((x) => x !== d) : [...prev, d],
                          )
                        }
                        className={
                          activeDays.includes(d)
                            ? "rounded-md bg-primary px-3 py-1.5 text-xs font-medium text-primary-foreground"
                            : "rounded-md border border-border px-3 py-1.5 text-xs font-medium text-muted-foreground hover:text-foreground"
                        }
                      >
                        {d}
                      </button>
                    ))}
                  </div>
                  <div className="flex items-center gap-3">
                    <Clock className="size-4 text-primary" />
                    <span className="text-sm">No horário</span>
                    <Select defaultValue="22">
                      <SelectTrigger className="w-24">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectGroup>
                          <SelectItem value="08">08:00</SelectItem>
                          <SelectItem value="12">12:00</SelectItem>
                          <SelectItem value="18">18:00</SelectItem>
                          <SelectItem value="22">22:00</SelectItem>
                        </SelectGroup>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Jogos no cronograma</CardTitle>
              <CardDescription>
                Selecione quais jogos seguem esta rotina automática.
              </CardDescription>
            </CardHeader>
            <CardContent className="flex flex-col gap-2">
              {games.map((g) => (
                <label
                  key={g.id}
                  className="flex cursor-pointer items-center gap-3 rounded-lg border border-border bg-muted/30 p-3 transition-colors hover:border-primary/40"
                >
                  <Checkbox
                    checked={!!scheduledGames[g.id]}
                    onCheckedChange={(c) =>
                      setScheduledGames((s) => ({ ...s, [g.id]: c === true }))
                    }
                  />
                  <img
                    src={g.cover || "/placeholder.svg"}
                    alt=""
                    className="h-10 w-8 rounded object-cover"
                  />
                  <span className="flex-1 truncate text-sm font-medium">{g.title}</span>
                  <PlatformBadge platform={g.platform} />
                </label>
              ))}
              <Button
                className="mt-2 self-end"
                onClick={() => toast.success("Cronograma salvo")}
              >
                Salvar cronograma
              </Button>
            </CardContent>
          </Card>
        </div>
      </TabsContent>

      {/* Notifications */}
      <TabsContent value="notifications">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Alertas e notificações</CardTitle>
            <CardDescription>Como você quer ser avisado sobre os backups.</CardDescription>
          </CardHeader>
          <CardContent className="flex flex-col">
            <SettingRow
              icon={Bell}
              title="Notificações do Windows"
              description="Avisa quando um backup é concluído com sucesso."
              control={<Switch defaultChecked onCheckedChange={(c) => toast.message(c ? "Notificações ligadas" : "Notificações desligadas")} />}
            />
            <Separator />
            <SettingRow
              icon={Bell}
              title="Alertas de falha"
              description="Notifica imed