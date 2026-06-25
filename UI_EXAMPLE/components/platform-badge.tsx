import { cn } from "@/lib/utils"
import { type Platform, platformColors } from "@/lib/mock-data"

export function PlatformBadge({
  platform,
  className,
}: {
  platform: Platform
  className?: string
}) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-md border px-2 py-0.5 text-xs font-medium",
        platformColors[platform],
        className,
      )}
    >
      {platform}
    </span>
  )
}
