'use client';

import { FormEvent, useState } from 'react';
import { MessageSquare, Send, X } from 'lucide-react';
import { toast } from 'sonner';
import { usePathname } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { trackEvent } from '@/lib/analytics';

export default function FeedbackWidget() {
    const pathname = usePathname();
    const isAppPage = pathname?.startsWith('/app');
    const [open, setOpen] = useState(false);
    const [message, setMessage] = useState('');
    const [email, setEmail] = useState('');
    const [submitting, setSubmitting] = useState(false);

    const handleSubmit = async (e: FormEvent) => {
        e.preventDefault();
        if (!message.trim()) {
            toast.error('Mensagem obrigatoria.');
            return;
        }

        setSubmitting(true);
        const { error } = await supabase.from('feedback').insert({
            message: message.trim(),
            email: email.trim() || null,
            page_path: pathname,
        });

        if (error) {
            console.error('Feedback error:', error);
            toast.error('Nao foi possivel enviar o feedback.');
        } else {
            toast.success('Feedback enviado. Obrigado!');
            trackEvent('feedback_submitted', { page: pathname });
            setMessage('');
            setEmail('');
            setOpen(false);
        }

        setSubmitting(false);
    };

    return (
        <>
            <button
                type="button"
                onClick={() => setOpen(true)}
                className={`fixed ${isAppPage ? 'bottom-24' : 'bottom-6'} right-6 z-[200] bg-brand text-white px-4 py-2 rounded-sm font-bold text-xs shadow-lg shadow-brand/20 flex items-center gap-2 hover:bg-brand/90 transition-colors`}
            >
                <MessageSquare className="h-4 w-4" />
                Feedback
            </button>

            {open && (
                <div className="fixed inset-0 z-[210] flex items-center justify-center bg-black/40 p-4">
                    <div className="w-full max-w-md bg-white border border-border rounded-sm shadow-xl">
                        <div className="flex items-center justify-between px-5 py-4 border-b border-border">
                            <h3 className="text-sm font-bold">Enviar feedback</h3>
                            <button
                                type="button"
                                onClick={() => setOpen(false)}
                                className="text-foreground/40 hover:text-foreground transition-colors"
                                aria-label="Fechar"
                            >
                                <X className="h-4 w-4" />
                            </button>
                        </div>
                        <form onSubmit={handleSubmit} className="px-5 py-4 space-y-4">
                            <div className="space-y-1">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40">
                                    Mensagem
                                </label>
                                <textarea
                                    value={message}
                                    onChange={(e) => setMessage(e.target.value)}
                                    rows={4}
                                    className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm focus:ring-1 focus:ring-brand outline-none resize-none"
                                    placeholder="O que podemos melhorar?"
                                    required
                                />
                            </div>
                            <div className="space-y-1">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40">
                                    Email (opcional)
                                </label>
                                <input
                                    type="email"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm focus:ring-1 focus:ring-brand outline-none"
                                    placeholder="voce@email.com"
                                />
                            </div>
                            <button
                                type="submit"
                                disabled={submitting}
                                className="w-full bg-brand text-white py-2 rounded-sm text-xs font-bold uppercase tracking-widest flex items-center justify-center gap-2 hover:bg-brand/90 transition-colors disabled:opacity-60"
                            >
                                {submitting ? 'Enviando...' : (
                                    <>
                                        <Send className="h-4 w-4" />
                                        Enviar
                                    </>
                                )}
                            </button>
                        </form>
                    </div>
                </div>
            )}
        </>
    );
}
