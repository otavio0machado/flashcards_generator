// Custom Service Worker for Flashcards Generator
// This extends the PWA service worker with custom functionality

// IndexedDB helper for offline data storage
const DB_NAME = 'flashcards-offline';
const DB_VERSION = 1;

const STORES = {
    PENDING_CARDS: 'pending-cards',
    PENDING_STUDY: 'pending-study',
    CACHED_DECKS: 'cached-decks'
};

// Open IndexedDB
function openDB() {
    return new Promise((resolve, reject) => {
        const request = indexedDB.open(DB_NAME, DB_VERSION);

        request.onerror = () => reject(request.error);
        request.onsuccess = () => resolve(request.result);

        request.onupgradeneeded = (event) => {
            const db = event.target.result;

            // Store for cards created while offline
            if (!db.objectStoreNames.contains(STORES.PENDING_CARDS)) {
                db.createObjectStore(STORES.PENDING_CARDS, { keyPath: 'id', autoIncrement: true });
            }

            // Store for study sessions completed offline
            if (!db.objectStoreNames.contains(STORES.PENDING_STUDY)) {
                db.createObjectStore(STORES.PENDING_STUDY, { keyPath: 'id', autoIncrement: true });
            }

            // Store for cached decks data
            if (!db.objectStoreNames.contains(STORES.CACHED_DECKS)) {
                db.createObjectStore(STORES.CACHED_DECKS, { keyPath: 'id' });
            }
        };
    });
}

// Add data to a store
async function addToStore(storeName, data) {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(storeName, 'readwrite');
        const store = tx.objectStore(storeName);
        const request = store.add({ ...data, timestamp: Date.now() });
        request.onsuccess = () => resolve(request.result);
        request.onerror = () => reject(request.error);
    });
}

// Get all data from a store
async function getAllFromStore(storeName) {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(storeName, 'readonly');
        const store = tx.objectStore(storeName);
        const request = store.getAll();
        request.onsuccess = () => resolve(request.result);
        request.onerror = () => reject(request.error);
    });
}

// Delete item from store
async function deleteFromStore(storeName, id) {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(storeName, 'readwrite');
        const store = tx.objectStore(storeName);
        const request = store.delete(id);
        request.onsuccess = () => resolve();
        request.onerror = () => reject(request.error);
    });
}

// Clear a store
async function clearStore(storeName) {
    const db = await openDB();
    return new Promise((resolve, reject) => {
        const tx = db.transaction(storeName, 'readwrite');
        const store = tx.objectStore(storeName);
        const request = store.clear();
        request.onsuccess = () => resolve();
        request.onerror = () => reject(request.error);
    });
}

// Handle push notification
self.addEventListener('push', (event) => {
    if (!event.data) return;

    const data = event.data.json();
    const { title, body, icon, badge, data: notificationData } = data;

    const options = {
        body,
        icon: icon || '/icons/icon-192x192.png',
        badge: badge || '/icons/icon-96x96.png',
        vibrate: [100, 50, 100],
        data: notificationData,
        actions: [
            { action: 'study', title: '📚 Estudar agora' },
            { action: 'dismiss', title: 'Depois' }
        ]
    };

    event.waitUntil(
        self.registration.showNotification(title, options)
    );
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
    event.notification.close();

    const action = event.action;
    const data = event.notification.data || {};
    let url = '/';

    if (action === 'study' || data.url) {
        url = data.url || '/decks';
    }

    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
            // Try to focus an existing window
            for (const client of clientList) {
                if (client.url.includes(self.location.origin) && 'focus' in client) {
                    client.navigate(url);
                    return client.focus();
                }
            }
            // Open new window if none found
            if (clients.openWindow) {
                return clients.openWindow(url);
            }
        })
    );
});

// Background Sync - Sync pending cards when back online
self.addEventListener('sync', (event) => {
    if (event.tag === 'sync-cards') {
        event.waitUntil(syncPendingCards());
    } else if (event.tag === 'sync-study') {
        event.waitUntil(syncPendingStudy());
    }
});

async function syncPendingCards() {
    try {
        const pendingCards = await getAllFromStore(STORES.PENDING_CARDS);

        for (const card of pendingCards) {
            try {
                const response = await fetch('/api/cards', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        deck_id: card.deck_id,
                        question: card.question,
                        answer: card.answer,
                    })
                });

                if (response.ok) {
                    await deleteFromStore(STORES.PENDING_CARDS, card.id);
                    // Notify the client
                    const clients = await self.clients.matchAll();
                    clients.forEach(client => {
                        client.postMessage({
                            type: 'CARD_SYNCED',
                            cardId: card.id,
                            success: true
                        });
                    });
                }
            } catch (error) {
                console.error('Failed to sync card:', error);
            }
        }
    } catch (error) {
        console.error('Error syncing pending cards:', error);
    }
}

async function syncPendingStudy() {
    try {
        const pendingStudy = await getAllFromStore(STORES.PENDING_STUDY);

        for (const session of pendingStudy) {
            try {
                const response = await fetch('/api/study', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(session)
                });

                if (response.ok) {
                    await deleteFromStore(STORES.PENDING_STUDY, session.id);
                }
            } catch (error) {
                console.error('Failed to sync study session:', error);
            }
        }
    } catch (error) {
        console.error('Error syncing pending study:', error);
    }
}

// Listen for messages from the main thread
self.addEventListener('message', (event) => {
    const { type, data } = event.data;

    switch (type) {
        case 'SAVE_CARD_OFFLINE':
            addToStore(STORES.PENDING_CARDS, data).then(() => {
                event.source.postMessage({ type: 'CARD_SAVED_OFFLINE', success: true });
            });
            break;

        case 'SAVE_STUDY_OFFLINE':
            addToStore(STORES.PENDING_STUDY, data).then(() => {
                event.source.postMessage({ type: 'STUDY_SAVED_OFFLINE', success: true });
            });
            break;

        case 'GET_PENDING_CARDS':
            getAllFromStore(STORES.PENDING_CARDS).then((cards) => {
                event.source.postMessage({ type: 'PENDING_CARDS', data: cards });
            });
            break;

        case 'TRIGGER_SYNC':
            if ('sync' in self.registration) {
                self.registration.sync.register('sync-cards');
                self.registration.sync.register('sync-study');
            }
            break;

        case 'SKIP_WAITING':
            self.skipWaiting();
            break;
    }
});

// Cleanup old caches on activation
self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames
                    .filter((name) => name.startsWith('flashcards-') && !name.includes('v1'))
                    .map((name) => caches.delete(name))
            );
        })
    );
});

// Export functions for use in main thread (via postMessage)
console.log('Flashcards Service Worker loaded');
