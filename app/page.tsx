import Link from 'next/link';
import Image from 'next/image';
import {
  ArrowRight,
  FileText,
  Cpu,
  Download,
  CheckCircle2,
  Zap,
  Globe,
  Layout,
  HelpCircle,
  Plus,
  Check
} from 'lucide-react';

export default function Home() {
  return (
    <div className="flex flex-col min-h-screen">
      {/* Hero Section */}
      <section className="relative pt-20 pb-32 overflow-hidden">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="text-center">
            <h1 className="text-5xl md:text-7xl font-bold tracking-tight text-foreground mb-6 leading-tight">
              Gere Flashcards para <span className="text-brand">Anki</span> e Quizlet <br className="hidden md:block" /> em Segundos com IA
            </h1>
            <p className="text-xl text-foreground/70 max-w-3xl mx-auto mb-10 leading-relaxed font-medium">
              Pare de perder horas resumindo. Cole seu texto e deixe nossa Inteligência Artificial criar as perguntas e respostas perfeitas para sua memorização.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
              <Link
                href="/app"
                className="group bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg flex items-center gap-2"
              >
                Começar Agora — É Grátis
                <ArrowRight className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
              </Link>
              <Link
                href="/guia"
                className="bg-white border border-border text-foreground px-8 py-4 rounded-sm text-lg font-bold hover:bg-gray-50 transition-all flex items-center gap-2"
              >
                Ver Tutorial
              </Link>
            </div>

            <div className="mt-16 relative">
              <div className="absolute inset-0 flex items-center" aria-hidden="true">
                <div className="w-full border-t border-border"></div>
              </div>
              <div className="relative flex justify-center uppercase tracking-widest text-[10px] font-bold text-foreground/40">
                <span className="bg-[#FAFAFA] px-4">Compatível com as principais plataformas</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Como Funciona Section */}
      <section className="py-24 bg-white border-y border-border">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-20">
            <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-4">Como Funciona</h2>
            <p className="text-lg text-foreground/60 font-medium">Três passos para acelerar seu aprendizado.</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
            <div className="text-center">
              <div className="w-16 h-16 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-6">
                <FileText className="h-8 w-8 text-brand" />
              </div>
              <h3 className="text-xl font-bold mb-3">1. Cole seu conteúdo</h3>
              <p className="text-foreground/60 leading-relaxed">
                Insira textos, resumos ou documentos PDF diretamente no nosso gerador inteligente.
              </p>
            </div>

            <div className="text-center">
              <div className="w-16 h-16 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-6">
                <Cpu className="h-8 w-8 text-brand" />
              </div>
              <h3 className="text-xl font-bold mb-3">2. IA Processa Tudo</h3>
              <p className="text-foreground/60 leading-relaxed">
                Nossa IA analisa os pontos-chave e cria pares de Pergunta/Resposta otimizados para SRS.
              </p>
            </div>

            <div className="text-center">
              <div className="w-16 h-16 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-6">
                <Download className="h-8 w-8 text-brand" />
              </div>
              <h3 className="text-xl font-bold mb-3">3. Exporte e Estude</h3>
              <p className="text-foreground/60 leading-relaxed">
                Baixe seu deck para Anki (.apkg), Quizlet ou use nosso preview para estudar na hora.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Benefícios Grid */}
      <section className="py-24">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
            <div>
              <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-8">Otimizado para quem busca máxima eficiência</h2>
              <ul className="space-y-6">
                <li className="flex gap-4">
                  <div className="mt-1 flex-shrink-0">
                    <CheckCircle2 className="h-6 w-6 text-brand" />
                  </div>
                  <div>
                    <h4 className="font-bold text-lg">Compatível com Anki</h4>
                    <p className="text-foreground/60">Gere arquivos .csv ou .txt prontos para importação no Anki Desktop, AnkiDroid ou AnkiMobile.</p>
                  </div>
                </li>
                <li className="flex gap-4">
                  <div className="mt-1 flex-shrink-0">
                    <Zap className="h-6 w-6 text-brand" />
                  </div>
                  <div>
                    <h4 className="font-bold text-lg">Resumos Inteligentes</h4>
                    <p className="text-foreground/60">Não apenas copia o texto, mas reformula perguntas para garantir que você entenda o conceito.</p>
                  </div>
                </li>
                <li className="flex gap-4">
                  <div className="mt-1 flex-shrink-0">
                    <Globe className="h-6 w-6 text-brand" />
                  </div>
                  <div>
                    <h4 className="font-bold text-lg">Exportação Universal</h4>
                    <p className="text-foreground/60">Funciona perfeitamente com Quizlet, RemNote e outras ferramentas de repetição espaçada.</p>
                  </div>
                </li>
              </ul>
            </div>
            <div className="relative">
              <div className="aspect-square bg-white border border-border p-8 rounded-sm shadow-2xl relative overflow-hidden">
                <div className="absolute top-0 right-0 p-4">
                  <div className="bg-brand/5 px-3 py-1 rounded-sm text-[10px] font-bold text-brand uppercase tracking-wider border border-brand/10">Preview do Deck</div>
                </div>
                <div className="space-y-4 mt-8">
                  {[1, 2, 3].map((i) => (
                    <div key={i} className="p-4 bg-gray-50 border border-border rounded-sm">
                      <div className="text-[10px] font-bold text-foreground/40 uppercase mb-1">Pergunta #{i}</div>
                      <div className="h-3 w-3/4 bg-gray-200 rounded-full mb-3 animate-pulse"></div>
                      <div className="text-[10px] font-bold text-foreground/40 uppercase mb-1">Resposta</div>
                      <div className="h-3 w-1/2 bg-gray-200 rounded-full animate-pulse"></div>
                    </div>
                  ))}
                </div>
                <div className="absolute bottom-4 right-4 translate-y-12 blur-sm opacity-50 bg-brand/20 w-32 h-32 rounded-full -z-10"></div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Pricing Section */}
      <section id="pricing" className="py-24 bg-white border-y border-border">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-32">
            <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-4">Planos e Preços</h2>
            <p className="text-lg text-foreground/60 font-medium">Escolha o plano ideal para sua rotina de estudos.</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-end pt-10">
            {/* Free Plan */}
            <div className="bg-white border border-border p-8 rounded-sm shadow-sm flex flex-col h-full hover:border-foreground/20 transition-all">
              <div className="mb-8">
                <h3 className="text-xl font-bold mb-2">Básico</h3>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-4xl font-bold tracking-tighter">Grátis</span>
                </div>
                <p className="text-sm font-medium text-foreground/50">Para estudantes ocasionais.</p>
              </div>
              <ul className="space-y-4 mb-8 flex-1">
                <PricingItem text="3 gerações por dia" />
                <PricingItem text="Apenas Texto (Copy/Paste)" />
                <PricingItem text="Limite de 2.000 caracteres" />
                <PricingItem text="Exportação Anki" />
              </ul>
              <Link href="/app" className="w-full py-3 border border-border text-center font-bold text-sm rounded-sm hover:bg-gray-50 transition-all">
                Começar Grátis
              </Link>
            </div>

            {/* Pro Plan */}
            <div className="bg-white border-2 border-brand p-8 rounded-sm shadow-xl flex flex-col h-[110%] relative z-10 scale-105">
              <div className="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-brand text-white text-[10px] font-black uppercase tracking-widest px-4 py-1.5 rounded-full">
                Mais Popular
              </div>
              <div className="mb-8 pt-4">
                <h3 className="text-xl font-bold text-brand mb-2">Pro</h3>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-sm font-bold text-foreground/40">R$</span>
                  <span className="text-5xl font-bold tracking-tighter">29</span>
                  <span className="text-sm font-bold text-foreground/40">/mês</span>
                </div>
                <p className="text-sm font-medium text-foreground/50">Para vestibulandos e concurseiros.</p>
              </div>
              <ul className="space-y-4 mb-8 flex-1">
                <PricingItem text="50 gerações por dia" />
                <PricingItem text="Upload de PDF e DOCX" />
                <PricingItem text="Até 20.000 caracteres" />
                <PricingItem text="Histórico Salvo" />
                <PricingItem text="IA Otimizada" highlight />
              </ul>
              <Link href="/app" className="w-full py-4 bg-brand text-white text-center font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20">
                Assinar Pro
              </Link>
            </div>

            {/* Ultimate Plan */}
            <div className="bg-[#1A1A1A] border border-[#333] p-8 rounded-sm shadow-sm flex flex-col h-full text-white">
              <div className="mb-8">
                <h3 className="text-xl font-bold mb-2">Ultimate</h3>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-sm font-bold text-white/40">R$</span>
                  <span className="text-4xl font-bold tracking-tighter italic">59</span>
                  <span className="text-sm font-bold text-white/40">/mês</span>
                </div>
                <p className="text-sm font-medium text-white/50">Para heavy users e pesquisadores.</p>
              </div>
              <ul className="space-y-4 mb-8 flex-1">
                <PricingItem text="Gerações Ilimitadas" dark />
                <PricingItem text="Upload de Imagens (OCR)" dark />
                <PricingItem text="Até 100.000 caracteres" dark />
                <PricingItem text="Cards com Imagens" dark />
                <PricingItem text="Suporte Prioritário" dark />
              </ul>
              <Link href="/app" className="w-full py-3 bg-white text-[#1A1A1A] text-center font-bold text-sm rounded-sm hover:bg-white/90 transition-all">
                Ir para o Elite
              </Link>
            </div>
          </div>
        </div>
      </section>
      <section className="py-24 bg-white border-t border-border">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">Perguntas Frequentes</h2>
            <p className="text-foreground/60 font-medium">Tudo o que você precisa saber sobre o gerador.</p>
          </div>

          <div className="space-y-4">
            <FaqItem
              question="É gratuito?"
              answer="Sim! O Flashcards Generator oferece um plano gratuito para você começar a criar seus primeiros decks agora mesmo."
            />
            <FaqItem
              question="Funciona com arquivos PDF?"
              answer="Com certeza. Você pode copiar o texto do seu PDF e colá-lo em nosso gerador para um processamento instantâneo."
            />
            <FaqItem
              question="Como importar no Anki?"
              answer="Após gerar os cards, basta clicar em 'Exportar para Anki'. Você receberá um arquivo formatado que o Anki reconhece automaticamente."
            />
            <FaqItem
              question="A IA entende português?"
              answer="Sim, nossa IA é treinada para processar conteúdos complexos em português, mantendo a precisão técnica e gramatical."
            />
          </div>
        </div>
      </section>

      {/* Final CTA */}
      <section className="py-24 bg-brand text-white overflow-hidden relative">
        <div className="absolute -top-24 -right-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
          <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-8">Pronto para dominar qualquer conteúdo?</h2>
          <Link
            href="/app"
            className="inline-flex bg-white text-brand px-10 py-5 rounded-sm text-xl font-bold hover:bg-gray-50 transition-all shadow-xl"
          >
            Começar a Criar Agora
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-white border-t border-border py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row justify-between items-center gap-8">
            <div className="flex items-center gap-3">
              <Image
                src="/logo.png"
                alt="Icon"
                width={32}
                height={32}
                className="object-contain"
              />
              <span className="text-lg font-black tracking-tighter text-foreground whitespace-nowrap">
                Flashcards <span className="text-brand">Generator</span>
              </span>
            </div>

            <div className="flex gap-8 text-sm font-medium text-foreground/40">
              <Link href="/" className="hover:text-brand transition-colors">Início</Link>
              <Link href="/app" className="hover:text-brand transition-colors">App</Link>
              <Link href="/guia" className="hover:text-brand transition-colors">Guia de Importação</Link>
              <Link href="#" className="hover:text-brand transition-colors">Privacidade</Link>
            </div>

            <div className="text-sm text-foreground/40 font-medium font-mono uppercase tracking-widest">
              © 2026 Flashcards Generator.
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}

