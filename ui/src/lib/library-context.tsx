import React, { createContext, useContext, useState, useEffect, useCallback } from "react";
import { type Game, games as mockGames } from "@/lib/mock-data";

function checkIsTauri(): boolean {
  return typeof window !== "undefined" && (window as any).__TAURI_INTERNALS__ !== undefined;
}

export interface CoverProgress {
  downloading: boolean;
  current: number;
  total: number;
  percentage: number;
}

interface LibraryContextType {
  games: Game[];
  loading: boolean;
  scanning: boolean;
  coverProgress: CoverProgress;
  loadGames: (silent?: boolean) => Promise<void>;
  scanGames: () => Promise<void>;
  stats: {
    totalGames: number;
    totalSizeMB: number;
    cloudSynced: number;
    pending: number;
  };
}

const LibraryContext = createContext<LibraryContextType | undefined>(undefined);

export function LibraryProvider({ children }: { children: React.ReactNode }) {
  const [isTauri] = useState(checkIsTauri);
  const [games, setGames] = useState<Game[]>(isTauri ? [] : mockGames);
  const [loading, setLoading] = useState(isTauri);
  const [scanning, setScanning] = useState(false);
  const [coverProgress, setCoverProgress] = useState<CoverProgress>({
    downloading: false,
    current: 0,
    total: 0,
    percentage: 0,
  });

  const loadGames = useCallback(async (silent = false) => {
    if (!isTauri) return;
    if (!silent) setLoading(true);
    try {
      const { invoke } = await import("@tauri-apps/api/core");
      const list = await invoke<Game[]>("get_games");
      setGames(list);
    } catch (err) {
      console.error("Failed to load games from Tauri:", err);
    } finally {
      setLoading(false);
    }
  }, [isTauri]);

  const scanGames = useCallback(async () => {
    if (!isTauri) {
      setScanning(true);
      await new Promise((resolve) => setTimeout(resolve, 2000));
      setScanning(false);

      // Simula o progresso do download de capas no navegador
      let current = 0;
      const total = 3;
      setCoverProgress({
        downloading: true,
        current: 0,
        total,
        percentage: 0,
      });

      const interval = setInterval(() => {
        current += 1;
        const percentage = Math.round((current * 100) / total);
        setCoverProgress({
          downloading: current < total,
          current,
          total,
          percentage,
        });
        if (current >= total) {
          clearInterval(interval);
        }
      }, 1500);
      return;
    }
    setScanning(true);
    try {
      const { invoke } = await import("@tauri-apps/api/core");
      const list = await invoke<Game[]>("scan_games");
      setGames(list);
    } catch (err) {
      console.error("Failed to scan games:", err);
      throw err;
    } finally {
      setScanning(false);
    }
  }, [isTauri]);

  useEffect(() => {
    loadGames();
  }, [loadGames]);

  useEffect(() => {
    if (!isTauri) return;

    let unlistenProgress: (() => void) | null = null;
    let unlistenDownloaded: (() => void) | null = null;

    const setupListeners = async () => {
      try {
        const { listen } = await import("@tauri-apps/api/event");

        const unsubProgress = await listen<CoverProgress>("cover-download-progress", (event) => {
          setCoverProgress(event.payload);
        });
        unlistenProgress = unsubProgress;

        const unsubDownloaded = await listen<{ gameId: string; cover: string }>("cover-downloaded", (event) => {
          setGames((prev) =>
            prev.map((g) =>
              g.id === event.payload.gameId ? { ...g, cover: event.payload.cover } : g
            )
          );
        });
        unlistenDownloaded = unsubDownloaded;
      } catch (err) {
        console.error("Failed to setup Tauri cover listeners:", err);
      }
    };

    setupListeners();

    return () => {
      if (unlistenProgress) unlistenProgress();
      if (unlistenDownloaded) unlistenDownloaded();
    };
  }, [isTauri]);

  const stats = React.useMemo(() => {
    return {
      totalGames: games.length,
      totalSizeMB: games.reduce((acc, g) => acc + (g.sizeMB || 0), 0),
      cloudSynced: games.filter((g) => g.cloudSync).length,
      pending: games.filter((g) => g.status === "pending" || g.status === "never").length,
    };
  }, [games]);

  return (
    <LibraryContext.Provider value={{ games, loading, scanning, coverProgress, loadGames, scanGames, stats }}>
      {children}
    </LibraryContext.Provider>
  );
}

export function useLibrary() {
  const context = useContext(LibraryContext);
  if (context === undefined) {
    throw new Error("useLibrary must be used within a LibraryProvider");
  }
  return context;
}
