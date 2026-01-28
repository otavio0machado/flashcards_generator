import { Metadata } from 'next';
import { Suspense } from 'react';
import GeneratorClient from './generator-client';
import CheckoutSuccessTracker from '@/components/CheckoutSuccessTracker';
import AppShell from '@/components/AppShell';

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
        <>
            <Suspense fallback={null}>
                <CheckoutSuccessTracker />
            </Suspense>

            <AppShell title="Gerador de Flashcards" subtitle="Transforme textos complexos em unidades de memorização simples.">
                <GeneratorClient />
            </AppShell>
        </>
    );
}
