import { AppShell } from "@/components/app-shell"
import { CloudClient } from "@/components/cloud/cloud-client"
import { useI18n } from "@/lib/i18n"

export default function Cloud() {
  const { t } = useI18n()
  return (
    <AppShell
      title={t("ludocard-cloud-title", "Nuvem & Sincronização")}
      description={t("ludocard-cloud-desc", "Configure o backup remoto dos seus saves")}
    >
      <CloudClient />
    </AppShell>
  )
}
