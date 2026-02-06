import React from 'react';
import {
    Plus,
    ChevronDown,
    Loader2,
    FileDown,
    Download,
    Check,
    Library,
    Globe,
} from 'lucide-react';
import { CardPreview } from './CardPreview';
import { FOLDERS } from './types';
import type { Flashcard, ImageDropTarget } from './types';

interface CardListProps {
    cards: Flashcard[];
    setCards: React.Dispatch<React.SetStateAction<Flashcard[]>>;
    deckTitle: string;
    setDeckTitle: (value: string) => void;
    deckDescription: string;
    setDeckDescription: (value: string) => void;
    deckTagsInput: string;
    setDeckTagsInput: (value: string) => void;
    selectedFolder: string;
    setSelectedFolder: (value: string) => void;
    isSaving: boolean;
    saveSuccess: boolean;
    isExportingApkg: boolean;
    savedDeckId: string | null;
    publishingPublic: boolean;
    dropTarget: ImageDropTarget | null;
    draggedImage: { cardId: string; section: 'question' | 'answer'; imageUrl: string } | null;
    limits: {
        allowFolders: boolean;
    };
    onSaveLibrary: () => void;
    onExportApkg: () => void;
    onExportAnki: () => void;
    onExportCsv: () => void;
    onExportPdf: () => void;
    onCopyToObsidian: () => void;
    onPublicLink: () => void;
    onDeleteCard: (id: string) => void;
    onUpdateCard: (id: string, field: 'question' | 'answer', value: string) => void;
    onRemoveImage: (cardId: string, section: 'question' | 'answer') => void;
    onImageDragStart: (e: React.DragEvent, cardId: string, section: 'question' | 'answer', imageUrl: string) => void;
    onImageDragEnd: () => void;
    onImageDragOver: (e: React.DragEvent, cardId: string, section: 'question' | 'answer') => void;
    onImageDragLeave: () => void;
    onImageDrop: (e: React.DragEvent, targetCardId: string, targetSection: 'question' | 'answer') => void;
    onShowUpgradeModal: () => void;
}

