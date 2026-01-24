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
import { trackEvent } from '@/lib/analytics';

interface Flashcard {
    id: string;
    question: string;
    answer: string;
}

const IMAGE_MIME_TYPES = new Set([
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/webp',
    'image/heic',
    'image/heif',
]);
const PDF_MIME_TYPE = 'application/pdf';
const DOCX_MIME_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
const MAX_UPLOAD_BYTES = 20 * 1024 * 1024;
const MAX_UPLOAD_MB = Math.floor(MAX_UPLOAD_BYTES / (1024 * 1024));

export default function GeneratorClient() {
    const router = useRouter();
    const [inputText, setInputText] = useState('');
    const [uploadedFile, setUploadedFile] = useState<File | null>(null);
    const [deckTitle, setDeckTitle] = useState('');
    const [deckDescription, setDeckDescription] = useState('');
    const [deckTagsInput, setDeckTagsInput] = useState('');
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
    const [language, setLanguage] = useState('Português');
    const [difficulty, setDifficulty] = useState('Intermediário');
    const [isExportingApkg, setIsExportingApkg] = useState(false);

    const limits = PLAN_LIMITS[currentPlan];
    const fileAccept = limits.allowOCR
        ? 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document,image/jpeg,image/jpg,image/png,image/webp,image/heic,image/heif'
        : 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    const uploadLabel = limits.allowOCR ? 'Upload PDF/DOCX ou Imagem' : 'Upload PDF/DOCX';

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
        const hasInput = inputText.trim().length > 0;
        const fileInfo = uploadedFile;

        if ((!hasInput && !fileInfo) || error || !user) return;

        setIsGenerating(true);
        const inputLength = inputText.length;

        try {
            const formData = new FormData();
            formData.append('text', inputText);
            formData.append('language', language);
            formData.append('difficulty', difficulty);
            formData.append('cardCount', cardCount.toString());
            if (fileInfo) {
                formData.append('files', fileInfo);
            }

            const response = await fetch('/api/generate', {
                method: 'POST',
                body: formData
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
            setUploadedFile(null);
            trackEvent('generate_cards_success', {
                plan: currentPlan,
                card_count: data.cards?.length,
                card_count_requested: cardCount,
                input_chars: inputLength,
                language,
                difficulty,
                has_file: !!fileInfo,
                file_type: fileInfo?.type,
                file_size: fileInfo?.size,
            });
        } catch (err) {
            setError(err instanceof Error ? err.message : 'Erro ao gerar cards');
            trackEvent('generate_cards_failed', {
                plan: currentPlan,
                input_chars: inputLength,
                error: err instanceof Error ? err.message : 'unknown',
                language,
                difficulty,
                has_file: !!fileInfo,
                file_type: fileInfo?.type,
                file_size: fileInfo?.size,
            });
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
            const tags = parseTags(deckTagsInput);
            const description = deckDescription.trim();
            await deckService.saveDeck(user.id, title, formattedCards, {
                tags,
                description: description || undefined
            });
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
        if (!limits.allowFile && !limits.allowOCR) {
            setShowUpgradeModal(true);
            return;
        }
        fileInputRef.current?.click();
    };

    const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        const isPdf = file.type === PDF_MIME_TYPE;
        const isDocx = file.type === DOCX_MIME_TYPE;
        const isImage = IMAGE_MIME_TYPES.has(file.type);

        if (!isPdf && !isDocx && !isImage) {
            setToast({ message: 'Por favor, envie arquivos PDF, DOCX ou imagens (JPG/PNG/WEBP/HEIC).', type: 'error' });
            return;
        }

        if (file.size > MAX_UPLOAD_BYTES) {
            setToast({ message: `Arquivo muito grande. Limite de ${MAX_UPLOAD_MB}MB.`, type: 'error' });
            return;
        }

        if (isImage && !limits.allowOCR) {
            setShowUpgradeModal(true);
            setToast({ message: 'Imagens estão disponíveis apenas no plano Ultimate.', type: 'error' });
            return;
        }

        if ((isPdf || isDocx) && !limits.allowFile) {
            setShowUpgradeModal(true);
            setToast({ message: 'Upload de arquivos disponível apenas nos planos Pro e Ultimate.', type: 'error' });
            return;
        }

        if (isDocx) {
            setIsGenerating(true);
            try {
                const mammoth = await import('mammoth');
                const arrayBuffer = await file.arrayBuffer();
                const result = await mammoth.extractRawText({ arrayBuffer });

                if (result.value.trim()) {
                    setInputText(result.value);
                    setToast({ message: 'Conteúdo extraído com sucesso!', type: 'success' });
                } else {
                    setToast({ message: 'Não foi possível extrair texto do arquivo.', type: 'error' });
                }
            } catch (err) {
                console.error('Erro ao ler arquivo:', err);
                setToast({ message: 'Erro ao processar o arquivo.', type: 'error' });
            } finally {
                setIsGenerating(false);
            }
            setUploadedFile(null);
        } else {
            setUploadedFile(file);
            setToast({
                message: isImage
                    ? 'Imagem anexada. Clique em "Gerar Flashcards" para processar.'
                    : 'PDF anexado. Clique em "Gerar Flashcards" para processar.',
                type: 'success'
            });
        }

        if (fileInputRef.current) {
            fileInputRef.current.value = '';
        }
    };

    const parseTags = (value: string) => {
        const rawTags = value
            .split(',')
            .map((tag) => tag.trim())
            .filter(Boolean);

        const seen = new Set<string>();
        const normalized: string[] = [];

        for (const tag of rawTags) {
            const key = tag.toLowerCase();
            if (!seen.has(key)) {
                seen.add(key);
                normalized.push(key);
            }
        }

        return normalized.slice(0, 10);
    };

    const deleteCard = (id: string) => {
        setCards(cards.filter(card => card.id !== id));
    };

    const updateCard = (id: string, field: 'question' | 'answer', value: string) => {
        setCards(cards.map(card =>
            card.id === id ? { ...card, [field]: value } : card
        ));
    };

    const getSafeFileName = (title: string) => {
        return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';
    };

    const exportToApkg = async () => {
        if (cards.length === 0 || isExportingApkg) return;
        setIsExportingApkg(true);
        try {
            const response = await fetch('/api/export/anki', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    title: deckTitle || `Deck ${new Date().toLocaleDateString()}`,
                    cards: cards.map((card) => ({ question: card.question, answer: card.answer }))
                })
            });

            if (!response.ok) {
                const errorData = await response.json().catch(() => ({}));
                throw new Error(errorData.error || 'Erro ao exportar .apkg');
            }

            const blob = await response.blob();
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.download = `${getSafeFileName(deckTitle || 'deck')}.apkg`;
            link.click();
            URL.revokeObjectURL(url);
        } catch (err) {
            console.error(err);
            setToast({ message: 'Erro ao exportar .apkg', type: 'error' });
        } finally {
            setIsExportingApkg(false);
        }
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
                            accept={fileAccept}
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
                                {uploadLabel}
                            </button>
                            <span className={error ? 'text-red-500 animate-pulse' : 'text-foreground/40'}>
                                {inputText.length} / {limits.maxChars}
                            </span>
                        </div>
                    </div>

                    {uploadedFile && (
                        <div className="mt-3 flex items-center justify-between text-xs font-bold bg-gray-50 border border-border rounded-sm px-3 py-2">
                            <div className="flex items-center gap-2 min-w-0">
                                <span className="text-brand">Arquivo anexado:</span>
                                <span className="truncate text-foreground/70">{uploadedFile.name}</span>
                            </div>
                            <button
                                type="button"
                                onClick={() => setUploadedFile(null)}
                                className="text-[10px] uppercase tracking-wider text-foreground/40 hover:text-brand transition-colors"
                            >
                                Remover
                            </button>
                        </div>
                    )}

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
                                <select
                                    id="difficulty-select"
                                    value={difficulty}
                                    onChange={(event) => setDifficulty(event.target.value)}
                                    className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                                >
                                    <option value="Iniciante">Iniciante</option>
                                    <option value="Intermedi?rio">Intermedi?rio</option>
                                    <option value="Avan?ado">Avan?ado</option>
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
                            <select
                                id="language-select"
                                value={language}
                                onChange={(event) => setLanguage(event.target.value)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="Portugu?s">Portugu?s</option>
                                <option value="Ingl?s">Ingl?s</option>
                                <option value="Espanhol">Espanhol</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>

                    <button
                        onClick={handleGenerate}
                        disabled={isGenerating || !!error || (!inputText.trim() && !uploadedFile)}
                        className={`w-full mt-8 py-4 rounded-sm font-bold text-white transition-all flex items-center justify-center gap-2 shadow-lg ${isGenerating || !!error || (!inputText.trim() && !uploadedFile)
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
                                onClick={exportToApkg}
                                disabled={isExportingApkg}
                                className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md disabled:opacity-60 disabled:cursor-not-allowed"
                            >
                                {isExportingApkg ? <Loader2 className="h-4 w-4 animate-spin" /> : <FileDown className="h-4 w-4 text-brand" />}
                                Anki (.apkg)
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

                {cards.length > 0 && (
                    <div className="bg-white border border-border rounded-sm p-4 shadow-sm space-y-4">
                        <div className="space-y-1">
                            <label htmlFor="deck-description" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                Descrição (opcional)
                            </label>
                            <textarea
                                id="deck-description"
                                value={deckDescription}
                                onChange={(event) => setDeckDescription(event.target.value)}
                                rows={2}
                                className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground/80 focus:ring-1 focus:ring-brand outline-none resize-none"
                                placeholder="Sobre o que é este baralho?"
                            />
                        </div>
                        <div className="space-y-1">
                            <label htmlFor="deck-tags" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                Tags (separadas por vírgulas)
                            </label>
                            <input
                                id="deck-tags"
                                type="text"
                                value={deckTagsInput}
                                onChange={(event) => setDeckTagsInput(event.target.value)}
                                className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground/80 focus:ring-1 focus:ring-brand outline-none"
                                placeholder="ex: biologia, enem, citologia"
                            />
                        </div>
                    </div>
                )}

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


