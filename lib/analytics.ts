import posthog from 'posthog-js';

type EventProps = Record<string, unknown>;

const isPosthogEnabled = !!process.env.NEXT_PUBLIC_POSTHOG_KEY;

export const trackEvent = (event: string, props?: EventProps) => {
    if (typeof window === 'undefined' || !isPosthogEnabled) return;
    posthog.capture(event, props);
};

export const identifyUser = (id: string, traits?: EventProps) => {
    if (typeof window === 'undefined' || !isPosthogEnabled) return;
    posthog.identify(id, traits);
};
