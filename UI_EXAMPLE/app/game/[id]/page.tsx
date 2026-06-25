import Link from "next/link"
import { notFound } from "next/navigation"
import { ArrowLeft } from "lucide-react"
import { AppShell } from "@/components/app-shell"
import { Button } from "@/components/ui/button"
import { GameDetailClient } from "@/components/game-detail/game-detail-client"
import { getGame } from "@/lib/mock-data"

export default async function GamePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const game = getGame(id)
  if (!game) notFound()

  return (
    <AppShell
      title={game.title}
      description="Detalhes e histórico de backups"
      actions={
        <Button
          variant="outline"
          render={
            <Link href="/">
              <ArrowLeft data-icon="inline-start" />
              Voltar
            </Link>
          }
        />
      }
    >
      <GameDetailClient game={game} />
    </AppShell>
  )
}
