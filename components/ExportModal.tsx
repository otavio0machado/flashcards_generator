'use client';

import React, { useState } from 'react';
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

    const handleExportApkg = async () => {
        if (exportingApkg) return;
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

    return (
        <div
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-in fade-in duration-200"
            role="dialog"
            aria-modal="true"
            aria-labelledby="export-modal-title"
        >
            <div className="bg-white rounded-sm shadow-xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
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
                    <div className="mb-6">
                        <p className="text-sm font-medium text-foreground/60 mb-2">Baralho selecionado:</p>
                        <p className="text-lg font-bold text-foreground">{deck.title}</p>
                        <p className="text-xs font-bold text-brand uppercase tracking-wider mt-1">{deck.cards.length} CARDS</p>
                    </div>

                    <div className="space-y-3">
                        <button
                            onClick={handleExportApkg}
                            disabled={exportingApkg}
                            className="w-full flex items-center justify-between p-4 border border-border rounded-sm hover:border-brand/40 hover:bg-gray-50 transition-all group text-left disabled:opacity-60 disabled:cursor-not-allowed"
                        >
                            <div className="flex items-center gap-3">
                                <div className="h-10 w-10 bg-brand/10 rounded-sm flex items-center justify-center group-hover:bg-brand group-hover:text-white transition-colors text-brand">
                                    {exportingApkg ? <Loader2 className="h-5 w-5 animate-spin" /> : <FileDown className="h-5 w-5" />}
                                </div>
                                <div>
                                    <h4 className="font-bold text-foreground group-hover:text-brand transition-colors">Anki (.apkg)</h4>
                                    <p className="text-xs text-foreground/50 font-medium">Pacote completo para importar direto no Anki.</p>
                                </div>
                            </div>
                            <Download className="h-4 w-4 text-foreground/20 group-hover:text-brand" />
                        </button>
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
