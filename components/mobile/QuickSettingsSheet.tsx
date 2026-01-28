'use client';

import React from 'react';
import { SheetModal } from '@/components/ios';
import { Sliders, BookOpen, Target, Palette, Image } from 'lucide-react';

type StudyLevel = 'ENEM' | 'Faculdade' | 'Concurso';
type StudyGoal = 'Memorizar' | 'Revisar rápido' | 'Aprofundar';
type CardStyle = 'basic' | 'short_answer' | 'image_occlusion';

interface QuickSettingsSheetProps {
    open: boolean;
    onClose: () => void;
    studyLevel: StudyLevel;
    onStudyLevelChange: (level: StudyLevel) => void;
    studyGoal: StudyGoal;
    onStudyGoalChange: (goal: StudyGoal) => void;
    cardStyle: CardStyle;
    onCardStyleChange: (style: CardStyle) => void;
    cardCount: number;
    onCardCountChange: (count: number) => void;
    maxCards: number;
    generateImages: boolean;
    onGenerateImagesChange: (value: boolean) => void;
    allowImageGeneration: boolean;
}

const STUDY_LEVELS: { id: StudyLevel; label: string; icon: string }[] = [
    { id: 'ENEM', label: 'ENEM', icon: '📚' },
    { id: 'Faculdade', label: 'Faculdade', icon: '🎓' },
    { id: 'Concurso', label: 'Concurso', icon: '📋' },
];

const STUDY_GOALS: { id: StudyGoal; label: string; description: string }[] = [
    { id: 'Memorizar', label: 'Memorizar', description: 'Foco em repetição' },
    { id: 'Revisar rápido', label: 'Revisar', description: 'Revisão ágil' },
    { id: 'Aprofundar', label: 'Aprofundar', description: 'Estudo detalhado' },
];

const CARD_STYLES: { id: CardStyle; label: string }[] = [
    { id: 'basic', label: 'Q&A Básico' },
    { id: 'short_answer', label: 'Resposta Curta' },
    { id: 'image_occlusion', label: 'Oclusão' },
];