export function CardList({
    cards,
    setCards,
    deckTitle,
    setDeckTitle,
    deckDescription,
    setDeckDescription,
    deckTagsInput,
    setDeckTagsInput,
    selectedFolder,
    setSelectedFolder,
    isSaving,
    saveSuccess,
    isExportingApkg,
    savedDeckId,
    publishingPublic,
    dropTarget,
    draggedImage,
    limits,
    onSaveLibrary,
    onExportApkg,
    onExportAnki,
    onExportCsv,
    onExportPdf,
    onCopyToObsidian,
    onPublicLink,
    onDeleteCard,
    onUpdateCard,
    onRemoveImage,
    onImageDragStart,
    onImageDragEnd,
    onImageDragOver,
    onImageDragLeave,
    onImageDrop,
    onShowUpgradeModal,
}: CardListProps) {
    return (
        <div className="lg:col-span-7 space-y-6">
            <div className="space-y-3">
                <div className="flex items-center gap-2">
                    <label htmlFor="deck-title-input" className="sr-only">Nome do Baralho</label>
                    <input
                        id="deck-title-input"
                        type="text"
                        value={deckTitle}
                        onChange={(e) => setDeckTitle(e.target.value)}
                        className="text-xl font-bold tracking-tight text-foreground bg-transparent border-b border-dashed border-gray-300 focus:border-brand outline-none w-full max-w-sm placeholder:text-gray-400 pb-1"
                        placeholder="Nome do seu baralho..."
                    />
                    {cards.length > 0 ? (
                        <span className="text-brand font-bold text-lg">({cards.length})</span>
                    ) : (
                        <span className="text-foreground/40 text-sm font-bold">Preview dos cards</span>
                    )}
                </div>
                {cards.length > 0 && (
                    <div className="flex flex-col sm:flex-row flex-wrap gap-2">
                        <button
                            onClick={onSaveLibrary}
                            disabled={isSaving || saveSuccess}
                            className={`w-full sm:w-auto flex items-center justify-center gap-2 border px-4 py-2 rounded-sm text-xs font-bold transition-all ${saveSuccess ? 'bg-green-50 border-green-200 text-green-600' : 'bg-white border-border hover:bg-gray-50 hover:border-brand/40 text-foreground shadow-sm hover:shadow-md'
                                }`}
                        >
                            {isSaving ? <Loader2 className="h-4 w-4 animate-spin" /> : saveSuccess ? <Check className="h-4 w-4" /> : <Library className="h-4 w-4 text-brand" />}
                            {saveSuccess ? 'Salvo!' : 'Salvar na Biblioteca'}
                        </button>
                        <button
                            onClick={onExportApkg}
                            disabled={isExportingApkg}
                            className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md disabled:opacity-60 disabled:cursor-not-allowed"
                        >
                            {isExportingApkg ? <Loader2 className="h-4 w-4 animate-spin" /> : <FileDown className="h-4 w-4 text-brand" />}
                            Anki (.apkg)
                        </button>
                        <button
                            onClick={onExportAnki}
                            className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                        >
                            <FileDown className="h-4 w-4 text-brand" />
                            Anki (.txt)
                        </button>
                        <button
                            onClick={onExportCsv}
                            className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                        >
                            <Download className="h-4 w-4 text-brand" />
                            CSV
                        </button>
                        <button
                            onClick={onExportPdf}
                            className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                        >
                            <Download className="h-4 w-4 text-brand" />
                            PDF
                        </button>
                        <button
                            onClick={onCopyToObsidian}
                            className="w-full sm:w-auto flex items-center justify-center gap-2 bg-white border border-border px-4 py-2 rounded-sm text-xs font-bold hover:bg-gray-50 hover:border-brand/40 transition-all text-foreground shadow-sm hover:shadow-md"
                        >
                            <Download className="h-4 w-4 text-brand" />
                            Obsidian
                        </button>
                        {savedDeckId && (
                            <button
                                onClick={onPublicLink}
                                disabled={publishingPublic}
                                className="w-full sm:w-auto flex items-center justify-center gap-2 bg-brand text-white border border-brand px-4 py-2 rounded-sm text-xs font-bold hover:bg-brand/90 transition-all shadow-sm disabled:opacity-60"
                            >
                                {publishingPublic ? <Loader2 className="h-4 w-4 animate-spin" /> : <Globe className="h-4 w-4" />}
                                Gerar link p\u00fablico
                            </button>
                        )}
                    </div>
                )}
            </div>

            {cards.length > 0 && (
                <div className="bg-white border border-border rounded-sm p-4 shadow-sm space-y-4">
                    <div className="space-y-1">
                        <label htmlFor="deck-description" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                            Descri\u00e7\u00e3o (opcional)
                        </label>
                        <textarea
                            id="deck-description"
                            value={deckDescription}
                            onChange={(event) => setDeckDescription(event.target.value)}
                            rows={2}
                            className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground/80 focus:ring-1 focus:ring-brand outline-none resize-none"
                            placeholder="Sobre o que \u00e9 este baralho?"
                        />
                    </div>
                    <div className="space-y-1">
                        <label htmlFor="deck-folder" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                            Pasta / Mat\u00e9ria {limits.allowFolders ? '' : '(Pro)'}
                        </label>
                        <div className="relative">
                            <select
                                id="deck-folder"
                                value={selectedFolder}
                                onChange={(e) => {
                                    if (!limits.allowFolders) {
                                        onShowUpgradeModal();
                                        return;
                                    }
                                    setSelectedFolder(e.target.value);
                                }}
                                className={`w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer ${!limits.allowFolders ? 'opacity-50' : ''}`}
                                disabled={!limits.allowFolders}
                            >
                                <option value="">Selecione uma pasta...</option>
                                {FOLDERS.map(f => (
                                    <option key={f} value={f}>{f}</option>
                                ))}
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    <div className="space-y-1">
                        <label htmlFor="deck-tags" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                            Tags (separadas por v\u00edrgulas)
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
                        Nenhum card gerado ainda. Cole seu texto ao lado para come\u00e7ar.
                    </p>
                </div>
            ) : (
                <div className="grid grid-cols-1 gap-4 text-foreground">
                    {cards.map((card, index) => (
                        <CardPreview
                            key={card.id}
                            card={card}
                            index={index}
                            dropTarget={dropTarget}
                            draggedImage={draggedImage}
                            onDeleteCard={onDeleteCard}
                            onUpdateCard={onUpdateCard}
                            onRemoveImage={onRemoveImage}
                            onImageDragStart={onImageDragStart}
                            onImageDragEnd={onImageDragEnd}
                            onImageDragOver={onImageDragOver}
                            onImageDragLeave={onImageDragLeave}
                            onImageDrop={onImageDrop}
                        />
                    ))}

                    <button
                        onClick={() => setCards(prev => [...prev, { id: Math.random().toString(), question: 'Nova pergunta...', answer: 'Nova resposta...', question_image_url: null, answer_image_url: null }])}
                        className="w-full py-4 border-2 border-dashed border-border rounded-sm text-foreground/40 font-bold hover:border-brand/40 hover:text-brand transition-all flex items-center justify-center gap-2 mt-4"
                    >
                        <Plus className="h-5 w-5" />
                        Adicionar Card Manualmente
                    </button>
                </div>
            )}
        </div>
    );
}
