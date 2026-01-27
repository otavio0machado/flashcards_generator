import { NextRequest, NextResponse } from 'next/server';
import webpush from 'web-push';
import { createClient } from '@/lib/supabase-server';

// Configure VAPID keys (generate once and store in env)
const vapidPublicKey = process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY || '';
const vapidPrivateKey = process.env.VAPID_PRIVATE_KEY || '';

if (vapidPublicKey && vapidPrivateKey) {
    webpush.setVapidDetails(
        'mailto:suporte@flashcards-generator.com',
        vapidPublicKey,
        vapidPrivateKey
    );
}

export async function POST(request: NextRequest) {
    try {
        const supabase = await createClient();
        const { data: { session } } = await supabase.auth.getSession();

        if (!session) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        const { subscription, action } = await request.json();

        if (action === 'subscribe') {
            // Save subscription to database
            const { error } = await supabase
                .from('push_subscriptions')
                .upsert({
                    user_id: session.user.id,
                    subscription: JSON.stringify(subscription),
                    created_at: new Date().toISOString(),
                    updated_at: new Date().toISOString(),
                }, {
                    onConflict: 'user_id'
                });

            if (error) {
                console.error('Error saving subscription:', error);
                return NextResponse.json({ error: 'Failed to save subscription' }, { status: 500 });
            }

            return NextResponse.json({ success: true, message: 'Subscription saved' });
        }

        if (action === 'unsubscribe') {
            const { error } = await supabase
                .from('push_subscriptions')
                .delete()
                .eq('user_id', session.user.id);

            if (error) {
                console.error('Error removing subscription:', error);
                return NextResponse.json({ error: 'Failed to remove subscription' }, { status: 500 });
            }

            return NextResponse.json({ success: true, message: 'Subscription removed' });
        }

        return NextResponse.json({ error: 'Invalid action' }, { status: 400 });
    } catch (error) {
        console.error('Push subscription error:', error);
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
    }
}

export async function GET() {
    // Return the public VAPID key for the client
    return NextResponse.json({
        publicKey: vapidPublicKey
    });
}
