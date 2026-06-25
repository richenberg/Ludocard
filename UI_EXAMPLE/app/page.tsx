import Link from "next/link"
import { ScanLine } from "lucide-react"
import { AppShell } from "@/components/app-shell"
import { Button } from "@/components/ui/button"
import { LibraryClient } from "@/components/dashboard/library-client"

export default function HomePage() {
  return (
    <AppShell
      title="Biblioteca"
      description="Gerencie e proteja os saves dos seus jogos"
      actions={
        <Button
          render={
            <Link href="/scan">
              <ScanLine data-icon="inline-start" />
              Escanear agora
            </Link>
          }
        />
      }
    >
      <LibraryClient />
    </AppShell>
  )
}
