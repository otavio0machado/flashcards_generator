import type { Metadata, Viewport } from "next";
import { Suspense } from "react";
import { Geist, Geist_Mono } from "next/font/google";
import Script from "next/script";
import "./globals.css";
import Navbar from "@/components/Navbar";
import { Toaster } from "sonner";
import AnalyticsProvider from "@/components/AnalyticsProvider";
import AnalyticsPageView from "@/components/AnalyticsPageView";
import BottomNav from "@/components/BottomNav";
import DesktopSidebar from "@/components/DesktopSidebar";
import { TauriProvider } from "@/lib/tauri";
import TauriConditionalComponents from "@/components/TauriConditionalComponents";
import TauriMainWrapper from "@/components/TauriMainWrapper";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://flashcards-generator.com";

export const viewport: Viewport = {
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#ffffff" },
    { media: "(prefers-color-scheme: dark)", color: "#0a0a0a" },
  ],
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
  viewportFit: "cover",
};

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: "Flashcards Generator - Crie Cards para Anki em Segundos",
  description: "Gere flashcards para Anki e Quizlet em segundos com nossa IA. Cole seu texto e pare de perder horas resumindo. Memorizacao rapida e eficiente.",
  keywords: ["Criar flashcards online", "Gerador Anki IA", "Estudar rapido", "Flashcards com inteligencia artificial"],
  manifest: "/manifest.json",
  appleWebApp: {
    capable: true,
    statusBarStyle: "default",
    title: "Flashcards",
  },
  formatDetection: {
    telephone: false,
  },
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
    icon: [
      { url: "/icons/favicon-32x32.png", sizes: "32x32", type: "image/png" },
      { url: "/icons/favicon-16x16.png", sizes: "16x16", type: "image/png" },
    ],
    apple: [
      { url: "/icons/apple-touch-icon.png", sizes: "180x180", type: "image/png" },
    ],
    other: [
      { rel: "mask-icon", url: "/favicon.svg", color: "#CC3F00" },
    ],
  },
  other: {
    "mobile-web-app-capable": "yes",
    "msapplication-TileColor": "#CC3F00",
    "msapplication-tap-highlight": "no",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="pt-BR" suppressHydrationWarning data-theme="light">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased noise-bg min-h-screen pt-16 pb-20 md:pb-0`}
      >
        <Script id="theme-init" strategy="beforeInteractive">
          {`(function() {
  try {
    var storedTheme = localStorage.getItem('theme');
    var hasStored = storedTheme === 'light' || storedTheme === 'dark';
    var systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    var theme = hasStored ? storedTheme : (systemDark ? 'dark' : 'light');
    var root = document.documentElement;
    root.classList.toggle('dark', theme === 'dark');
    root.setAttribute('data-theme', theme);
  } catch (e) { /* localStorage pode não estar disponível em alguns contextos */ }
})();`}
        </Script>
        <AnalyticsProvider>
          <TauriProvider>
            <Navbar />
            <DesktopSidebar />
            <Suspense fallback={null}>
              <AnalyticsPageView />
            </Suspense>
            <TauriMainWrapper>{children}</TauriMainWrapper>
            <BottomNav />
            <TauriConditionalComponents />
            <Toaster />
          </TauriProvider>
        </AnalyticsProvider>
      </body>
    </html>
  );
}
