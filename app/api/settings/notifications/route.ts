import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase-server';

export async function POST(request: NextRequest) {
    try {
        const supabase = await createClient();
        const { data: { session } } = await supabase.auth.getSession();

        if (!session) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        const { reminderHour, studyRemindersEnabled, streakNotifications, achievementNotifications } = await request.json();

        const updates: Record<string, unknown> = {
            user_id: session.user.id,
            updated_at: new Date().toISOString(),
        };

        if (typeof reminderHour === 'number') {
            updates.reminder_hour = reminderHour;
        }
        if (typeof studyRemindersEnabled === 'boolean') {
            updates.study_reminders_enabled = studyRemindersEnabled;
        }
        if (typeof streakNotifications === 'boolean') {
            updates.streak_notifications = streakNotifications;
        }
        if (typeof achievementNotifications === 'boolean') {
            updates.achievement_notifications = achievementNotifications;
        }

        const { error } = await supabase
            .from('notification_preferences')
            .upsert(updates, { onConflict: 'user_id' });

        if (error) {
            console.error('Error updating notification preferences:', error);
            return NextResponse.json({ error: 'Failed to update preferences' }, { status: 500 });
        }

        return NextResponse.json({ success: true });
    } catch (error) {
        console.error('Notification settings error:', error);
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
    }
}

export async function GET() {
    try {
        const supabase = await createClient();
        const { data: { session } } = await supabase.auth.getSession();

        if (!session) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        const { data, error } = await supabase
            .from('notification_preferences')
            .select('*')
            .eq('user_id', session.user.id)
            .single();

        if (error && error.code !== 'PGRST116') {
            console.error('Error fetching preferences:', error);
            return NextResponse.json({ error: 'Failed to fetch preferences' }, { status: 500 });
        }

        // Return defaults if no preferences exist
        return NextResponse.json(data || {
            study_reminders_enabled: true,
            reminder_hour: 19,
            streak_notifications: true,
            achievement_notifications: true
        });
    } catch (error) {
        console.error('Notification settings error:', error);
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
    }
}
