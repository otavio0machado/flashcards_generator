import React from 'react';
import Link from 'next/link';
import { ArrowLeft, Shield } from 'lucide-react';
import { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Política de Privacidade - Flashcards Generator',
    description: 'Saiba como protegemos seus dados e sua privacidade no Flashcards Generator.',
};

export default function PrivacyPage() {
    return (
        <div className="min-h-screen bg-gray-50/50 py-20 px-4">
            <div className="max-w-3xl mx-auto bg-white border border-border rounded-sm p-8 md:p-12 shadow-sm">
                <Link
                    href="/"
                    className="inline-flex items-center gap-2 text-sm font-bold text-brand hover:gap-3 transition-all mb-10"
                >
                    <ArrowLeft className="h-4 w-4" /> Voltar para o Início
                </Link>

                <div className="flex items-center gap-4 mb-8">
                    <div className="w-12 h-12 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm text-brand">
                        <Shield className="h-6 w-6" />
                    </div>
                    <h1 className="text-4xl font-bold tracking-tight">Política de Privacidade</h1>
                </div>

                <div className="space-y-6 text-foreground/80 font-medium">
                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-2">O texto é armazenado?</h2>
                        <p>Não armazenamos o texto bruto do demo. Para usuários com conta, o texto e os cards podem ser salvos na sua biblioteca quando você escolhe salvar.</p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-2">Por quanto tempo?</h2>
                        <p>Cards salvos ficam na sua conta até você excluir. Logs técnicos e métricas são mantidos apenas pelo tempo necessário para operação e melhoria do serviço.</p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-2">Usa IA? Como?</h2>
                        <p>Sim. O conteúdo é processado por IA para gerar perguntas e respostas. Não treinamos modelos com o seu conteúdo.</p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-2">Como deletar dados?</h2>
                        <p>Você pode excluir decks na área de biblioteca. Para remoções completas, entre em contato via suporte.</p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-2">Pagamentos</h2>
                        <p>Pagamentos são processados pelo Stripe. Não armazenamos dados do cartão.</p>
                    </section>

                    <div className="pt-8 border-t border-border mt-8 text-foreground/40 text-xs text-center font-mono uppercase tracking-widest">
                        Última atualização: 25 de Janeiro de 2026
                    </div>
                </div>
            </div>
        </div>
    );
}
