'use client';

import { useState } from 'react';
import { loadStripe } from '@stripe/stripe-js';
import { Loader2 } from 'lucide-react';
import { toast } from 'sonner';

const stripePromise = loadStripe(process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY!);

interface CheckoutButtonProps {
    priceId: string;
    planName: string;
    className?: string;
    children: React.ReactNode;
}

export default function CheckoutButton({ priceId, planName, className, children }: CheckoutButtonProps) {
    const [loading, setLoading] = useState(false);

    const handleCheckout = async () => {
        try {
            setLoading(true);

            const response = await fetch('/api/stripe/checkout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    priceId,
                    planName,
                }),
            });

            if (!response.ok) {
                if (response.status === 401) {
                    toast.error("Faça login para continuar");
                    // Redirect to login handled by user usually, but here we might validly want to redirect.
                    // window.location.href = '/auth/login'; 
                    return;
                }
                throw new Error('Network response was not ok');
            }

            const { sessionId } = await response.json();
            const stripe = await stripePromise;

            if (!stripe) throw new Error('Stripe failed to load');

            const { error } = await stripe.redirectToCheckout({ sessionId });

            if (error) {
                console.error('Stripe error:', error);
                toast.error(error.message);
            }
        } catch (error) {
            console.error('Checkout error:', error);
            toast.error('Erro ao iniciar checkout. Tente novamente.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <button
            onClick={handleCheckout}
            disabled={loading}
            className={className}
        >
            {loading ? (
                <span className="flex items-center justify-center gap-2">
                    <Loader2 className="h-4 w-4 animate-spin" />
                    Processando...
                </span>
            ) : (
                children
            )}
        </button>
    );
}
