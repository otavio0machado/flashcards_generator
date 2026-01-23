'use client';

import React from 'react';
import { X, FileDown, Table, Download } from 'lucide-react';

interface Card {
    front?: string;
    back?: string;
    question?: string;
    answer?: string;
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
    if (!isOpen || !deck) return null;

    const getSafeFileName = (title: string) => {
        return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';
    };

    const handleExportAnki = () => {
        const content = deck.cards.map(c => {
            const front = c.front || c.question || '';
            const back = c.back || c.answer || '';
            return `${front}\t${back}`;
        }).join('\n');

        downloadFile(content, `${getSafeFileName(deck.title)}-anki.txt`, 'text/plain;charset=utf-8');
        onClose();
    };

    const handleExportCsv = () => {
        const header = "Front,Back\n";
        const content = deck.cards.map(c => {
            const front = c.front || c.question || '';
            const back = c.back || c.answer || '';
            // Escape quotes by doubling them, and wrap fields in quotes
            const safeFront = `"${front.replace(/"/g, '""')}"`;
            const safeBack = `"${back.replace(/"/g, '""')}"`;
            return `${safeFront},${safeBack}`;
        }).join('\n');

        downloadFile(header + content, `${getSafeFileName(deck.title)}.csv`, 'text/csv;charset=utf-8');
        onClose();
    };

    const downloadFile = (content: string, filename: string, type: string) => {
        const blob = new Blob([content], { type });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(url);
    };

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-in fade-in duration-200">
            <div className="bg-white rounded-sm shadow-xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
                <div className="flex items-center justify-between p-6 border-b border-border">
                    <h3 className="text-xl font-bold tracking-tight">Exportar Baralho</h3>
                    <button
                        onClick={onClose}
                        className="text-foreground/40 hover:text-foreground transition-colors"
                    >
                        <X className="h-5 w-5" />
                    </button>
                </div>

                <div className="p-6">
                    <div className="mb-6">
                        <p className="text-sm font-medium text-foreground/60 mb-2">Baralho selecionado:</p>
                        <p className="text-lg font-bold text-foreground">{deck.title}</p>
                        <p className="text-xs font-bold text-brand uppercase tracking-wider mt-1">{deck.cards.length} CARDS</p>
                    </div>

                    <div className="space-y-3">
                        <button
                            onClick={handleExportAnki}
                            className="w-full flex items-center justify-between p-4 border border-border rounded-sm hover:border-brand/40 hover:bg-gray-50 transition-all group text-left"
                        >
                            <div className="flex items-center gap-3">
                                <div className="h-10 w-10 bg-brand/10 rounded-sm flex items-center justify-center group-hover:bg-brand group-hover:text-white transition-colors text-brand">
                                    <FileDown className="h-5 w-5" />
                                </div>
                                <div>
                                    <h4 className="font-bold text-foreground group-hover:text-brand transition-colors">Anki Deck (.txt)</h4>
                                    <p className="text-xs text-foreground/50 font-medium">Melhor para importação direta no Anki.</p>
                                </div>
                            </div>
                            <Download className="h-4 w-4 text-foreground/20 group-hover:text-brand" />
                        </button>

                        <button
                            onClick={handleExportCsv}
                            className="w-full flex items-center justify-between p-4 border border-border rounded-sm hover:border-brand/40 hover:bg-gray-50 transition-all group text-left"
                        >
                            <div className="flex items-center gap-3">
                                <div className="h-10 w-10 bg-green-50 rounded-sm flex items-center justify-center group-hover:bg-green-500 group-hover:text-white transition-colors text-green-600">
                                    <Table className="h-5 w-5" />
                                </div>
                                <div>
                                    <h4 className="font-bold text-foreground group-hover:text-green-600 transition-colors">Planilha Excel/CSV</h4>
                                    <p className="text-xs text-foreground/50 font-medium">Compatível com Excel, Sheets, Quizlet.</p>
                                </div>
                            </div>
                            <Download className="h-4 w-4 text-foreground/20 group-hover:text-green-600" />
                        </button>
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
            </div>
        </div>
    );
}
