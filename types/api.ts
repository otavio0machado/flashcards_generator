/**
 * Tipos unificados para respostas de API
 *
 * Este arquivo centraliza as definições de tipos para respostas de API,
 * garantindo consistência entre todos os endpoints.
 */

import type { GeneratedCard } from './card';

/**
 * Resposta de erro padrão
 */
export interface ApiError {
    error: string;
    code?: string;
    details?: unknown;
}

/**
 * Resposta de sucesso genérica
 */
export interface ApiResponse<T> {
    data?: T;
    error?: string;
    code?: string;
    details?: unknown;
}

/**
 * Estatísticas de geração de imagem
 */
export interface ImageGenerationStats {
    requested: number;
    successful: number;
    failed: number;
}

/**
 * Resposta do endpoint /api/generate
 */
export interface GenerateResponse {
    cards: GeneratedCard[];
    usage?: number;
    limit?: number;
    imageGeneration?: ImageGenerationStats;
    notification?: string | null;
}

/**
 * Resposta do endpoint /api/demo/generate
 */
export interface DemoGenerateResponse {
    cards: GeneratedCard[];
}

/**
 * Resposta do endpoint /api/health
 */
export interface HealthCheckResponse {
    status: 'healthy' | 'degraded' | 'unhealthy';
    timestamp: string;
    services: {
        database: ServiceStatus;
        redis?: ServiceStatus;
        openai?: ServiceStatus;
    };
    version?: string;
}

export interface ServiceStatus {
    status: 'up' | 'down' | 'unknown';
    latency?: number;
    error?: string;
}

/**
 * Parâmetros de entrada para geração de cards
 */
export interface GenerateParams {
    content: string;
    language?: string;
    difficulty?: 'easy' | 'medium' | 'hard';
    cardCount?: number;
    autoTags?: boolean;
    generateImages?: boolean;
    templateType?: string;
    goal?: string;
}

/**
 * Cria uma resposta de erro padronizada
 */
export function createErrorResponse(error: string, code?: string, details?: unknown): ApiError {
    const response: ApiError = { error };

    if (code) {
        response.code = code;
    }

    if (details) {
        response.details = details;
    }

    return response;
}

/**
 * Cria uma resposta de sucesso padronizada
 */
export function createSuccessResponse<T>(data: T): ApiResponse<T> {
    return { data };
}

/**
 * Códigos de erro comuns
 */
export const ErrorCodes = {
    // Autenticação
    AUTH_REQUIRED: 'auth_required',
    AUTH_INVALID: 'auth_invalid',

    // Validação
    VALIDATION_ERROR: 'validation_error',
    INVALID_INPUT: 'invalid_input',

    // Rate limiting
    RATE_LIMIT_EXCEEDED: 'rate_limit_exceeded',
    COOLDOWN_ACTIVE: 'cooldown_active',

    // Limites do plano
    PLAN_LIMIT_EXCEEDED: 'plan_limit_exceeded',
    UPGRADE_REQUIRED: 'upgrade_required',

    // Captcha
    CAPTCHA_REQUIRED: 'captcha_required',
    CAPTCHA_INVALID: 'captcha_invalid',

    // Servidor
    INTERNAL_ERROR: 'internal_error',
    SERVICE_UNAVAILABLE: 'service_unavailable',
    CONFIG_ERROR: 'config_error',

    // Demo específico
    DEMO_LIMIT_EXCEEDED: 'demo_limit_exceeded',
    DEMO_COOLDOWN: 'demo_cooldown',
} as const;

export type ErrorCode = typeof ErrorCodes[keyof typeof ErrorCodes];
