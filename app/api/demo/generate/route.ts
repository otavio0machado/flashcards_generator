import { NextResponse } from 'next/server';
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';
import { createHash, randomUUID } from 'crypto';
import { supabaseAdmin } from '@/lib/supabase-admin';
import { sanitizeInput } from '@/lib/utils';
import { aiService, GeneratedCard } from '@/services/aiService';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

const MAX_DEMO_CHARS = 2000;
const MIN_DEMO_CHARS = 200;
const MAX_DEMO_CARDS = 5;
const COOLDOWN_SECONDS = 45;
const MAX_COOLDOWN_VIOLATIONS = 3;
const DEMO_FINGERPRINT_COOKIE = 'demo_fp';
const DEMO_LAST_TS_COOKIE = 'demo_last_ts';
const DEMO_FP_LAST_DATE_COOKIE = 'demo_fp_last_date';

const demoRatelimit = process.env.UPSTASH_REDIS_REST_URL
    ? new Ratelimit({
        redis: Redis.fromEnv(),
        limiter: Ratelimit.fixedWindow(1, '24 h'),
        analytics: true,
    })
    : null;

const redis = process.env.UPSTASH_REDIS_REST_URL ? Redis.fromEnv() : null;
const isProd = process.env.NODE_ENV === 'production';

function getClientIp(req: Request): string {
    const headers = req.headers;

    // Vercel / Cloudflare specific headers (Prioritized)
    const vercelIp = headers.get('x-vercel-forwarded-for');
    if (vercelIp) return vercelIp.split(',')[0].trim();

    const forwarded = headers.get('x-forwarded-for');
    if (forwarded) {
        return forwarded.split(',')[0]?.trim() || forwarded.trim();
    }

    return (
        headers.get('cf-connecting-ip') ||
        headers.get('x-real-ip') ||
        headers.get('true-client-ip') ||
        headers.get('x-client-ip') ||
        headers.get('fastly-client-ip') ||
        '0.0.0.0'
    );
}

function getUserAgent(req: Request): string {
    return req.headers.get('user-agent') || '';
}

function isSuspiciousUserAgent(userAgent: string) {
    return /(bot|crawler|spider|headless|curl|wget|python|scrapy|httpclient|axios|puppeteer|playwright)/i.test(userAgent);
}

function hashIp(ip: string): string {
    const salt = process.env.DEMO_IP_SALT || 'demo-salt';
    return createHash('sha256').update(`${salt}:${ip}`).digest('hex');
}

function getFingerprint(req: Request): string {
    const headerFp = req.headers.get('x-demo-fingerprint');
    const cookieFp = req.headers.get('cookie')
        ?.split(';')
        .map((part) => part.trim())
        .find((part) => part.startsWith(`${DEMO_FINGERPRINT_COOKIE}=`))
        ?.split('=')[1];

    return headerFp || cookieFp || randomUUID();
}

function getCookieValue(req: Request, name: string) {
    return req.headers
        .get('cookie')
        ?.split(';')
        .map((part) => part.trim())
        .find((part) => part.startsWith(`${name}=`))
        ?.split('=')[1];
}

async function verifyCaptcha(token: string | undefined, ip: string): Promise<{ success: boolean; error?: string }> {
    const secret = process.env.TURNSTILE_SECRET_KEY;
    const isProduction = process.env.NODE_ENV === 'production';

    if (!secret) {
        if (isProduction) {
            console.error('[Captcha] TURNSTILE_SECRET_KEY não configurado em produção - bloqueando requisição');
            return { success: false, error: 'captcha_not_configured' };
        }
        console.warn('[Captcha] TURNSTILE_SECRET_KEY não configurado - ignorando verificação em desenvolvimento');
        return { success: true };
    }

    if (!token) {
        return { success: false, error: 'captcha_token_missing' };
    }

    try {
        const response = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                secret,
                response: token,
                remoteip: ip,
            }),
        });

        if (!response.ok) {
            console.error(`[Captcha] Erro na verificação: HTTP ${response.status}`);
            return { success: false, error: 'captcha_verification_failed' };
        }

        const data = await response.json();
        if (!data?.success) {
            console.warn('[Captcha] Verificação falhou:', data?.['error-codes'] || 'motivo desconhecido');
            return { success: false, error: 'captcha_invalid' };
        }

        return { success: true };
    } catch (error) {
        console.error('[Captcha] Erro ao verificar captcha:', error);
        return { success: false, error: 'captcha_verification_error' };
    }
}

function withDemoCookies(req: Request, response: NextResponse, fingerprint: string, setLastAttempt: boolean) {
    response.cookies.set(DEMO_FINGERPRINT_COOKIE, fingerprint, {
        httpOnly: true,
        sameSite: 'lax',
        secure: isProd,
        maxAge: 60 * 60 * 24 * 365,
        path: '/',
    });

    if (setLastAttempt) {
        response.cookies.set(DEMO_LAST_TS_COOKIE, Date.now().toString(), {
            httpOnly: true,
            sameSite: 'lax',
            secure: isProd,
            maxAge: 60 * 60 * 24,
            path: '/',
        });
    }

    return response;
}

