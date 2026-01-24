'use client';

import { ReactNode } from 'react';
import posthog from 'posthog-js';
import { PostHogProvider } from 'posthog-js/react';

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
    if (!posthogKey) {
        return <>{children}</>;
    }

    return <PostHogProvider client={posthog}>{children}</PostHogProvider>;
}
