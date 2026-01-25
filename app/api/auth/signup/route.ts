import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

const MIN_PASSWORD_LENGTH = 8;

function isValidPassword(password: string) {
    return (
        password.length >= MIN_PASSWORD_LENGTH &&
        /[A-Z]/.test(password) &&
        /[a-z]/.test(password) &&
        /[0-9]/.test(password) &&
        /[!@#$%^&*(),.?":{}|<>]/.test(password)
    );
}

export async function POST(req: Request) {
    try {
        const body = await req.json().catch(() => ({}));
        const name = typeof body?.name === 'string' ? body.name.trim() : '';
        const email = typeof body?.email === 'string' ? body.email.trim() : '';
        const password = typeof body?.password === 'string' ? body.password : '';

        if (!email || !password) {
            return NextResponse.json({ error: 'E-mail e senha são obrigatórios.' }, { status: 400 });
        }

        if (!isValidPassword(password)) {
            return NextResponse.json({ error: 'Senha não atende aos requisitos mínimos.' }, { status: 400 });
        }

        const { data, error } = await supabaseAdmin.auth.admin.createUser({
            email,
            password,
            email_confirm: true,
            user_metadata: {
                full_name: name,
            },
        });

        if (error) {
            return NextResponse.json({ error: error.message }, { status: 400 });
        }

        if (data?.user?.id) {
            try {
                const { data: deck } = await supabaseAdmin
                    .from('decks')
                    .insert({
                        user_id: data.user.id,
                        title: 'Seu primeiro deck ✅',
                        description: 'Exemplo rápido para começar a estudar.',
                        tags: ['bem-vindo'],
                    })
                    .select()
                    .single();

                if (deck?.id) {
                    await supabaseAdmin
                        .from('cards')
                        .insert([
                            {
                                deck_id: deck.id,
                                front: 'O que é repetição espaçada?',
                                back: 'Uma técnica de estudo que revisa conteúdos em intervalos crescentes.',
                                order: 0,
                            },
                            {
                                deck_id: deck.id,
                                front: 'Qual é o objetivo do Flashcards Generator?',
                                back: 'Transformar textos em perguntas e respostas prontas para revisar.',
                                order: 1,
                            },
                            {
                                deck_id: deck.id,
                                front: 'Próximo passo?',
                                back: 'Gere seus próprios cards e exporte para o Anki.',
                                order: 2,
                            },
                        ]);
                }
            } catch (deckError) {
                console.error('Erro ao criar deck inicial:', deckError);
            }
        }

        return NextResponse.json({ user: data.user, onboarding: { deck_saved: true } });
    } catch (error) {
        console.error('Erro ao criar usuario (signup):', error);
        return NextResponse.json({ error: 'Erro interno ao criar conta.' }, { status: 500 });
    }
}
