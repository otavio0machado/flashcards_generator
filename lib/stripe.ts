import Stripe from 'stripe';
import { getRequiredEnv } from './env-validation';

let stripeInstance: Stripe | null = null;

export const getStripe = (): Stripe => {
    if (!stripeInstance) {
        const secretKey = getRequiredEnv('STRIPE_SECRET_KEY');
        stripeInstance = new Stripe(secretKey, {
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
        return typeof value === 'function'
            ? (value as (...args: unknown[]) => unknown).bind(instance)
            : value;
    }
});
