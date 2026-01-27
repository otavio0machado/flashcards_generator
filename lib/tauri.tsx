'use client';

import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';
import { useRouter } from 'next/navigation';

interface TauriContextType {
    isTauri: boolean;
    platform: string | null;
    isDesktop: boolean;
    isMobile: boolean;
    appVersion: string | null;
    sidebarCollapsed: boolean;
    setSidebarCollapsed: (collapsed: boolean) => void;
}

const TauriContext = createContext<TauriContextType>({
    isTauri: false,
    platform: null,
    isDesktop: false,
    isMobile: false,
    appVersion: null,
    sidebarCollapsed: false,
    setSidebarCollapsed: () => {},
});

function detectPlatform(): { platform: string; isDesktop: boolean; isMobile: boolean } {
    if (typeof window === 'undefined' || typeof navigator === 'undefined') {
        return { platform: 'unknown', isDesktop: true, isMobile: false };
    }

    const userAgent = navigator.userAgent.toLowerCase();

    if (userAgent.includes('android')) {
        return { platform: 'android', isDesktop: false, isMobile: true };
    }
    if (userAgent.includes('iphone') || userAgent.includes('ipad')) {
        return { platform: 'ios', isDesktop: false, isMobile: true };
    }
    if (userAgent.includes('win')) {
        return { platform: 'windows', isDesktop: true, isMobile: false };
    }
    if (userAgent.includes('mac')) {
        return { platform: 'macos', isDesktop: true, isMobile: false };
    }
    if (userAgent.includes('linux')) {
        return { platform: 'linux', isDesktop: true, isMobile: false };
    }

    return { platform: 'unknown', isDesktop: true, isMobile: false };
}

export function TauriProvider({ children }: { children: ReactNode }) {
    const [state, setState] = useState<Omit<TauriContextType, 'setSidebarCollapsed'>>({
        isTauri: false,
        platform: null,
        isDesktop: false,
        isMobile: false,
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
            const { platform, isDesktop, isMobile } = detectPlatform();

            // Restore sidebar state from localStorage
            const savedCollapsed = localStorage.getItem('desktop_sidebar_collapsed') === 'true';

            setState(prev => ({
                ...prev,
                isTauri: true,
                platform,
                isDesktop,
                isMobile,
                sidebarCollapsed: savedCollapsed,
            }));

            // Get app version
            import('@tauri-apps/api/app').then(({ getVersion }) => {
                getVersion().then(version => {
                    setState(prev => ({ ...prev, appVersion: version }));
                });
            }).catch(() => {
                // Version unavailable
            });
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
