'use client';

import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';
import { useRouter } from 'next/navigation';

interface TauriContextType {
    isTauri: boolean;
    isLoading: boolean;
    platform: string | null;
    isDesktop: boolean;
    isMobile: boolean;
    isTablet: boolean; // NEW
    isMobileTauri: boolean;
    isDesktopTauri: boolean;
    appVersion: string | null;
    sidebarCollapsed: boolean;
    setSidebarCollapsed: (collapsed: boolean) => void;
}

const TauriContext = createContext<TauriContextType>({
    isTauri: false,
    isLoading: true,
    platform: null,
    isDesktop: false,
    isMobile: false,
    isTablet: false, // NEW
    isMobileTauri: false,
    isDesktopTauri: false,
    appVersion: null,
    sidebarCollapsed: false,
    setSidebarCollapsed: () => { },
});

function detectPlatform(): { platform: string; isDesktop: boolean; isMobile: boolean; isTablet: boolean } {
    if (typeof window === 'undefined' || typeof navigator === 'undefined') {
        return { platform: 'unknown', isDesktop: true, isMobile: false, isTablet: false };
    }

    const userAgent = navigator.userAgent.toLowerCase();

    // iPad Pro / iPadOS 13+ often sends "Macintosh" as UA but has touch points
    const isIpadOS = (userAgent.includes('mac') && typeof navigator !== 'undefined' && navigator.maxTouchPoints > 1);

    // Tablet Detection
    const isIpad = userAgent.includes('ipad') || isIpadOS;
    const isAndroid = userAgent.includes('android');
    const isMobileUA = userAgent.includes('mobile');

    // Android Tablet: Android but often NOT "mobile" (though sometimes it is). 
    // Best effort: Android AND NOT Mobile, OR iPad.
    const isAndroidTablet = isAndroid && !isMobileUA;
    const isTablet = isIpad || isAndroidTablet;

    if (isAndroid || isIpad || userAgent.includes('iphone') || userAgent.includes('ipod')) {
        // Platform identification
        let platform = 'unknown';
        if (isAndroid) platform = 'android';
        else if (isIpad || userAgent.includes('iphone') || userAgent.includes('ipod')) platform = 'ios';

        return { platform, isDesktop: false, isMobile: true, isTablet };
    }

    if (userAgent.includes('win')) {
        return { platform: 'windows', isDesktop: true, isMobile: false, isTablet: false };
    }
    if (userAgent.includes('mac')) {
        return { platform: 'macos', isDesktop: true, isMobile: false, isTablet: false };
    }

    return { platform: 'unknown', isDesktop: true, isMobile: false, isTablet: false };
}

export function TauriProvider({ children }: { children: ReactNode }) {
    const [state, setState] = useState<Omit<TauriContextType, 'setSidebarCollapsed'>>({
        isTauri: false,
        isLoading: true,
        platform: null,
        isDesktop: false,
        isMobile: false,
        isTablet: false,
        isMobileTauri: false,
        isDesktopTauri: false,
        appVersion: null,
        sidebarCollapsed: false,
    });

    const setSidebarCollapsed = useCallback((collapsed: boolean) => {
        setState(prev => ({ ...prev, sidebarCollapsed: collapsed }));
        if (typeof window !== 'undefined') {
            localStorage.setItem('desktop_sidebar_collapsed', collapsed ? 'true' : 'false');
        }
    }, []);

    useEffect(() => {
        const isTauriEnv = typeof window !== 'undefined' && '__TAURI__' in window;

        if (isTauriEnv) {
            const { platform, isDesktop, isMobile, isTablet } = detectPlatform();

            // Restore sidebar state from localStorage
            const savedCollapsed = localStorage.getItem('desktop_sidebar_collapsed') === 'true';

            setState(prev => ({
                ...prev,
                isTauri: true,
                platform,
                isDesktop,
                isMobile,
                isTablet,
                isMobileTauri: isMobile,
                isDesktopTauri: isDesktop,
                sidebarCollapsed: savedCollapsed,
                isLoading: !isMobile, // On mobile we can trust UA more for immediate redirect, desktop waits for plugin
            }));

            // Reliable platform info via @tauri-apps/plugin-os (sync in v2)
            import('@tauri-apps/plugin-os').then(({ platform: osPlatform }) => {
                const os = osPlatform();
                const isMobileOs = os === 'android' || os === 'ios';
                const isDesktopOs = !isMobileOs;
                setState(prev => ({
                    ...prev,
                    platform: os,
                    isDesktop: isDesktopOs,
                    isMobile: isMobileOs,
                    isMobileTauri: isMobileOs,
                    isDesktopTauri: isDesktopOs,
                    isLoading: false,
                }));
            }).catch(() => {
                setState(prev => ({ ...prev, isLoading: false }));
            });

            // Get app version
            import('@tauri-apps/api/app').then(({ getVersion }) => {
                getVersion().then(version => {
                    setState(prev => ({ ...prev, appVersion: version }));
                });
            }).catch(() => {
                // Version unavailable
            });
        } else {
            // WEB environment
            const { platform, isDesktop, isMobile, isTablet } = detectPlatform();
            setState(prev => ({
                ...prev,
                isTauri: false,
                isLoading: false,
                platform,
                isDesktop,
                isMobile,
                isTablet,
                isMobileTauri: false,
                isDesktopTauri: false,
            }));
        }
    }, []);

    return (
        <TauriContext.Provider value={{ ...state, setSidebarCollapsed }}>
            {children}
        </TauriContext.Provider>
    );
}

