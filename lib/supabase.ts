import { createBrowserClient } from '@supabase/auth-helpers-nextjs';
import { type SupabaseClient } from '@supabase/supabase-js';

let supabaseInstance: SupabaseClient | null = null;

export const getSupabase = (): SupabaseClient => {
    if (!supabaseInstance) {
        const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
        const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

        supabaseInstance = createBrowserClient(supabaseUrl, supabaseAnonKey);
    }
    return supabaseInstance;
};

// Lazy proxy for backward compatibility
export const supabase = new Proxy({} as SupabaseClient, {
    get(_, prop) {
        const instance = getSupabase();
        return instance[prop as keyof SupabaseClient];
    }
});

