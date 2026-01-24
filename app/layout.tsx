import type { Metadata } from "next";
import { Suspense } from "react";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/Navbar";
import { Toaster } from "sonner";
import AnalyticsProvider from "@/components/AnalyticsProvider";
import AnalyticsPageView from "@/components/AnalyticsPageView";
import FeedbackWidget from "@/components/FeedbackWidget";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://flashcards-generator.com";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: "Flashcards Generator - Crie Cards para Anki em Segundos",
  description: "Gere flashcards para Anki e Quizlet em segundos com nossa IA. Cole seu texto e pare de perder horas resumindo. Memorizacao rapida e eficiente.",
  keywords: ["Criar flashcards online", "Gerador Anki IA", "Estudar rapido", "Flashcards com inteligencia artificial"],
  openGraph: {
    title: "Flashcards Generator - Estude com Eficiencia",
    description: "Crie decks de flashcards instantaneamente a partir de qualquer texto.",
    type: "website",
    locale: "pt_BR",
    url: siteUrl,
    siteName: "Flashcards Generator",
    images: [
      {
        url: "/opengraph-image",
        width: 1200,
        height: 630,
        alt: "Flashcards Generator",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Flashcards Generator - Estude com Eficiencia",
    description: "Crie decks de flashcards instantaneamente a partir de qualquer texto.",
    images: ["/opengraph-image"],
  },
  icons: {
    icon: "/favicon.svg",
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
        <AnalyticsProvider>
          <Navbar />
          <Suspense fallback={null}>
            <AnalyticsPageView />
          </Suspense>
          <main>{children}</main>
          <FeedbackWidget />
          <Toaster />
        </AnalyticsProvider>
      </body>
    </html>
  );
}