export function useTauri() {
    return useContext(TauriContext);
}

// Static check (no context needed)
export function isTauriApp(): boolean {
    return typeof window !== 'undefined' && '__TAURI__' in window;
}

// --- Small helpers for mobile/native interactions ---
export async function pickFilesTauri(accept: string[] = ['*/*']): Promise<Array<{ name: string; path?: string; type?: string; blob?: Blob }>> {
    try {
        // Dynamically import to avoid SSR bundling issues
        const { open } = await import('@tauri-apps/plugin-dialog');
        const { readFile } = await import('@tauri-apps/plugin-fs');

        const selected = await open({ multiple: true });
        if (!selected) return [];

        // selected may be string or string[]
        const files = Array.isArray(selected) ? selected : [selected];

        const results: Array<{ name: string; path?: string; type?: string; blob?: Blob }> = [];

        for (const filePath of files) {
            try {
                const bytes = await readFile(filePath as string);
                const u8 = new Uint8Array(bytes as unknown as number[]);
                const blob = new Blob([u8.buffer]);
                const name = (filePath as string).split(/[\\/]/).pop() || 'file';
                results.push({ name, path: filePath as string, blob });
            } catch (e) {
                console.error('pickFilesTauri read failed:', e);
            }
        }

        return results;
    } catch (err) {
        console.warn('Tauri file picker not available', err);
        return [];
    }
}

export async function performOCRStub(filePath: string): Promise<string> {
    // Placeholder for native OCR implementation in future
    await new Promise((r) => setTimeout(r, 400));
    return 'OCR não implementado (stub)';
}

// --- Desktop keyboard shortcuts ---

export function useDesktopShortcuts() {
    const { isTauri, isDesktop } = useTauri();
    const router = useRouter();

    useEffect(() => {
        if (!isTauri || !isDesktop) return;

        const handleKeyDown = (e: KeyboardEvent) => {
            const mod = e.ctrlKey || e.metaKey;
            if (!mod) return;

            // Don't capture shortcuts when typing in inputs
            const target = e.target as HTMLElement;
            if (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable) {
                return;
            }

            if (e.key === 'n' && !e.shiftKey) {
                e.preventDefault();
                router.push('/app');
            } else if (e.key === 'b' && !e.shiftKey) {
                e.preventDefault();
                router.push('/decks');
            } else if (e.key === ',' && !e.shiftKey) {
                e.preventDefault();
                router.push('/settings');
            } else if (e.key === 'e' && !e.shiftKey) {
                e.preventDefault();
                router.push('/marketplace');
            } else if (e.key === 'd' && e.shiftKey) {
                e.preventDefault();
                const root = document.documentElement;
                const isDark = root.classList.contains('dark');
                const newTheme = isDark ? 'light' : 'dark';
                root.classList.toggle('dark', !isDark);
                root.setAttribute('data-theme', newTheme);
                localStorage.setItem('theme', newTheme);
            }
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [isTauri, isDesktop, router]);
}
