'use client';

import { useState, useEffect } from 'react';
import { useTauri } from '@/lib/tauri';
import FeedbackWidget from '@/components/FeedbackWidget';
import CookieConsent from '@/components/CookieConsent';
import InstallPrompt from '@/components/InstallPrompt';
import OfflineIndicator from '@/components/OfflineIndicator';
import { WifiOff, RefreshCw } from 'lucide-react';

function DesktopOfflineIndicator() {
    const [isOffline, setIsOffline] = useState(false);

    useEffect(() => {
        setIsOffline(!navigator.onLine);

        const handleOffline = () => setIsOffline(true);
        const handleOnline = () => setIsOffline(false);

        window.addEventListener('offline', handleOffline);
        window.addEventListener('online', handleOnline);
        return () => {
            window.removeEventListener('offline', handleOffline);
            window.removeEventListener('online', handleOnline);
        };
    }, []);

    if (!isOffline) return null;

    return (
        <div className="fixed top-0 left-0 right-0 z-50 bg-amber-500 text-white px-4 py-2 flex items-center justify-center gap-3 text-sm font-medium shadow-md">
            <WifiOff className="w-4 h-4 shrink-0" />
            <span>Sem conexão com a internet</span>
            <button
                onClick={() => window.location.reload()}
                className="inline-flex items-center gap-1.5 px-3 py-1 bg-white/20 rounded-md hover:bg-white/30 transition-colors text-xs font-semibold"
            >
                <RefreshCw className="w-3 h-3" />
                Reconectar
            </button>
        </div>
    );
}

export default function TauriConditionalComponents() {
    const { isTauri } = useTauri();

    if (isTauri) {
        return <DesktopOfflineIndicator />;
    }

    return (
        <>
            <FeedbackWidget />
            <CookieConsent />
            <InstallPrompt />
            <OfflineIndicator />
        </>
    );
}
