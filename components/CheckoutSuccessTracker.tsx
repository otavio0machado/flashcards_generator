'use client';

import { useEffect } from 'react';
import { useSearchParams } from 'next/navigation';
import { trackEvent } from '@/lib/analytics';

export default function CheckoutSuccessTracker() {
    const searchParams = useSearchParams();

    useEffect(() => {
        const success = searchParams.get('success');
        if (success === 'true') {
            trackEvent('checkout_success');
        }
    }, [searchParams]);

    return null;
}
