import { AppShell } from "@/components/app-shell"
import { CloudClient } from "@/components/cloud/cloud-client"

export default function Cloud() {
  return (
    <AppShell
      title="Nuvem & Sincronização"
      description="Configure o backup remoto dos seus saves"
    >
      <CloudClient />
    </AppShell>
  )
}
