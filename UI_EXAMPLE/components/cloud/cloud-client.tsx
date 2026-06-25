"use client"

import { useState } from "react"
import { toast } from "sonner"
import { Cloud, Check, LinkIcon, Unlink, HardDrive, ArrowUpFromLine, ArrowDownToLine } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Switch } from "@/components/ui/switch"
import { Progress } from "@/components/ui/progress"
import { cn } from "@/lib/utils"
import { cloudProviders, type CloudProvider } from "@/lib/mock-data"

const providerInitials: Record<CloudProvider, string> = {
  "Google Drive": "GD",
  OneDrive: "OD",
  Dropbox: "DB",
  WebDAV: "WD",
  FTP: "FTP",
}

const providerColor: Record<CloudProvider, string> = {
  "Google Drive": "bg-sky-500/15 text-sky-300",
  OneDrive: "bg-blue-500/15 text-blue-300",
  Dropbox: "bg-indigo-500/15 text-indigo-300",
  WebDAV: "bg-teal-500/15 text-teal-300",
  FTP: "bg-amber-500/15 text-amber-300",
}

export function CloudClient() {
  const [active, setActive] = useState<CloudProvider>("Google Drive")
  const [providers, setProviders] = useState(cloudProviders)

  const current = providers.find((p) => p.provider === active)!

  function toggleConnection(provider: CloudProvider) {
    setProviders((prev) =>
      prev.map((p) =>
        p.provider === provider
          ? p.connected
            ? { ...p, connected: false, account: undefined, usedGB: undefined, totalGB: undefined }
            : { ...p, connected: true, account: "player@exemplo.com", usedGB: 3.2, totalGB: 100 }
          : p,
      ),
    )
    const wasConnected = providers.find((p) => p.provider === provider)?.connected
    toast[wasConnected ? "message" : "success"](
      wasConnected ? `${provider} desconectado` : `${provider} conectado`,
    )
  }

  return (
    <div className="flex flex-col gap-6">
      {/* Provider selector */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Provedor de nuvem</CardTitle>
          <CardDescription>
            Escolha onde seus backups serão armazenados remotamente.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
            {providers.map((p) => (
              <button
                key={p.provider}
                onClick={() => setActive(p.provider)}
                className={cn(
                  "relative flex flex-col items-center gap-2 rounded-xl border p-4 transition-colors",
                  active === p.provider
                    ? "border-primary bg-primary/5"
                    : "border-border bg-muted/30 hover:border-primary/40",
                )}
              >
                {p.connected && (
                  <span className="absolute right-2 top-2 flex size-4 items-center justify-center rounded-full bg-primary text-primary-foreground">
                    <Check className="size-3" />
                  </span>
                )}
                <span
                  className={cn(
                    "flex size-11 items-center justify-center rounded-lg text-sm font-bold",
                    providerColor[p.provider],
                  )}
                >
                  {providerInitials[p.provider]}
                </span>
                <span className="text-xs font-medium">{p.provider}</span>
              </button>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Authentication / status */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-base">
            <Cloud className="size-4 text-primary" />
            {active}
          </CardTitle>
          <CardDescription>Status de autenticação e armazenamento.</CardDescription>
        </CardHeader>
        <CardContent className="flex flex-col gap-4">
          {current.connected ? (
            <>
              <div className="flex flex-col gap-3 rounded-lg border border-border bg-muted/30 p-4 sm:flex-row sm:items-center sm:justify-between">
                <div className="flex flex-col gap-0.5">
                  <span className="flex items-center gap-2 text-sm font-medium">
                    <Check className="size-4 text-primary" />
                    Conectado como {current.account}
                  </span>
                  <span className="text-xs text-muted-foreground">
                    Conta autorizada via OAuth
                  </span>
                </div>
                <Button variant="outline" size="sm" onClick={() => toggleConnection(active)}>
                  <Unlink data-icon="inline-start" />
                  Desconectar
                </Button>
              </div>

              {current.usedGB != null && current.totalGB != null && (
                <div className="flex flex-col gap-2">
                  <div className="flex items-center justify-between text-sm">
                    <span className="flex items-center gap-2 text-muted-foreground">
                      <HardDrive className="size-4" />
                      Espaço utilizado
                    </span>
                    <span className="font-medium">
                      {current.usedGB} GB de {current.totalGB} GB
                    </span>
                  </div>
                  <Progress value={(current.usedGB / current.totalGB) * 100} />
                </div>
              )}
            </>
          ) : (
            <div className="flex flex-col items-center gap-3 rounded-lg border border-dashed border-border py-8 text-center">
              <span className={cn("flex size-12 items-center justify-center rounded-xl text-base font-bold", providerColor[active])}>
                {providerInitials[active]}
              </span>
              <p className="max-w-xs text-balance text-sm text-muted-foreground">
                Conecte sua conta {active} para habilitar o backup remoto dos seus saves.
              </p>
              <Button onClick={() => toggleConnection(active)}>
                <LinkIcon data-icon="inline-start" />
                Conectar conta
              </Button>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Sync rules */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Regras de sincronização</CardTitle>
          <CardDescription>Como os saves se movem entre o PC e a nuvem.</CardDescription>
        </CardHeader>
        <CardContent className="flex flex-col gap-1">
          <label className="flex items-center justify-between gap-3 rounded-lg px-1 py-3">
            <span className="flex items-center gap-3">
              <ArrowUpFromLine className="size-4 text-primary" />
              <span className="flex flex-col">
                <span className="text-sm font-medium">Upload automático após backup local</span>
                <span className="text-xs text-muted-foreground">
                  Envia para a nuvem imediatamente após cada backup.
                </span>
              </span>
            </span>
            <Switch defaultChecked onCheckedChange={(c) => toast.message(c ? "Upload automático ligado" : "Upload automático desligado")} />
          </label>
          <label className="flex items-center justify-between gap-3 rounded-lg px-1 py-3">
            <span className="flex items-center gap-3">
              <ArrowDownToLine className="size-4 text-primary" />
              <span className="flex flex-col">
                <span className="text-sm font-medium">Baixar se o save remoto for mais recente</span>
                <span className="text-xs text-muted-foreground">
                  Resolve conflitos priorizando a versão mais nova.
                </span>
              </span>
            </span>
            <Switch defaultChecked onCheckedChange={(c) => toast.message(c ? "Download automático ligado" : "Download automático desligado")} />
          </label>
        </CardContent>
      </Card>
    </div>
  )
}
