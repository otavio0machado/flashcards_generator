'use client';

import { useState } from 'react';
import { Loader2 } from 'lucide-react';
import { toast } from 'sonner';
import { motion } from 'framer-motion';


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

            const { url } = await response.json();

            if (url) {
                window.location.href = url;
            } else {
                throw new Error('No checkout URL received');
            }
        } catch (error) {
            console.error('Checkout error:', error);
            toast.error('Erro ao iniciar checkout. Tente novamente.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <motion.button
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
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
        </motion.button>
    );
}
