import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { HashRouter } from "react-router-dom";
import { Toaster } from "@/components/ui/sonner";
import { LibraryProvider } from "@/lib/library-context";
import App from "./App";
import "./globals.css";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <HashRouter>
      <LibraryProvider>
        <App />
        <Toaster position="bottom-right" />
      </LibraryProvider>
    </HashRouter>
  </StrictMode>
);
