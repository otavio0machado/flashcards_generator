/**
 * Constantes de Limites
 *
 * Centraliza todos os limites usados no sistema para evitar duplicação
 * e facilitar manutenção.
 */

// ==================== DEMO ====================
export const DEMO_LIMITS = {
    MAX_CHARS: 2000,
    MIN_CHARS: 200,
    MAX_CARDS: 5,
    COOLDOWN_SECONDS: 45,
    MAX_COOLDOWN_VIOLATIONS: 3,
} as const;

// ==================== UPLOAD ====================
export const UPLOAD_LIMITS = {
    MAX_FILES: 4,
    MAX_BYTES: 20 * 1024 * 1024, // 20MB
    MAX_BYTES_DISPLAY: '20MB',
} as const;

// ==================== IMAGE ====================
export const IMAGE_LIMITS = {
    MAX_TOPIC_CHARS: 300,
    MAX_CONCURRENT_REQUESTS: 3,
    REQUEST_TIMEOUT_MS: 30000,
    BATCH_DELAY_MS: 100,
} as const;

// ==================== RATE LIMITING ====================
export const RATE_LIMITS = {
    API_REQUESTS_PER_MINUTE: 10,
    DEMO_REQUESTS_PER_DAY: 1,
} as const;

// ==================== HEALTH CHECK ====================
export const HEALTH_CHECK = {
    TIMEOUT_MS: 5000,
} as const;
