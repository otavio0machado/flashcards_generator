import React from 'react';
import { AlertCircle } from 'lucide-react';
import type { Flashcard } from './types';

interface GeneratorActionsProps {
    isDemo: boolean;
    cards: Flashcard[];
    selectedIntent: string | null;
    showImageWarningModal: boolean;
    onSetShowImageWarningModal: (value: boolean) => void;
    onConfirmGenerate: () => void;
    onOpenAuthGate: (reason: string) => void;
    onIntentSelect: (intent: string) => void;
}

export function GeneratorActions({
    isDemo,
    cards,
    selectedIntent,
    showImageWarningModal,
    onSetShowImageWarningModal,
    onConfirmGenerate,
    onOpenAuthGate,
    onIntentSelect,
}: GeneratorActionsProps) {
    return (
        <>
            {isDemo && cards.length > 0 && (
                <div className="border border-brand/30 bg-brand/5 rounded-sm p-4 text-sm font-medium text-foreground space-y-4">
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                        <span>Pronto! Salve, exporte e gere mais flashcards com uma conta gr\u00e1tis.</span>
                        <div className="flex flex-col sm:flex-row gap-2">
                            <button
                                onClick={() => onOpenAuthGate('demo_cta_save_export')}
                                className="px-4 py-2 rounded-sm bg-brand text-white font-bold text-xs"
                            >
                                Salvar e Exportar (Criar conta gr\u00e1tis)
                            </button>
                            <button
                                onClick={() => onOpenAuthGate('demo_cta_more_cards')}
                                className="px-4 py-2 rounded-sm border border-brand text-brand font-bold text-xs"
                            >
                                Gerar mais 10 (crie conta)
                            </button>
                        </div>
                    </div>
                    <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs text-foreground/70">
                        <li>&#x2705; Exportar Anki (.apkg)</li>
                        <li>&#x2705; Exportar CSV</li>
                        <li>&#x2705; Hist\u00f3rico salvo</li>
                        <li>&#x2705; Mais limites e gera\u00e7\u00f5es</li>
                    </ul>
                    <div className="border-t border-brand/20 pt-3">
                        <div className="text-xs font-bold text-foreground/70 mb-2">Para que voc\u00ea est\u00e1 estudando?</div>
                        <div className="flex flex-wrap gap-2">
                            {['ENEM', 'Concurso', 'Faculdade', 'Idiomas', 'Outros'].map((intent) => (
                                <button
                                    key={intent}
                                    type="button"
                                    onClick={() => onIntentSelect(intent)}
                                    className={`px-3 py-1.5 rounded-sm text-[11px] font-bold border transition-all ${selectedIntent === intent ? 'bg-brand text-white border-brand' : 'bg-white border-border text-foreground/60 hover:border-brand/40'}`}
                                >
                                    {intent}
                                </button>
                            ))}
                        </div>
                    </div>
                </div>
            )}

            {isDemo && (
                <div className="fixed bottom-0 left-0 right-0 z-40 bg-white border-t border-border px-4 py-3 shadow-[0_-8px_20px_-12px_rgba(0,0,0,0.2)]">
                    <div className="max-w-7xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-3">
                        <span className="text-xs font-bold text-foreground/70">Voc\u00ea est\u00e1 no modo demo. Salve e exporte criando uma conta gratuita.</span>
                        <button
                            onClick={() => onOpenAuthGate('demo_sticky_cta')}
                            className="px-4 py-2 rounded-sm bg-brand text-white font-bold text-xs"
                        >
                            Criar conta para exportar
                        </button>
                    </div>
                </div>
            )}

            {/* Modal de aviso sobre geracao de imagens */}
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
                            A gera\u00e7\u00e3o de imagens ainda est\u00e1 em desenvolvimento e pode apresentar <strong>lentid\u00e3o</strong> durante o processo.
                        </p>
                        <p className="text-foreground font-medium mb-6">
                            Voc\u00ea deseja continuar mesmo assim?
                        </p>
                        <div className="flex flex-col sm:flex-row gap-3">
                            <button
                                onClick={() => onSetShowImageWarningModal(false)}
                                className="flex-1 px-4 py-3 border border-border rounded-sm font-bold text-foreground/70 hover:bg-gray-50 transition-colors"
                            >
                                N\u00e3o, vou testar depois
                            </button>
                            <button
                                onClick={onConfirmGenerate}
                                className="flex-1 px-4 py-3 bg-brand text-white rounded-sm font-bold hover:bg-brand/90 transition-colors"
                            >
                                Sim, desejo prosseguir
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}
