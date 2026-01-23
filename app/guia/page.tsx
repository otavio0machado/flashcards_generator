import { Metadata } from 'next';
import Link from 'next/link';
import {
    ArrowLeft,
    Monitor,
    Smartphone,
    Zap,
    Info,
    ChevronRight,
    Import,
    Check
} from 'lucide-react';

export const metadata: Metadata = {
    title: "Guia de Importação - Flashcards Generator",
    description: "Aprenda como importar seus flashcards gerados por IA no Anki, Quizlet e outras ferramentas.",
    openGraph: {
        title: "Guia de Importação - Flashcards Generator",
        description: "Aprenda como importar seus flashcards gerados por IA no Anki, Quizlet e outras ferramentas.",
        type: "article",
    }
};

export default function GuiaPage() {
    return (
        <div className="min-h-screen pb-24">
            {/* Article Header */}
            <header className="bg-white border-b border-border py-20 mb-16">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                    <Link href="/" className="inline-flex items-center gap-2 text-brand font-bold text-sm mb-8 hover:gap-3 transition-all">
                        <ArrowLeft className="h-4 w-4" />
                        Voltar para o Início
                    </Link>
                    <h1 className="text-4xl md:text-6xl font-bold tracking-tight text-foreground mb-6 leading-tight">
                        Como Importar seus <br className="hidden md:block" /> Decks no <span className="text-brand">Anki</span> e Quizlet
                    </h1>
                    <p className="text-xl text-foreground/60 font-medium leading-relaxed max-w-2xl">
                        Siga este guia visual para transferir os cards gerados por nossa IA para sua ferramenta de estudo favorita em menos de 2 minutos.
                    </p>
                </div>
            </header>

            <article className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                {/* Quick Nav */}
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-16">
                    <a href="#anki-desktop" className="p-4 bg-white border border-border rounded-sm hover:border-brand transition-all flex items-center justify-between group">
                        <span className="font-bold text-sm">Anki Desktop</span>
                        <ChevronRight className="h-4 w-4 text-foreground/20 group-hover:text-brand" />
                    </a>
                    <a href="#anki-mobile" className="p-4 bg-white border border-border rounded-sm hover:border-brand transition-all flex items-center justify-between group">
                        <span className="font-bold text-sm">AnkiDroid/iOS</span>
                        <ChevronRight className="h-4 w-4 text-foreground/20 group-hover:text-brand" />
                    </a>
                    <a href="#quizlet" className="p-4 bg-white border border-border rounded-sm hover:border-brand transition-all flex items-center justify-between group">
                        <span className="font-bold text-sm">Quizlet</span>
                        <ChevronRight className="h-4 w-4 text-foreground/20 group-hover:text-brand" />
                    </a>
                </div>

                {/* Section: Anki Desktop */}
                <section id="anki-desktop" className="mb-24 scroll-mt-24">
                    <div className="flex items-center gap-3 mb-8">
                        <div className="bg-brand/10 p-2 rounded-sm text-brand">
                            <Monitor className="h-6 w-6" />
                        </div>
                        <h2 className="text-3xl font-bold tracking-tight">Anki Desktop</h2>
                    </div>

                    <div className="space-y-12">
                        <div className="flex flex-col md:flex-row gap-8 items-start">
                            <div className="flex-1 space-y-4">
                                <div className="flex gap-4">
                                    <span className="bg-brand text-white w-6 h-6 rounded-full flex items-center justify-center shrink-0 text-xs font-bold">1</span>
                                    <p className="font-medium text-foreground/70">
                                        No gerador do Flashcards Generator, clique em <span className="text-brand font-bold">&quot;Exportar Anki (.txt)&quot;</span>.
                                    </p>
                                </div>
                                <div className="flex gap-4">
                                    <span className="bg-brand text-white w-6 h-6 rounded-full flex items-center justify-center shrink-0 text-xs font-bold">2</span>
                                    <p className="font-medium text-foreground/70">
                                        Abra o Anki no seu computador e clique no botão <span className="bg-gray-100 px-2 py-0.5 border border-border rounded text-xs font-bold">Importar Arquivo</span> na parte inferior.
                                    </p>
                                </div>
                            </div>

                            {/* Simulated UI: Anki Button */}
                            <div className="w-full md:w-72 bg-white border border-border p-6 rounded-sm shadow-sm relative overflow-hidden group">
                                <div className="flex gap-1 mb-4">
                                    <div className="w-2 h-2 rounded-full bg-red-400"></div>
                                    <div className="w-2 h-2 rounded-full bg-yellow-400"></div>
                                    <div className="w-2 h-2 rounded-full bg-green-400"></div>
                                </div>
                                <div className="h-20 bg-gray-50 flex items-center justify-center border border-dashed border-border mb-4">
                                    <span className="text-[10px] uppercase font-bold text-foreground/20">Seus Decks Aqui</span>
                                </div>
                                <div className="flex justify-center border-t border-border pt-4">
                                    <div className="bg-blue-50 border border-blue-200 px-3 py-1.5 rounded-sm flex items-center gap-2 scale-110 shadow-lg ring-4 ring-blue-500/10">
                                        <Import className="h-3 w-3 text-blue-600" />
                                        <span className="text-[10px] font-bold text-blue-600">Importar Arquivo</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="bg-brand/5 border-l-4 border-brand p-6">
                            <div className="flex gap-3">
                                <Info className="h-5 w-5 text-brand shrink-0" />
                                <div>
                                    <h4 className="font-bold text-brand mb-1">Dica de Configuração</h4>
                                    <p className="text-sm font-medium text-brand/80 leading-relaxed">
                                        Ao importar, certifique-se de que a opção &quot;Campos separados por:&quot; esteja definida como <span className="font-bold underline">Tabulação</span>. Nossa IA já formata o arquivo dessa maneira para garantir que a frente e o verso fiquem corretos.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Section: Anki Mobile */}
                <section id="anki-mobile" className="mb-24 scroll-mt-24">
                    <div className="flex items-center gap-3 mb-8">
                        <div className="bg-brand/10 p-2 rounded-sm text-brand">
                            <Smartphone className="h-6 w-6" />
                        </div>
                        <h2 className="text-3xl font-bold tracking-tight">AnkiDroid / iOS</h2>
                    </div>

                    <p className="text-lg text-foreground/60 font-medium mb-8">
                        A forma mais fácil de levar seus cards para o celular é através da sincronização do <span className="text-foreground font-bold underline">AnkiWeb</span>.
                    </p>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div className="bg-white border border-border p-8 rounded-sm">
                            <h3 className="font-bold mb-4 flex items-center gap-2">
                                <Check className="h-4 w-4 text-green-500" /> Passo 1
                            </h3>
                            <p className="text-sm font-medium text-foreground/60 leading-relaxed">
                                Após importar no Desktop, clique no botão <span className="font-bold text-brand">Sincronizar</span> (ou no ícone de nuvem) no topo da tela do Anki.
                            </p>
                        </div>
                        <div className="bg-white border border-border p-8 rounded-sm">
                            <h3 className="font-bold mb-4 flex items-center gap-2">
                                <Check className="h-4 w-4 text-green-500" /> Passo 2
                            </h3>
                            <p className="text-sm font-medium text-foreground/60 leading-relaxed">
                                No seu celular, abra o app e clique em <span className="font-bold text-brand">Sincronizar</span>. Faça login com a mesma conta e pronto!
                            </p>
                        </div>
                    </div>
                </section>

                {/* Section: Quizlet */}
                <section id="quizlet" className="mb-24 scroll-mt-24">
                    <div className="flex items-center gap-3 mb-8">
                        <div className="bg-brand/10 p-2 rounded-sm text-brand">
                            <Zap className="h-6 w-6" />
                        </div>
                        <h2 className="text-3xl font-bold tracking-tight">Quizlet</h2>
                    </div>

                    <div className="space-y-6">
                        <p className="text-lg text-foreground/60 font-medium">
                            O Quizlet permite criar listas instantaneamente usando a função de importação rápida.
                        </p>

                        <ol className="space-y-4">
                            <li className="flex items-start gap-4 p-4 hover:bg-white rounded-sm transition-colors group">
                                <div className="bg-gray-100 group-hover:bg-brand/10 w-8 h-8 rounded-sm flex items-center justify-center shrink-0 font-bold text-xs transition-colors group-hover:text-brand">1</div>
                                <div>
                                    <p className="font-bold">Crie uma nova &quot;Lista de Estudos&quot; no Quizlet.</p>
                                </div>
                            </li>
                            <li className="flex items-start gap-4 p-4 hover:bg-white rounded-sm transition-colors group">
                                <div className="bg-gray-100 group-hover:bg-brand/10 w-8 h-8 rounded-sm flex items-center justify-center shrink-0 font-bold text-xs transition-colors group-hover:text-brand">2</div>
                                <div>
                                    <p className="font-bold">Clique em <span className="text-brand">+ Importar</span> (geralmente abaixo do campo de título).</p>
                                </div>
                            </li>
                            <li className="flex items-start gap-4 p-4 hover:bg-white rounded-sm transition-colors group">
                                <div className="bg-gray-100 group-hover:bg-brand/10 w-8 h-8 rounded-sm flex items-center justify-center shrink-0 font-bold text-xs transition-colors group-hover:text-brand">3</div>
                                <div>
                                    <p className="font-bold">Copie os cards do nosso preview e cole na caixa de texto do Quizlet.</p>
                                </div>
                            </li>
                        </ol>
                    </div>
                </section>

                {/* Closing CTA */}
                <div className="border-t border-border pt-16 text-center">
                    <h2 className="text-3xl font-bold mb-6">Pronto para começar?</h2>
                    <Link href="/app" className="inline-flex bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg items-center gap-2">
                        Criar meu primeiro deck agora
                        <ArrowLeft className="h-5 w-5 rotate-180" />
                    </Link>
                </div>
            </article>

            {/* Structured Data for Google (Schema.js) */}
            <script
                type="application/ld+json"
                dangerouslySetInnerHTML={{
                    __html: JSON.stringify({
                        "@context": "https://schema.org",
                        "@type": "HowTo",
                        "name": "Como importar flashcards no Anki",
                        "step": [
                            {
                                "@type": "HowToStep",
                                "text": "Exportar deck formatado do Flashcards Generator"
                            },
                            {
                                "@type": "HowToStep",
                                "text": "Usar a função Importar no Anki Desktop"
                            },
                            {
                                "@type": "HowToStep",
                                "text": "Sincronizar com AnkiWeb para usar no mobile"
                            }
                        ]
                    }),
                }}
            />
        </div>
    );
}
