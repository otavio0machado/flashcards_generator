'use client';

import { ReactNode, useEffect } from 'react';
import posthog from 'posthog-js';
import { PostHogProvider } from 'posthog-js/react';
import { supabase } from '@/lib/supabase';

const posthogKey = process.env.NEXT_PUBLIC_POSTHOG_KEY;
const posthogHost = process.env.NEXT_PUBLIC_POSTHOG_HOST || 'https://app.posthog.com';

if (typeof window !== 'undefined' && posthogKey) {
    posthog.init(posthogKey, {
        api_host: posthogHost,
        capture_pageview: false,
        capture_pageleave: true,
    });
}

export default function AnalyticsProvider({ children }: { children: ReactNode }) {
    useEffect(() => {
        if (!posthogKey) return;

        const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
            if (event === 'SIGNED_IN' && session?.user) {
                posthog.identify(session.user.id, {
                    email: session.user.email,
                    name: session.user.user_metadata?.full_name
                });
            } else if (event === 'SIGNED_OUT') {
                posthog.reset();
            }
        });

        return () => {
            subscription.unsubscribe();
        };
    }, []);

    if (!posthogKey) {
        return <>{children}</>;
    }

    return <PostHogProvider client={posthog}>{children}</PostHogProvider>;
}
