import { Metadata } from 'next';
import HomeContent from '@/components/HomeContent';

export const metadata: Metadata = {
  title: "Flashcards Generator - Crie Cards para Anki em Segundos",
  description: "Gere flashcards para Anki e Quizlet em segundos com nossa IA. Cole seu texto e pare de perder horas resumindo. Memorização rápida e eficiente.",
  keywords: ["Criar flashcards online", "Gerador Anki IA", "Estudar rápido", "Flashcards com inteligência artificial"],
  openGraph: {
    title: "Flashcards Generator - Estude com Eficiência",
    description: "Crie decks de flashcards instantaneamente a partir de qualquer texto.",
    type: "website",
    locale: "pt_BR",
    url: "https://flashcards-generator.com",
    siteName: "Flashcards Generator",
  },
};

export default function Home() {
  return <HomeContent />;
}
