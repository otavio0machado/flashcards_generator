import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin'; // You'll need to create this admin client

// This would normally be your Stripe Secret Key and Webhook Secret
// const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, { apiVersion: '2023-10-16' });
// const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET!;

export async function POST(req: Request) {
    try {
        const body = await req.text();
        // const signature = headers().get('stripe-signature')!;

        // let event;
        // try {
        //     event = stripe.webhooks.constructEvent(body, signature, webhookSecret);
        // } catch (err: any) {
        //     return NextResponse.json({ error: `Webhook Error: ${err.message}` }, { status: 400 });
        // }

        const event = JSON.parse(body); // Mock parsing for now

        if (event.type === 'checkout.session.completed') {
            const session = event.data.object;
            const userId = session.client_reference_id; // Pass this when creating Checkout Session
            const plan = 'pro'; // Determine plan from session.line_items

            // Update User Profile
            const { error } = await supabaseAdmin
                .from('profiles')
                .update({
                    plan_tier: plan,
                    stripe_customer_id: session.customer,
                    subscription_status: 'active'
                })
                .eq('id', userId);

            if (error) throw error;
        }

        return NextResponse.json({ received: true });
    } catch (error) {
        console.error('Webhook handler failed:', error);
        return NextResponse.json({ error: 'Webhook handler failed' }, { status: 500 });
    }
}