async function enforceDemoRateLimit(ipHash: string, fingerprint: string, req: Request, ip: string, captchaToken?: string) {
    const today = new Date().toISOString().split('T')[0];
    const rateKey = `demo:${ipHash}:${today}`;
    const fpRateKey = `demo:fp:${fingerprint}:${today}`;

    const userAgent = getUserAgent(req);
    const suspicious = isSuspiciousUserAgent(userAgent);
    if (suspicious) {
        if (!process.env.TURNSTILE_SECRET_KEY) {
            return NextResponse.json(
                { error: 'Acesso bloqueado por segurança. Tente em um navegador comum.', code: 'demo_ua_blocked' },
                { status: 403 }
            );
        }
        const captchaResult = await verifyCaptcha(captchaToken, ip);
        if (!captchaResult.success) {
            return NextResponse.json(
                { error: 'Verificação necessária para continuar no demo.', code: captchaResult.error || 'captcha_required' },
                { status: 403 }
            );
        }
    }

    if (redis) {
        const cooldownKey = `demo:cooldown:${fingerprint}`;
        const cooldownSet = await redis.set(cooldownKey, '1', { nx: true, ex: COOLDOWN_SECONDS });
        if (!cooldownSet) {
            const violationsKey = `demo:cooldown:violations:${fingerprint}`;
            const violations = await redis.incr(violationsKey);
            await redis.expire(violationsKey, 60 * 60);
            if (violations >= MAX_COOLDOWN_VIOLATIONS && !captchaToken) {
                return NextResponse.json(
                    { error: 'Verificação necessária para continuar no demo.', code: 'captcha_required' },
                    { status: 403 }
                );
            }
            return NextResponse.json(
                { error: `Aguarde ${COOLDOWN_SECONDS}s antes de tentar novamente.`, code: 'demo_cooldown' },
                { status: 429 }
            );
        }
    } else {
        const lastTs = getCookieValue(req, DEMO_LAST_TS_COOKIE);
        if (lastTs) {
            const diff = Date.now() - Number(lastTs);
            if (diff < COOLDOWN_SECONDS * 1000) {
                return NextResponse.json(
                    { error: `Aguarde ${COOLDOWN_SECONDS}s antes de tentar novamente.`, code: 'demo_cooldown' },
                    { status: 429 }
                );
            }
        }
    }

    if (demoRatelimit) {
        const { success, limit, remaining, reset } = await demoRatelimit.limit(rateKey);
        if (!success) {
            return NextResponse.json(
                { error: 'Você atingiu o limite do demo. Volte amanhã ou crie conta grátis para liberar mais gerações.', code: 'demo_rate_limited' },
                {
                    status: 429,
                    headers: {
                        'X-RateLimit-Limit': limit.toString(),
                        'X-RateLimit-Remaining': remaining.toString(),
                        'X-RateLimit-Reset': reset.toString(),
                    },
                }
            );
        }

        const fpResult = await demoRatelimit.limit(fpRateKey);
        if (!fpResult.success) {
            return NextResponse.json(
                { error: 'Você atingiu o limite do demo. Volte amanhã ou crie conta grátis para liberar mais gerações.', code: 'demo_rate_limited' },
                { status: 429 }
            );
        }

        return null;
    }

    const fpDateCookie = getCookieValue(req, DEMO_FP_LAST_DATE_COOKIE);
    if (fpDateCookie === today) {
        return NextResponse.json(
            { error: 'Você atingiu o limite do demo. Volte amanhã ou crie conta grátis para liberar mais gerações.', code: 'demo_rate_limited' },
            { status: 429 }
        );
    }

    const { count, error } = await supabaseAdmin
        .from('demo_usage')
        .select('id', { count: 'exact', head: true })
        .eq('ip_hash', ipHash)
        .eq('usage_date', today);

    if (error) {
        console.error('Erro ao verificar limite do demo:', error);
        return NextResponse.json({ error: 'Erro ao verificar limite do demo.' }, { status: 500 });
    }

    if (count && count > 0) {
        return NextResponse.json(
            { error: 'Você atingiu o limite do demo. Volte amanhã ou crie conta grátis para liberar mais gerações.', code: 'demo_rate_limited' },
            { status: 429 }
        );
    }

    const { error: insertError } = await supabaseAdmin
        .from('demo_usage')
        .insert({ ip_hash: ipHash, usage_date: today });

    if (insertError) {
        console.error('Erro ao registrar uso do demo:', insertError);
        return NextResponse.json({ error: 'Erro ao registrar uso do demo.' }, { status: 500 });
    }

    return null;
}

