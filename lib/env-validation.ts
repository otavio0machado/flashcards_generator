/**
 * Validação de Variáveis de Ambiente
 * Este módulo valida todas as variáveis de ambiente necessárias no startup
 */

type EnvVar = {
    name: string;
    required: boolean;
    isPublic?: boolean;
};

const ENV_VARS: EnvVar[] = [
    // Supabase (obrigatório)
    { name: 'NEXT_PUBLIC_SUPABASE_URL', required: true, isPublic: true },
    { name: 'NEXT_PUBLIC_SUPABASE_ANON_KEY', required: true, isPublic: true },
    { name: 'SUPABASE_SERVICE_ROLE_KEY', required: true },

    // OpenAI (obrigatório)
    { name: 'OPENAI_API_KEY', required: true },

    // Stripe (obrigatório para pagamentos)
    { name: 'STRIPE_SECRET_KEY', required: true },
    { name: 'STRIPE_WEBHOOK_SECRET', required: true },
    { name: 'NEXT_PUBLIC_STRIPE_PRICE_ID_PRO', required: true, isPublic: true },
    { name: 'NEXT_PUBLIC_STRIPE_PRICE_ID_ULTIMATE', required: true, isPublic: true },

    // Redis (opcional - rate limiting)
    { name: 'UPSTASH_REDIS_REST_URL', required: false },
    { name: 'UPSTASH_REDIS_REST_TOKEN', required: false },

    // Cloudflare Turnstile (opcional - captcha)
    { name: 'TURNSTILE_SECRET_KEY', required: false },
    { name: 'NEXT_PUBLIC_TURNSTILE_SITE_KEY', required: false, isPublic: true },

    // Analytics (opcional)
    { name: 'NEXT_PUBLIC_POSTHOG_KEY', required: false, isPublic: true },
    { name: 'NEXT_PUBLIC_POSTHOG_HOST', required: false, isPublic: true },

    // Security
    { name: 'DEMO_IP_SALT', required: false },

    // Site config
    { name: 'NEXT_PUBLIC_SITE_URL', required: false, isPublic: true },
];

export interface EnvValidationResult {
    valid: boolean;
    missing: string[];
    warnings: string[];
}

/**
 * Valida variáveis de ambiente obrigatórias
 * @throws Error se variáveis obrigatórias estiverem faltando em produção
 */
export function validateEnv(): EnvValidationResult {
    const missing: string[] = [];
    const warnings: string[] = [];
    const isProduction = process.env.NODE_ENV === 'production';

    for (const envVar of ENV_VARS) {
        const value = process.env[envVar.name];

        if (!value || value.trim() === '') {
            if (envVar.required) {
                missing.push(envVar.name);
            } else {
                warnings.push(`Variável opcional não configurada: ${envVar.name}`);
            }
        }
    }

    const result: EnvValidationResult = {
        valid: missing.length === 0,
        missing,
        warnings,
    };

    if (!result.valid && isProduction) {
        console.error('=== ERRO DE CONFIGURAÇÃO ===');
        console.error('Variáveis de ambiente obrigatórias não configuradas:');
        missing.forEach(name => console.error(`  - ${name}`));
        throw new Error(`Variáveis de ambiente faltando: ${missing.join(', ')}`);
    }

    if (!result.valid) {
        console.warn('=== AVISO DE CONFIGURAÇÃO (DEV) ===');
        console.warn('Variáveis de ambiente obrigatórias não configuradas:');
        missing.forEach(name => console.warn(`  - ${name}`));
    }

    return result;
}

/**
 * Obtém uma variável de ambiente obrigatória
 * @throws Error se a variável não estiver configurada
 */
export function getRequiredEnv(name: string): string {
    const value = process.env[name];
    if (!value || value.trim() === '') {
        throw new Error(`Variável de ambiente obrigatória não configurada: ${name}`);
    }
    return value;
}

/**
 * Obtém uma variável de ambiente opcional com fallback
 */
export function getOptionalEnv(name: string, fallback: string = ''): string {
    return process.env[name] || fallback;
}

/**
 * Verifica se uma variável de ambiente está configurada
 */
export function hasEnv(name: string): boolean {
    const value = process.env[name];
    return Boolean(value && value.trim() !== '');
}

// Validação específica para Supabase
export function getSupabaseEnv() {
    return {
        url: getRequiredEnv('NEXT_PUBLIC_SUPABASE_URL'),
        anonKey: getRequiredEnv('NEXT_PUBLIC_SUPABASE_ANON_KEY'),
        serviceRoleKey: getRequiredEnv('SUPABASE_SERVICE_ROLE_KEY'),
    };
}

// Validação específica para Stripe
export function getStripeEnv() {
    return {
        secretKey: getRequiredEnv('STRIPE_SECRET_KEY'),
        webhookSecret: getRequiredEnv('STRIPE_WEBHOOK_SECRET'),
        priceIdPro: getRequiredEnv('NEXT_PUBLIC_STRIPE_PRICE_ID_PRO'),
        priceIdUltimate: getRequiredEnv('NEXT_PUBLIC_STRIPE_PRICE_ID_ULTIMATE'),
    };
}

// Validação específica para OpenAI
export function getOpenAIEnv() {
    return {
        apiKey: getRequiredEnv('OPENAI_API_KEY'),
    };
}

// Validação específica para Redis (opcional)
export function getRedisEnv() {
    const url = process.env.UPSTASH_REDIS_REST_URL;
    const token = process.env.UPSTASH_REDIS_REST_TOKEN;

    if (!url || !token) {
        return null;
    }

    return { url, token };
}

// Validação específica para Turnstile/Captcha (opcional)
export function getTurnstileEnv() {
    const secretKey = process.env.TURNSTILE_SECRET_KEY;
    const siteKey = process.env.NEXT_PUBLIC_TURNSTILE_SITE_KEY;

    if (!secretKey || !siteKey) {
        return null;
    }

    return { secretKey, siteKey };
}
