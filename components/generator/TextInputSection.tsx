import React from 'react';
import {
    Sparkles,
    FileUp,
    AlertCircle,
    ChevronDown,
    Loader2,
} from 'lucide-react';
import { TEMPLATE_OPTIONS } from './types';
import type { PlanKey } from '@/constants/pricing';

interface TextInputSectionProps {
    inputText: string;
    setInputText: (value: string) => void;
    isDemo: boolean;
    demoInputStarted: boolean;
    setDemoInputStarted: (value: boolean) => void;
    error: string | null;
    limits: {
        name: string;
        maxChars: number;
        maxCardsPerGen: number;
        customCardCount: boolean;
        allowFile: boolean;
        allowOCR: boolean;
        allowImageGeneration: boolean;
        allowEnemMode: boolean;
        allowFolders: boolean;
        maxImageCardsPerGen: number;
    };
    currentPlan: PlanKey;
    templateType: string;
    recentTexts: string[];
    studyLevel: 'ENEM' | 'Faculdade' | 'Concurso';
    setStudyLevel: (value: 'ENEM' | 'Faculdade' | 'Concurso') => void;
    studyGoal: 'Memorizar' | 'Revisar r\u00e1pido' | 'Aprofundar';
    setStudyGoal: (value: 'Memorizar' | 'Revisar r\u00e1pido' | 'Aprofundar') => void;
    cardStyle: 'basic' | 'short_answer' | 'image_occlusion';
    setCardStyle: (value: 'basic' | 'short_answer' | 'image_occlusion') => void;
    cardCount: number;
    setCardCount: (value: number) => void;
    difficulty: string;
    setDifficulty: (value: string) => void;
    language: string;
    setLanguage: (value: string) => void;
    generateImages: boolean;
    imageCount: number;
    setImageCount: (value: number) => void;
    enemMode: boolean;
    setEnemMode: (value: boolean) => void;
    isGenerating: boolean;
    captchaRequired: boolean;
    captchaContainerRef: React.RefObject<HTMLDivElement | null>;
    uploadedFiles: File[];
    uploadLabel: string;
    fileAccept: string;
    fileInputRef: React.RefObject<HTMLInputElement | null>;
    onTemplateSelect: (key: string, placeholder: string) => void;
    onFileUpload: () => void;
    onFileChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    onToggleImageGeneration: () => void;
    onCaptchaRetry: () => void;
    onGenerateClick: () => void;
    onGenerateEnemExample: () => void;
    onOpenAuthGate: (reason: string) => void;
    onShowUpgradeModal: () => void;
    onTrackEvent: (event: string, data: Record<string, unknown>) => void;
    fileUploadSlot?: React.ReactNode;
}

