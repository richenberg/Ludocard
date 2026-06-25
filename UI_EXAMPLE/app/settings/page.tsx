import { AppShell } from "@/components/app-shell"
import { SettingsClient } from "@/components/settings/settings-client"

export default function SettingsPage() {
  return (
    <AppShell
      title="Configurações"
      description="Preferências globais e comportamento do aplicativo"
    >
      <SettingsClient />
    </AppShell>
  )
}
