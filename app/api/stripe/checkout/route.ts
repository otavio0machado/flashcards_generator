import { createClient } from '@/lib/supabase-server';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';
import { stripe } from '@/lib/stripe';
import { supabaseAdmin } from '@/lib/supabase-admin';


export const dynamic = 'force-dynamic';

export async function POST(req: Request) {
    const supabase = await createClient();

    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
        return new NextResponse('Unauthorized', { status: 401 });
    }

    const { priceId, planName } = await req.json();

    if (!priceId) {
        return new NextResponse('Price ID is required', { status: 400 });
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
}
