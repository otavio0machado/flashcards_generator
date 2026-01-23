import React from 'react';
import Link from 'next/link';
import { ArrowLeft, FileText } from 'lucide-react';
import { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Termos de Uso - Flashcards Generator',
    description: 'Leia os termos e condições de uso do Flashcards Generator.',
};

export default function TermsPage() {
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
                        <FileText className="h-6 w-6" />
                    </div>
                    <h1 className="text-4xl font-bold tracking-tight">Termos de Uso</h1>
                </div>

                <div className="prose prose-slate max-w-none font-medium text-foreground/80 leading-relaxed space-y-8">
                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">1. Aceitação dos Termos</h2>
                        <p>
                            Ao acessar ao site Flashcards Generator, você concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis ​​e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum destes termos, está proibido de usar ou acessar este site.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">2. Uso de Licença</h2>
                        <p>
                            É concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no site Flashcards Generator, apenas para visualização transitória pessoal e não comercial.
                        </p>
                        <p className="mt-4">Esta licença não permite que você:</p>
                        <ul className="list-disc pl-5 mt-2 space-y-2 text-foreground/70">
                            <li>Modificar ou copiar os materiais;</li>
                            <li>Usar os materiais para qualquer finalidade comercial ou para exibição pública;</li>
                            <li>Tentar descompilar ou fazer engenharia reversa de qualquer software contido no site Flashcards Generator;</li>
                            <li>Remover quaisquer direitos autorais ou outras notações de propriedade dos materiais.</li>
                        </ul>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">3. Isenção de Responsabilidade</h2>
                        <p>
                            Os materiais no site da Flashcards Generator são fornecidos 'como estão'. Flashcards Generator não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">4. Limitações</h2>
                        <p>
                            Em nenhum caso o Flashcards Generator ou seus fornecedores serão responsáveis ​​por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Flashcards Generator.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">5. Assinaturas e Pagamentos</h2>
                        <p>
                            Oferecemos planos gratuitos e pagos (Pro e Ultimate). Os pagamentos são processados pelo Stripe. Ao assinar um plano pago, você concorda com as taxas e ciclos de faturamento especificados no momento da compra. Pedidos de reembolso serão analisados individualmente.
                        </p>
                    </section>

                    <div className="pt-8 border-t border-border mt-12 text-foreground/40 text-xs text-center font-mono uppercase tracking-widest">
                        Última atualização: 23 de Janeiro de 2026
                    </div>
                </div>
            </div>
        </div>
    );
}
