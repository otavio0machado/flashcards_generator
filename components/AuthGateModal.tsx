'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { X, Lock } from 'lucide-react';

interface AuthGateModalProps {
    isOpen: boolean;
    onClose: () => void;
    title?: string;
    description?: string;
    onSignupClick?: () => void;
    onLoginClick?: () => void;
    onDismiss?: () => void;
}

export default function AuthGateModal({
    isOpen,
    onClose,
    title = 'Salve e exporte seus flashcards',
    description = 'Crie uma conta gratuita em 10 segundos para salvar, exportar e gerar mais.',
    onSignupClick,
    onLoginClick,
    onDismiss,
}: AuthGateModalProps) {
    const router = useRouter();

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[110] flex items-center justify-center p-4">
            <div
                className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                onClick={() => {
                    onDismiss?.();
                    onClose();
                }}
            ></div>
            <div className="bg-white border border-border w-full max-w-md p-8 rounded-sm relative z-10 shadow-2xl animate-in fade-in zoom-in duration-200">
                <button
                    onClick={() => {
                        onDismiss?.();
                        onClose();
                    }}
                    className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors"
                    aria-label="Fechar"
                >
                    <X className="h-5 w-5" />
                </button>

                <div className="bg-brand/10 w-16 h-16 rounded-full flex items-center justify-center mb-6 mx-auto">
                    <Lock className="h-8 w-8 text-brand" />
                </div>

                <h2 className="text-2xl font-bold text-center mb-2 text-foreground">{title}</h2>
                <p className="text-center text-foreground/60 font-medium mb-8 leading-relaxed">
                    {description}
                </p>

                <div className="space-y-3">
                    <button
                        onClick={() => {
                            onSignupClick?.();
                            onDismiss?.();
                            onClose();
                            router.push('/auth/signup');
                        }}
                        className="w-full bg-brand text-white py-4 font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                    >
                        Criar conta
                    </button>
                    <button
                        onClick={() => {
                            onLoginClick?.();
                            onDismiss?.();
                            onClose();
                            router.push('/auth/login');
                        }}
                        className="w-full text-foreground/60 font-bold py-2 text-sm"
                    >
                        Já tenho conta → Entrar
                    </button>
                </div>
            </div>
        </div>
    );
}
