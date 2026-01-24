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
    Library,
    GripVertical,
    X
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
    question_image_url?: string | null;
    answer_image_url?: string | null;
}

type ImageDropTarget = {
    cardId: string;
    section: 'question' | 'answer';
};

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
    const [uploadedFiles, setUploadedFiles] = useState<File[]>([]);
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
    const [generateImages, setGenerateImages] = useState(false);
    const [imageCount, setImageCount] = useState(1);
    const [showImageWarningModal, setShowImageWarningModal] = useState(false);
    const [draggedImage, setDraggedImage] = useState<{ cardId: string; section: 'question' | 'answer'; imageUrl: string } | null>(null);
    const [dropTarget, setDropTarget] = useState<ImageDropTarget | null>(null);

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

    useEffect(() => {
        if (!limits.allowImageGeneration && generateImages) {
            setGenerateImages(false);
        }
    }, [limits.allowImageGeneration, generateImages]);

    const handleToggleImageGeneration = () => {
        if (!limits.allowImageGeneration) {
            setShowUpgradeModal(true);
            setToast({ message: 'Geracao de imagens disponivel apenas no plano Ultimate.', type: 'info' });
            return;
        }
        setGenerateImages((prev) => !prev);
    };

    const handleGenerateClick = () => {
        if (generateImages) {
            setShowImageWarningModal(true);
        } else {
            handleGenerate();
        }
    };

    const handleConfirmGenerate = () => {
        setShowImageWarningModal(false);
        handleGenerate();
    };

    const handleGenerate = async () => {
        const hasInput = inputText.trim().length > 0;
        const hasFiles = uploadedFiles.length > 0;

        if ((!hasInput && !hasFiles) || error || !user) return;

        setIsGenerating(true);
        const inputLength = inputText.length;

        try {
            const formData = new FormData();
            formData.append('text', inputText);
            formData.append('language', language);
            formData.append('difficulty', difficulty);
            formData.append('cardCount', cardCount.toString());
            formData.append('generateImages', generateImages ? 'true' : 'false');
            formData.append('imageCount', imageCount.toString());
            
            uploadedFiles.forEach(file => {
                formData.append('files', file);
            });

            const response = await fetch('/api/generate', {
                method: 'POST',
                body: formData
            });

            const data = await response.json();

            if (data.error) throw new Error(data.error);

            const newCardsFormatted = data.cards.map((c: {
                question: string;
                answer: string;
                image_url?: string | null;
                question_image_url?: string | null;
                answer_image_url?: string | null;
                user_image_index?: number;
                user_image_section?: 'question' | 'answer';
            }) => {
                let qImg = c.question_image_url ?? c.image_url ?? null;
                let aImg = c.answer_image_url ?? null;

                // Handle user uploaded image assignment
                if (c.user_image_index !== undefined && c.user_image_index >= 0 && c.user_image_index < uploadedFiles.length) {
                    const file = uploadedFiles[c.user_image_index];

                    if (IMAGE_MIME_TYPES.has(file.type)) {
                        const objectUrl = URL.createObjectURL(file);

                        if (c.user_image_section === 'question') {
                            qImg = objectUrl;
                        } else {
                            aImg = objectUrl;
                        }
                        if (!c.user_image_section) {
                            if (!aImg) aImg = objectUrl;
                        }
                    }
                }
                
                return {
                    id: Math.random().toString(36).substr(2, 9),
                    question: c.question,
                    answer: c.answer,
                    question_image_url: qImg,
                    answer_image_url: aImg
                };
            });

            setCards([...newCardsFormatted, ...cards]);

            if (!deckTitle) {
                setDeckTitle(`Deck ${new Date().toLocaleDateString()}`);
            }
            setInputText('');
            setUploadedFiles([]);
            if (data.imageGeneration?.failed) {
                setToast({
                    message: `Algumas imagens nao puderam ser geradas (${data.imageGeneration.failed}).`,
                    type: 'info'
                });
            }
            trackEvent('generate_cards_success', {
                plan: currentPlan,
                card_count: data.cards?.length,
                card_count_requested: cardCount,
                image_cards_requested: generateImages ? Math.min(cardCount, limits.maxImageCardsPerGen) : 0,
                image_cards_generated: data.imageGeneration?.generated ?? 0,
                input_chars: inputLength,
                language,
                difficulty,
                has_files: hasFiles,
                file_count: uploadedFiles.length,
            });
        } catch (err) {
            setError(err instanceof Error ? err.message : 'Erro ao gerar cards');
            trackEvent('generate_cards_failed', {
                plan: currentPlan,
                input_chars: inputLength,
                error: err instanceof Error ? err.message : 'unknown',
                image_cards_requested: generateImages ? Math.min(cardCount, limits.maxImageCardsPerGen) : 0,
                language,
                difficulty,
                has_files: hasFiles,
                file_count: uploadedFiles.length,
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
            const formattedCards = cards.map(c => ({
                front: c.question,
                back: c.answer,
                question_image_url: c.question_image_url,
                answer_image_url: c.answer_image_url
            }));
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
        const files = Array.from(e.target.files || []);
        if (files.length === 0) return;

        const newFiles = [...uploadedFiles];
        let docxCount = 0;

        for (const file of files) {
            const isPdf = file.type === PDF_MIME_TYPE;
            const isDocx = file.type === DOCX_MIME_TYPE;
            const isImage = IMAGE_MIME_TYPES.has(file.type);

            if (!isPdf && !isDocx && !isImage) {
                setToast({ message: `Arquivo ${file.name} ignorado. Formato inválido.`, type: 'error' });
                continue;
            }

            if (file.size > MAX_UPLOAD_BYTES) {
                setToast({ message: `Arquivo ${file.name} muito grande.`, type: 'error' });
                continue;
            }

            if (isImage && !limits.allowOCR) {
                setShowUpgradeModal(true);
                return;
            }

            if ((isPdf || isDocx) && !limits.allowFile) {
                setShowUpgradeModal(true);
                return;
            }

            if (isDocx) {
                docxCount++;
                setIsGenerating(true);
                try {
                    const mammoth = await import('mammoth');
                    const arrayBuffer = await file.arrayBuffer();
                    const result = await mammoth.extractRawText({ arrayBuffer });

                    if (result.value.trim()) {
                        setInputText(prev => prev + '\n\n' + result.value);
                    }
                } catch (err) {
                    console.error('Erro ao ler arquivo:', err);
                    setToast({ message: `Erro ao processar ${file.name}.`, type: 'error' });
                } finally {
                    setIsGenerating(false);
                }
            } else {
                newFiles.push(file);
            }
        }

        if (docxCount > 0) {
            setToast({ message: 'Conteúdo dos arquivos DOCX extraído!', type: 'success' });
        }
        
        setUploadedFiles(newFiles);
        
        const imageCount = newFiles.filter(f => IMAGE_MIME_TYPES.has(f.type)).length;
        const pdfCount = newFiles.filter(f => f.type === PDF_MIME_TYPE).length;

        if (imageCount > 0 || pdfCount > 0) {
             setToast({
                message: `${newFiles.length} arquivo(s) anexado(s).`,
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

    // Drag and drop handlers for images
    const handleImageDragStart = (e: React.DragEvent, cardId: string, section: 'question' | 'answer', imageUrl: string) => {
        e.dataTransfer.setData('application/json', JSON.stringify({ cardId, section, imageUrl }));
        e.dataTransfer.effectAllowed = 'move';
        setDraggedImage({ cardId, section, imageUrl });
    };

    const handleImageDragEnd = () => {
        setDraggedImage(null);
        setDropTarget(null);
    };

    const handleImageDragOver = (e: React.DragEvent, cardId: string, section: 'question' | 'answer') => {
        e.preventDefault();
        e.dataTransfer.dropEffect = 'move';
        setDropTarget({ cardId, section });
    };

    const handleImageDragLeave = () => {
        setDropTarget(null);
    };

    const handleImageDrop = (e: React.DragEvent, targetCardId: string, targetSection: 'question' | 'answer') => {
        e.preventDefault();
        const data = e.dataTransfer.getData('application/json');
        if (!data) return;

        try {
            const { cardId: sourceCardId, section: sourceSection, imageUrl } = JSON.parse(data);

            // If dropping on the same position, do nothing
            if (sourceCardId === targetCardId && sourceSection === targetSection) {
                setDropTarget(null);
                setDraggedImage(null);
                return;
            }

            setCards(prevCards => {
                return prevCards.map(card => {
                    // Remove image from source
                    if (card.id === sourceCardId) {
                        if (sourceSection === 'question') {
                            card = { ...card, question_image_url: null };
                        } else {
                            card = { ...card, answer_image_url: null };
                        }
                    }
                    // Add image to target
                    if (card.id === targetCardId) {
                        if (targetSection === 'question') {
                            card = { ...card, question_image_url: imageUrl };
                        } else {
                            card = { ...card, answer_image_url: imageUrl };
                        }
                    }
                    return card;
                });
            });

            setToast({ message: 'Imagem movida com sucesso!', type: 'success' });
        } catch (err) {
            console.error('Error parsing drag data:', err);
        }

        setDropTarget(null);
        setDraggedImage(null);
    };

    const removeImage = (cardId: string, section: 'question' | 'answer') => {
        setCards(prevCards => prevCards.map(card => {
            if (card.id === cardId) {
                if (section === 'question') {
                    return { ...card, question_image_url: null };
                } else {
                    return { ...card, answer_image_url: null };
                }
            }
            return card;
        }));
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
                    cards: cards.map((card) => ({
                        question: card.question,
                        answer: card.answer,
                        question_image_url: card.question_image_url,
                        answer_image_url: card.answer_image_url
                    }))
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
                    </div>multiple
                            

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

                    {uploadedFiles.length > 0 && (
                        <div className="mt-3 space-y-2">
                             {uploadedFiles.map((file, idx) => (
                                <div key={idx} className="flex items-center justify-between text-xs font-bold bg-gray-50 border border-border rounded-sm px-3 py-2">
                                    <div className="flex items-center gap-2 min-w-0">
                                        <span className="text-brand">Anexo {idx + 1}:</span>
                                        <span className="truncate text-foreground/70">{file.name}</span>
                                    </div>
                                    <button
                                        type="button"
                                        onClick={() => setUploadedFiles(prev => prev.filter((_, i) => i !== idx))}
                                        className="text-[10px] uppercase tracking-wider text-foreground/40 hover:text-brand transition-colors"
                                    >
                                        Remover
                                    </button>
                                </div>
                             ))}
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
                                    <option value="Intermediário">Intermediário</option>
                                    <option value="Avançado">Avançado</option>
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
                                <option value="Português">Português</option>
                                <option value="Inglês">Inglês</option>
                                <option value="Espanhol">Espanhol</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div className="mt-4">
                        <div className={`flex items-center justify-between gap-3 border rounded-sm px-3 py-2 ${limits.allowImageGeneration ? 'bg-gray-50 border-border' : 'bg-gray-100 border-border/60'}`}>
                            <label className={`flex items-center gap-3 text-xs font-bold ${limits.allowImageGeneration ? 'text-foreground' : 'text-foreground/40'}`}>
                                <input
                                    type="checkbox"
                                    checked={generateImages}
                                    onChange={handleToggleImageGeneration}
                                    className="h-4 w-4 accent-brand"
                                    aria-disabled={!limits.allowImageGeneration}
                                />
                                Gerar imagens para os cards
                            </label>
                            <span className={`text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded-sm ${limits.allowImageGeneration ? 'bg-brand/10 text-brand' : 'bg-gray-200 text-foreground/40'}`}>
                                Ultimate
                            </span>
                        </div>
                        {generateImages && limits.allowImageGeneration && (
                            <div className="mt-3 flex items-center gap-3">
                                <label className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                    Quantidade de imagens:
                                </label>
                                <select
                                    value={imageCount}
                                    onChange={(e) => setImageCount(Number(e.target.value))}
                                    className="appearance-none bg-gray-50 border border-border px-3 py-1.5 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none cursor-pointer"
                                >
                                    {Array.from({ length: limits.maxImageCardsPerGen }, (_, i) => i + 1).map((num) => (
                                        <option key={num} value={num}>{num}</option>
                                    ))}
                                </select>
                            </div>
                        )}
                        <p className="text-[10px] text-foreground/40 mt-2">
                            {limits.allowImageGeneration
                                ? `Ate ${limits.maxImageCardsPerGen} imagens por geracao.`
                                : 'Disponivel no Ultimate.'}
                        </p>
                        {generateImages && limits.allowImageGeneration && (
                            <div className="mt-3 p-3 bg-amber-50 border border-amber-200 rounded-sm">
                                <p className="text-[11px] text-amber-800 font-medium leading-relaxed">
                                    <span className="font-bold">⚡ Recurso Premium:</span> A geração de imagens por IA utiliza tecnologia avançada (DALL-E 3) com custo elevado por imagem. 
                                    Use de forma consciente, priorizando cards que realmente se beneficiam de recursos visuais, como diagramas, anatomia, mapas e conceitos abstratos.
                                </p>
                            </div>
                        )}
                    </div>

                    <button
                        onClick={handleGenerateClick}
                        disabled={isGenerating || !!error || (!inputText.trim() && uploadedFiles.length === 0)}
                        className={`w-full mt-8 py-4 rounded-sm font-bold text-white transition-all flex items-center justify-center gap-2 shadow-lg ${isGenerating || !!error || (!inputText.trim() && uploadedFiles.length === 0)
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
                                    {/* Seção Pergunta */}
                                    <div
                                        className={`space-y-2 rounded-sm transition-all ${dropTarget?.cardId === card.id && dropTarget?.section === 'question' ? 'bg-brand/5 ring-2 ring-brand/30 ring-dashed p-2 -m-2' : ''}`}
                                        onDragOver={(e) => handleImageDragOver(e, card.id, 'question')}
                                        onDragLeave={handleImageDragLeave}
                                        onDrop={(e) => handleImageDrop(e, card.id, 'question')}
                                    >
                                        <label className="text-[10px] font-black uppercase tracking-widest text-brand">Pergunta #{index + 1}</label>
                                        {card.question_image_url ? (
                                            <div className="relative group/img w-full">
                                                <img
                                                    src={card.question_image_url}
                                                    alt={`Imagem da pergunta ${index + 1}`}
                                                    className="w-full h-40 object-cover rounded-sm border border-border cursor-grab active:cursor-grabbing"
                                                    draggable
                                                    onDragStart={(e) => handleImageDragStart(e, card.id, 'question', card.question_image_url!)}
                                                    onDragEnd={handleImageDragEnd}
                                                    onError={() => removeImage(card.id, 'question')}
                                                />
                                                <div className="absolute top-2 right-2 flex gap-1 opacity-0 group-hover/img:opacity-100 transition-opacity">
                                                    <div className="bg-black/60 text-white p-1.5 rounded-sm cursor-grab">
                                                        <GripVertical className="h-3.5 w-3.5" />
                                                    </div>
                                                    <button
                                                        onClick={() => removeImage(card.id, 'question')}
                                                        className="bg-red-500/90 hover:bg-red-600 text-white p-1.5 rounded-sm transition-colors"
                                                        title="Remover imagem"
                                                    >
                                                        <X className="h-3.5 w-3.5" />
                                                    </button>
                                                </div>
                                                <p className="text-[9px] text-foreground/40 mt-1 text-center">Arraste para mover</p>
                                            </div>
                                        ) : (
                                            <div
                                                className={`w-full h-20 border-2 border-dashed rounded-sm flex items-center justify-center text-xs text-foreground/30 transition-all ${draggedImage ? 'border-brand/40 bg-brand/5' : 'border-border'}`}
                                            >
                                                {draggedImage ? 'Solte aqui' : 'Arraste uma imagem aqui'}
                                            </div>
                                        )}
                                        <textarea
                                            value={card.question}
                                            onChange={(e) => updateCard(card.id, 'question', e.target.value)}
                                            className="w-full bg-transparent border border-transparent hover:border-border/50 focus:border-border focus:bg-white p-2 -ml-2 rounded-sm focus:ring-0 text-sm font-bold resize-none leading-relaxed text-foreground transition-all"
                                            rows={3}
                                        />
                                    </div>

                                    {/* Seção Resposta */}
                                    <div
                                        className={`space-y-2 border-t md:border-t-0 md:border-l border-border pt-4 md:pt-0 md:pl-6 text-foreground rounded-sm transition-all ${dropTarget?.cardId === card.id && dropTarget?.section === 'answer' ? 'bg-brand/5 ring-2 ring-brand/30 ring-dashed p-2 -m-2' : ''}`}
                                        onDragOver={(e) => handleImageDragOver(e, card.id, 'answer')}
                                        onDragLeave={handleImageDragLeave}
                                        onDrop={(e) => handleImageDrop(e, card.id, 'answer')}
                                    >
                                        <label className="text-[10px] font-black uppercase tracking-widest text-foreground/30">Resposta</label>
                                        {card.answer_image_url ? (
                                            <div className="relative group/img w-full">
                                                <img
                                                    src={card.answer_image_url}
                                                    alt={`Imagem da resposta ${index + 1}`}
                                                    className="w-full h-40 object-cover rounded-sm border border-border cursor-grab active:cursor-grabbing"
                                                    draggable
                                                    onDragStart={(e) => handleImageDragStart(e, card.id, 'answer', card.answer_image_url!)}
                                                    onDragEnd={handleImageDragEnd}
                                                    onError={() => removeImage(card.id, 'answer')}
                                                />
                                                <div className="absolute top-2 right-2 flex gap-1 opacity-0 group-hover/img:opacity-100 transition-opacity">
                                                    <div className="bg-black/60 text-white p-1.5 rounded-sm cursor-grab">
                                                        <GripVertical className="h-3.5 w-3.5" />
                                                    </div>
                                                    <button
                                                        onClick={() => removeImage(card.id, 'answer')}
                                                        className="bg-red-500/90 hover:bg-red-600 text-white p-1.5 rounded-sm transition-colors"
                                                        title="Remover imagem"
                                                    >
                                                        <X className="h-3.5 w-3.5" />
                                                    </button>
                                                </div>
                                                <p className="text-[9px] text-foreground/40 mt-1 text-center">Arraste para mover</p>
                                            </div>
                                        ) : (
                                            <div
                                                className={`w-full h-20 border-2 border-dashed rounded-sm flex items-center justify-center text-xs text-foreground/30 transition-all ${draggedImage ? 'border-brand/40 bg-brand/5' : 'border-border'}`}
                                            >
                                                {draggedImage ? 'Solte aqui' : 'Arraste uma imagem aqui'}
                                            </div>
                                        )}
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
                            onClick={() => setCards([...cards, { id: Math.random().toString(), question: 'Nova pergunta...', answer: 'Nova resposta...', question_image_url: null, answer_image_url: null }])}
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

            {/* Modal de aviso sobre geração de imagens */}
            {showImageWarningModal && (
                <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
                    <div className="bg-white rounded-sm shadow-xl max-w-md w-full p-6">
                        <div className="flex items-center gap-3 mb-4">
                            <div className="bg-amber-100 p-2 rounded-full">
                                <AlertCircle className="h-6 w-6 text-amber-600" />
                            </div>
                            <h3 className="text-lg font-bold text-foreground">Funcionalidade em Desenvolvimento</h3>
                        </div>
                        <p className="text-foreground/70 mb-6">
                            A geração de imagens ainda está em desenvolvimento e pode apresentar <strong>lentidão</strong> durante o processo.
                        </p>
                        <p className="text-foreground font-medium mb-6">
                            Você deseja continuar mesmo assim?
                        </p>
                        <div className="flex flex-col sm:flex-row gap-3">
                            <button
                                onClick={() => setShowImageWarningModal(false)}
                                className="flex-1 px-4 py-3 border border-border rounded-sm font-bold text-foreground/70 hover:bg-gray-50 transition-colors"
                            >
                                Não, vou testar depois
                            </button>
                            <button
                                onClick={handleConfirmGenerate}
                                className="flex-1 px-4 py-3 bg-brand text-white rounded-sm font-bold hover:bg-brand/90 transition-colors"
                            >
                                Sim, desejo prosseguir
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}


