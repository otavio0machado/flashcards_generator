import React from 'react';
import {
    Loader2,
    Check,
    FileText,
} from 'lucide-react';
import { PDF_PREVIEW_INITIAL_PAGES } from './types';
import type { PdfPreview } from './types';

interface FileUploadSectionProps {
    uploadedFiles: File[];
    pdfPreviews: PdfPreview[];
    onRemoveFile: (file: File) => void;
    onTogglePdfPageSelection: (fileId: string, pageNumber: number) => void;
    onSelectAllPdfPages: (fileId: string) => void;
    onClearPdfPages: (fileId: string) => void;
    onRenderAllPdfPages: (fileId: string) => void;
    onRenderPdfPage: (fileId: string, pageNumber: number) => void;
}

export function FileUploadSection({
    uploadedFiles,
    pdfPreviews,
    onRemoveFile,
    onTogglePdfPageSelection,
    onSelectAllPdfPages,
    onClearPdfPages,
    onRenderAllPdfPages,
    onRenderPdfPage,
}: FileUploadSectionProps) {
    if (uploadedFiles.length === 0) return null;

    return (
        <div className="mt-3 space-y-2">
            {uploadedFiles.map((file, idx) => (
                <div key={`${file.name}-${idx}`} className="flex items-center justify-between text-xs font-bold bg-gray-50 border border-border rounded-sm px-3 py-2">
                    <div className="flex items-center gap-2 min-w-0">
                        <span className="text-brand">Anexo {idx + 1}:</span>
                        <span className="truncate text-foreground/70">{file.name}</span>
                    </div>
                    <button
                        type="button"
                        onClick={() => onRemoveFile(file)}
                        className="text-[10px] uppercase tracking-wider text-foreground/40 hover:text-brand transition-colors"
                    >
                        Remover
                    </button>
                </div>
            ))}

            {pdfPreviews.length > 0 && (
                <div className="space-y-4 mt-4">
                    {pdfPreviews.map((preview) => {
                        const isAllSelected = preview.selectedPages.length === preview.pageCount;
                        return (
                            <div key={preview.fileId} className="border border-border rounded-sm p-4 bg-white">
                                <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                                    <div className="flex items-center gap-2">
                                        <div className="bg-brand/10 text-brand p-2 rounded-sm">
                                            <FileText className="h-4 w-4" />
                                        </div>
                                        <div>
                                            <p className="text-xs font-bold text-foreground">Pr\u00e9via do PDF</p>
                                            <p className="text-[11px] text-foreground/60 font-medium truncate max-w-xs">{preview.fileName}</p>
                                        </div>
                                    </div>
                                    <div className="flex flex-wrap gap-2">
                                        <button
                                            type="button"
                                            onClick={() => onSelectAllPdfPages(preview.fileId)}
                                            className={`px-3 py-1 rounded-sm text-[10px] font-bold border transition-all ${isAllSelected ? 'bg-brand text-white border-brand' : 'bg-gray-50 text-foreground/70 border-border hover:border-brand/40'}`}
                                        >
                                            Selecionar todas
                                        </button>
                                        <button
                                            type="button"
                                            onClick={() => onClearPdfPages(preview.fileId)}
                                            className="px-3 py-1 rounded-sm text-[10px] font-bold border bg-gray-50 text-foreground/60 border-border hover:border-brand/40"
                                        >
                                            Limpar sele\u00e7\u00e3o
                                        </button>
                                        <button
                                            type="button"
                                            onClick={() => onRenderAllPdfPages(preview.fileId)}
                                            className="px-3 py-1 rounded-sm text-[10px] font-bold border bg-gray-50 text-foreground/60 border-border hover:border-brand/40"
                                        >
                                            Carregar pr\u00e9vias
                                        </button>
                                    </div>
                                </div>

                                <p className="mt-3 text-[10px] font-bold text-foreground/40">
                                    Pr\u00e9via r\u00e1pida carrega s\u00f3 as {PDF_PREVIEW_INITIAL_PAGES} primeiras p\u00e1ginas para acelerar.
                                </p>

                                {preview.isLoading && (
                                    <div className="mt-4 flex items-center gap-2 text-xs text-foreground/60">
                                        <Loader2 className="h-4 w-4 animate-spin" />
                                        Carregando p\u00e1ginas...
                                    </div>
                                )}

                                {preview.error && (
                                    <div className="mt-4 text-xs font-bold text-red-500">{preview.error}</div>
                                )}

                                {!preview.isLoading && !preview.error && (
                                    <div className="mt-4 grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-5 gap-3">
                                        {preview.pages.map((page) => {
                                            const selected = preview.selectedPages.includes(page.pageNumber);
                                            return (
                                                <button
                                                    key={`${preview.fileId}-${page.pageNumber}`}
                                                    type="button"
                                                    onClick={() => {
                                                        onTogglePdfPageSelection(preview.fileId, page.pageNumber);
                                                        if (!page.dataUrl && !page.isRendering) {
                                                            onRenderPdfPage(preview.fileId, page.pageNumber);
                                                        }
                                                    }}
                                                    className={`relative border rounded-sm overflow-hidden transition-all ${selected ? 'border-brand ring-2 ring-brand/30' : 'border-border hover:border-brand/40'}`}
                                                >
                                                    {page.dataUrl ? (
                                                        <img
                                                            src={page.dataUrl}
                                                            alt={`P\u00e1gina ${page.pageNumber}`}
                                                            className="w-full h-auto object-cover"
                                                        />
                                                    ) : (
                                                        <div className="flex flex-col items-center justify-center bg-gray-50 text-foreground/60 text-[10px] font-bold h-36">
                                                            {page.isRendering ? (
                                                                <Loader2 className="h-4 w-4 animate-spin" />
                                                            ) : (
                                                                <span>Pr\u00e9via r\u00e1pida</span>
                                                            )}
                                                            <span className="mt-1">P\u00e1gina {page.pageNumber}</span>
                                                        </div>
                                                    )}
                                                    <div className="absolute inset-x-0 bottom-0 bg-white/90 text-[10px] font-bold text-foreground/70 px-2 py-1 flex items-center justify-between">
                                                        <span>P\u00e1gina {page.pageNumber}</span>
                                                        {selected && <Check className="h-3 w-3 text-brand" />}
                                                    </div>
                                                </button>
                                            );
                                        })}
                                    </div>
                                )}
                            </div>
                        );
                    })}
                </div>
            )}
        </div>
    );
}
