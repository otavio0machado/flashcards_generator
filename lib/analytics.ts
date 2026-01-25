import posthog from 'posthog-js';

type EventProps = Record<string, unknown>;

const isPosthogEnabled = !!process.env.NEXT_PUBLIC_POSTHOG_KEY;

const getMarketingProps = () => {
    if (typeof window === 'undefined') return {};

    const params = new URLSearchParams(window.location.search);
    const utmSource = params.get('utm_source') || undefined;
    const utmCampaign = params.get('utm_campaign') || undefined;
    const utmMedium = params.get('utm_medium') || undefined;
    const utmTerm = params.get('utm_term') || undefined;
    const utmContent = params.get('utm_content') || undefined;
    const source = utmSource || params.get('source') || (document.referrer ? new URL(document.referrer).host : undefined);

    return {
        source,
        utm_source: utmSource,
        utm_campaign: utmCampaign,
        utm_medium: utmMedium,
        utm_term: utmTerm,
        utm_content: utmContent,
    };
};

export const trackEvent = (event: string, props?: EventProps) => {
    if (typeof window === 'undefined' || !isPosthogEnabled) return;
    posthog.capture(event, { ...getMarketingProps(), ...props });
};

export const identifyUser = (id: string, traits?: EventProps) => {
    if (typeof window === 'undefined' || !isPosthogEnabled) return;
    posthog.identify(id, traits);
};
