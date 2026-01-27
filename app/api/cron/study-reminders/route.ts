import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';

// This endpoint is called by a cron job (e.g., Vercel Cron, GitHub Actions)
// to send study reminders to users who opted in

export async function GET(request: Request) {
    try {
        // Verify cron secret
        const authHeader = request.headers.get('authorization');
        const cronSecret = process.env.CRON_SECRET;

        if (!cronSecret || authHeader !== `Bearer ${cronSecret}`) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        // Get current hour in BRT (UTC-3)
        const now = new Date();
        const brtHour = (now.getUTCHours() - 3 + 24) % 24;

        // Find users who should receive reminders at this hour
        const { data: users, error } = await supabaseAdmin
            .from('notification_preferences')
            .select('user_id, reminder_hour')
            .eq('study_reminders_enabled', true)
            .eq('reminder_hour', brtHour);

        if (error) {
            console.error('Error fetching notification preferences:', error);
            return NextResponse.json({ error: 'Database error' }, { status: 500 });
        }

        if (!users || users.length === 0) {
            return NextResponse.json({ message: 'No reminders to send at this hour' });
        }

        // Get users who haven't studied today
        const today = new Date().toISOString().split('T')[0];

        const { data: studiedToday, error: activityError } = await supabaseAdmin
            .from('study_activity')
            .select('user_id')
            .eq('day', today)
            .in('user_id', users.map(u => u.user_id));

        if (activityError) {
            console.error('Error fetching study activity:', activityError);
        }

        const studiedUserIds = new Set(studiedToday?.map(s => s.user_id) || []);
        const usersToNotify = users.filter(u => !studiedUserIds.has(u.user_id));

        if (usersToNotify.length === 0) {
            return NextResponse.json({ message: 'All users have already studied today' });
        }

        // Send notifications
        const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://flashcards-generator.com';
        
        const results = await Promise.allSettled(
            usersToNotify.map(async (user) => {
                const response = await fetch(`${baseUrl}/api/push/send`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${cronSecret}`
                    },
                    body: JSON.stringify({
                        userId: user.user_id,
                        payload: {
                            title: '📚 Hora de estudar!',
                            body: 'Mantenha sua sequência! Revise seus flashcards agora.',
                            url: '/decks',
                            tag: 'study-reminder'
                        }
                    })
                });
                return response.ok;
            })
        );

        const sent = results.filter(r => r.status === 'fulfilled' && r.value).length;

        return NextResponse.json({
            message: `Sent ${sent} study reminders`,
            total: usersToNotify.length,
            sent
        });
    } catch (error) {
        console.error('Study reminder cron error:', error);
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
    }
}
