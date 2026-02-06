'use client';

import React, { useState, useEffect, useRef } from 'react';
import { gzip } from 'pako';
import Toast, { ToastType } from '@/components/Toast';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { supabase } from '@/lib/supabase';
import { getApiUrl } from '@/lib/api-config';
import { deckService } from '@/services/deckService';
import UpgradeModal from '@/components/UpgradeModal';
import AuthGateModal from '@/components/AuthGateModal';
import { User } from '@supabase/supabase-js';
import { trackEvent } from '@/lib/analytics';
import { TextInputSection } from '@/components/generator/TextInputSection';
import { FileUploadSection } from '@/components/generator/FileUploadSection';
import { CardList } from '@/components/generator/CardList';
import { GeneratorActions } from '@/components/generator/GeneratorActions';
import type { Flashcard, PdfPreview, PdfPagePreview, ImageDropTarget } from '@/components/generator/types';

declare global {
    interface Window {
        turnstile?: {
            render: (container: HTMLElement, options: { sitekey: string; size: 'invisible'; callback: (token: string) => void }) => string;
            execute: (widgetId: string) => void;
        };
    }
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

const ENEM_EXAMPLE_TEXT = `No Brasil, o Exame Nacional do Ensino Médio (ENEM) avalia competências e habilidades dos estudantes ao final da educação básica. Além de medir o domínio de conteúdos, o ENEM busca avaliar a capacidade de interpretar textos, resolver problemas e aplicar conhecimentos em situações reais. Isso incentiva um ensino mais contextualizado e interdisciplinar. As provas incluem Linguagens, Ciências Humanas, Ciências da Natureza e Matemática, além da redação, que exige argumentação clara, coesão e proposta de intervenção para um problema social.`;

export default function GeneratorClient() {
    const [inputText, setInputText] = useState('');
    const [uploadedFiles, setUploadedFiles] = useState<File[]>([]);
    const [pdfPreviews, setPdfPreviews] = useState<PdfPreview[]>([]);
    const [deckTitle, setDeckTitle] = useState('');
    const [deckDescription, setDeckDescription] = useState('');
    const [deckTagsInput, setDeckTagsInput] = useState('');
    const [cards, setCards] = useState<Flashcard[]>([]);
    const [isGenerating, setIsGenerating] = useState(false);
    const [currentPlan, setCurrentPlan] = useState<PlanKey>('free');
    const [showUpgradeModal, setShowUpgradeModal] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [user, setUser] = useState<User | null>(null);
    const [isDemo, setIsDemo] = useState(true);
    const [isAuthChecked, setIsAuthChecked] = useState(false);
    const [isSaving, setIsSaving] = useState(false);
    const [saveSuccess, setSaveSuccess] = useState(false);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);
    const [cardCount, setCardCount] = useState(5);
    const [language, setLanguage] = useState('Português');
    const [difficulty, setDifficulty] = useState('Intermediário');
    const [studyLevel, setStudyLevel] = useState<'ENEM' | 'Faculdade' | 'Concurso'>('ENEM');
    const [studyGoal, setStudyGoal] = useState<'Memorizar' | 'Revisar rápido' | 'Aprofundar'>('Memorizar');
    const [cardStyle, setCardStyle] = useState<'basic' | 'short_answer' | 'image_occlusion'>('basic');
    const [templateType, setTemplateType] = useState<string>('');
    const [recentTexts, setRecentTexts] = useState<string[]>([]);
    const [selectedIntent, setSelectedIntent] = useState<string | null>(null);
    const [stats, setStats] = useState<{ cardsWeek: number; decksToday: number } | null>(null);
    const [isExportingApkg, setIsExportingApkg] = useState(false);
    const [savedDeckId, setSavedDeckId] = useState<string | null>(null);
    const [savedDeckPublic, setSavedDeckPublic] = useState(false);
    const [publishingPublic, setPublishingPublic] = useState(false);
    const [generateImages, setGenerateImages] = useState(false);
    const [imageCount, setImageCount] = useState(1);
    const [showImageWarningModal, setShowImageWarningModal] = useState(false);
    const [draggedImage, setDraggedImage] = useState<{ cardId: string; section: 'question' | 'answer'; imageUrl: string } | null>(null);
    const [dropTarget, setDropTarget] = useState<ImageDropTarget | null>(null);
    const [showAuthGateModal, setShowAuthGateModal] = useState(false);
    const [appOpenTracked, setAppOpenTracked] = useState(false);
    const [demoInputStarted, setDemoInputStarted] = useState(false);
    const [demoFingerprint, setDemoFingerprint] = useState('');
    const [captchaRequired, setCaptchaRequired] = useState(false);
    const [pendingDemoText, setPendingDemoText] = useState<string | null>(null);
    const [signupModalAction, setSignupModalAction] = useState(false);
    const [enemMode, setEnemMode] = useState(false);
    const [selectedFolder, setSelectedFolder] = useState('');
    const captchaContainerRef = useRef<HTMLDivElement | null>(null);
    const captchaWidgetIdRef = useRef<string | null>(null);
    const objectUrlsRef = useRef<Set<string>>(new Set());
    const pdfDocsRef = useRef<Map<string, any>>(new Map());
    const pdfjsRef = useRef<any>(null);
    const fileInputRef = React.useRef<HTMLInputElement>(null);

    const getFileId = (file: File) => `${file.name}-${file.size}-${file.lastModified}`;

    // Cleanup object URLs when component unmounts
    useEffect(() => {
        return () => {
            objectUrlsRef.current.forEach(url => {
                try { URL.revokeObjectURL(url); } catch { /* already revoked */ }
            });
            objectUrlsRef.current.clear();
            pdfDocsRef.current.clear();
            pdfjsRef.current = null;
        };
    }, []);

    // --- PDF preview logic ---
    const renderPdfPage = async (fileId: string, pageNumber: number) => {
        const doc = pdfDocsRef.current.get(fileId);
        if (!doc) return;
        const preview = pdfPreviews.find((item) => item.fileId === fileId);
        const page = preview?.pages.find((item) => item.pageNumber === pageNumber);
        if (!page || page.dataUrl || page.isRendering) return;

        setPdfPreviews((prev) =>
            prev.map((item) => {
                if (item.fileId !== fileId) return item;
                const pages = item.pages.map((pageItem) =>
                    pageItem.pageNumber === pageNumber ? { ...pageItem, isRendering: true } : pageItem
                );
                return { ...item, pages };
            })
        );

        try {
            const pageDoc = await doc.getPage(pageNumber);
            const viewport = pageDoc.getViewport({ scale: 0.25 });
            const canvas = document.createElement('canvas');
            const context = canvas.getContext('2d');
            if (!context) return;
            canvas.width = Math.floor(viewport.width);
            canvas.height = Math.floor(viewport.height);
            await pageDoc.render({ canvasContext: context, viewport }).promise;
            const dataUrl = canvas.toDataURL('image/png');

            setPdfPreviews((prev) =>
                prev.map((item) => {
                    if (item.fileId !== fileId) return item;
                    const pages = item.pages.map((pageItem) =>
                        pageItem.pageNumber === pageNumber
                            ? { ...pageItem, dataUrl, width: canvas.width, height: canvas.height, isRendering: false }
                            : pageItem
                    );
                    return { ...item, pages };
                })
            );
        } catch (err) {
            console.error('Erro ao renderizar página PDF:', err);
            setPdfPreviews((prev) =>
                prev.map((item) => {
                    if (item.fileId !== fileId) return item;
                    const pages = item.pages.map((pageItem) =>
                        pageItem.pageNumber === pageNumber ? { ...pageItem, isRendering: false } : pageItem
                    );
                    return { ...item, pages };
                })
            );
        }
    };

    useEffect(() => {
        const pdfFileIds = new Set(
            uploadedFiles.filter((file) => file.type === PDF_MIME_TYPE).map(getFileId)
        );
        setPdfPreviews((prev) => prev.filter((preview) => pdfFileIds.has(preview.fileId)));
    }, [uploadedFiles]);

    useEffect(() => {
        let isCancelled = false;

        const buildPdfPreview = async (file: File) => {
            const fileId = getFileId(file);
            setPdfPreviews((prev) => {
                if (prev.some((item) => item.fileId === fileId)) return prev;
                return [...prev, { fileId, fileName: file.name, pageCount: 0, pages: [], selectedPages: [], isLoading: true }];
            });

            try {
                if (!pdfjsRef.current) {
                    const pdfjsModule = await import('pdfjs-dist/legacy/build/pdf.mjs');
                    if (pdfjsModule.GlobalWorkerOptions && !pdfjsModule.GlobalWorkerOptions.workerSrc) {
                        pdfjsModule.GlobalWorkerOptions.workerSrc = new URL(
                            'pdfjs-dist/legacy/build/pdf.worker.min.mjs',
                            import.meta.url
                        ).toString();
                    }
                    pdfjsRef.current = pdfjsModule;
                }

                const arrayBuffer = await file.arrayBuffer();
                const loadingTask = pdfjsRef.current.getDocument({ data: new Uint8Array(arrayBuffer) });
                const pdf = await loadingTask.promise;
                const pageCount = pdf.numPages;
                pdfDocsRef.current.set(fileId, pdf);

                const pages: PdfPagePreview[] = Array.from({ length: pageCount }, (_, idx) => ({
                    pageNumber: idx + 1
                }));

                if (isCancelled) return;

                setPdfPreviews((prev) =>
                    prev.map((preview) =>
                        preview.fileId === fileId
                            ? { ...preview, pageCount, pages, selectedPages: Array.from({ length: pageCount }, (_, idx) => idx + 1), isLoading: false }
                            : preview
                    )
                );
            } catch (err) {
                if (isCancelled) return;
                console.error('Erro ao gerar preview PDF:', err);
                setPdfPreviews((prev) =>
                    prev.map((preview) =>
                        preview.fileId === fileId
                            ? { ...preview, isLoading: false, error: 'Falha ao carregar preview do PDF.' }
                            : preview
                    )
                );
            }
        };

        const pdfFiles = uploadedFiles.filter((file) => file.type === PDF_MIME_TYPE);
        const knownIds = new Set(pdfPreviews.map((preview) => preview.fileId));
        const newFiles = pdfFiles.filter((file) => !knownIds.has(getFileId(file)));

        if (newFiles.length > 0) {
            newFiles.forEach((file) => { if (!isCancelled) buildPdfPreview(file); });
        }

        return () => { isCancelled = true; };
    }, [uploadedFiles, pdfPreviews]);

    // --- Plan limits ---
    const demoLimits = {
        ...PLAN_LIMITS.free,
        name: 'Demo',
        dailyGens: 1,
        historySaved: false,
        allowFile: false,
        allowOCR: false,
        allowImageGeneration: false,
        customCardCount: false,
    };

    const limits = isDemo ? demoLimits : PLAN_LIMITS[currentPlan];
    const fileAccept = limits.allowOCR
        ? 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document,image/jpeg,image/jpg,image/png,image/webp,image/heic,image/heif'
        : 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    const uploadLabel = limits.allowOCR ? 'Upload PDF/DOCX ou Imagem' : 'Upload PDF/DOCX';

    // --- Auth & Profile Check ---
    useEffect(() => {
        supabase.auth.getSession().then(({ data: { session } }) => {
            if (!session) {
                setUser(null); setIsDemo(true); setCurrentPlan('free');
                setCardCount(demoLimits.maxCardsPerGen); setIsAuthChecked(true);
                return;
            }
            setUser(session.user); setIsDemo(false);
            deckService.checkUserLimit(session.user.id).then(res => {
                setCurrentPlan(res.planTier);
                setCardCount(PLAN_LIMITS[res.planTier].maxCardsPerGen);
            }).catch(console.error).finally(() => setIsAuthChecked(true));
        });
    }, []);

    useEffect(() => {
        if (isDemo && inputText.trim().length > 0 && inputText.trim().length < 200) {
            setError('Cole um conteúdo maior (mín. 200 caracteres).'); return;
        }
        if (inputText.length > limits.maxChars) {
            setError(`Limite do plano ${limits.name} atingido (${limits.maxChars} caracteres).`);
        } else { setError(null); }
    }, [inputText, limits]);

    useEffect(() => {
        if (!limits.allowImageGeneration && generateImages) setGenerateImages(false);
    }, [limits.allowImageGeneration, generateImages]);

    useEffect(() => {
        if (isAuthChecked && !appOpenTracked) {
            trackEvent('app_open', { is_demo: isDemo }); setAppOpenTracked(true);
        }
    }, [appOpenTracked, isDemo, isAuthChecked]);

    useEffect(() => {
        if (typeof window === 'undefined') return;
        const stored = window.localStorage.getItem('demo_fingerprint');
        if (stored) { setDemoFingerprint(stored); return; }
        const newFp = crypto.randomUUID();
        window.localStorage.setItem('demo_fingerprint', newFp); setDemoFingerprint(newFp);
    }, []);

    useEffect(() => {
        if (typeof window === 'undefined') return;
        const storedRecent = window.localStorage.getItem('recent_texts');
        if (storedRecent) {
            try {
                const parsed = JSON.parse(storedRecent);
                if (Array.isArray(parsed)) setRecentTexts(parsed.slice(0, 3));
            } catch { setRecentTexts([]); }
        }
        const storedIntent = window.localStorage.getItem('demo_intent');
        if (storedIntent) setSelectedIntent(storedIntent);
    }, []);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await fetch(getApiUrl('api/stats'));
                if (!response.ok) return;
                const data = await response.json();
                setStats({ cardsWeek: Number(data?.cardsWeek || 0), decksToday: Number(data?.decksToday || 0) });
            } catch { setStats(null); }
        };
        fetchStats();
    }, []);

    useEffect(() => {
        if (!captchaRequired) return;
        const siteKey = process.env.NEXT_PUBLIC_TURNSTILE_SITE_KEY;
        if (!siteKey || typeof window === 'undefined' || window.turnstile) return;
        const script = document.createElement('script');
        script.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit';
        script.async = true; script.defer = true;
        document.body.appendChild(script);
        return () => { document.body.removeChild(script); };
    }, [captchaRequired]);

    useEffect(() => {
        if (isDemo && uploadedFiles.length > 0) setUploadedFiles([]);
    }, [isDemo, uploadedFiles.length]);

    // --- Callbacks ---
    const openAuthGate = (reason?: string) => {
        setSignupModalAction(false); setShowAuthGateModal(true);
        trackEvent('paywall_viewed', { reason, is_demo: true });
        trackEvent('signup_view', { source: reason || 'demo', is_demo: true });
    };

    const handleToggleImageGeneration = () => {
        if (isDemo) { openAuthGate('demo_image_generation'); return; }
        if (!limits.allowImageGeneration) {
            setShowUpgradeModal(true);
            setToast({ message: 'Geracao de imagens disponivel apenas no plano Ultimate.', type: 'info' }); return;
        }
        setGenerateImages((prev) => !prev);
    };

    const handleGenerateClick = () => {
        if (isDemo) trackEvent('demo_generate_click', { is_demo: true, char_count: inputText.length });
        if (generateImages) { setShowImageWarningModal(true); } else { handleGenerate(); }
    };

    const handleConfirmGenerate = () => { setShowImageWarningModal(false); handleGenerate(); };

    const handleTemplateSelect = (key: string, placeholder: string) => {
        setTemplateType(key);
        if (!inputText.trim()) setInputText(placeholder);
        trackEvent('template_selected', { template: key, is_demo: isDemo });
    };

    const storeRecentText = (text: string) => {
        if (typeof window === 'undefined') return;
        const trimmed = text.trim(); if (!trimmed) return;
        const updated = [trimmed, ...recentTexts.filter((item) => item !== trimmed)].slice(0, 3);
        setRecentTexts(updated);
        window.localStorage.setItem('recent_texts', JSON.stringify(updated));
    };

    const handleIntentSelect = (intent: string) => {
        setSelectedIntent(intent);
        if (typeof window !== 'undefined') window.localStorage.setItem('demo_intent', intent);
        trackEvent('demo_intent_selected', { intent, is_demo: true });
    };

    const getPdfPageSelections = () => {
        const selections: Record<string, number[] | 'all'> = {};
        pdfPreviews.forEach((preview) => {
            if (preview.selectedPages.length === 0) { selections[preview.fileId] = []; return; }
            if (preview.selectedPages.length === preview.pageCount) { selections[preview.fileId] = 'all'; return; }
            selections[preview.fileId] = preview.selectedPages;
        });
        return selections;
    };

    const parseTags = (value: string) => {
        const rawTags = value.split(',').map((tag) => tag.trim()).filter(Boolean);
        const seen = new Set<string>(); const normalized: string[] = [];
        for (const tag of rawTags) { const key = tag.toLowerCase(); if (!seen.has(key)) { seen.add(key); normalized.push(key); } }
        return normalized.slice(0, 10);
    };

    // --- Generation ---
    const handleGenerate = async (overrideText?: string, captchaToken?: string) => {
        const textToUse = typeof overrideText === 'string' ? overrideText : inputText;
        const hasInput = textToUse.trim().length > 0;
        const hasFiles = uploadedFiles.length > 0;
        if ((!hasInput && !hasFiles) || error || (!user && !isDemo)) return;

        const pdfPreviewsWithEmptySelection = pdfPreviews.filter((preview) => preview.selectedPages.length === 0);
        if (pdfPreviewsWithEmptySelection.length > 0) {
            setToast({ message: 'Selecione pelo menos uma página em cada PDF.', type: 'error' }); return;
        }

        setIsGenerating(true);
        const inputLength = textToUse.length;
        const pdfPageSelections = getPdfPageSelections();

        try {
            const response = isDemo
                ? await fetch(getApiUrl('api/demo/generate'), {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'x-demo-fingerprint': demoFingerprint || '' },
                    body: JSON.stringify({ text: textToUse, language, difficulty, studyLevel, studyGoal, templateType, cardStyle, captchaToken })
                })
                : await fetch(getApiUrl('api/generate'), {
                    method: 'POST',
                    body: (() => {
                        const formData = new FormData();
                        formData.append('text', textToUse);
                        formData.append('language', language);
                        formData.append('difficulty', difficulty);
                        formData.append('studyLevel', studyLevel);
                        formData.append('studyGoal', studyGoal);
                        formData.append('templateType', templateType);
                        formData.append('cardStyle', cardStyle);
                        formData.append('cardCount', cardCount.toString());
                        formData.append('generateImages', generateImages ? 'true' : 'false');
                        formData.append('imageCount', imageCount.toString());
                        formData.append('enemMode', enemMode ? 'true' : 'false');
                        formData.append('autoTags', limits.allowFolders ? 'true' : 'false');
                        formData.append('pdfPageSelections', JSON.stringify(pdfPageSelections));
                        uploadedFiles.forEach(file => { formData.append('fileIds', getFileId(file)); formData.append('files', file); });
                        return formData;
                    })()
                });

            const data = await response.json();

            if (!response.ok) {
                if (response.status === 403) setShowUpgradeModal(true);
                if (response.status === 429 && data?.error) {
                    setToast({ message: data.error, type: 'info' });
                    if (isDemo) { trackEvent('demo_rate_limited', { is_demo: true, char_count: inputLength }); openAuthGate('demo_rate_limited'); }
                }
                if (isDemo && data?.code === 'captcha_required') { setCaptchaRequired(true); setPendingDemoText(textToUse); }
                if (isDemo) trackEvent('demo_generate_error', { is_demo: true, reason: data?.code || 'unknown', message: data?.error || 'Erro ao gerar cards', char_count: inputLength });
                throw new Error(data.error || 'Erro ao gerar cards');
            }

            if (isDemo) { setCaptchaRequired(false); setPendingDemoText(null); }

            const newCardsFormatted = data.cards.map((c: { question: string; answer: string; image_url?: string | null; question_image_url?: string | null; answer_image_url?: string | null; user_image_index?: number; user_image_section?: 'question' | 'answer'; }) => {
                let qImg = c.question_image_url ?? c.image_url ?? null;
                let aImg = c.answer_image_url ?? null;
                if (c.user_image_index !== undefined && c.user_image_index >= 0 && c.user_image_index < uploadedFiles.length) {
                    const file = uploadedFiles[c.user_image_index];
                    if (IMAGE_MIME_TYPES.has(file.type)) {
                        const objectUrl = URL.createObjectURL(file);
                        objectUrlsRef.current.add(objectUrl);
                        if (c.user_image_section === 'question') { qImg = objectUrl; } else { aImg = objectUrl; }
                        if (!c.user_image_section) { if (!aImg) aImg = objectUrl; }
                    }
                }
                return { id: Math.random().toString(36).substr(2, 9), question: c.question, answer: c.answer, question_image_url: qImg, answer_image_url: aImg };
            });

            setCards([...newCardsFormatted, ...cards]);
            if (!deckTitle) setDeckTitle(`Deck ${new Date().toLocaleDateString()}`);
            setInputText(''); setUploadedFiles([]); storeRecentText(textToUse); setTemplateType('');
            if (data.imageGeneration?.failed) setToast({ message: `Algumas imagens nao puderam ser geradas (${data.imageGeneration.failed}).`, type: 'info' });
            if (data.notification) setTimeout(() => { setToast({ message: data.notification, type: 'info' }); }, 1000);

            trackEvent(isDemo ? 'demo_generation_success' : 'generation_completed', {
                plan: isDemo ? 'demo' : currentPlan, cards_generated: data.cards?.length,
                card_count_requested: isDemo ? limits.maxCardsPerGen : cardCount,
                image_cards_requested: isDemo ? 0 : generateImages ? Math.min(cardCount, limits.maxImageCardsPerGen) : 0,
                image_cards_generated: data.imageGeneration?.generated ?? 0, char_count: inputLength,
                language, difficulty, has_files: hasFiles, file_count: uploadedFiles.length, is_demo: isDemo,
            });

            if (currentPlan === 'free' && !isDemo) setToast({ message: 'Para salvar seu baralho e ter acesso ilimitado, faça upgrade para o Pro.', type: 'info' });
        } catch (err) {
            setError(err instanceof Error ? err.message : 'Erro ao gerar cards');
            if (isDemo) trackEvent('demo_generate_error', { is_demo: true, reason: 'exception', message: err instanceof Error ? err.message : 'unknown', char_count: inputLength });
            trackEvent(isDemo ? 'demo_generation_failed' : 'generate_cards_failed', {
                plan: isDemo ? 'demo' : currentPlan, input_chars: inputLength, error: err instanceof Error ? err.message : 'unknown',
                image_cards_requested: isDemo ? 0 : generateImages ? Math.min(cardCount, limits.maxImageCardsPerGen) : 0,
                language, difficulty, has_files: hasFiles, file_count: uploadedFiles.length,
            });
        } finally { setIsGenerating(false); }
    };

    const handleCaptchaRetry = () => {
        const siteKey = process.env.NEXT_PUBLIC_TURNSTILE_SITE_KEY;
        if (!siteKey) { setToast({ message: 'Verificação indisponível. Tente novamente mais tarde.', type: 'info' }); return; }
        if (!captchaContainerRef.current || !window.turnstile) { setToast({ message: 'Carregando verificação, tente novamente.', type: 'info' }); return; }
        if (!captchaWidgetIdRef.current) {
            captchaWidgetIdRef.current = window.turnstile.render(captchaContainerRef.current, {
                sitekey: siteKey, size: 'invisible',
                callback: (token: string) => { setCaptchaRequired(false); const text = pendingDemoText || inputText; handleGenerate(text, token); },
            });
        }
        window.turnstile.execute(captchaWidgetIdRef.current);
    };

    // --- Save / Export ---
    const handleSaveLibrary = async () => {
        if (isDemo) { openAuthGate('demo_save'); return; }
        if (cards.length === 0 || !user || isSaving) return;
        if (!limits.historySaved) { setShowUpgradeModal(true); return; }
        setIsSaving(true);
        try {
            const title = deckTitle || `Deck ${new Date().toLocaleDateString()}`;
            const formattedCards = cards.map(c => ({ front: c.question, back: c.answer, question_image_url: c.question_image_url, answer_image_url: c.answer_image_url }));
            let tags = parseTags(deckTagsInput);
            if (selectedFolder) {
                if (!limits.allowFolders) { setShowUpgradeModal(true); setIsSaving(false); return; }
                tags = [...tags, selectedFolder];
            }
            const description = deckDescription.trim();
            const savedDeck = await deckService.saveDeck(user.id, title, formattedCards, { tags, description: description || undefined });
            setSavedDeckId(savedDeck?.id || null); setSavedDeckPublic(false); setSaveSuccess(true);
            setToast({ message: 'Baralho salvo com sucesso!', type: 'success' });
            setTimeout(() => setSaveSuccess(false), 3000);
        } catch (err) { console.error(err); setToast({ message: 'Erro ao salvar baralho', type: 'error' }); }
        finally { setIsSaving(false); }
    };

    const handlePublicLink = async () => {
        if (isDemo) { openAuthGate('demo_public_link'); return; }
        if (!savedDeckId || publishingPublic) return;
        setPublishingPublic(true);
        try {
            if (!savedDeckPublic) {
                const { error } = await supabase.from('decks').update({ is_public: true, published_at: new Date().toISOString() }).eq('id', savedDeckId);
                if (error) throw error; setSavedDeckPublic(true);
            }
            const publicUrl = `${window.location.origin}/marketplace/${savedDeckId}`;
            await navigator.clipboard.writeText(publicUrl);
            setToast({ message: 'Link público copiado!', type: 'success' });
        } catch (err) { console.error(err); setToast({ message: 'Erro ao gerar link público.', type: 'error' }); }
        finally { setPublishingPublic(false); }
    };

    const handleFileUpload = () => {
        if (isDemo) { openAuthGate('demo_file_upload'); return; }
        if (!limits.allowFile && !limits.allowOCR) { setShowUpgradeModal(true); return; }
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
            if (!isPdf && !isDocx && !isImage) { setToast({ message: `Arquivo ${file.name} ignorado. Formato inválido.`, type: 'error' }); continue; }
            if (file.size > MAX_UPLOAD_BYTES) { setToast({ message: `Arquivo ${file.name} muito grande.`, type: 'error' }); continue; }
            if (isImage && !limits.allowOCR) { setShowUpgradeModal(true); return; }
            if ((isPdf || isDocx) && !limits.allowFile) { setShowUpgradeModal(true); return; }
            if (isDocx) {
                docxCount++;
                setIsGenerating(true);
                try {
                    const mammoth = await import('mammoth');
                    const arrayBuffer = await file.arrayBuffer();
                    const result = await mammoth.extractRawText({ arrayBuffer });
                    if (result.value.trim()) setInputText(prev => prev + '\n\n' + result.value);
                } catch (err) { console.error('Erro ao ler arquivo:', err); setToast({ message: `Erro ao processar ${file.name}.`, type: 'error' }); }
                finally { setIsGenerating(false); }
            } else { newFiles.push(file); }
        }
        if (docxCount > 0) setToast({ message: 'Conteúdo dos arquivos DOCX extraído!', type: 'success' });
        setUploadedFiles(newFiles);
        const imgCount = newFiles.filter(f => IMAGE_MIME_TYPES.has(f.type)).length;
        const pdfCount = newFiles.filter(f => f.type === PDF_MIME_TYPE).length;
        if (imgCount > 0 || pdfCount > 0) setToast({ message: `${newFiles.length} arquivo(s) anexado(s).`, type: 'success' });
        if (fileInputRef.current) fileInputRef.current.value = '';
    };

    const handleRemoveFile = (fileToRemove: File) => {
        const fileId = getFileId(fileToRemove);
        setUploadedFiles((prev) => prev.filter((file) => file !== fileToRemove));
        setPdfPreviews((prev) => prev.filter((preview) => preview.fileId !== fileId));
        pdfDocsRef.current.delete(fileId);
    };

    const togglePdfPageSelection = (fileId: string, pageNumber: number) => {
        setPdfPreviews((prev) =>
            prev.map((preview) => {
                if (preview.fileId !== fileId) return preview;
                const isSelected = preview.selectedPages.includes(pageNumber);
                const nextSelected = isSelected ? preview.selectedPages.filter((page) => page !== pageNumber) : [...preview.selectedPages, pageNumber];
                return { ...preview, selectedPages: nextSelected.sort((a, b) => a - b) };
            })
        );
    };

    const selectAllPdfPages = (fileId: string) => {
        setPdfPreviews((prev) => prev.map((preview) => preview.fileId === fileId ? { ...preview, selectedPages: Array.from({ length: preview.pageCount }, (_, idx) => idx + 1) } : preview));
    };

    const clearPdfPages = (fileId: string) => {
        setPdfPreviews((prev) => prev.map((preview) => (preview.fileId === fileId ? { ...preview, selectedPages: [] } : preview)));
    };

    const renderAllPdfPages = (fileId: string) => {
        const preview = pdfPreviews.find((item) => item.fileId === fileId);
        if (!preview) return;
        preview.pages.filter((page) => !page.dataUrl && !page.isRendering).forEach((page) => renderPdfPage(fileId, page.pageNumber));
    };

    const deleteCard = (id: string) => { setCards(cards.filter(card => card.id !== id)); };
    const updateCard = (id: string, field: 'question' | 'answer', value: string) => { setCards(cards.map(card => card.id === id ? { ...card, [field]: value } : card)); };

    // --- Image drag-and-drop ---
    const handleImageDragStart = (e: React.DragEvent, cardId: string, section: 'question' | 'answer', imageUrl: string) => {
        e.dataTransfer.setData('application/json', JSON.stringify({ cardId, section, imageUrl }));
        e.dataTransfer.effectAllowed = 'move'; setDraggedImage({ cardId, section, imageUrl });
    };
    const handleImageDragEnd = () => { setDraggedImage(null); setDropTarget(null); };
    const handleImageDragOver = (e: React.DragEvent, cardId: string, section: 'question' | 'answer') => { e.preventDefault(); e.dataTransfer.dropEffect = 'move'; setDropTarget({ cardId, section }); };
    const handleImageDragLeave = () => { setDropTarget(null); };

    const handleImageDrop = (e: React.DragEvent, targetCardId: string, targetSection: 'question' | 'answer') => {
        e.preventDefault();
        const data = e.dataTransfer.getData('application/json');
        if (!data) return;
        try {
            const { cardId: sourceCardId, section: sourceSection, imageUrl } = JSON.parse(data);
            if (sourceCardId === targetCardId && sourceSection === targetSection) { setDropTarget(null); setDraggedImage(null); return; }
            setCards(prevCards => prevCards.map(card => {
                if (card.id === sourceCardId) { card = sourceSection === 'question' ? { ...card, question_image_url: null } : { ...card, answer_image_url: null }; }
                if (card.id === targetCardId) { card = targetSection === 'question' ? { ...card, question_image_url: imageUrl } : { ...card, answer_image_url: imageUrl }; }
                return card;
            }));
            setToast({ message: 'Imagem movida com sucesso!', type: 'success' });
        } catch (err) { console.error('Error parsing drag data:', err); }
        setDropTarget(null); setDraggedImage(null);
    };

    const removeImage = (cardId: string, section: 'question' | 'answer') => {
        setCards(prevCards => prevCards.map(card => {
            if (card.id === cardId) return section === 'question' ? { ...card, question_image_url: null } : { ...card, answer_image_url: null };
            return card;
        }));
    };

    const getSafeFileName = (title: string) => title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';

    const exportToApkg = async () => {
        if (isDemo) { openAuthGate('demo_export_apkg'); return; }
        if (cards.length === 0 || isExportingApkg) return;
        setIsExportingApkg(true);
        try {
            const payload = { title: deckTitle || `Deck ${new Date().toLocaleDateString()}`, cards: cards.map((card) => ({ question: card.question, answer: card.answer, question_image_url: card.question_image_url, answer_image_url: card.answer_image_url })) };
            const compressedBody = gzip(JSON.stringify(payload));
            const response = await fetch('/api/export/anki', { method: 'POST', headers: { 'Content-Type': 'application/json', 'Content-Encoding': 'gzip' }, body: compressedBody });
            if (!response.ok) { const errorData = await response.json().catch(() => ({})); throw new Error(errorData.error || 'Erro ao exportar .apkg'); }
            const blob = await response.blob();
            const url = URL.createObjectURL(blob); const link = document.createElement('a');
            link.href = url; link.download = `${getSafeFileName(deckTitle || 'deck')}.apkg`; link.click(); URL.revokeObjectURL(url);
        } catch (err) { console.error(err); setToast({ message: 'Erro ao exportar .apkg', type: 'error' }); }
        finally { setIsExportingApkg(false); }
    };

    const exportToAnki = () => {
        if (isDemo) { openAuthGate('demo_export_txt'); return; }
        const content = cards.map(c => `${c.question}\t${c.answer}`).join('\n');
        const blob = new Blob([content], { type: 'text/plain;charset=utf-8' });
        const url = URL.createObjectURL(blob); const link = document.createElement('a');
        link.href = url; link.download = `anki-deck-${Date.now()}.txt`; link.click(); URL.revokeObjectURL(url);
    };

    const exportToCsv = () => {
        if (isDemo) { openAuthGate('demo_export_csv'); return; }
        const header = "Question,Answer\n";
        const content = cards.map(c => `"${c.question.replace(/"/g, '""')}","${c.answer.replace(/"/g, '""')}"`).join('\n');
        const blob = new Blob([header + content], { type: 'text/csv;charset=utf-8' });
        const url = URL.createObjectURL(blob); const link = document.createElement('a');
        link.href = url; link.download = 'flashcards.csv'; link.click(); URL.revokeObjectURL(url);
    };

    const exportToPdf = () => {
        if (isDemo) { openAuthGate('demo_export_pdf'); return; }
        if (cards.length === 0) return;
        const win = window.open('', '_blank'); if (!win) return;
        const title = deckTitle || 'Flashcards';
        const html = `<html><head><title>${title}</title><style>body { font-family: Arial, sans-serif; padding: 24px; } h1 { font-size: 22px; margin-bottom: 16px; } .card { border: 1px solid #ddd; padding: 12px; margin-bottom: 12px; border-radius: 6px; } .label { font-size: 10px; text-transform: uppercase; letter-spacing: 0.1em; color: #999; } .value { font-size: 14px; font-weight: 600; }</style></head><body><h1>${title}</h1>${cards.map((card, index) => `<div class="card"><div class="label">Pergunta #${index + 1}</div><div class="value">${card.question}</div><div class="label" style="margin-top:8px;">Resposta</div><div class="value">${card.answer}</div></div>`).join('')}</body></html>`;
        win.document.write(html); win.document.close(); win.focus(); win.print();
    };

    const copyToObsidian = async () => {
        if (isDemo) { openAuthGate('demo_export_obsidian'); return; }
        if (cards.length === 0) return;
        const title = deckTitle || 'Flashcards';
        const md = ['---', `title: "${title.replace(/"/g, '\\"')}"`, `tags: [flashcards]`, '---', '', ...cards.flatMap((card) => [`## ${card.question}`, card.answer, ''])].join('\n');
        try { await navigator.clipboard.writeText(md); setToast({ message: 'Copiado no formato Obsidian!', type: 'success' }); }
        catch { setToast({ message: 'Falha ao copiar. Tente novamente.', type: 'error' }); }
    };

    const handleGenerateEnemExample = async () => {
        setStudyLevel('ENEM'); setStudyGoal('Memorizar');
        if (isDemo) { trackEvent('demo_generate_click', { is_demo: true, char_count: ENEM_EXAMPLE_TEXT.length, source: 'enem_example' }); setInputText(ENEM_EXAMPLE_TEXT); await handleGenerate(ENEM_EXAMPLE_TEXT); return; }
        setInputText(ENEM_EXAMPLE_TEXT); await handleGenerate(ENEM_EXAMPLE_TEXT);
    };

    return (
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start relative pb-20">

            {/* Upgrade Modal */}
            {/* Upgrade Modal */}
            <UpgradeModal
                isOpen={showUpgradeModal}
                onClose={() => setShowUpgradeModal(false)}
            />

            <AuthGateModal
                isOpen={showAuthGateModal}
                onClose={() => setShowAuthGateModal(false)}
                onSignupClick={() => {
                    setSignupModalAction(true);
                    trackEvent('signup_start', { source: 'demo_modal' });
                }}
                onLoginClick={() => {
                    setSignupModalAction(true);
                }}
                onDismiss={() => {
                    if (!signupModalAction) {
                        trackEvent('signup_abandoned', { source: 'demo_modal' });
                    }
                }}
            />

            {/* Coluna Esquerda: Input e Configs */}
            <div className="lg:col-span-5 space-y-6">
                <TextInputSection
                    inputText={inputText}
                    setInputText={setInputText}
                    isDemo={isDemo}
                    demoInputStarted={demoInputStarted}
                    setDemoInputStarted={setDemoInputStarted}
                    error={error}
                    limits={limits}
                    currentPlan={currentPlan}
                    templateType={templateType}
                    recentTexts={recentTexts}
                    studyLevel={studyLevel}
                    setStudyLevel={setStudyLevel}
                    studyGoal={studyGoal}
                    setStudyGoal={setStudyGoal}
                    cardStyle={cardStyle}
                    setCardStyle={setCardStyle}
                    cardCount={cardCount}
                    setCardCount={setCardCount}
                    difficulty={difficulty}
                    setDifficulty={setDifficulty}
                    language={language}
                    setLanguage={setLanguage}
                    generateImages={generateImages}
                    imageCount={imageCount}
                    setImageCount={setImageCount}
                    enemMode={enemMode}
                    setEnemMode={setEnemMode}
                    isGenerating={isGenerating}
                    captchaRequired={captchaRequired}
                    captchaContainerRef={captchaContainerRef}
                    uploadedFiles={uploadedFiles}
                    uploadLabel={uploadLabel}
                    fileAccept={fileAccept}
                    fileInputRef={fileInputRef}
                    onTemplateSelect={handleTemplateSelect}
                    onFileUpload={handleFileUpload}
                    onFileChange={handleFileChange}
                    onToggleImageGeneration={handleToggleImageGeneration}
                    onCaptchaRetry={handleCaptchaRetry}
                    onGenerateClick={handleGenerateClick}
                    onGenerateEnemExample={handleGenerateEnemExample}
                    onOpenAuthGate={openAuthGate}
                    onShowUpgradeModal={() => setShowUpgradeModal(true)}
                    onTrackEvent={trackEvent}
                    fileUploadSlot={
                        <FileUploadSection
                            uploadedFiles={uploadedFiles}
                            pdfPreviews={pdfPreviews}
                            onRemoveFile={handleRemoveFile}
                            onTogglePdfPageSelection={togglePdfPageSelection}
                            onSelectAllPdfPages={selectAllPdfPages}
                            onClearPdfPages={clearPdfPages}
                            onRenderAllPdfPages={renderAllPdfPages}
                            onRenderPdfPage={renderPdfPage}
                        />
                    }
                />
            </div>

            {/* Coluna Direita: Preview dos Cards */}
            <CardList
                cards={cards}
                setCards={setCards}
                deckTitle={deckTitle}
                setDeckTitle={setDeckTitle}
                deckDescription={deckDescription}
                setDeckDescription={setDeckDescription}
                deckTagsInput={deckTagsInput}
                setDeckTagsInput={setDeckTagsInput}
                selectedFolder={selectedFolder}
                setSelectedFolder={setSelectedFolder}
                isSaving={isSaving}
                saveSuccess={saveSuccess}
                isExportingApkg={isExportingApkg}
                savedDeckId={savedDeckId}
                publishingPublic={publishingPublic}
                dropTarget={dropTarget}
                draggedImage={draggedImage}
                limits={limits}
                onSaveLibrary={handleSaveLibrary}
                onExportApkg={exportToApkg}
                onExportAnki={exportToAnki}
                onExportCsv={exportToCsv}
                onExportPdf={exportToPdf}
                onCopyToObsidian={copyToObsidian}
                onPublicLink={handlePublicLink}
                onDeleteCard={deleteCard}
                onUpdateCard={updateCard}
                onRemoveImage={removeImage}
                onImageDragStart={handleImageDragStart}
                onImageDragEnd={handleImageDragEnd}
                onImageDragOver={handleImageDragOver}
                onImageDragLeave={handleImageDragLeave}
                onImageDrop={handleImageDrop}
                onShowUpgradeModal={() => setShowUpgradeModal(true)}
            />

            <GeneratorActions
                isDemo={isDemo}
                cards={cards}
                selectedIntent={selectedIntent}
                showImageWarningModal={showImageWarningModal}
                onSetShowImageWarningModal={setShowImageWarningModal}
                onConfirmGenerate={handleConfirmGenerate}
                onOpenAuthGate={openAuthGate}
                onIntentSelect={handleIntentSelect}
            />

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
