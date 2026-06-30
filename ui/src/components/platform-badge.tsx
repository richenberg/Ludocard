import { cn } from "@/lib/utils"
import { type Platform, platformColors, emulatorColors } from "@/lib/mock-data"

export function PlatformBadge({
  platform,
  emulator,
  className,
}: {
  platform: Platform
  emulator?: string
  className?: string
}) {
  const displayLabel = emulator || platform
  const colorClass = emulator ? (emulatorColors[emulator] || platformColors[platform]) : platformColors[platform]

  return (
    <span
      className={cn(
        "inline-flex items-center rounded-md border px-2 py-0.5 text-xs font-medium",
        colorClass,
        className,
      )}
    >
      {displayLabel}
    </span>
  )
}
