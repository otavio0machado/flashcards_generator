# Fase 4 – Distribuição e Marketing

Este documento consolida o planejamento de distribuição e marketing para o Flashcards Generator.

## 1. Planejamento de Conteúdo (Calendário Editorial - 4 Semanas)

**Objetivo:** Trazer tráfego qualificado e converter os primeiros pagantes.

### Semana 1: Conscientização e Problema
*Foco: Mostrar a dor de perder tempo criando flashcards manualmente.*

*   **Reddit (r/enem, r/concursos):**
    *   *Post:* "Quanto tempo vocês perdem passando limpo resumos para o Anki? Fiz um teste cronometrado." (Comparação manual vs. gerador).
*   **TikTok / YouTube Shorts:**
    *   *Ideia:* "POV: Você tem prova amanhã e 0 flashcards prontos." (Mostra o desespero e depois a solução rápida).
*   **Blog:**
    *   *Artigo:* "Flashcards Manuais vs. Automáticos: Qual método retém mais conteúdo em menos tempo?"

### Semana 2: Solução e Demonstração (Demo)
*Foco: Mostrar como a ferramenta funciona e a mágica acontecendo.*

*   **Reddit:**
    *   *Post:* "Criei uma ferramenta gratuita pra gerar decks do Anki a partir de PDFs/Textos. Alguém quer testar?" (Link para a demo gratuita).
*   **TikTok / YouTube Shorts:**
    *   *Ideia:* "Transformando um texto gigante de Biologia em perguntas de prova em 5 segundos." (Screen recording acelerado).
*   **Blog:**
    *   *Artigo:* "Como usar o Flashcards Generator para estudar Lei Seca para concursos."

### Semana 3: Prova Social e Benefícios
*Foco: Resultados e métodos de estudo.*

*   **Reddit:**
    *   *Post:* "Minha estratégia de revisão para Humanas usando IA + Anki." (Mini-caso de uso).
*   **TikTok / YouTube Shorts:**
    *   *Ideia:* "3 Dicas de estudo que salvaram meu semestre." (Dica 3 é usar o gerador para revisão ativa).
*   **Blog:**
    *   *Artigo:* "Depoimentos: Como estudantes de medicina estão economizando 10h por semana na criação de material."

### Semana 4: Urgência e Oferta (Conversão)
*Foco: Levar para o plano Pro/Ultimate.*

*   **Reddit:**
    *   *Post:* "Update da ferramenta: Agora aceita PDF e imagens (função nova)." (Focar nas features pagas/novas).
*   **TikTok / YouTube Shorts:**
    *   *Ideia:* "O segredo de quem passa em 1º lugar: Não perca tempo resumindo, perca tempo revisando." (Chamada direta para teste grátis).
*   **Blog:**
    *   *Artigo:* "5 Motivos para investir na versão Pro do Flashcards Generator."

---

## 2. Material de Divulgação (Script de Vídeo - 15s)

**Formato:** Vertical (TikTok/Reels/Shorts)
**Duração:** 15 segundos

| Tempo | Visual (O que aparece na tela) | Áudio / Legenda (Locução ou Texto na tela) |
| :--- | :--- | :--- |
| **00-03s** | (Close no rosto, expressão de cansaço/tédio) <br> Zoom out mostrando um livro/texto enorme e um caderno em branco. | **Áudio:** "Ainda perdendo horas resumindo texto na mão?" <br> **Texto:** *Resumindo na mão? 🤡* |
| **03-10s** | (Screen recording da tela do celular/PC) <br> 1. Copia o texto. <br> 2. Cola no Flashcards Generator. <br> 3. Clica "Gerar". <br> 4. Os cards aparecem magicamente. | **Áudio:** "Cole seu texto aqui e BOOM! A IA cria as perguntas e respostas pra você em segundos." <br> **Texto:** *Texto → Flashcards em 5s ⚡* |
| **10-15s** | (Mostra o deck exportado no Anki ou PDF pronto) <br> Corta para o site com botão "Testar Grátis". | **Áudio:** "Pare de resumir e comece a estudar. Teste grátis agora no link da bio!" <br> **Texto:** *Teste grátis agora 👇* |

---

## 3. Prova Social (Modelo de Depoimento)

**Template para o Site:**

Este modelo deve ser usado para coletar e exibir depoimentos na seção de "Quem usa aprova" (a ser criada).

**Estrutura de Dados (JSON):**

```json
{
  "nome": "Nome do Usuário",
  "ocupacao": "Estudante de [Curso] / Concurseiro",
  "foto_url": "/path/to/photo.jpg",
  "nota": 5, // 1 a 5 estrelas
  "texto": "Depoimento curto e direto focando no benefício de tempo.",
  "data": "DD/MM/AAAA"
}
```

**Exemplo Visual (Mockup do Texto):**

> **[Foto/Avatar]**
>
> **Julia M. - Estudante de Medicina**
> ⭐⭐⭐⭐⭐
>
> *"Antes eu levava 2 horas pra resumir um capítulo de Fisiologia. Com o Flashcards Generator, faço isso em 10 minutos e já começo a revisar no Anki. Salvou meu semestre!"*

**Sugestão de Implementação:**
Adicionar um carrossel ou grid de 3 colunas na Home Page, logo após a seção "Como funciona", para aumentar a confiança antes do Pricing.
