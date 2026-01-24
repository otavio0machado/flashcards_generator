export const dynamic = 'force-static';

export default function DocumentacaoPage() {
  return (
    <div className="min-h-screen bg-white">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
        <div className="mb-12">
          <span className="inline-flex items-center gap-2 text-[10px] font-black uppercase tracking-widest text-brand bg-brand/10 px-3 py-1 rounded-sm">
            Documentacao
          </span>
          <h1 className="text-3xl sm:text-4xl font-black text-foreground mt-4">
            Como os processos de IA funcionam
          </h1>
          <p className="text-foreground/60 mt-3 text-base sm:text-lg">
            Esta pagina explica, de forma transparente, como o gerador utiliza IA para criar flashcards, imagens e organizar anexos.
          </p>
        </div>

        <div className="space-y-10">
          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">1) Entrada de conteudo</h2>
            <ul className="mt-3 text-sm text-foreground/70 space-y-2 list-disc pl-5">
              <li>Texto colado no campo principal.</li>
              <li>Arquivos PDF e DOCX (texto e estrutura).</li>
              <li>Imagens enviadas (diagramas, fotos, esquemas) para serem usadas como apoio visual.</li>
            </ul>
            <p className="mt-4 text-sm text-foreground/60">
              O sistema combina essas fontes para criar perguntas e respostas consistentes e alinhadas ao nivel de dificuldade escolhido.
            </p>
          </section>

          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">2) Geracao dos flashcards</h2>
            <p className="mt-3 text-sm text-foreground/70">
              A IA analisa o conteudo fornecido e gera exatamente a quantidade de cards solicitada. Cada card tem:
            </p>
            <ul className="mt-3 text-sm text-foreground/70 space-y-2 list-disc pl-5">
              <li>Pergunta clara e direta.</li>
              <li>Resposta concisa e objetiva.</li>
              <li>Idioma e nivel de dificuldade configurados no app.</li>
            </ul>
          </section>

          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">3) Uso de imagens enviadas</h2>
            <p className="mt-3 text-sm text-foreground/70">
              Se voce enviar imagens junto com um prompt de texto, a IA tenta encaixar cada imagem em um card que faca sentido.
            </p>
            <ul className="mt-3 text-sm text-foreground/70 space-y-2 list-disc pl-5">
              <li>Se a pergunta for "O que e isto?", a imagem vai para a Pergunta.</li>
              <li>Se a resposta explicar um diagrama, a imagem vai para a Resposta.</li>
              <li>Se nenhuma imagem se encaixar, ela nao e usada automaticamente.</li>
            </ul>
          </section>

          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">4) Geracao de imagens pela IA</h2>
            <p className="mt-3 text-sm text-foreground/70">
              Quando a opcao de gerar imagens esta ativada, a IA cria ilustrações educativas baseadas no conteudo dos cards.
              Essas imagens sao adicionadas automaticamente aos primeiros cards gerados (respeitando o limite do plano).
            </p>
          </section>

          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">5) Ajustes manuais e UX</h2>
            <ul className="mt-3 text-sm text-foreground/70 space-y-2 list-disc pl-5">
              <li>Voce pode editar perguntas e respostas livremente.</li>
              <li>Arraste imagens entre Pergunta e Resposta, ou entre cards.</li>
              <li>Remova imagens que nao sejam relevantes para o estudo.</li>
            </ul>
          </section>

          <section className="bg-white border border-border rounded-sm p-6 shadow-sm">
            <h2 className="text-lg font-bold text-foreground">6) Privacidade e seguranca</h2>
            <p className="mt-3 text-sm text-foreground/70">
              Os dados enviados sao usados exclusivamente para gerar os flashcards solicitados. O sistema aplica filtros
              para reduzir instrucoes maliciosas embutidas no conteudo enviado.
            </p>
          </section>
        </div>
      </div>
    </div>
  );
}
