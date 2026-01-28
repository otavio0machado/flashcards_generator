import { Metadata } from 'next';
import HomeContent from '@/components/HomeContent';
import AppShell from '@/components/AppShell';
import { getHeroHeadline, getHeroSubtitle } from '@/lib/hero';

export const metadata: Metadata = {
  title: "Gerar Flashcards automaticamente (Anki)",
  description: "Cole seu texto e gere flashcards prontos para Anki em segundos. Prévia instantânea e exportação fácil.",
  keywords: ["Criar flashcards online", "Gerador Anki IA", "Estudar rápido", "Flashcards com inteligência artificial"],
  openGraph: {
    title: "Gerar Flashcards automaticamente (Anki)",
    description: "Cole seu texto e gere flashcards prontos para Anki em segundos.",
    type: "website",
    locale: "pt_BR",
    url: "https://flashcards-generator.com",
    siteName: "Flashcards Generator",
  },
  twitter: {
    card: "summary_large_image",
    title: "Gerar Flashcards automaticamente (Anki)",
    description: "Cole seu texto e gere flashcards prontos para Anki em segundos.",
  },
};

export default function Home() {
  const variant = process.env.NEXT_PUBLIC_HERO_VARIANT || 'A';
  const title = getHeroHeadline(variant);
  const subtitle = getHeroSubtitle(variant);

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "SoftwareApplication",
            "name": "Flashcards Generator",
            "applicationCategory": "EducationalApplication",
            "operatingSystem": "Web",
            "offers": {
              "@type": "Offer",
              "price": "0",
              "priceCurrency": "BRL"
            },
            "aggregateRating": {
              "@type": "AggregateRating",
              "ratingValue": "4.8",
              "ratingCount": "1250"
            }
          })
        }}
      />
      <AppShell title={title} subtitle={subtitle} titleClassName="text-4xl md:text-6xl font-black leading-tight">
        <HomeContent />
      </AppShell>
    </>
  );
}
