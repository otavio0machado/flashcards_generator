import { NextResponse } from 'next/server';
import { createServerClient, type CookieOptions } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';

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

        // 1. Verificar Sessão
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) {
            return NextResponse.json({ error: 'Não autorizado. Por favor, faça login.' }, { status: 401 });
        }

        const { text, language } = await req.json();

        if (!text) {
            return NextResponse.json({ error: 'Texto é obrigatório' }, { status: 400 });
        }

        // 2. Buscar Perfil e Plano do Usuário
        const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('*')
            .eq('id', session.user.id)
            .single();

        if (profileError || !profile) {
            return NextResponse.json({ error: 'Erro ao buscar perfil do usuário' }, { status: 500 });
        }

        const planKey = (profile.plan_tier || 'free') as PlanKey;
        const limits = PLAN_LIMITS[planKey];

        // 3. Verificar Limite de Caracteres
        if (text.length > limits.maxChars) {
            return NextResponse.json({
                error: `Seu plano ${limits.name} suporta até ${limits.maxChars} caracteres. O texto enviado tem ${text.length}.`
            }, { status: 403 });
        }

        // 4. Verificar Limite Diário
        // Resetamos o contador se for um novo dia (lógica espelhada da função SQL)
        const today = new Date().toISOString().split('T')[0];
        const isNewDay = profile.last_reset_date !== today;
        const currentUsage = isNewDay ? 0 : profile.daily_generations;

        if (currentUsage >= limits.dailyGens) {
            return NextResponse.json({
                error: `Você atingiu o limite de ${limits.dailyGens} gerações diárias do plano ${limits.name}.`
            }, { status: 403 });
        }

        // 5. Integração com IA (Gemini 1.5 Flash)
        const prompt = `
            Você é um especialista em educação e memorização espaçada (SRS).
            Analise o texto fornecido e crie flashcards otimizados para o Anki.
            
            REGRAS:
            1. Crie entre 5 a 15 flashcards dependendo da densidade do texto.
            2. Cada flashcard deve ter uma pergunta clara e uma resposta concisa.
            3. O idioma da resposta deve ser obrigatoriamente: ${language || 'Português'}.
            4. Retorne APENAS um JSON puro no seguinte formato, sem formatação markdown (como \`\`\`json):
               [{"question": "string", "answer": "string"}]

            TEXTO:
            ${text}
        `;

        const geminiResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${process.env.GEMINI_API_KEY}`, {
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

        // 6. Incrementar Uso no Supabase
        const { error: updateError } = await supabase.rpc('increment_daily_usage', {
            p_user_id: session.user.id
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
