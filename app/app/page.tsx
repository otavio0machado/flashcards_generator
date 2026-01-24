import { Metadata } from 'next';
import { Suspense } from 'react';
import GeneratorClient from './generator-client';
import CheckoutSuccessTracker from '@/components/CheckoutSuccessTracker';

export const metadata: Metadata = {
    title: "Gerador de Flashcards IA - Área de Criação",
    description: "Cole seu conteúdo e gere flashcards instantaneamente. Exporte para Anki ou Quizlet.",
    openGraph: {
        title: "Gerador de Flashcards IA",
        description: "Crie flashcards instantaneamente com nossa Inteligência Artificial.",
        type: "website",
    }
};

export default function AppPage() {
    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 md:py-12">
            <Suspense fallback={null}>
                <CheckoutSuccessTracker />
            </Suspense>
            <header className="mb-10">
                <h1 className="text-3xl md:text-4xl font-bold tracking-tight text-foreground">Gerador de Flashcards</h1>
                <p className="text-foreground/60 font-medium mt-2">Transforme textos complexos em unidades de memorização simples.</p>
            </header>

            <GeneratorClient />
        </div>
    );
}
