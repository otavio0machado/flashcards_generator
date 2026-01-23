import { createClient } from '@supabase/supabase-js';

// Note: This client uses the SERVICE_ROLE_KEY which bypasses RLS.
// Use ONLY in server-side API routes (webhooks, etc). NOT in client code.

export const supabaseAdmin = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
);
