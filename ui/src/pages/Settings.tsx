import { AppShell } from "@/components/app-shell"
import { SettingsClient } from "@/components/settings/settings-client"

export default function Settings() {
  return (
    <AppShell
      title="Configurações"
      description="Preferências e comportamento do aplicativo"
    >
      <SettingsClient />
    </AppShell>
  )
}
