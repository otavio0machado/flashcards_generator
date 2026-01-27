-- Push Subscriptions Table
-- Stores web push subscriptions for each user

CREATE TABLE IF NOT EXISTS push_subscriptions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    subscription JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE push_subscriptions ENABLE ROW LEVEL SECURITY;

-- Users can only manage their own subscriptions
CREATE POLICY "Users can view own subscription" ON push_subscriptions
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own subscription" ON push_subscriptions
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own subscription" ON push_subscriptions
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own subscription" ON push_subscriptions
    FOR DELETE USING (auth.uid() = user_id);

-- Create index for faster lookups
CREATE INDEX idx_push_subscriptions_user_id ON push_subscriptions(user_id);

-- Notification Preferences Table
-- Stores user notification preferences

CREATE TABLE IF NOT EXISTS notification_preferences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    study_reminders_enabled BOOLEAN DEFAULT true,
    reminder_hour INTEGER DEFAULT 19 CHECK (reminder_hour >= 0 AND reminder_hour < 24),
    streak_notifications BOOLEAN DEFAULT true,
    achievement_notifications BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE notification_preferences ENABLE ROW LEVEL SECURITY;

-- Users can only manage their own preferences
CREATE POLICY "Users can view own preferences" ON notification_preferences
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own preferences" ON notification_preferences
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own preferences" ON notification_preferences
    FOR UPDATE USING (auth.uid() = user_id);

-- Create index
CREATE INDEX idx_notification_preferences_user_id ON notification_preferences(user_id);
CREATE INDEX idx_notification_preferences_reminder ON notification_preferences(study_reminders_enabled, reminder_hour);

-- Function to auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers
CREATE TRIGGER update_push_subscriptions_updated_at
    BEFORE UPDATE ON push_subscriptions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_notification_preferences_updated_at
    BEFORE UPDATE ON notification_preferences
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
