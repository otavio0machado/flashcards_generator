import { NextResponse } from 'next/server';
import { headers } from 'next/headers';
import { stripe } from '@/lib/stripe';
import { supabaseAdmin } from '@/lib/supabase-admin';
import Stripe from 'stripe';
import { PostHog } from 'posthog-node';

export const dynamic = 'force-dynamic';

const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET!;

export async function POST(req: Request) {
    try {
        const body = await req.text();
        const signature = (await headers()).get('stripe-signature')!;

        let event: Stripe.Event;

        try {
            event = stripe.webhooks.constructEvent(body, signature, webhookSecret);
        } catch (err) {
            console.error(`Webhook Signature Verification Failed: ${err instanceof Error ? err.message : 'Unknown error'}`);
            return NextResponse.json({ error: `Webhook Error: ${err instanceof Error ? err.message : 'Unknown error'}` }, { status: 400 });
        }

        const session = event.data.object as Stripe.Checkout.Session & { subscription?: string };

        switch (event.type) {
            case 'checkout.session.completed':
            case 'customer.subscription.updated':
            case 'customer.subscription.created': {
                const subscription = await stripe.subscriptions.retrieve(session.subscription || session.id);
                const userId = session.metadata?.userId || subscription.metadata?.userId;
                const planName = session.metadata?.planName || subscription.metadata?.planName || 'pro';

                if (userId) {
                    const { error } = await supabaseAdmin
                        .from('profiles')
                        .update({
                            plan_tier: planName.toLowerCase(),
                            stripe_customer_id: session.customer,
                            stripe_subscription_id: subscription.id,
                        })
                        .eq('id', userId);

                    if (error) throw error;

                    if (event.type === 'checkout.session.completed') {
                        const client = new PostHog(
                            process.env.NEXT_PUBLIC_POSTHOG_KEY!,
                            { host: process.env.NEXT_PUBLIC_POSTHOG_HOST || 'https://app.posthog.com' }
                        );

                        client.capture({
                            distinctId: userId,
                            event: 'purchase_completed',
                            properties: {
                                plan: planName,
                                price: (session.amount_total || 0) / 100,
                                currency: session.currency,
                                billing_cycle: 'monthly', // Assuming monthly for now based on context
                                user_id: userId
                            }
                        });
                        await client.shutdown();
                    }
                }
                break;
            }

            case 'customer.subscription.deleted': {
                const subscription = event.data.object as Stripe.Subscription;
                const userId = subscription.metadata?.userId;

                if (userId) {
                    await supabaseAdmin
                        .from('profiles')
                        .update({
                            plan_tier: 'free',
                            stripe_subscription_id: null,
                        })
                        .eq('id', userId);
                }
                break;
            }

            default:
                console.log(`Unhandled event type ${event.type}`);
        }

        return NextResponse.json({ received: true });
    } catch (error) {
        console.error('Webhook handler failed:', error);
        return NextResponse.json({ error: 'Webhook handler failed' }, { status: 500 });
    }
}
