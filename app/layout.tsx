import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/Navbar";
import { Toaster } from "sonner";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

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

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="pt-BR">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased noise-bg min-h-screen pt-16`}
      >
        <Navbar />
        <main>{children}</main>
        <Toaster />
      </body>
    </html>
  );
}
