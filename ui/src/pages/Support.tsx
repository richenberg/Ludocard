import {
  Heart,
  Coffee,
  Globe,
  ExternalLink,
  Info,
  CreditCard,
} from "lucide-react"
import { AppShell } from "@/components/app-shell"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { useI18n } from "@/lib/i18n"

const ITCH_URL = "https://itch.io" // Link de doação do Itch.io
const STRIPE_URL = "https://stripe.com" // Link de pagamento do Stripe (suporta Pix e Cartões)

export default function Support() {
  const { t } = useI18n()
  
  const handleOpenUrl = async (url: string) => {
    try {
      const { invoke } = await import("@tauri-apps/api/core")
      await invoke("open_url", { url })
    } catch (err) {
      console.error("Failed to open URL in browser:", err)
      // Fallback inside web browser
      window.open(url, "_blank", "noopener,noreferrer")
    }
  }

  return (
    <AppShell
      title={t("ludocard-support-title", "Apoiar o Projeto")}
      description={t("ludocard-support-desc", "Ajude a manter os servidores comunitários de saves e presets online")}
    >
      <div className="flex flex-col gap-6 max-w-2xl mx-auto my-4">
        {/* Intro Banner */}
        <div className="relative overflow-hidden rounded-2xl border border-border bg-gradient-to-r from-primary/10 via-background to-background p-5 shadow-sm">
          <div className="relative flex flex-col sm:flex-row gap-4 items-start sm:items-center">
            <div className="flex size-12 shrink-0 items-center justify-center rounded-xl bg-primary/20 text-primary border border-primary/30">
              <Heart className="size-6 fill-current text-rose-500 animate-pulse" />
            </div>
            <div className="flex-1 flex flex-col gap-1">
              <h2 className="text-sm font-bold text-foreground">{t("ludocard-support-intro-title", "O Ludocard é totalmente gratuito!")}</h2>
              <p className="text-xs text-muted-foreground leading-relaxed">
                {t("ludocard-support-intro-desc", "Nossos recursos de nuvem (Save Share Hub e Presets) geram custos mensais de servidores e tráfego. Se o aplicativo é útil para você, considere apoiar para ajudar a mantê-los online!")}
              </p>
            </div>
          </div>
        </div>

        {/* Unified Support Card */}
        <Card className="relative overflow-hidden border-border bg-card/60 backdrop-blur-md shadow-lg">
          <div className="absolute top-0 right-0 w-24 h-24 bg-primary/5 rounded-bl-full pointer-events-none" />
          
          <CardHeader className="pb-4">
            <CardTitle className="flex items-center gap-2 text-base text-primary">
              <span className="flex size-6 items-center justify-center rounded-md bg-primary/10 text-primary">
                <Coffee className="size-3.5 fill-current" />
              </span>
              {t("ludocard-how-to-support", "Como Apoiar o Projeto")}
            </CardTitle>
            <CardDescription className="text-xs">
              {t("ludocard-how-to-support-desc", "Escolha a sua forma de contribuição preferida. O Stripe oferece suporte a cartões de crédito e PIX nacional.")}
            </CardDescription>
          </CardHeader>
          
          <CardContent className="pb-6">
            {/* Action Buttons (Itch & Stripe) */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {/* Itch.io Button */}
              <Button
                onClick={() => handleOpenUrl(ITCH_URL)}
                className="w-full bg-rose-600 hover:bg-rose-500 text-white font-medium flex items-center justify-center gap-2 h-11 shadow-md shadow-rose-950/10 cursor-pointer text-sm"
              >
                <Globe className="size-4" />
                {t("ludocard-support-itch", "Apoiar no Itch.io")}
                <ExternalLink className="size-3.5" />
              </Button>

              {/* Stripe Button */}
              <Button
                onClick={() => handleOpenUrl(STRIPE_URL)}
                className="w-full bg-indigo-600 hover:bg-indigo-500 text-white font-medium flex items-center justify-center gap-2 h-11 shadow-md shadow-indigo-950/10 cursor-pointer text-sm"
              >
                <CreditCard className="size-4" />
                {t("ludocard-support-stripe", "Cartão / PIX via Stripe")}
                <ExternalLink className="size-3.5" />
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Server status alert info */}
        <div className="flex gap-3 rounded-xl border border-blue-500/20 bg-blue-500/5 p-4 text-xs text-blue-300">
          <Info className="size-4 shrink-0 text-blue-400 mt-0.5" />
          <div className="flex flex-col gap-0.5">
            <span className="font-semibold text-blue-200">{t("ludocard-support-dest", "Destinação dos Recursos")}</span>
            <p className="text-[11px] text-blue-300/80 leading-relaxed">
              {t("ludocard-support-dest-desc", "Toda contribuição é integralmente voltada para a manutenção dos servidores em nuvem (hospedagem e tráfego de dados).")}
            </p>
          </div>
        </div>
      </div>
    </AppShell>
  )
}