export function TextInputSection({
    inputText,
    setInputText,
    isDemo,
    demoInputStarted,
    setDemoInputStarted,
    error,
    limits,
    currentPlan,
    templateType,
    recentTexts,
    studyLevel,
    setStudyLevel,
    studyGoal,
    setStudyGoal,
    cardStyle,
    setCardStyle,
    cardCount,
    setCardCount,
    difficulty,
    setDifficulty,
    language,
    setLanguage,
    generateImages,
    imageCount,
    setImageCount,
    enemMode,
    setEnemMode,
    isGenerating,
    captchaRequired,
    captchaContainerRef,
    uploadedFiles,
    uploadLabel,
    fileAccept,
    fileInputRef,
    onTemplateSelect,
    onFileUpload,
    onFileChange,
    onToggleImageGeneration,
    onCaptchaRetry,
    onGenerateClick,
    onGenerateEnemExample,
    onOpenAuthGate,
    onShowUpgradeModal,
    onTrackEvent,
    fileUploadSlot,
}: TextInputSectionProps) {
    return (
        <div className="bg-white border border-border p-6 rounded-sm shadow-sm lg:sticky lg:top-24">
            <div className="mb-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
                <div className="flex items-center gap-2 text-[11px] font-bold text-foreground/60">
                    <span className="px-2 py-0.5 rounded-sm bg-gray-100">Passo 1</span>
                    <span>Fonte do conte\u00fado</span>
                </div>
                <div className="text-[11px] font-bold text-foreground/40">Passo 2: Ajustes \u2022 Passo 3: Revis\u00e3o</div>
            </div>
            {isDemo && (
                <div className="mb-4 rounded-sm border border-amber-200 bg-amber-50 px-3 py-2 text-[11px] font-bold text-amber-800">
                    Voc\u00ea est\u00e1 no modo demo \u2022 1 gera\u00e7\u00e3o/dia \u2022 5 cards \u2022 2.000 caracteres
                </div>
            )}
            <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                    <div className="bg-brand/10 p-1.5 rounded-sm">
                        <Sparkles className="h-4 w-4 text-brand" />
                    </div>
                    <h2 className="text-lg font-bold text-foreground">Fonte do Conte\u00fado</h2>
                </div>
                <div className={`text-[10px] font-black uppercase tracking-widest px-2 py-0.5 rounded-sm ${isDemo || currentPlan === 'free' ? 'bg-gray-100 text-foreground/40' : 'bg-brand text-white'}`}>
                    {isDemo ? 'Modo Demo' : `Plano ${limits.name}`}
                </div>
            </div>


            <div className="space-y-4">
                <details>
                    <summary className="cursor-pointer select-none px-3 py-2 rounded-sm border border-border bg-white text-[11px] font-bold text-foreground/70 hover:border-brand/40">
                        Templates r\u00e1pidos
                    </summary>
                    <div className="mt-3 flex flex-wrap gap-2">
                        {TEMPLATE_OPTIONS.map((template) => (
                            <button
                                key={template.key}
                                type="button"
                                onClick={() => onTemplateSelect(template.key, template.placeholder)}
                                className={`px-3 py-1.5 rounded-sm text-[11px] font-bold border transition-all ${templateType === template.key ? 'bg-brand text-white border-brand' : 'bg-white border-border text-foreground/60 hover:border-brand/40'}`}
                            >
                                {template.label}
                            </button>
                        ))}
                    </div>
                </details>

                {recentTexts.length > 0 && (
                    <div>
                        <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-2">Conte\u00fados recentes</div>
                        <div className="flex flex-col gap-2">
                            {recentTexts.map((item, index) => (
                                <button
                                    key={`${item.slice(0, 20)}-${index}`}
                                    type="button"
                                    onClick={() => setInputText(item)}
                                    className="text-left text-[11px] font-bold text-foreground/60 bg-gray-50 border border-border rounded-sm px-3 py-2 hover:border-brand/40"
                                >
                                    {item.slice(0, 120)}{item.length > 120 ? '...' : ''}
                                </button>
                            ))}
                        </div>
                    </div>
                )}
            </div>

            <div className="relative mt-4">
                <input
                    type="file"
                    ref={fileInputRef}
                    onChange={onFileChange}
                    accept={fileAccept}
                    className="hidden"
                />
                <label htmlFor="content-input" className="sr-only">Conte\u00fado para Flashcards</label>
                <textarea
                    id="content-input"
                    value={inputText}
                    onChange={(e) => {
                        const next = e.target.value;
                        if (isDemo && !demoInputStarted && next.trim().length > 0) {
                            setDemoInputStarted(true);
                            onTrackEvent('demo_input_started', { is_demo: true, char_count: next.length });
                        }
                        setInputText(next);
                    }}
                    placeholder="Cole seu texto, resumo ou notas aqui..."
                    className={`w-full h-80 p-4 pb-16 bg-gray-50 border rounded-sm focus:ring-1 outline-none transition-all resize-none font-medium text-foreground/80 placeholder:text-foreground/30 ${error ? 'border-red-500 focus:ring-red-500 bg-red-50/10' : 'border-border focus:ring-brand focus:border-brand'
                        }`}
                />

                {/* Status bar inside textarea */}
                <div className="absolute bottom-4 left-4 right-4 flex flex-col sm:flex-row sm:items-center items-start sm:justify-between gap-2 text-[11px] font-bold">
                    <button
                        onClick={onFileUpload}
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

            {fileUploadSlot}

            {error && (
                <div className="mt-3 flex items-center gap-2 text-red-500 text-xs font-bold bg-red-50 p-2 border border-red-100 rounded-sm">
                    <AlertCircle className="h-4 w-4" />
                    {error}
                    <button
                        onClick={() => (isDemo ? onOpenAuthGate('demo_limit') : onShowUpgradeModal())}
                        className="ml-auto underline"
                    >
                        {isDemo ? 'Criar conta' : 'Upgrade'}
                    </button>
                </div>
            )}

            {captchaRequired && (
                <div className="mt-3 flex flex-col sm:flex-row sm:items-center gap-2 text-amber-700 text-xs font-bold bg-amber-50 p-2 border border-amber-100 rounded-sm">
                    <span>Verifica\u00e7\u00e3o necess\u00e1ria para continuar no demo.</span>
                    <button
                        onClick={onCaptchaRetry}
                        className="sm:ml-auto underline text-amber-700"
                    >
                        Verificar e tentar novamente
                    </button>
                    <div ref={captchaContainerRef} className="hidden" />
                </div>
            )}

            <div className="mt-6">
                <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-2">Passo 2 \u2022 Ajustes principais</div>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label htmlFor="study-level" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">N\u00edvel</label>
                        <div className="relative text-foreground">
                            <select
                                id="study-level"
                                value={studyLevel}
                                onChange={(event) => setStudyLevel(event.target.value as typeof studyLevel)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="ENEM">ENEM</option>
                                <option value="Faculdade">Faculdade</option>
                                <option value="Concurso">Concurso</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="study-goal" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Objetivo</label>
                        <div className="relative text-foreground">
                            <select
                                id="study-goal"
                                value={studyGoal}
                                onChange={(event) => setStudyGoal(event.target.value as typeof studyGoal)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="Memorizar">Memorizar</option>
                                <option value="Revisar r\u00e1pido">Revisar r\u00e1pido</option>
                                <option value="Aprofundar">Aprofundar</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="card-style" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Estilo do card</label>
                        <div className="relative text-foreground">
                            <select
                                id="card-style"
                                value={cardStyle}
                                onChange={(event) => setCardStyle(event.target.value as typeof cardStyle)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="basic">Pergunta e resposta</option>
                                <option value="short_answer">Resposta curta</option>
                                <option value="image_occlusion">Oclus\u00e3o (imagem)</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="card-count" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Qtd. de Cards {limits.customCardCount ? '' : '(Limite)'}</label>
                        <div className="relative text-foreground">
                            {limits.customCardCount && !isDemo ? (
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
                                    <button
                                        onClick={() => (isDemo ? onOpenAuthGate('demo_card_limit') : onShowUpgradeModal())}
                                        className="text-[10px] text-brand underline hover:text-brand/80"
                                    >
                                        {isDemo ? 'Criar conta' : 'Upgrade'}
                                    </button>
                                </div>
                            )}
                        </div>
                    </div>
                </div>
            </div>
            <details className="mt-4 border border-border rounded-sm bg-gray-50">
                <summary className="cursor-pointer select-none px-3 py-2 text-xs font-bold text-foreground/60">
                    Configura\u00e7\u00f5es avan\u00e7adas
                </summary>
                <div className="px-3 pb-3 space-y-4">
                    <div>
                        <label htmlFor="difficulty-select" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">N\u00edvel de Dificuldade</label>
                        <div className="relative text-foreground">
                            <select
                                id="difficulty-select"
                                value={difficulty}
                                onChange={(event) => setDifficulty(event.target.value)}
                                className="w-full appearance-none bg-white border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="Iniciante">Iniciante</option>
                                <option value="Intermedi\u00e1rio">Intermedi\u00e1rio</option>
                                <option value="Avan\u00e7ado">Avan\u00e7ado</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="language-select" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40 mb-1.5 block">Idioma do Deck</label>
                        <div className="relative text-foreground">
                            <select
                                id="language-select"
                                value={language}
                                onChange={(event) => setLanguage(event.target.value)}
                                className="w-full appearance-none bg-white border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="Portugu\u00eas">Portugu\u00eas</option>
                                <option value="Ingl\u00eas">Ingl\u00eas</option>
                                <option value="Espanhol">Espanhol</option>
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div>
                        <div className={`flex items-center justify-between gap-3 border rounded-sm px-3 py-2 ${limits.allowImageGeneration ? 'bg-white border-border' : 'bg-gray-100 border-border/60'}`}>
                            <label className={`flex items-center gap-3 text-xs font-bold ${limits.allowImageGeneration ? 'text-foreground' : 'text-foreground/40'}`}>
                                <input
                                    type="checkbox"
                                    checked={generateImages}
                                    onChange={onToggleImageGeneration}
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
                                    className="appearance-none bg-white border border-border px-3 py-1.5 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none cursor-pointer"
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
                                    <span className="font-bold">&#x26A1; Recurso Premium:</span> A gera\u00e7\u00e3o de imagens por IA utiliza tecnologia avan\u00e7ada (DALL-E 3) com custo elevado por imagem.
                                    Use de forma consciente, priorizando cards que realmente se beneficiam de recursos visuais, como diagramas, anatomia, mapas e conceitos abstratos.
                                </p>
                            </div>
                        )}
                    </div>
                    <div className={`flex items-center justify-between gap-3 border rounded-sm px-3 py-2 ${limits.allowEnemMode ? 'bg-white border-border' : 'bg-gray-100 border-border/60'}`}>
                        <label className={`flex items-center gap-3 text-xs font-bold ${limits.allowEnemMode ? 'text-foreground' : 'text-foreground/40'}`}>
                            <input
                                type="checkbox"
                                checked={enemMode}
                                onChange={() => {
                                    if (!limits.allowEnemMode) {
                                        onShowUpgradeModal();
                                        return;
                                    }
                                    setEnemMode(!enemMode);
                                }}
                                className="h-4 w-4 accent-brand"
                                disabled={!limits.allowEnemMode}
                            />
                            Ativar Modo ENEM (Conceito + Pegadinha + Exemplo)
                        </label>
                        <span className={`text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded-sm ${limits.allowEnemMode ? 'bg-brand/10 text-brand' : 'bg-gray-200 text-foreground/40'}`}>
                            Pro
                        </span>
                    </div>
                </div>
            </details>

            <button
                onClick={onGenerateEnemExample}
                disabled={isGenerating}
                className="w-full mt-3 py-3 rounded-sm font-bold text-foreground transition-all flex items-center justify-center gap-2 border border-border bg-white hover:bg-gray-50"
            >
                <Sparkles className="h-4 w-4 text-brand" />
                Testar com um exemplo pronto (ENEM)
            </button>

            <button
                onClick={onGenerateClick}
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
                        Gerar Flashcards Bons
                    </>
                )}
            </button>
        </div>
    );
}
