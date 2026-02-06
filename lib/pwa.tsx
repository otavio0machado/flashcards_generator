'use client';

import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';

interface BeforeInstallPromptEvent extends Event {
    readonly platforms: string[];
    readonly userChoice: Promise<{
        outcome: 'accepted' | 'dismissed';
        platform: string;
    }>;
    prompt(): Promise<void>;
}

declare global {
    interface WindowEventMap {
        beforeinstallprompt: BeforeInstallPromptEvent;
    }
}

interface PWAContextType {
    isStandalone: boolean;
    isInstallable: boolean;
    isIOS: boolean;
    promptInstall: () => Promise<'accepted' | 'dismissed' | 'unavailable'>;
}

const PWAContext = createContext<PWAContextType>({
    isStandalone: false,
    isInstallable: false,
    isIOS: false,
    promptInstall: async () => 'unavailable',
});

export function PWAProvider({ children }: { children: ReactNode }) {
    const [isStandalone, setIsStandalone] = useState(false);
    const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null);
    const [isIOS, setIsIOS] = useState(false);

    useEffect(() => {
        // Detect standalone mode (PWA installed)
        const mqStandalone = window.matchMedia('(display-mode: standalone)');
        const safariStandalone = (navigator as Navigator & { standalone?: boolean }).standalone === true;
        setIsStandalone(mqStandalone.matches || safariStandalone);

        const handleDisplayChange = (e: MediaQueryListEvent) => {
            setIsStandalone(e.matches);
        };
        mqStandalone.addEventListener('change', handleDisplayChange);

        // Detect iOS
        const ua = navigator.userAgent;
        setIsIOS(/iPad|iPhone|iPod/.test(ua) && !('MSStream' in window));

        // Capture beforeinstallprompt
        const handleBeforeInstall = (e: BeforeInstallPromptEvent) => {
            e.preventDefault();
            setDeferredPrompt(e);
        };
        window.addEventListener('beforeinstallprompt', handleBeforeInstall);

        return () => {
            mqStandalone.removeEventListener('change', handleDisplayChange);
            window.removeEventListener('beforeinstallprompt', handleBeforeInstall);
        };
    }, []);

    const promptInstall = useCallback(async (): Promise<'accepted' | 'dismissed' | 'unavailable'> => {
        if (!deferredPrompt) return 'unavailable';
        await deferredPrompt.prompt();
        const { outcome } = await deferredPrompt.userChoice;
        setDeferredPrompt(null);
        return outcome;
    }, [deferredPrompt]);

    return (
        <PWAContext.Provider value={{
            isStandalone,
            isInstallable: !!deferredPrompt,
            isIOS,
            promptInstall,
        }}>
            {children}
        </PWAContext.Provider>
    );
}

export function usePWA() {
    return useContext(PWAContext);
}

export function isStandaloneMode(): boolean {
    if (typeof window === 'undefined') return false;
    return window.matchMedia('(display-mode: standalone)').matches
        || (navigator as Navigator & { standalone?: boolean }).standalone === true;
}
