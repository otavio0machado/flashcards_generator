import { NextResponse } from 'next/server';
import type { HealthCheckResponse, ServiceStatus } from '@/types/api';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

const TIMEOUT_MS = 5000;

async function checkWithTimeout<T>(
    promise: Promise<T>,
    timeoutMs: number = TIMEOUT_MS
): Promise<T> {
    const timeout = new Promise<never>((_, reject) =>
        setTimeout(() => reject(new Error('Timeout')), timeoutMs)
    );
    return Promise.race([promise, timeout]);
}

async function checkSupabase(): Promise<ServiceStatus> {
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!url || !key) {
        return { status: 'down', error: 'Configuração ausente' };
    }

    const start = Date.now();

    try {
        const response = await checkWithTimeout(
            fetch(`${url}/rest/v1/`, {
                method: 'HEAD',
                headers: {
                    'apikey': key,
                    'Authorization': `Bearer ${key}`,
                },
            })
        );

        const latency = Date.now() - start;
        return {
            status: response.ok ? 'up' : 'down',
            latency,
            ...(response.ok ? {} : { error: `HTTP ${response.status}` }),
        };
    } catch (error) {
        return {
            status: 'down',
            latency: Date.now() - start,
            error: error instanceof Error ? error.message : 'Erro desconhecido',
        };
    }
}

async function checkRedis(): Promise<ServiceStatus | undefined> {
    const url = process.env.UPSTASH_REDIS_REST_URL;
    const token = process.env.UPSTASH_REDIS_REST_TOKEN;

    if (!url || !token) {
        return undefined; // Redis é opcional
    }

    const start = Date.now();

    try {
        const response = await checkWithTimeout(
            fetch(`${url}/ping`, {
                headers: {
                    'Authorization': `Bearer ${token}`,
                },
            })
        );

        const latency = Date.now() - start;
        return {
            status: response.ok ? 'up' : 'down',
            latency,
            ...(response.ok ? {} : { error: `HTTP ${response.status}` }),
        };
    } catch (error) {
        return {
            status: 'down',
            latency: Date.now() - start,
            error: error instanceof Error ? error.message : 'Erro desconhecido',
        };
    }
}

async function checkOpenAI(): Promise<ServiceStatus | undefined> {
    const apiKey = process.env.OPENAI_API_KEY;

    if (!apiKey) {
        return undefined; // Retorna undefined se não configurado
    }

    const start = Date.now();

    try {
        // Usa endpoint de modelos que é mais leve que gerar conteúdo
        const response = await checkWithTimeout(
            fetch('https://api.openai.com/v1/models', {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${apiKey}`,
                },
            })
        );

        const latency = Date.now() - start;
        return {
            status: response.ok ? 'up' : 'down',
            latency,
            ...(response.ok ? {} : { error: `HTTP ${response.status}` }),
        };
    } catch (error) {
        return {
            status: 'down',
            latency: Date.now() - start,
            error: error instanceof Error ? error.message : 'Erro desconhecido',
        };
    }
}

export async function GET(): Promise<NextResponse<HealthCheckResponse>> {
    const timestamp = new Date().toISOString();

    // Executa todas as verificações em paralelo
    const [database, redis, openai] = await Promise.all([
        checkSupabase(),
        checkRedis(),
        checkOpenAI(),
    ]);

    const services: HealthCheckResponse['services'] = {
        database,
        ...(redis && { redis }),
        ...(openai && { openai }),
    };

    // Determina o status geral
    const allServicesUp = database.status === 'up' &&
        (!redis || redis.status === 'up') &&
        (!openai || openai.status === 'up');

    const criticalDown = database.status === 'down';

    const status: HealthCheckResponse['status'] = criticalDown
        ? 'unhealthy'
        : allServicesUp
            ? 'healthy'
            : 'degraded';

    const response: HealthCheckResponse = {
        status,
        timestamp,
        services,
        version: process.env.npm_package_version || '1.0.0',
    };

    const httpStatus = status === 'unhealthy' ? 503 : status === 'degraded' ? 200 : 200;

    return NextResponse.json(response, { status: httpStatus });
}
