/**
 * Offline data cache using native IndexedDB.
 *
 * Database: fg_offline_cache
 * Object stores:
 *   - decks   (keyPath: "id")  — cached user decks list
 *   - cards   (keyPath: "id")  — cached cards keyed by deck id
 *
 * Every public function silently catches errors so that callers in
 * components never blow up when IndexedDB is unavailable (e.g. some
 * private-browsing modes, very old browsers, or storage quota exceeded).
 */

const DB_NAME = 'fg_offline_cache';
const DB_VERSION = 1;

const STORE_DECKS = 'decks';
const STORE_CARDS = 'cards';

// ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------

function isIndexedDBAvailable(): boolean {
  try {
    return typeof indexedDB !== 'undefined' && indexedDB !== null;
  } catch {
    return false;
  }
}

function openDB(): Promise<IDBDatabase> {
  return new Promise((resolve, reject) => {
    if (!isIndexedDBAvailable()) {
      reject(new Error('IndexedDB is not available'));
      return;
    }

    const request = indexedDB.open(DB_NAME, DB_VERSION);

    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);

    request.onupgradeneeded = (event) => {
      const db = (event.target as IDBOpenDBRequest).result;

      if (!db.objectStoreNames.contains(STORE_DECKS)) {
        db.createObjectStore(STORE_DECKS, { keyPath: 'id' });
      }

      if (!db.objectStoreNames.contains(STORE_CARDS)) {
        db.createObjectStore(STORE_CARDS, { keyPath: 'id' });
      }
    };
  });
}

// ---------------------------------------------------------------------------
// Decks
// ---------------------------------------------------------------------------

/**
 * Persist the full list of user decks into the cache.
 * Replaces the entire store content so stale entries are removed.
 */
export async function saveDecksToCache(decks: object[]): Promise<void> {
  try {
    const db = await openDB();
    const tx = db.transaction(STORE_DECKS, 'readwrite');
    const store = tx.objectStore(STORE_DECKS);

    // Clear previous entries then write current ones
    store.clear();
    for (const deck of decks) {
      store.put(deck);
    }

    return new Promise((resolve, reject) => {
      tx.oncomplete = () => resolve();
      tx.onerror = () => reject(tx.error);
    });
  } catch (err) {
    console.warn('[offline-cache] Failed to save decks:', err);
  }
}

/**
 * Retrieve all cached decks (or an empty array when nothing is cached).
 */
export async function getDecksFromCache(): Promise<object[]> {
  try {
    const db = await openDB();
    const tx = db.transaction(STORE_DECKS, 'readonly');
    const store = tx.objectStore(STORE_DECKS);
    const request = store.getAll();

    return new Promise((resolve, reject) => {
      request.onsuccess = () => resolve(request.result ?? []);
      request.onerror = () => reject(request.error);
    });
  } catch (err) {
    console.warn('[offline-cache] Failed to read decks:', err);
    return [];
  }
}

// ---------------------------------------------------------------------------
// Cards (per deck)
// ---------------------------------------------------------------------------

/**
 * Persist cards for a specific deck.
 * Cards are stored as a single document keyed by deck id so that
 * multiple decks' cards can coexist without collision.
 */
export async function saveDeckCardsToCache(
  deckId: string,
  cards: object[]
): Promise<void> {
  try {
    const db = await openDB();
    const tx = db.transaction(STORE_CARDS, 'readwrite');
    const store = tx.objectStore(STORE_CARDS);

    // Store the whole cards array as a single entry keyed by deckId
    store.put({ id: deckId, cards, updatedAt: Date.now() });

    return new Promise((resolve, reject) => {
      tx.oncomplete = () => resolve();
      tx.onerror = () => reject(tx.error);
    });
  } catch (err) {
    console.warn('[offline-cache] Failed to save cards for deck', deckId, err);
  }
}

/**
 * Retrieve cached cards for a specific deck (or empty array).
 */
export async function getDeckCardsFromCache(
  deckId: string
): Promise<object[]> {
  try {
    const db = await openDB();
    const tx = db.transaction(STORE_CARDS, 'readonly');
    const store = tx.objectStore(STORE_CARDS);
    const request = store.get(deckId);

    return new Promise((resolve, reject) => {
      request.onsuccess = () => {
        const result = request.result;
        resolve(result?.cards ?? []);
      };
      request.onerror = () => reject(request.error);
    });
  } catch (err) {
    console.warn('[offline-cache] Failed to read cards for deck', deckId, err);
    return [];
  }
}

// ---------------------------------------------------------------------------
// Maintenance
// ---------------------------------------------------------------------------

/**
 * Clear all cached offline data (both decks and cards stores).
 */
export async function clearCache(): Promise<void> {
  try {
    const db = await openDB();
    const tx = db.transaction([STORE_DECKS, STORE_CARDS], 'readwrite');

    tx.objectStore(STORE_DECKS).clear();
    tx.objectStore(STORE_CARDS).clear();

    return new Promise((resolve, reject) => {
      tx.oncomplete = () => resolve();
      tx.onerror = () => reject(tx.error);
    });
  } catch (err) {
    console.warn('[offline-cache] Failed to clear cache:', err);
  }
}
