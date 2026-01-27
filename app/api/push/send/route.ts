import { NextRequest, NextResponse } from 'next/server';
import webpush from 'web-push';
import { supabaseAdmin } from '@/lib/supabase-admin';

const vapidPublicKey = process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY || '';
const vapidPrivateKey = process.env.VAPID_PRIVATE_KEY || '';

if (vapidPublicKey && vapidPrivateKey) {
    webpush.setVapidDetails(
        'mailto:suporte@flashcards-generator.com',
        vapidPublicKey,
        vapidPrivateKey
    );
}

interface NotificationPayload {
    title: string;
    body: string;
    icon?: string;
    badge?: string;
    url?: string;
    tag?: string;
}

export async function POST(request: NextRequest) {
    try {
        // Verify API key for cron jobs
        const authHeader = request.headers.get('authorization');
        const cronSecret = process.env.CRON_SECRET;

        if (!cronSecret || authHeader !== `Bearer ${cronSecret}`) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        const { userId, payload }: { userId?: string; payload: NotificationPayload } = await request.json();

        if (!payload || !payload.title) {
            return NextResponse.json({ error: 'Missing notification payload' }, { status: 400 });
        }

        // Get subscriptions
        let query = supabaseAdmin
            .from('push_subscriptions')
            .select('user_id, subscription');

        if (userId) {
            query = query.eq('user_id', userId);
        }

        const { data: subscriptions, error } = await query;

        if (error) {
            console.error('Error fetching subscriptions:', error);
            return NextResponse.json({ error: 'Failed to fetch subscriptions' }, { status: 500 });
        }

        if (!subscriptions || subscriptions.length === 0) {
            return NextResponse.json({ message: 'No subscriptions found' });
        }

        const notificationPayload = JSON.stringify({
            title: payload.title,
            body: payload.body,
            icon: payload.icon || '/icons/icon-192x192.png',
            badge: payload.badge || '/icons/icon-96x96.png',
            data: {
                url: payload.url || '/',
            },
            tag: payload.tag || 'flashcards-notification',
        });

        const results = await Promise.allSettled(
            subscriptions.map(async (sub) => {
                try {
                    const subscription = JSON.parse(sub.subscription);
                    await webpush.sendNotification(subscription, notificationPayload);
                    return { userId: sub.user_id, success: true };
                } catch (err) {
                    const error = err as { statusCode?: number };
                    // If subscription is expired or invalid, remove it
                    if (error.statusCode === 404 || error.statusCode === 410) {
                        await supabaseAdmin
                            .from('push_subscriptions')
                            .delete()
                            .eq('user_id', sub.user_id);
                    }
                    return { userId: sub.user_id, success: false, error };
                }
            })
        );

        const successful = results.filter(r => r.status === 'fulfilled' && (r.value as { success: boolean }).success).length;
        const failed = results.length - successful;

        return NextResponse.json({
            message: `Sent ${successful} notifications, ${failed} failed`,
            total: results.length,
            successful,
            failed
        });
    } catch (error) {
        console.error('Send notification error:', error);
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
    }
}
