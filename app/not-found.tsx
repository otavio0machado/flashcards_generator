import React from 'react';
import { Search, Home, ArrowRight } from 'lucide-react';
import Link from 'next/link';

export default function NotFound() {
    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4">
            <div className="text-center max-w-md">
                <div className="bg-gray-100 w-24 h-24 rounded-full flex items-center justify-center mb-8 mx-auto">
                    <Search className="h-12 w-12 text-foreground/30" />
                </div>

                <h1 className="text-3xl font-bold tracking-tight mb-4">
                    Página não encontrada
                </h1>

                <p className="text-foreground/60 font-medium mb-8 leading-relaxed">
                    A página que você está procurando não existe ou foi movida.
                </p>

                <div className="space-y-3">
                    <Link
                        href="/app"
                        className="w-full bg-brand text-white py-3 px-6 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                    >
                        Ir para o Gerador
                        <ArrowRight className="h-4 w-4" />
                    </Link>

                    <Link
                        href="/"
                        className="w-full bg-white border border-border py-3 px-6 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-gray-50 transition-all"
                    >
                        <Home className="h-4 w-4" />
                        Voltar ao início
                    </Link>
                </div>
            </div>
        </div>
    );
}
