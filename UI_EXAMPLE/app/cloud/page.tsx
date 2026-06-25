import { AppShell } from "@/components/app-shell"
import { CloudClient } from "@/components/cloud/cloud-client"

export default function CloudPage() {
  return (
    <AppShell
      title="Nuvem & Sincronização"
      description="Conecte um provedor e configure o backup remoto"
    >
      <CloudClient />
    </AppShell>
  )
}
