import type { ReactNode } from "react"
import { SidebarProvider, SidebarInset, SidebarTrigger } from "@/components/ui/sidebar"
import { Separator } from "@/components/ui/separator"
import { AppSidebar } from "@/components/app-sidebar"

interface AppShellProps {
  title: ReactNode
  description?: ReactNode
  actions?: ReactNode
  children: ReactNode
}

export function AppShell({ title, description, actions, children }: AppShellProps) {
  return (
    <SidebarProvider>
      <AppSidebar />
      <SidebarInset>
        <header className="sticky top-0 z-10 flex shrink-0 items-center gap-3 border-b border-border bg-background/80 px-4 py-3 backdrop-blur md:px-6">
          <SidebarTrigger className="md:hidden" />
          <Separator orientation="vertical" className="h-6 md:hidden" />
          <div className="flex min-w-0 flex-1 flex-col">
            <h1 className="truncate text-lg font-semibold leading-tight">{title}</h1>
            {description ? (
              <p className="truncate text-sm text-muted-foreground">{description}</p>
            ) : null}
          </div>
          {actions ? <div className="flex items-center gap-2">{actions}</div> : null}
        </header>
        <div className="flex-1 p-4 md:p-6">{children}</div>
      </SidebarInset>
    </SidebarProvider>
  )
}
