'use client';

import React, { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import {
    Plus,
    Trash2,
    Download,
    Sparkles,
    Loader2,
    FileDown,
    ChevronDown,
    FileUp,
    AlertCircle,
    Check,
    Library
} from 'lucide-react';
import Toast, { ToastType } from '@/components/Toast';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { supabase } from '@/lib/supabase';
import { deckService } from '@/services/deckService';
import UpgradeModal from '@/components/UpgradeModal';
import { User } from '@supabase/supabase-js';

interface Flashcard {
    id: string;
    question: string;
    answer: string;
}

export default function GeneratorClient() {
    const router = useRouter();
    const [inputText, setInputText] = useState('');
    const [deckTitle, setDeckTitle] = useState('');
    const [cards, setCards] = useState<Flashcard[]>([]);
    const [isGenerating, setIsGenerating] = useState(false);
    const [currentPlan, setCurrentPlan] = useState<PlanKey>('free');
    const [showUpgradeModal, setShowUpgradeModal] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [user, setUser] = useState<User | null>(null);
    const [isSaving, setIsSaving] = useState(false);
    const [saveSuccess, setSaveSuccess] = useState(false);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);
    const [cardCount, setCardCount] = useState(5);

    const limits = PLAN_LIMITS[currentPlan];

    // Auth & Profile Check
    useEffect(() => {
        supabase.auth.getSession().then(({ data: { session } }) => {
            if (!session) {
                router.push('/auth/login');
                return;
            }
            setUser(session.user);
            deckService.checkUserLimit(session.user.id).then(res => {
                setCurrentPlan(res.planTier);
                // Ajustar cardCount inicial baseado no plano
                setCardCount(PLAN_LIMITS[res.planTier].maxCardsPerGen);
            }).catch(console.error);
        });
    }, [router]);

    // Check character limits on input
    useEffect(() => {
        if (inputText.length > limits.maxChars) {
            setError(`Limite do plano ${limits.name} atingido (${limits.maxChars} caracteres).`);
        } else {
            setError(null);
        }
    }, [inputText, limits]);

    const handleGenerate = async () => {
        if (!inputText.trim() || error || !user) return;

        setIsGenerating(true);

        try {
            const response = await fetch('/api/generate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    text: inputText,
                    plan: currentPlan,
                    language: 'pt-BR',
                    cardCount: cardCount
                })
            });

            const data = await response.json();

            if (data.error) throw new Error(data.error);

            const newCardsFormatted = data.cards.map((c: { question: string, answer: string }) => ({
                id: Math.random().toString(36).substr(2, 9),
                question: c.question,
                answer: c.answer
            }));

            setCards([...newCardsFormatted, ...cards]);

            // Uso já incrementado no servidor (API route)

            if (!deckTitle) {
                setDeckTitle(`Deck ${new Date().toLocaleDateString()}`);
            }
            setInputText('');
        } catch (err) {
            setError(err instanceof Error ? err.message : 'Erro ao gerar cards');
        } finally {
            setIsGenerating(false);
        }
    };

    const handleSaveLibrary = async () => {
        if (cards.length === 0 || !user || isSaving) return;

        if (!limits.historySaved) {
            setShowUpgradeModal(true);
            return;
        }

        setIsSaving(true);
        try {
            const title = deckTitle || `Deck ${new Date().toLocaleDateString()}`;
            const formattedCards = cards.map(c => ({ front: c.question, back: c.answer }));
            await deckService.saveDeck(user.id, title, formattedCards);
            setSaveSuccess(true);
            setToast({ message: 'Baralho salvo com sucesso!', type: 'success' });
            setTimeout(() => setSaveSuccess(false), 3000);
        } catch (err) {
            console.error(err);
            setToast({ message: 'Erro ao salvar baralho', type: 'error' });
        } finally {
            setIsSaving(false);
        }
    };

    const fileInputRef = React.useRef<HTMLInputElement>(null);

    const handleFileUpload = () => {
        if (!limits.allowFile) {
            setShowUpgradeModal(true);
            return;
        }
        fileInputRef.current?.click();
    };

    const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        if (file.type !== 'application/pdf' && file.type !== 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
            setToast({ message: 'Por favor, envie arquivos PDF ou DOCX.', type: 'error' });
            return;
        }

        setIsGenerating(true);
        try {
            let fullText = '';

            if (file.type === 'application/pdf') {
                const pdfjs = await import('pdfjs-dist');
                pdfjs.GlobalWorkerOptions.workerSrc = `https://cdn.jsdelivr.net/npm/pdfjs-dist@${pdfjs.version}/build/pdf.worker.min.mjs`;

                const arrayBuffer = await file.arrayBuffer();
                const pdf = await pdfjs.getDocument({ data: arrayBuffer }).promise;

                for (let i = 1; i <= pdf.numPages; i++) {
                    const page = await pdf.getPage(i);
                    const textContent = await page.getTextContent();
                    const pageText = textContent.items
                        .map((item) => (item as { str: string }).str)
                        .join(' ');
                    fullText += pageText + '\n\n';
                }
            } else {
                // Suporte DOCX com Mammoth
                const mammoth = await import('mammoth');
                const arrayBuffer = await file.arrayBuffer();
                const result = await mammoth.extractRawText({ arrayBuffer });
                fullText = result.value;
            }

            if (fullText.trim()) {
                setInputText(fullText);
                setToast({ message: 'Conteúdo extraído com sucesso!', type: 'success' });
            } else {
                setToast({ message: 'Não foi possível extrair texto do arquivo.', type: 'error' });
            }
        } catch (err) {
            console.error('Erro ao ler arquivo:', err);
            setToast({ message: 'Erro ao processar o arquivo.', type: 'error' });
        } finally {
            setIsGenerating(false);
            if (fileInputRef.current) {
                fileInputRef.current.value = '';
            }
        }
    };

    const deleteCard = (id: string) => {
        setCards(cards.filter(card => card.id !== id));
    };

    const updateCard = (id: string, field: 'question' | 'answer', value: string) => {
        setCards(cards.map(card =>
            card.id === id ? { ...card, [field]: value } : card
        ));
    };

    const exportToAnki = () => {
        const content = cards.map(c => `${c.question}\t${c.answer}`).join('\n');
        const blob = new Blob([content], { type: 'text/plain;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = `anki-deck-${Date.now()}.txt`;
        link.click();
    };

    const exportToCsv = () => {
        const header = "Question,Answer\n";
        const content = cards.map(c => `"${c.question.replace(/"/g, '""')}","${c.answer.replace(/"/g, '""')}"`).join('\n');
        const blob = new Blob([header + content], { type: 'text/csv;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'flashcards.csv';
        link.click();
    };

    if (!user) return <div className="h-64 flex items-center justify-center"><Loader2 className="h-8 w-8 animate-spin text-brand" /></div>;

    return (
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start relative pb-20">

            {/* Upgrade Modal */}
            {/* Upgrade Modal */}
            <UpgradeModal
                isOpen={showUpgradeModal}
                onClose={() => setShowUpgradeModal(false)}
            />

            {/* Coluna Esquerda: Input e Configs */}
            <div className="lg:col-span-5 space-y-6">
                <div className="bg-white border border-border p-6 rounded-sm shadow-sm lg:sticky lg:top-24">
                    <div className="flex items-center justify-between mb-4">
                        <div className="flex items-center gap-2">
                            <div className="bg-brand/10 p-1.5 rounded-sm">
                                <Sparkles className="h-4 w-4 text-brand" />
                            </div>
                            <h2 className="text-lg font-bold text-foreground">Entrada de Conteúdo</h2>
                        </div>
                        <div className={`text-[10px] font-black uppercase tracking-widest px-2 py-0.5 rounded-sm ${currentPlan === 'free' ? 'bg-gray-100 text-foreground/40' : 'bg-brand text-white'}`}>
                            Plano {limits.name}
                        </div>
                    </div>

                    <div className="relative">
                        <input
                            type="file"
                            ref={fileInputRef}
                            onChange={handleFileChange}
                            accept="application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                            className="hidden"
                        />
                        <label htmlFor="content-input" className="sr-only">Conteúdo para Flashcards</label>
                        <textarea
                            id="content-input"
                            value={inputText}
                            onChange={(e) => setInputText(e.target.value)}
                            placeholder="Cole seu texto, resumo ou notas aqui..."
                            className={`w-full h-80 p-4 pb-16 bg-gray-50 border rounded-sm focus:ring-1 outline-none transition-all resize-none font-medium text-foreground/80 placeholder:text-foreground/30 ${error ? 'border-red-500 focus:ring-red-500 bg-red-50/10' : 'border-border focus:ring-brand focus:border-brand'
                                }`}
                        />

                        {/* Status bar inside textarea */}
                        <div className="absolute bottom-4 left-4 right-4 flex flex-col sm:flex-row sm:items-center items-start sm:justify-between gap-2 text-[11px] font-bold">
                            <button
                                onClick={handleFileUpload}
                                className="flex items-center gap-1.5 text-brand hover:underline"
                            >
                                <FileUp className="h-3.5 w-3.5" />
                                Upload PDF
                            </button>
                            <span className={error ? 'text-red-500 animate-pulse' : 'text-foreground/40'}>
                                {inputText.length} / {limits.maxChars}
                            </span>
                        </div>
                    </div>

                    {error && (
                        <div className="mt-3 flex items-center gap-2 text-red-500 text-xs font-bold bg-red-50 p-2 border border-red-100 rounded-sm">
                            <AlertCircle className="h-4 w-4" />
                            {error}
                            <button onClick={() => setShowUpgradeModal(true)} className="ml-auto underline">Upgrade</button>
                        </div>
                    )}

                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-6">
                        <div>
                            <label htmlFor="difficulty-select" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Nível de Dificuldade</label>
                            <div className="relative text-foreground">
                                <select id="difficulty-select" className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer">
                                    <option>Iniciante</option>
                                    <option>Intermediário</option>
                                    <option>Avançado</option>
                                </select>
                                <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                            </div>
                        </div>
                        <div>
                            <label htmlFor="card-count" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Qtd. de Cards {limits.customCardCount ? '' : '(Limite)'}</label>
                            <div className="relative text-foreground">
                                {limits.customCardCount ? (
                                    <input
                                        id="card-count"
                                        type="number"
                                        min={1}
                                        max={limits.maxCardsPerGen}
                                        value={cardCount}
                                        onChange={(e) => setCardCount(Math.max(1, Math.min(limits.maxCardsPerGen, parseInt(e.target.value) || 1)))}
                                        className="w-full bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none cursor-pointer"
                                    />
                                ) : (
                                    <div className="w-full bg-gray-100 border border-border px-3 py-2 rounded-sm text-sm font-bold text-foreground/40 flex items-center justify-between">
                                        <span>{limits.maxCardsPerGen} cards</span>
                                        <button onClick={() => setShowUpgradeModal(true)} className="text-[10px] text-brand underline hover:text-brand/80">Upgrade</button>
                                    </div>
                                )}
                            </div>
                        </div>
                    </div>
                    <div className="mt-4">
                        <label htmlFor="language-select" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Idioma do Deck</label>
                        <div className="relative text-foreground">
                            <select id="language-select" className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer">
                                <option>Português</option>
                                <option>Inglês</option>
                                <option>Espanhol</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>

                    <button
                        onClick={handleGenerate}
                        disabled={isGenerating || !inputText.trim() || !!error}
                        className={`w-full mt-8 py-4 rounded-sm font-bold text-white transition-all flex items-center justify-center gap-2 shadow-lg ${isGenerating || !inputText.trim() || !!error
                            ? 'bg-gray-200 cursor-not-allowed text-gray-400 shadow-none'
                            : 'bg-brand hover:bg-brand/90'
                            }`}
                    >
                        {isGenerating ? (
                            <>
                                <Loader2 className="h-5 w-5 animate-spin" />
                                Processando...
                            </>
                        ) : (
                            <>
                                <Sparkles className="h-5 w-5" />
                                Gerar Flashcards
                            </>
                        )}
                    </button>
                </div>
            </div>

            {/* Coluna Direita: Preview dos Cards */}
            <div className="lg:col-span-7 space-y-6">
                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    <div className="flex items-center gap-2 flex-1">
                        {cards.length > 0 ? (
                            <>
                                <label htmlFor="deck-title-input" className="sr-only">Nome do Baralho</label>
                                <input
                                    id="deck-title-input"
                                    type="text"
                                    value={deckTitle}
                                    onChange={(e) => setDeckTitle(e.target.value)}
                                    className="text-xl font-bold tracking-tight text-foreground bg-transparent border-b border-dashed border-gray-300 focus:border-brand outline-none w-full max-w-sm placeholder:text-gray-400 pb-1"
                                    placeholder="Nome do seu baralho..."
                                />
                            </>
                        ) : (
                            <h2 className="text-xl font-bold tracking-tight text-foreground">
                                Preview dos Cards
                            </h2>
                        )}
                        {cards.length > 0 && <span className="text-brand font-bold text-lg">({cards.length})</span>}
                    </div>

                    {cards.length > 0 && (
                        <div className="flex flex-col sm:flex-row gap-2 w-full sm:w-auto">
                            <button
                                onClick={handleSaveLibrary}
                                disabled={isSaving || saveSuccess}
                                className={`w-full sm:w-auto flex items-center justify-center gap-2 border px-4 py-2 rounded-sm text-xs font-bold transition-all ${saveSuccess ? 'bg-green-50 border-green-200 text-green-600' : 'bg-white border-border hover:bg-gray-50 hover:border-brand/40 text-foreground shadow-sm hover:shadow-md'
                                    }`}
                            >
                                {isSaving ? <Loader2 className="h-4 w-4 animate-spin" /> : saveSuccess ? <Check className="h-4 w-4" /> : <Library className="h-4 w-4 text-brand" />}
                                {saveSuccess ? 'Salvo!' : 'Salvar na Biblioteca'}
                            </button>
                            <button
                                onClick={exportToAnki}
                                className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                            >
                                <FileDown className="h-4 w-4 text-brand" />
                                Anki (.txt)
                            </button>
                            <button
                                onClick={exportToCsv}
                                className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                            >
                                <Download className="h-4 w-4 text-brand" />
                                CSV
                            </button>
                        </div>
                    )}
                </div>

                {cards.length === 0 ? (
                    <div className="border-2 border-dashed border-border rounded-sm py-20 sm:py-32 flex flex-col items-center justify-center text-center px-4 bg-white/50">
                        <div className="bg-gray-100 p-4 rounded-full mb-4">
                            <Plus className="h-8 w-8 text-foreground/20" />
                        </div>
                        <p className="text-foreground/40 font-bold max-w-xs">
                            Nenhum card gerado ainda. Cole seu texto ao lado para começar.
                        </p>
                    </div>
                ) : (
                    <div className="grid grid-cols-1 gap-4 text-foreground">
                        {cards.map((card, index) => (
                            <div key={card.id} className="group bg-white border border-border rounded-sm hover:border-brand/40 transition-all p-5 shadow-sm relative overflow-hidden">
                                <div className="absolute top-0 right-0 p-3 opacity-0 group-hover:opacity-100 transition-opacity flex gap-1">
                                    <button
                                        onClick={() => deleteCard(card.id)}
                                        className="p-1.5 text-foreground/30 hover:text-red-500 hover:bg-red-50 rounded-sm transition-colors"
                                    >
                                        <Trash2 className="h-4 w-4" />
                                    </button>
                                </div>

                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div className="space-y-2">
                                        <label className="text-[10px] font-black uppercase tracking-widest text-brand">Pergunta #{index + 1}</label>
                                        <textarea
                                            value={card.question}
                                            onChange={(e) => updateCard(card.id, 'question', e.target.value)}
                                            className="w-full bg-transparent border border-transparent hover:border-border/50 focus:border-border focus:bg-white p-2 -ml-2 rounded-sm focus:ring-0 text-sm font-bold resize-none leading-relaxed text-foreground transition-all"
                                            rows={3}
                                        />
                                    </div>
                                    <div className="space-y-2 border-t md:border-t-0 md:border-l border-border pt-4 md:pt-0 md:pl-6 text-foreground">
                                        <label className="text-[10px] font-black uppercase tracking-widest text-foreground/30">Resposta</label>
                                        <textarea
                                            value={card.answer}
                                            onChange={(e) => updateCard(card.id, 'answer', e.target.value)}
                                            className="w-full bg-transparent border border-transparent hover:border-border/50 focus:border-border focus:bg-white p-2 -ml-2 rounded-sm focus:ring-0 text-sm font-medium text-foreground/80 resize-none leading-relaxed text-foreground transition-all"
                                            rows={3}
                                        />
                                    </div>
                                </div>
                            </div>
                        ))}

                        <button
                            onClick={() => setCards([...cards, { id: Math.random().toString(), question: 'Nova pergunta...', answer: 'Nova resposta...' }])}
                            className="w-full py-4 border-2 border-dashed border-border rounded-sm text-foreground/40 font-bold hover:border-brand/40 hover:text-brand transition-all flex items-center justify-center gap-2 mt-4"
                        >
                            <Plus className="h-5 w-5" />
                            Adicionar Card Manualmente
                        </button>
                    </div>
                )}
            </div>

            {toast && (
                <Toast
                    message={toast.message}
                    type={toast.type}
                    onClose={() => setToast(null)}
                />
            )}
        </div>
    );
}


