import { Metadata } from "next";

export const metadata: Metadata = {
    title: {
        template: "%s | Flashcards Generator",
        default: "Acesso à Conta | Flashcards Generator",
    },
    description: "Faça login ou crie sua conta para gerenciar seus decks e criar novos flashcards automaticamente.",
};

export default function AuthLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
