'use client';

import React from 'react';
import { AlertTriangle, RefreshCw, Home } from 'lucide-react';
import Link from 'next/link';

export default function Error({
    error,
    reset,
}: {
    error: Error & { digest?: string };
    reset: () => void;
}) {
    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4">
            <div className="text-center max-w-md">
                <div className="bg-red-50 w-24 h-24 rounded-full flex items-center justify-center mb-8 mx-auto">
                    <AlertTriangle className="h-12 w-12 text-red-400" />
                </div>

                <h1 className="text-3xl font-bold tracking-tight mb-4">
                    Algo deu errado
                </h1>

                <p className="text-foreground/60 font-medium mb-8 leading-relaxed">
                    Ocorreu um erro inesperado. Tente recarregar a página ou voltar ao início.
                </p>

                <div className="space-y-3">
                    <button
                        onClick={reset}
                        className="w-full bg-brand text-white py-3 px-6 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                    >
                        <RefreshCw className="h-4 w-4" />
                        Tentar novamente
                    </button>

                    <Link
                        href="/"
                        className="w-full bg-white border border-border py-3 px-6 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-gray-50 transition-all"
                    >
                        <Home className="h-4 w-4" />
                        Voltar ao início
                    </Link>
                </div>

                {error.digest && (
                    <p className="mt-8 text-xs font-medium text-foreground/30">
                        Código do erro: {error.digest}
                    </p>
                )}
            </div>
        </div>
    );
}
