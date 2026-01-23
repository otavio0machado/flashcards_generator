import { headers } from 'next/headers';
import { NextResponse } from 'next/server';
import { stripe } from '@/lib/stripe';
import { supabaseAdmin } from '@/lib/supabase-admin';
import Stripe from 'stripe';

export const dynamic = 'force-dynamic';

export async function POST(req: Request) {
    const body = await req.text();
    const headerList = await headers();
    const signature = headerList.get('Stripe-Signature') as string;

    let event: Stripe.Event;

    try {
        event = stripe.webhooks.constructEvent(
            body,
            signature,
            process.env.STRIPE_WEBHOOK_SECRET || ''
        );
    } catch (error: any) {
        console.error('Webhook signature verification failed:', error.message);
        return new NextResponse(`Webhook Error: ${error.message}`, { status: 400 });
    }

    const session = event.data.object as Stripe.Checkout.Session;

    if (event.type === 'checkout.session.completed') {
        const subscriptionId = session.subscription as string;
        const userId = session.metadata?.userId;
        const planName = session.metadata?.planName; // 'pro' or 'ultimate'

        if (userId && planName) {
            await supabaseAdmin
                .from('profiles')
                .update({
                    plan_tier: planName,
                    stripe_subscription_id: subscriptionId,
                })
                .eq('id', userId);
        }
    }

    if (event.type === 'customer.subscription.deleted') {
        const subscription = event.data.object as Stripe.Subscription;
        const userId = subscription.metadata?.userId;

        if (userId) {
            await supabaseAdmin
                .from('profiles')
                .update({ plan_tier: 'free' })
                .eq('id', userId);
        } else {
            await supabaseAdmin
                .from('profiles')
                .update({ plan_tier: 'free' })
                .eq('stripe_subscription_id', subscription.id);
        }
    }

    return new NextResponse('OK', { status: 200 });
}
