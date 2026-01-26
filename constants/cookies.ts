/**
 * Constantes de Cookies
 *
 * Centraliza nomes e configurações de cookies para evitar typos
 * e facilitar manutenção.
 */

// ==================== NOMES DE COOKIES ====================
export const COOKIE_NAMES = {
    DEMO_FINGERPRINT: 'demo_fp',
    DEMO_LAST_TIMESTAMP: 'demo_last_ts',
    DEMO_FP_LAST_DATE: 'demo_fp_last_date',
} as const;

// ==================== TTL DE COOKIES (em segundos) ====================
export const COOKIE_TTL = {
    FINGERPRINT: 60 * 60 * 24 * 365, // 1 ano
    LAST_ATTEMPT: 60 * 60 * 24,      // 24 horas
} as const;
