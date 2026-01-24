import { NextResponse } from 'next/server';
import { createServerClient, type CookieOptions } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

export const dynamic = 'force-dynamic';

// Rate limiter: 10 requests per minute per user
const ratelimit = process.env.UPSTASH_REDIS_REST_URL ? new Ratelimit({
    redis: Redis.fromEnv(),
    limiter: Ratelimit.slidingWindow(10, '1 m'),
    analytics: true,
}) : null;

// Sanitize user input to prevent AI prompt injection
function sanitizeInput(text: string): string {
    // Remove potential prompt injection patterns
    const dangerousPatterns = [
        /ignore\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /disregard\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /forget\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /new\s+instructions?:/gi,
        /system\s*prompt/gi,
        /you\s+are\s+now/gi,
        /act\s+as\s+if/gi,
        /pretend\s+(you\s+are|to\s+be)/gi,
    ];

    let sanitized = text;
    for (const pattern of dangerousPatterns) {
        sanitized = sanitized.replace(pattern, '[REMOVED]');
    }

    // Limit consecutive special characters
    sanitized = sanitized.replace(/[{}[\]<>]{3,}/g, '');

    return sanitized.trim();
}

export async function POST(req: Request) {
    try {
        const cookieStore = await cookies();
        const supabase = createServerClient(
            process.env.NEXT_PUBLIC_SUPABASE_URL!,
            process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
            {
                cookies: {
                    get(name: string) {
                        return cookieStore.get(name)?.value;
                    },
                    set(name: string, value: string, options: CookieOptions) {
                        cookieStore.set({ name, value, ...options });
                    },
                    remove(name: string, options: CookieOptions) {
                        cookieStore.set({ name, value: '', ...options });
                    },
                },
            }
        );

        // 1. Verificar Autenticação (usando getUser para validar JWT server-side)
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        if (authError || !user) {
            return NextResponse.json({ error: 'Não autorizado. Por favor, faça login.' }, { status: 401 });
        }

        // 2. Rate Limiting por usuário
        if (ratelimit) {
            const { success, limit, reset, remaining } = await ratelimit.limit(user.id);
            if (!success) {
                return NextResponse.json(
                    { error: 'Muitas requisições. Por favor, aguarde um momento.' },
                    {
                        status: 429,
                        headers: {
                            'X-RateLimit-Limit': limit.toString(),
                            'X-RateLimit-Remaining': remaining.toString(),
                            'X-RateLimit-Reset': reset.toString(),
                        }
                    }
                );
            }
        }

        // 3. Buscar Perfil e Plano do Usuário
        const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('*')
            .eq('id', user.id)
            .single();

        if (profileError || !profile) {
            return NextResponse.json({ error: 'Erro ao buscar perfil do usuário' }, { status: 500 });
        }

        const planKey = (profile.plan_tier || 'free') as PlanKey;
        const limits = PLAN_LIMITS[planKey];

        // Se o usuário for ultimate, ele pode ter enviado um cardCount específico
        const { text, language, cardCount } = await req.json();

        if (!text) {
            return NextResponse.json({ error: 'Texto é obrigatório' }, { status: 400 });
        }

        // 4. Sanitizar input para prevenir prompt injection
        const sanitizedText = sanitizeInput(text);

        // 5. Verificar Limite de Caracteres
        if (sanitizedText.length > limits.maxChars) {
            return NextResponse.json({
                error: `Seu plano ${limits.name} suporta até ${limits.maxChars} caracteres. O texto enviado tem ${sanitizedText.length}.`
            }, { status: 403 });
        }

        // 6. Verificar Limite Diário
        const today = new Date().toISOString().split('T')[0];
        const isNewDay = profile.last_reset_date !== today;
        const currentUsage = isNewDay ? 0 : profile.daily_generations;

        if (currentUsage >= limits.dailyGens) {
            return NextResponse.json({
                error: `Você atingiu o limite de ${limits.dailyGens} gerações diárias do plano ${limits.name}.`
            }, { status: 403 });
        }

        // Definir quantidade de cards
        let requestedCardCount = limits.maxCardsPerGen;
        if (limits.customCardCount && cardCount) {
            requestedCardCount = Math.min(cardCount, limits.maxCardsPerGen);
        }

        // 5. Integração com IA (Gemini 2.5 Flash)
        const optimizationPrompt = limits.aiOptimized
            ? "Crie cards mais profundos, focando em conceitos-chave e aplicações práticas, evitando perguntas muito superficiais."
            : "Crie cards simples e diretos.";

        const prompt = `
            Você é um especialista em educação e memorização espaçada (SRS).
            Analise o texto fornecido e crie flashcards otimizados para o Anki.
            
            REGRAS:
            1. Crie EXATAMENTE ${requestedCardCount} flashcards.
            2. Cada flashcard deve ter uma pergunta clara e uma resposta concisa.
            3. O idioma da resposta deve ser obrigatoriamente: ${language || 'Português'}.
            4. ${optimizationPrompt}
            5. Retorne APENAS um JSON puro no seguinte formato:
               [{"question": "string", "answer": "string"}]

            TEXTO:
            ${sanitizedText}
        `;

        const geminiResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${process.env.GEMINI_API_KEY}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                contents: [{ parts: [{ text: prompt }] }],
                generationConfig: {
                    temperature: 0.7,
                    responseMimeType: "application/json"
                }
            })
        });

        if (!geminiResponse.ok) {
            const errorData = await geminiResponse.json();
            console.error('Erro Gemini:', errorData);
            return NextResponse.json({ error: 'Erro ao processar com a IA' }, { status: 502 });
        }

        const data = await geminiResponse.json();
        let cards = [];

        try {
            const rawContent = data.candidates?.[0]?.content?.parts?.[0]?.text;
            // O Gemini com responseMimeType "application/json" já deve retornar algo limpo
            cards = JSON.parse(rawContent || '[]');
        } catch (parseError) {
            console.error('Erro ao parsear resposta da IA:', parseError);
            return NextResponse.json({ error: 'A IA gerou um formato inválido. Tente novamente.' }, { status: 500 });
        }

        // 7. Incrementar Uso no Supabase
        const { error: updateError } = await supabase.rpc('increment_daily_usage', {
            p_user_id: user.id
        });

        if (updateError) {
            console.error('Erro ao atualizar uso:', updateError);
        }

        return NextResponse.json({
            cards,
            usage: currentUsage + 1,
            limit: limits.dailyGens
        });

    } catch (error) {
        console.error('Erro na geração:', error);
        return NextResponse.json({ error: 'Falha ao processar a requisição' }, { status: 500 });
    }
}