function PricingItem({ text, highlight, dark }: { text: string; highlight?: boolean; dark?: boolean }) {
  return (
    <li className="flex items-center gap-3">
      <div className={`shrink-0 w-5 h-5 rounded-full flex items-center justify-center ${dark ? 'bg-white/10' : 'bg-brand/10'}`}>
        <Check className={`h-3 w-3 ${dark ? 'text-white' : 'text-brand'}`} />
      </div>
      <span className={`text-sm font-medium ${highlight ? 'font-bold' : ''} ${dark ? 'text-white/80' : 'text-foreground/70'}`}>
        {text}
      </span>
    </li>
  );
}

function FaqItem({ question, answer }: { question: string; answer: string }) {
  return (
    <div className="border border-border rounded-sm bg-gray-50/50 overflow-hidden">
      <details className="group">
        <summary className="flex items-center justify-between p-6 cursor-pointer list-none">
          <span className="text-lg font-bold text-foreground leading-tight">{question}</span>
          <span className="bg-white border border-border p-1 rounded-sm group-open:rotate-45 transition-transform">
            <Plus className="h-5 w-5 text-brand" />
          </span>
        </summary>
        <div className="px-6 pb-6 text-foreground/70 leading-relaxed font-medium">
          {answer}
        </div>
      </details>
    </div>
  );
}

function Sparkles(props: any) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z" />
      <path d="M5 3v4" />
      <path d="M19 17v4" />
      <path d="M3 5h4" />
      <path d="M17 19h4" />
    </svg>
  );
}