export async function POST(req: Request) {
    try {
        const body = await req.json().catch(() => ({}));
        const rawText = typeof body?.text === 'string' ? body.text : '';
        const language = typeof body?.language === 'string' ? body.language : 'Português';
        const difficulty = typeof body?.difficulty === 'string' ? body.difficulty : 'Intermediário';
        const studyLevel = typeof body?.studyLevel === 'string' ? body.studyLevel : 'ENEM';
        const studyGoal = typeof body?.studyGoal === 'string' ? body.studyGoal : 'Memorizar';
        const templateType = typeof body?.templateType === 'string' ? body.templateType : '';
        const cardStyle = typeof body?.cardStyle === 'string' ? body.cardStyle : 'basic';
        const captchaToken = typeof body?.captchaToken === 'string' ? body.captchaToken : undefined;

        const sanitizedText = sanitizeInput(rawText || '');
        const ip = getClientIp(req);
        const ipHash = hashIp(ip);
        const fingerprint = getFingerprint(req);

        if (!sanitizedText.trim()) {
            const response = NextResponse.json({ error: 'Cole um conteúdo maior para gerar os cards.', code: 'demo_text_too_short' }, { status: 400 });
            return withDemoCookies(req, response, fingerprint, true);
        }

        if (sanitizedText.length < MIN_DEMO_CHARS) {
            const response = NextResponse.json({
                error: `Cole um conteúdo maior (mín. ${MIN_DEMO_CHARS} caracteres).`,
                code: 'demo_text_too_short',
            }, { status: 400 });
            return withDemoCookies(req, response, fingerprint, true);
        }

        if (sanitizedText.length > MAX_DEMO_CHARS) {
            const response = NextResponse.json({
                error: `No demo é ${MAX_DEMO_CHARS} caracteres. Com conta, você aumenta esse limite.`,
                code: 'demo_text_too_long',
            }, { status: 400 });
            return withDemoCookies(req, response, fingerprint, true);
        }

        const rateLimitResponse = await enforceDemoRateLimit(ipHash, fingerprint, req, ip, captchaToken);
        if (rateLimitResponse) return withDemoCookies(req, rateLimitResponse, fingerprint, false);

        // Delegate to aiService.generateFlashcards which handles prompt construction
        // (via promptService), OpenAI API calls (with retry), and response parsing.
        let cards: GeneratedCard[];
        try {
            cards = await aiService.generateFlashcards({
                userText: sanitizedText,
                attachments: [],
                config: {
                    cardCount: MAX_DEMO_CARDS,
                    language,
                    difficulty,
                    studyLevel,
                    studyGoal,
                    templateType,
                    cardStyle: cardStyle as 'basic' | 'short_answer' | 'image_occlusion',
                    // Demo-specific: disable premium features
                    aiOptimized: false,
                    enemMode: false,
                    autoTags: false,
                },
            });
        } catch (error) {
            const message = error instanceof Error ? error.message : '';
            console.error('Erro ao gerar flashcards (demo):', error);

            if (message.includes('OPENAI_API_KEY')) {
                const response = NextResponse.json({ error: 'OPENAI_API_KEY não configurada.', code: 'demo_generate_error' }, { status: 500 });
                return withDemoCookies(req, response, fingerprint, true);
            }
            if (message.includes('Failed to connect')) {
                const response = NextResponse.json({ error: 'Limite de requisições atingido. Tente novamente.', code: 'demo_generate_error' }, { status: 429 });
                return withDemoCookies(req, response, fingerprint, true);
            }
            if (message.includes('error:') || message.includes('AI Service returned')) {
                const response = NextResponse.json({ error: 'Erro ao processar com a IA. Tente novamente.', code: 'demo_generate_error' }, { status: 502 });
                return withDemoCookies(req, response, fingerprint, true);
            }
            if (message.includes('Failed to process')) {
                const response = NextResponse.json({ error: 'A IA gerou um formato inválido. Tente novamente.', code: 'demo_generate_error' }, { status: 500 });
                return withDemoCookies(req, response, fingerprint, true);
            }

            const response = NextResponse.json({ error: 'Erro ao processar com a IA. Tente novamente.', code: 'demo_generate_error' }, { status: 502 });
            return withDemoCookies(req, response, fingerprint, true);
        }

        // Demo-specific: enforce card limit and strip to question/answer only
        const trimmedCards = cards.slice(0, MAX_DEMO_CARDS).map((card) => ({
            question: card.question,
            answer: card.answer,
        }));

        const response = NextResponse.json({ cards: trimmedCards });
        response.cookies.set(DEMO_FP_LAST_DATE_COOKIE, new Date().toISOString().split('T')[0], {
            httpOnly: true,
            sameSite: 'lax',
            secure: isProd,
            maxAge: 60 * 60 * 24,
            path: '/',
        });

        return withDemoCookies(req, response, fingerprint, true);
    } catch (error) {
        console.error('Erro no demo generate:', error);
        return NextResponse.json({ error: 'Erro interno ao gerar flashcards.' }, { status: 500 });
    }
}
