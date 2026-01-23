export const PAYMENT_LINKS = {
    pro: process.env.NEXT_PUBLIC_STRIPE_PAYMENT_LINK_PRO || 'https://buy.stripe.com/test_...', // Replace with real link
    ultimate: process.env.NEXT_PUBLIC_STRIPE_PAYMENT_LINK_ULTIMATE || 'https://buy.stripe.com/test_...',
};
