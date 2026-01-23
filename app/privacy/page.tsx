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

                <div className="prose prose-slate max-w-none font-medium text-foreground/80 leading-relaxed space-y-8">
                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">1. Introdução</h2>
                        <p>
                            A sua privacidade é importante para nós. É política do Flashcards Generator respeitar a sua privacidade em relação a qualquer informação sua que possamos coletar no site Flashcards Generator, e outros sites que possuímos e operamos.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">2. Coleta de Dados</h2>
                        <p>
                            Solicitamos informações pessoais apenas quando realmente precisamos delas para lhe fornecer um serviço. Fazemo-lo por meios justos e legais, com o seu conhecimento e consentimento. Também informamos por que estamos coletando e como será usado.
                        </p>
                        <ul className="list-disc pl-5 mt-4 space-y-2 text-foreground/70">
                            <li><strong>E-mail:</strong> Coletamos seu e-mail para criação de conta e autenticação via Supabase.</li>
                            <li><strong>Dados de Pagamento:</strong> Processados de forma segura pelo Stripe. Não armazenamos os detalhes do seu cartão em nossos servidores.</li>
                            <li><strong>Conteúdo:</strong> Os textos que você insere para gerar flashcards são processados via IA para fornecer o serviço solicitado.</li>
                        </ul>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">3. Retenção de Dados</h2>
                        <p>
                            Apenas retemos as informações coletadas pelo tempo necessário para fornecer o serviço solicitado. Quando armazenamos dados, os protegemos dentro de meios comercialmente aceitáveis para evitar perdas e roubos, bem como acesso, divulgação, cópia, uso ou modificação não autorizados.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">4. Cookies</h2>
                        <p>
                            Utilizamos cookies para melhorar sua experiência, manter sua sessão ativa e entender como você utiliza nossa plataforma. Você pode optar por desativar os cookies nas configurações do seu navegador, embora isso possa afetar algumas funcionalidades do site.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-foreground mb-4">5. Seus Direitos</h2>
                        <p>
                            Você é livre para recusar a nossa solicitação de informações pessoais, entendendo que talvez não possamos fornecer alguns dos serviços desejados. O uso continuado de nosso site será considerado como aceitação de nossas práticas em torno de privacidade e informações pessoais.
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
