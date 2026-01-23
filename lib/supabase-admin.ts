import { createClient, SupabaseClient } from '@supabase/supabase-js';

// Note: This client uses the SERVICE_ROLE_KEY which bypasses RLS.
// Use ONLY in server-side API routes (webhooks, etc). NOT in client code.

let supabaseAdminInstance: SupabaseClient | null = null;

export const getSupabaseAdmin = (): SupabaseClient => {
    if (!supabaseAdminInstance) {
        const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
        const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

        if (!url || !key) {
            throw new Error('Supabase admin credentials not configured');
        }

        supabaseAdminInstance = createClient(url, key);
    }
    return supabaseAdminInstance;
};

// Backward compatibility - lazy getter
export const supabaseAdmin = new Proxy({} as SupabaseClient, {
    get(_, prop) {
        return getSupabaseAdmin()[prop as keyof SupabaseClient];
    }
});