export default function QuickSettingsSheet({
    open,
    onClose,
    studyLevel,
    onStudyLevelChange,
    studyGoal,
    onStudyGoalChange,
    cardStyle,
    onCardStyleChange,
    cardCount,
    onCardCountChange,
    maxCards,
    generateImages,
    onGenerateImagesChange,
    allowImageGeneration,
}: QuickSettingsSheetProps) {
    return (
        <SheetModal
            open={open}
            onClose={onClose}
            title="Configurações"
            detent="large"
        >
            <div className="px-4 py-6 space-y-8">
                {/* Study Level */}
                <section>
                    <div className="flex items-center gap-2 mb-3">
                        <BookOpen className="w-4 h-4 text-brand" />
                        <h3 className="text-sm font-bold text-[var(--label)]">Nível de Estudo</h3>
                    </div>
                    <div className="grid grid-cols-3 gap-2">
                        {STUDY_LEVELS.map((level) => (
                            <button
                                key={level.id}
                                onClick={() => onStudyLevelChange(level.id)}
                                className={`
                                    flex flex-col items-center gap-1 p-3
                                    rounded-[var(--corner-card)] border-2
                                    transition-all active:scale-95
                                    ${studyLevel === level.id
                                        ? 'border-brand bg-brand/5'
                                        : 'border-zinc-100 dark:border-zinc-800'
                                    }
                                `}
                            >
                                <span className="text-xl">{level.icon}</span>
                                <span className={`text-xs font-bold ${studyLevel === level.id ? 'text-brand' : 'text-zinc-500'}`}>
                                    {level.label}
                                </span>
                            </button>
                        ))}
                    </div>
                </section>

                {/* Study Goal */}
                <section>
                    <div className="flex items-center gap-2 mb-3">
                        <Target className="w-4 h-4 text-brand" />
                        <h3 className="text-sm font-bold text-[var(--label)]">Objetivo</h3>
                    </div>
                    <div className="space-y-2">
                        {STUDY_GOALS.map((goal) => (
                            <button
                                key={goal.id}
                                onClick={() => onStudyGoalChange(goal.id)}
                                className={`
                                    w-full flex items-center justify-between p-3
                                    rounded-[var(--corner-card)] border-2
                                    transition-all active:scale-[0.98]
                                    ${studyGoal === goal.id
                                        ? 'border-brand bg-brand/5'
                                        : 'border-zinc-100 dark:border-zinc-800'
                                    }
                                `}
                            >
                                <span className={`text-sm font-bold ${studyGoal === goal.id ? 'text-brand' : 'text-[var(--label)]'}`}>
                                    {goal.label}
                                </span>
                                <span className="text-xs text-zinc-400">{goal.description}</span>
                            </button>
                        ))}
                    </div>
                </section>

                {/* Card Style */}
                <section>
                    <div className="flex items-center gap-2 mb-3">
                        <Palette className="w-4 h-4 text-brand" />
                        <h3 className="text-sm font-bold text-[var(--label)]">Estilo de Card</h3>
                    </div>
                    <div className="flex flex-wrap gap-2">
                        {CARD_STYLES.map((style) => (
                            <button
                                key={style.id}
                                onClick={() => onCardStyleChange(style.id)}
                                className={`
                                    px-4 py-2 rounded-full text-xs font-bold
                                    border-2 transition-all active:scale-95
                                    ${cardStyle === style.id
                                        ? 'border-brand bg-brand/5 text-brand'
                                        : 'border-zinc-100 dark:border-zinc-800 text-zinc-500'
                                    }
                                `}
                            >
                                {style.label}
                            </button>
                        ))}
                    </div>
                </section>

                {/* Card Count Slider */}
                <section>
                    <div className="flex items-center gap-2 mb-3">
                        <Sliders className="w-4 h-4 text-brand" />
                        <h3 className="text-sm font-bold text-[var(--label)]">Quantidade de Cards</h3>
                    </div>
                    <div className="px-2">
                        <div className="flex items-center justify-between mb-2">
                            <span className="text-xs text-zinc-400">5</span>
                            <span className="text-2xl font-black text-brand">{cardCount}</span>
                            <span className="text-xs text-zinc-400">{maxCards}</span>
                        </div>
                        <input
                            type="range"
                            min={5}
                            max={maxCards}
                            step={1}
                            value={cardCount}
                            onChange={(e) => onCardCountChange(Number(e.target.value))}
                            className="w-full h-2 bg-zinc-200 dark:bg-zinc-700 rounded-full appearance-none cursor-pointer accent-brand"
                            aria-label={`Quantidade de cards: ${cardCount}`}
                        />
                    </div>
                </section>

                {/* Image Generation Toggle */}
                <section className={!allowImageGeneration ? 'opacity-50' : ''}>
                    <div className="flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-800/50 rounded-[var(--corner-card)]">
                        <div className="flex items-center gap-3">
                            <div className="p-2 bg-brand/10 rounded-[var(--corner-card)]">
                                <Image className="w-5 h-5 text-brand" />
                            </div>
                            <div>
                                <h3 className="text-sm font-bold text-[var(--label)]">Gerar Imagens</h3>
                                <p className="text-xs text-zinc-400">Ilustrações com IA</p>
                            </div>
                        </div>
                        <button
                            onClick={() => allowImageGeneration && onGenerateImagesChange(!generateImages)}
                            disabled={!allowImageGeneration}
                            className={`
                                w-12 h-7 rounded-full relative transition-colors
                                ${generateImages && allowImageGeneration ? 'bg-brand' : 'bg-zinc-300 dark:bg-zinc-600'}
                            `}
                            role="switch"
                            aria-checked={generateImages}
                            aria-label="Gerar imagens com IA"
                        >
                            <div
                                className={`
                                    absolute top-1 w-5 h-5 bg-white rounded-full shadow
                                    transition-all
                                    ${generateImages && allowImageGeneration ? 'left-6' : 'left-1'}
                                `}
                            />
                        </button>
                    </div>
                    {!allowImageGeneration && (
                        <p className="text-xs text-zinc-400 mt-2 text-center">
                            Disponível no plano Ultimate
                        </p>
                    )}
                </section>

                {/* Apply Button */}
                <button
                    onClick={onClose}
                    className="w-full py-4 bg-brand text-white font-bold rounded-[var(--corner-card)] active:scale-[0.98] transition-transform shadow-lg shadow-brand/20"
                >
                    Aplicar Configurações
                </button>
            </div>
        </SheetModal>
    );
}
