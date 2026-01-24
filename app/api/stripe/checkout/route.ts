import { createClient } from '@/lib/supabase-server';
import { NextResponse } from 'next/server';
import { stripe } from '@/lib/stripe';
import { supabaseAdmin } from '@/lib/supabase-admin';


export const dynamic = 'force-dynamic';

export async function POST(req: Request) {
    try {
        // Check if Stripe is configured
        if (!process.env.STRIPE_SECRET_KEY) {
            console.error('STRIPE_SECRET_KEY is not configured');
            return NextResponse.json(
                { error: 'Stripe não está configurado. Configure STRIPE_SECRET_KEY no Vercel.' },
                { status: 500 }
            );
        }

        const supabase = await createClient();

        const { data: { user }, error: authError } = await supabase.auth.getUser();

        if (authError || !user) {
            return NextResponse.json({ error: 'Não autorizado' }, { status: 401 });
        }

        const { priceId, planName } = await req.json();

        if (!priceId) {
            return NextResponse.json({ error: 'Price ID é obrigatório' }, { status: 400 });
        }

        // Validate priceId format (must start with 'price_')
        if (!priceId.startsWith('price_')) {
            console.error('Invalid priceId:', priceId);
            return NextResponse.json(
                { error: 'Price ID inválido. Configure NEXT_PUBLIC_STRIPE_PRICE_ID_PRO e NEXT_PUBLIC_STRIPE_PRICE_ID_ULTIMATE no Vercel.' },
                { status: 400 }
            );
        }

        const { data: profile } = await supabaseAdmin
            .from('profiles')
            .select('stripe_customer_id')
            .eq('id', user.id)
            .single();

        let stripeCustomerId = profile?.stripe_customer_id;

        if (!stripeCustomerId) {
            const customer = await stripe.customers.create({
                email: user.email,
                metadata: {
                    userId: user.id,
                },
            });

            stripeCustomerId = customer.id;

            await supabaseAdmin
                .from('profiles')
                .update({ stripe_customer_id: stripeCustomerId })
                .eq('id', user.id);
        }

        const origin = req.headers.get('origin') || 'http://localhost:3000';

        const session = await stripe.checkout.sessions.create({
            customer: stripeCustomerId,
            line_items: [
                {
                    price: priceId,
                    quantity: 1,
                },
            ],
            mode: 'subscription',
            success_url: `${origin}/app?success=true`,
            cancel_url: `${origin}/app?canceled=true`,
            metadata: {
                userId: user.id,
                planName: planName,
            },
            subscription_data: {
                metadata: {
                    userId: user.id,
                    planName: planName,
                }
            }
        });

        return NextResponse.json({ url: session.url });
    } catch (error: unknown) {
        console.error('Checkout error:', error);
        console.error('Full error details:', JSON.stringify(error, Object.getOwnPropertyNames(error as object)));

        // Return more specific error for debugging
        const errorMessage = error instanceof Error ? error.message : 'Unknown error';
        const isStripeError = error && typeof error === 'object' && 'type' in error;

        return NextResponse.json(
            {
                error: 'Erro ao criar sessão de checkout',
                details: errorMessage,
                stripeError: isStripeError ? (error as { type: string }).type : undefined
            },
            { status: 500 }
        );
    }
}
