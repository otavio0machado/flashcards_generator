import Stripe from 'stripe';

let stripeInstance: Stripe | null = null;

export const getStripe = (): Stripe => {
    if (!stripeInstance) {
        stripeInstance = new Stripe(process.env.STRIPE_SECRET_KEY || '', {
            apiVersion: '2025-12-15.clover' as any,
            typescript: true,
        });
    }
    return stripeInstance;
};

// Backward compatibility
export const stripe = new Proxy({} as Stripe, {
    get(_, prop) {
        const instance = getStripe();
        const value = instance[prop as keyof Stripe];
        return typeof value === 'function' ? (value as Function).bind(instance) : value;
    }
});
