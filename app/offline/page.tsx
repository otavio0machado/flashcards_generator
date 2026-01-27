'use client';

import React from 'react';
import { WifiOff, RefreshCw, Home } from 'lucide-react';
import Link from 'next/link';

export default function OfflinePage() {
    const handleRetry = () => {
        window.location.reload();
    };

    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4">
            <div className="text-center max-w-md">
                <div className="bg-gray-100 w-24 h-24 rounded-full flex items-center justify-center mb-8 mx-auto">
                    <WifiOff className="h-12 w-12 text-foreground/30" />
                </div>
                
                <h1 className="text-3xl font-bold tracking-tight mb-4">
                    Você está offline
                </h1>
                
                <p className="text-foreground/60 font-medium mb-8 leading-relaxed">
                    Parece que você perdeu a conexão com a internet. 
                    Verifique sua conexão e tente novamente.
                </p>

                <div className="space-y-3">
                    <button
                        onClick={handleRetry}
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

                <div className="mt-12 p-4 bg-gray-50 border border-border rounded-sm">
                    <p className="text-xs font-medium text-foreground/40">
                        💡 Dica: Seus flashcards salvos ainda podem ser acessados offline 
                        se você visitou eles recentemente.
                    </p>
                </div>
            </div>
        </div>
    );
}
