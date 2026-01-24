'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { X, Zap } from 'lucide-react';

interface UpgradeModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export default function UpgradeModal({ isOpen, onClose }: UpgradeModalProps) {
    const router = useRouter();

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
            <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" onClick={onClose}></div>
            <div className="bg-white border-2 border-brand w-full max-w-md p-8 rounded-sm relative z-10 shadow-2xl animate-in fade-in zoom-in duration-200">
                <button
                    onClick={onClose}
                    className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors"
                >
                    <X className="h-5 w-5" />
                </button>

                <div className="bg-brand/10 w-16 h-16 rounded-full flex items-center justify-center mb-6 mx-auto">
                    <Zap className="h-8 w-8 text-brand" />
                </div>

                <h2 className="text-2xl font-bold text-center mb-2 text-foreground">Desbloqueie mais poder com os Planos Pro e Ultimate</h2>
                <p className="text-center text-foreground/60 font-medium mb-8 leading-relaxed">
                    O plano gratuito tem limites de 3 gerações diárias e 5 cards. Assine o Pro ou Ultimate para fazer upload de PDFs/DOCX, salvar seu histórico e gerar até 30 cards por vez. Geracao de imagens e upload de imagens estao disponiveis no Ultimate.
                </p>

                <div className="space-y-4">
                    <button
                        onClick={() => {
                            onClose();
                            router.push('/#pricing');
                        }}
                        className="w-full bg-brand text-white py-4 font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                    >
                        Ver Planos e Preços
                    </button>
                    <button
                        onClick={onClose}
                        className="w-full text-foreground/40 font-bold py-2 text-sm"
                    >
                        Continuar no Plano Grátis
                    </button>
                </div>
            </div>
        </div>
    );
}
