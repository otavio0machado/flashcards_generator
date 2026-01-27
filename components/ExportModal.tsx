'use client';

import React, { useState } from 'react';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { X, FileDown, Table, Download, Loader2 } from 'lucide-react';

interface Card {
    front?: string;
    back?: string;
    question?: string;
    answer?: string;
    image_url?: string | null;
    imageUrl?: string | null;
}

interface Deck {
    title: string;
    cards: Card[];
}

interface ExportModalProps {
    isOpen: boolean;
    onClose: () => void;
    deck: Deck | null;
}

export default function ExportModal({ isOpen, onClose, deck }: ExportModalProps) {
    const [exportingApkg, setExportingApkg] = useState(false);

    const getSafeFileName = (title: string) => {
        return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';
    };

    const handleExportAnki = () => {
        if (!deck) return;
        const content = deck.cards.map(c => {
            const front = c.front || c.question || '';
            const back = c.back || c.answer || '';
            return `${front}\t${back}`;
        }).join('\n');

        downloadFile(content, `${getSafeFileName(deck.title)}-anki.txt`, 'text/plain;charset=utf-8');
        onClose();
    };

    const handleExportApkg = async () => {
        if (exportingApkg || !deck) return;
        setExportingApkg(true);
        try {
            const response = await fetch('/api/export/anki', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    title: deck.title,
                    cards: deck.cards
                })
            });

            if (!response.ok) {
                const errorData = await response.json().catch(() => ({}));
                throw new Error(errorData.error || 'Erro ao exportar .apkg');
            }

            const blob = await response.blob();
            downloadBlob(blob, `${getSafeFileName(deck.title)}.apkg`);
            onClose();
        } catch (error) {
            console.error('Erro ao exportar .apkg:', error);
            alert('Erro ao exportar arquivo .apkg. Tente novamente.');
        } finally {
            setExportingApkg(false);
        }
    };

    const handleExportCsv = () => {
        if (!deck) return;
        const header = "Front,Back\n";
        const content = deck.cards.map(c => {
            const front = c.front || c.question || '';
            const back = c.back || c.answer || '';
            const safeFront = `"${front.replace(/"/g, '""')}"`;
            const safeBack = `"${back.replace(/"/g, '""')}"`;
            return `${safeFront},${safeBack}`;
        }).join('\n');

        downloadFile(header + content, `${getSafeFileName(deck.title)}.csv`, 'text/csv;charset=utf-8');
        onClose();
    };

    const downloadBlob = (blob: Blob, filename: string) => {
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(url);
    };

    const downloadFile = (content: string, filename: string, type: string) => {
        const blob = new Blob([content], { type });
        downloadBlob(blob, filename);
    };

    const exportOptions = [
        {
            id: 'apkg',
            title: 'Anki (.apkg)',
            description: 'Pacote completo para importar direto no Anki.',
            icon: FileDown,
            iconBg: 'bg-brand/10',
            iconHoverBg: 'group-hover:bg-brand',
            iconColor: 'text-brand',
            hoverColor: 'group-hover:text-brand',
            onClick: handleExportApkg,
            loading: exportingApkg
        },
        {
            id: 'txt',
            title: 'Anki Deck (.txt)',
            description: 'Melhor para importação direta no Anki.',
            icon: FileDown,
            iconBg: 'bg-brand/10',
            iconHoverBg: 'group-hover:bg-brand',
            iconColor: 'text-brand',
            hoverColor: 'group-hover:text-brand',
            onClick: handleExportAnki,
            loading: false
        },
        {
            id: 'csv',
            title: 'Planilha Excel/CSV',
            description: 'Compatível com Excel, Sheets, Quizlet.',
            icon: Table,
            iconBg: 'bg-green-50',
            iconHoverBg: 'group-hover:bg-green-500',
            iconColor: 'text-green-600',
            hoverColor: 'group-hover:text-green-600',
            onClick: handleExportCsv,
            loading: false
        }
    ];

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isOpen && deck && (
                    <div
                        className="fixed inset-0 z-50 flex items-center justify-center p-4"
                        role="dialog"
                        aria-modal="true"
                        aria-labelledby="export-modal-title"
                    >
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/50 backdrop-blur-sm"
                            onClick={onClose}
                        />
                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="bg-white rounded-sm shadow-xl w-full max-w-md overflow-hidden relative z-10"
                        >
                            <div className="flex items-center justify-between p-6 border-b border-border">
                                <h3 id="export-modal-title" className="text-xl font-bold tracking-tight">Exportar Baralho</h3>
                                <button
                                    onClick={onClose}
                                    className="text-foreground/40 hover:text-foreground transition-colors"
                                    aria-label="Fechar modal"
                                >
                                    <X className="h-5 w-5" aria-hidden="true" />
                                </button>
                            </div>

                            <div className="p-6">
                                <m.div
                                    initial={{ opacity: 0, y: 10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.1 }}
                                    className="mb-6"
                                >
                                    <p className="text-sm font-medium text-foreground/60 mb-2">Baralho selecionado:</p>
                                    <p className="text-lg font-bold text-foreground">{deck.title}</p>
                                    <p className="text-xs font-bold text-brand uppercase tracking-wider mt-1">{deck.cards.length} CARDS</p>
                                </m.div>

                                <div className="space-y-3">
                                    {exportOptions.map((option, index) => (
                                        <m.button
                                            key={option.id}
                                            initial={{ opacity: 0, x: -10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.15 + index * 0.05 }}
                                            whileHover={{ scale: 1.01, x: 4 }}
                                            whileTap={{ scale: 0.99 }}
                                            onClick={option.onClick}
                                            disabled={option.loading}
                                            className="w-full flex items-center justify-between p-4 border border-border rounded-sm hover:border-brand/40 hover:bg-gray-50 transition-all group text-left disabled:opacity-60 disabled:cursor-not-allowed"
                                        >
                                            <div className="flex items-center gap-3">
                                                <div className={`h-10 w-10 ${option.iconBg} rounded-sm flex items-center justify-center ${option.iconHoverBg} group-hover:text-white transition-colors ${option.iconColor}`}>
                                                    {option.loading ? <Loader2 className="h-5 w-5 animate-spin" /> : <option.icon className="h-5 w-5" />}
                                                </div>
                                                <div>
                                                    <h4 className={`font-bold text-foreground ${option.hoverColor} transition-colors`}>{option.title}</h4>
                                                    <p className="text-xs text-foreground/50 font-medium">{option.description}</p>
                                                </div>
                                            </div>
                                            <Download className={`h-4 w-4 text-foreground/20 ${option.hoverColor}`} />
                                        </m.button>
                                    ))}
                                </div>
                            </div>

                            <div className="p-4 bg-gray-50 border-t border-border flex justify-end">
                                <button
                                    onClick={onClose}
                                    className="px-4 py-2 font-bold text-sm text-foreground/60 hover:text-foreground transition-colors"
                                >
                                    Cancelar
                                </button>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
