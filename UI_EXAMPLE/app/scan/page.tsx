import { AppShell } from "@/components/app-shell"
import { ScanClient } from "@/components/scan/scan-client"

export default function ScanPage() {
  return (
    <AppShell
      title="Escanear & Adicionar"
      description="Encontre saves e adicione jogos ao gerenciador"
    >
      <ScanClient />
    </AppShell>
  )
}
