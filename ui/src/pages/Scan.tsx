import { AppShell } from "@/components/app-shell"
import { ScanClient } from "@/components/scan/scan-client"

export default function Scan() {
  return (
    <AppShell
      title="Escanear & Adicionar"
      description="Encontre saves de jogos no seu computador"
    >
      <ScanClient />
    </AppShell>
  )
}
