'use client';

import { useEffect } from 'react';
import { usePathname, useSearchParams } from 'next/navigation';
import posthog from 'posthog-js';

export default function AnalyticsPageView() {
    const pathname = usePathname();
    const searchParams = useSearchParams();

    useEffect(() => {
        if (!process.env.NEXT_PUBLIC_POSTHOG_KEY) return;
        const params = searchParams?.toString();
        const url = params ? `${pathname}?${params}` : pathname;
        posthog.capture('$pageview', { $current_url: url });
    }, [pathname, searchParams]);

    return null;
}
