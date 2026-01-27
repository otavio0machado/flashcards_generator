'use client';

import { useState, useEffect } from 'react';
import { WifiOff, Wifi, CloudOff, RefreshCw } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { useBackgroundSync } from '@/lib/useBackgroundSync';

export default function OfflineIndicator() {
    const [isOnline, setIsOnline] = useState(true);
    const [showBanner, setShowBanner] = useState(false);
    const [pendingCount, setPendingCount] = useState(0);
    const [isSyncing, setIsSyncing] = useState(false);
    const { triggerSync, getPendingCards } = useBackgroundSync();

    useEffect(() => {
        // Set initial state
        setIsOnline(navigator.onLine);
        setShowBanner(!navigator.onLine);

        // Listen for online/offline events
        const handleOnline = () => {
            setIsOnline(true);
            // Keep banner visible briefly to show we're back online
            setTimeout(() => setShowBanner(false), 3000);
            // Trigger sync when back online
            handleSync();
        };

        const handleOffline = () => {
            setIsOnline(false);
            setShowBanner(true);
        };

        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);

        // Check for pending items
        checkPendingItems();

        // Listen for sync events
        const handleCardSynced = () => {
            checkPendingItems();
        };

        window.addEventListener('cardSynced', handleCardSynced);

        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
            window.removeEventListener('cardSynced', handleCardSynced);
        };
    }, []);

    async function checkPendingItems() {
        const cards = await getPendingCards();
        setPendingCount(cards.length);
    }

    async function handleSync() {
        if (!navigator.onLine) return;
        
        setIsSyncing(true);
        await triggerSync();
        
        // Wait a bit then check pending items
        setTimeout(() => {
            checkPendingItems();
            setIsSyncing(false);
        }, 2000);
    }

    return (
        <AnimatePresence>
            {showBanner && (
                <motion.div
                    initial={{ y: -100, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    exit={{ y: -100, opacity: 0 }}
                    className={`fixed top-0 left-0 right-0 z-50 p-3 text-center text-sm font-medium ${
                        isOnline 
                            ? 'bg-green-500 text-white' 
                            : 'bg-amber-500 text-white'
                    }`}
                >
                    <div className="flex items-center justify-center gap-2">
                        {isOnline ? (
                            <>
                                <Wifi className="h-4 w-4" />
                                <span>Conexão restaurada! Sincronizando dados...</span>
                            </>
                        ) : (
                            <>
                                <WifiOff className="h-4 w-4" />
                                <span>Você está offline. Suas alterações serão salvas localmente.</span>
                            </>
                        )}
                    </div>
                </motion.div>
            )}

            {/* Pending sync indicator */}
            {pendingCount > 0 && isOnline && (
                <motion.button
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    exit={{ scale: 0 }}
                    onClick={handleSync}
                    disabled={isSyncing}
                    className="fixed bottom-20 right-4 z-40 flex items-center gap-2 rounded-full bg-brand px-4 py-2 text-sm font-medium text-white shadow-lg hover:bg-brand/90 disabled:opacity-70"
                >
                    <RefreshCw className={`h-4 w-4 ${isSyncing ? 'animate-spin' : ''}`} />
                    <span>{pendingCount} pendente{pendingCount !== 1 ? 's' : ''}</span>
                </motion.button>
            )}

            {/* Persistent offline mode indicator */}
            {!isOnline && (
                <motion.div
                    initial={{ x: 100, opacity: 0 }}
                    animate={{ x: 0, opacity: 1 }}
                    exit={{ x: 100, opacity: 0 }}
                    className="fixed bottom-4 right-4 z-40 flex items-center gap-2 rounded-full bg-zinc-800 px-3 py-1.5 text-xs text-white shadow-lg dark:bg-zinc-700"
                >
                    <CloudOff className="h-3 w-3" />
                    <span>Modo Offline</span>
                </motion.div>
            )}
        </AnimatePresence>
    );
}
