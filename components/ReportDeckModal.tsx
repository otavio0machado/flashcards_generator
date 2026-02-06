'use client';

import React, { useState } from 'react';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { X, Flag, Loader2 } from 'lucide-react';
import { supabase } from '@/lib/supabase';

interface ReportDeckModalProps {
    isOpen: boolean;
    onClose: () => void;
    deckId: string;
    onSuccess: () => void;
}

const REPORT_REASONS = [
    { value: 'inappropriate', label: 'Conteúdo impróprio ou ofensivo' },
    { value: 'incorrect', label: 'Informações incorretas ou enganosas' },
    { value: 'spam', label: 'Spam ou conteúdo promocional' },
    { value: 'copyright', label: 'Violação de direitos autorais' },
    { value: 'other', label: 'Outro motivo' },
] as const;

export default function ReportDeckModal({ isOpen, onClose, deckId, onSuccess }: ReportDeckModalProps) {
    const [reason, setReason] = useState('');
    const [details, setDetails] = useState('');
    const [submitting, setSubmitting] = useState(false);
    const [error, setError] = useState('');

    const handleSubmit = async () => {
        if (!reason) {
            setError('Selecione um motivo.');
            return;
        }

        setSubmitting(true);
        setError('');

        try {
            const { data: { session } } = await supabase.auth.getSession();
            if (!session) {
                setError('Faça login para enviar uma denúncia.');
                setSubmitting(false);
                return;
            }

            const { error: insertError } = await supabase
                .from('deck_reports')
                .insert({
                    deck_id: deckId,
                    user_id: session.user.id,
                    reason,
                    details: details.trim() || null,
                });

            if (insertError) {
                if (insertError.code === '23505') {
                    setError('Você já denunciou este deck.');
                } else {
                    console.error(insertError);
                    setError('Erro ao enviar denúncia. Tente novamente.');
                }
                setSubmitting(false);
                return;
            }

            onSuccess();
            handleClose();
        } catch {
            setError('Erro ao enviar denúncia. Tente novamente.');
            setSubmitting(false);
        }
    };

    const handleClose = () => {
        setReason('');
        setDetails('');
        setError('');
        setSubmitting(false);
        onClose();
    };

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isOpen && (
                    <div
                        className="fixed inset-0 z-[100] flex items-center justify-center p-4"
                        role="dialog"
                        aria-modal="true"
                        aria-labelledby="report-modal-title"
                    >
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/40 backdrop-blur-sm"
                            onClick={handleClose}
                            aria-hidden="true"
                        />

                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="relative w-full max-w-md bg-white rounded-sm shadow-2xl overflow-hidden z-10"
                        >
                            <div className="p-6">
                                <div className="flex items-start gap-4 mb-6">
                                    <div className="p-2 rounded-sm bg-red-50 text-red-500 shrink-0">
                                        <Flag className="h-5 w-5" />
                                    </div>
                                    <div className="flex-1 min-w-0">
                                        <h3 id="report-modal-title" className="text-lg font-bold text-foreground">
                                            Denunciar deck
                                        </h3>
                                        <p className="text-sm font-medium text-foreground/50 mt-1">
                                            Nos ajude a manter o marketplace seguro.
                                        </p>
                                    </div>
                                    <button
                                        onClick={handleClose}
                                        className="text-foreground/20 hover:text-foreground transition-colors p-1"
                                        aria-label="Fechar"
                                    >
                                        <X className="h-5 w-5" />
                                    </button>
                                </div>

                                <fieldset>
                                    <legend className="text-[10px] font-black uppercase tracking-widest text-foreground/40 mb-3">
                                        Motivo da denúncia
                                    </legend>
                                    <div className="space-y-2">
                                        {REPORT_REASONS.map((r) => (
                                            <label
                                                key={r.value}
                                                className={`flex items-center gap-3 p-3 rounded-sm border cursor-pointer transition-all ${
                                                    reason === r.value
                                                        ? 'border-brand bg-brand/5'
                                                        : 'border-border hover:border-foreground/20'
                                                }`}
                                            >
                                                <input
                                                    type="radio"
                                                    name="report-reason"
                                                    value={r.value}
                                                    checked={reason === r.value}
                                                    onChange={(e) => {
                                                        setReason(e.target.value);
                                                        setError('');
                                                    }}
                                                    className="accent-brand"
                                                />
                                                <span className="text-sm font-medium text-foreground/70">
                                                    {r.label}
                                                </span>
                                            </label>
                                        ))}
                                    </div>
                                </fieldset>

                                <div className="mt-4">
                                    <label
                                        htmlFor="report-details"
                                        className="text-[10px] font-black uppercase tracking-widest text-foreground/40 block mb-2"
                                    >
                                        Detalhes (opcional)
                                    </label>
                                    <textarea
                                        id="report-details"
                                        value={details}
                                        onChange={(e) => setDetails(e.target.value)}
                                        placeholder="Descreva o problema com mais detalhes..."
                                        maxLength={500}
                                        rows={3}
                                        className="w-full bg-gray-50 border border-border rounded-sm p-3 text-sm font-medium text-foreground placeholder:text-foreground/30 focus:outline-none focus:ring-1 focus:ring-brand resize-none"
                                    />
                                </div>

                                {error && (
                                    <p className="mt-3 text-sm font-bold text-red-500">{error}</p>
                                )}

                                <div className="mt-6 flex flex-col sm:flex-row gap-3 justify-end text-[10px] font-black uppercase tracking-wider">
                                    <button
                                        onClick={handleClose}
                                        className="px-6 py-3 border border-border rounded-sm hover:bg-gray-50 transition-all text-foreground/60"
                                    >
                                        Cancelar
                                    </button>
                                    <button
                                        onClick={handleSubmit}
                                        disabled={submitting || !reason}
                                        className="px-6 py-3 bg-red-500 text-white rounded-sm hover:bg-red-600 transition-all shadow-lg shadow-red-500/20 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                                    >
                                        {submitting ? (
                                            <Loader2 className="h-4 w-4 animate-spin" />
                                        ) : (
                                            <Flag className="h-3.5 w-3.5" />
                                        )}
                                        Enviar denúncia
                                    </button>
                                </div>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
