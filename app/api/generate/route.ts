import { NextResponse } from 'next/server';

export async function POST(req: Request) {
    try {
        const { text, plan, language } = await req.json();

        if (!text) {
            return NextResponse.json({ error: 'Texto é obrigatório' }, { status: 400 });
        }

        // Aqui você integraria com o Gemini ou OpenAI
        // Exemplo de como seria a chamada (comentado para evitar erro sem chave):
        /*
        const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', 'x-goog-api-key': process.env.GEMINI_API_KEY },
          body: JSON.stringify({
            contents: [{ parts: [{ text: `Gere flashcards para o seguinte texto: ${text}. Formato JSON: [{question: string, answer: string}]` }] }]
          })
        });
        */

        // Simulação de resposta da IA para fins de desenvolvimento
        const mockFlashcards = [
            {
                question: `O que o texto diz sobre "${text.substring(0, 20)}..."?`,
                answer: "Esta é uma resposta gerada automaticamente pela nossa IA de teste."
            },
            {
                question: "Como este conceito pode ser aplicado no dia a dia?",
                answer: "Através da prática constante e repetição espaçada facilitada pelo Anki."
            }
        ];

        return NextResponse.json({ cards: mockFlashcards });
    } catch (error) {
        console.error('Erro na geração:', error);
        return NextResponse.json({ error: 'Falha ao processar a requisição' }, { status: 500 });
    }
}
