import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { HashRouter } from "react-router-dom";
import { Toaster } from "@/components/ui/sonner";
import { LibraryProvider } from "@/lib/library-context";
import { I18nProvider } from "@/lib/i18n";
import App from "./App";
import "./globals.css";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <HashRouter>
      <I18nProvider>
        <LibraryProvider>
          <App />
          <Toaster position="bottom-right" />
        </LibraryProvider>
      </I18nProvider>
    </HashRouter>
  </StrictMode>
);
