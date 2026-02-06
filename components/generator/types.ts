export interface Flashcard {
    id: string;
    question: string;
    answer: string;
    question_image_url?: string | null;
    answer_image_url?: string | null;
}

export type ImageDropTarget = {
    cardId: string;
    section: 'question' | 'answer';
};

export type PdfPagePreview = {
    pageNumber: number;
    dataUrl?: string;
    width?: number;
    height?: number;
    isRendering?: boolean;
};

export type PdfPreview = {
    fileId: string;
    fileName: string;
    pageCount: number;
    pages: PdfPagePreview[];
    selectedPages: number[];
    isLoading: boolean;
    error?: string;
};

export type TemplateOption = {
    key: string;
    label: string;
    placeholder: string;
};

export const TEMPLATE_OPTIONS: TemplateOption[] = [
    {
        key: 'resumo',
        label: 'Resumo \u2192 Flashcards',
        placeholder: 'Cole um resumo estruturado para transformar em flashcards.'
    },
    {
        key: 'questoes_erradas',
        label: 'Quest\u00f5es erradas \u2192 Flashcards',
        placeholder: 'Cole quest\u00f5es que voc\u00ea errou e as respostas corretas.'
    },
    {
        key: 'apostila_topicos',
        label: 'Apostila \u2192 Flashcards (t\u00f3picos)',
        placeholder: 'Cole t\u00f3picos e subt\u00f3picos de uma apostila.'
    },
    {
        key: 'lei_seca',
        label: 'Lei seca \u2192 Flashcards (artigos)',
        placeholder: 'Cole artigos/trechos da lei para memorizar.'
    },
    {
        key: 'biologia_processos',
        label: 'Biologia: processos \u2192 cards',
        placeholder: 'Cole processos biol\u00f3gicos e etapas.'
    },
    {
        key: 'matematica_formula',
        label: 'Matem\u00e1tica: f\u00f3rmula \u2192 defini\u00e7\u00e3o + aplica\u00e7\u00e3o + pegadinha',
        placeholder: 'Cole f\u00f3rmulas e conceitos matem\u00e1ticos.'
    },
];

export const PDF_PREVIEW_INITIAL_PAGES = 6;

export const FOLDERS = ['Biologia', 'Qu\u00edmica', 'F\u00edsica', 'Matem\u00e1tica', 'Hist\u00f3ria', 'Geografia', 'Portugu\u00eas', 'Literatura', 'Ingl\u00eas', 'Espanhol', 'Filosofia', 'Sociologia'];
