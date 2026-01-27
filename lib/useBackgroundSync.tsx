'use client';

import { useEffect, useRef, useCallback } from 'react';

interface PendingCard {
    deck_id: string;
    question: string;
    answer: string;
}

interface PendingStudy {
    deck_id: string;
    cards_studied: number;
    duration_seconds: number;
    completed_at: string;
}

export function useBackgroundSync() {
    const swRef = useRef<ServiceWorkerRegistration | null>(null);

    useEffect(() => {
        if ('serviceWorker' in navigator) {
            navigator.serviceWorker.ready.then((registration) => {
                swRef.current = registration;
            });

            // Listen for messages from service worker
            navigator.serviceWorker.addEventListener('message', handleSWMessage);

            return () => {
                navigator.serviceWorker.removeEventListener('message', handleSWMessage);
            };
        }
    }, []);

    const handleSWMessage = useCallback((event: MessageEvent) => {
        const { type, data, success } = event.data;

        switch (type) {
            case 'CARD_SYNCED':
                console.log('Card synced successfully:', data);
                // You can dispatch a custom event or update state here
                window.dispatchEvent(new CustomEvent('cardSynced', { detail: { cardId: data, success } }));
                break;
            case 'CARD_SAVED_OFFLINE':
                console.log('Card saved offline');
                window.dispatchEvent(new CustomEvent('cardSavedOffline'));
                break;
            case 'STUDY_SAVED_OFFLINE':
                console.log('Study session saved offline');
                window.dispatchEvent(new CustomEvent('studySavedOffline'));
                break;
        }
    }, []);

    const isOnline = useCallback(() => {
        return navigator.onLine;
    }, []);

    const saveCardOffline = useCallback(async (card: PendingCard): Promise<boolean> => {
        const controller = navigator.serviceWorker.controller;
        if (!controller) {
            console.warn('Service worker not ready');
            return false;
        }

        return new Promise((resolve) => {
            const handler = (event: MessageEvent) => {
                if (event.data.type === 'CARD_SAVED_OFFLINE') {
                    navigator.serviceWorker.removeEventListener('message', handler);
                    resolve(event.data.success);
                }
            };

            navigator.serviceWorker.addEventListener('message', handler);
            controller.postMessage({
                type: 'SAVE_CARD_OFFLINE',
                data: card
            });

            // Timeout after 5 seconds
            setTimeout(() => {
                navigator.serviceWorker.removeEventListener('message', handler);
                resolve(false);
            }, 5000);
        });
    }, []);

    const saveStudyOffline = useCallback(async (study: PendingStudy): Promise<boolean> => {
        const controller = navigator.serviceWorker.controller;
        if (!controller) {
            console.warn('Service worker not ready');
            return false;
        }

        return new Promise((resolve) => {
            const handler = (event: MessageEvent) => {
                if (event.data.type === 'STUDY_SAVED_OFFLINE') {
                    navigator.serviceWorker.removeEventListener('message', handler);
                    resolve(event.data.success);
                }
            };

            navigator.serviceWorker.addEventListener('message', handler);
            controller.postMessage({
                type: 'SAVE_STUDY_OFFLINE',
                data: study
            });

            setTimeout(() => {
                navigator.serviceWorker.removeEventListener('message', handler);
                resolve(false);
            }, 5000);
        });
    }, []);

    const triggerSync = useCallback(async () => {
        if (swRef.current && 'sync' in swRef.current) {
            try {
                // @ts-expect-error - Background Sync API
                await swRef.current.sync.register('sync-cards');
                // @ts-expect-error - Background Sync API
                await swRef.current.sync.register('sync-study');
            } catch (error) {
                console.error('Background sync registration failed:', error);
                // Fallback: manual sync via message
                navigator.serviceWorker.controller?.postMessage({ type: 'TRIGGER_SYNC' });
            }
        }
    }, []);

    const getPendingCards = useCallback((): Promise<PendingCard[]> => {
        return new Promise((resolve) => {
            const controller = navigator.serviceWorker.controller;
            if (!controller) {
                resolve([]);
                return;
            }

            const handler = (event: MessageEvent) => {
                if (event.data.type === 'PENDING_CARDS') {
                    navigator.serviceWorker.removeEventListener('message', handler);
                    resolve(event.data.data || []);
                }
            };

            navigator.serviceWorker.addEventListener('message', handler);
            controller.postMessage({ type: 'GET_PENDING_CARDS' });

            setTimeout(() => {
                navigator.serviceWorker.removeEventListener('message', handler);
                resolve([]);
            }, 5000);
        });
    }, []);

    return {
        isOnline,
        saveCardOffline,
        saveStudyOffline,
        triggerSync,
        getPendingCards
    };
}

// HOC to provide offline functionality
export function withOfflineSupport<T extends object>(
    WrappedComponent: React.ComponentType<T & { offlineSync: ReturnType<typeof useBackgroundSync> }>
) {
    return function WithOfflineSupportComponent(props: T) {
        const offlineSync = useBackgroundSync();
        return <WrappedComponent {...props} offlineSync={offlineSync} />;
    };
}
