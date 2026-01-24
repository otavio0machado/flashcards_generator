import { createClient } from '@/lib/supabase-server';
import { NextResponse } from 'next/server';
import { stripe } from '@/lib/stripe';
import { supabaseAdmin } from '@/lib/supabase-admin';


export const dynamic = 'force-dynamic';

export async function POST(req: Request) {
    try {
        const supabase = await createClient();

        const { data: { user }, error: authError } = await supabase.auth.getUser();

        if (authError || !user) {
            return NextResponse.json({ error: 'Não autorizado' }, { status: 401 });
        }

        const { data: profile } = await supabaseAdmin
            .from('profiles')
            .select('stripe_customer_id')
            .eq('id', user.id)
            .single();

        let stripeCustomerId = profile?.stripe_customer_id;

        if (!stripeCustomerId) {
            // Create a new customer if one doesn't exist
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

        const session = await stripe.billingPortal.sessions.create({
            customer: stripeCustomerId!,
            return_url: `${origin}/app`,
        });

        return NextResponse.json({ url: session.url });
    } catch (error) {
        console.error('Portal error:', error);
        return NextResponse.json(
            { error: 'Erro ao acessar portal de pagamentos' },
            { status: 500 }
        );
    }
}
