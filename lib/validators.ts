
import { z } from 'zod';

export const CardSchema = z.object({
    front: z.string().min(1, "Frente do card é obrigatória").max(1000, "Texto muito longo"),
    back: z.string().min(1, "Verso do card é obrigatório").max(2000, "Texto muito longo"),
    image_url: z.string().url().optional().nullable(),
    question_image_url: z.string().url().optional().nullable(),
    answer_image_url: z.string().url().optional().nullable(),
    order: z.number().int().optional(),
});

export const CreateDeckSchema = z.object({
    title: z.string().min(3, "O título deve ter pelo menos 3 caracteres").max(100),
    description: z.string().max(500).optional(),
    is_public: z.boolean().default(false),
    tags: z.array(z.string()).optional(),
    cards: z.array(CardSchema).min(1, "O baralho deve ter pelo menos 1 card"),
    category_id: z.string().uuid().optional().nullable(),
    price: z.number().min(0).default(0),
});

export const UpdateDeckSchema = CreateDeckSchema.partial().extend({
    id: z.string().uuid(),
});

// New Schemas for Generation API
export const GenerateOptionsSchema = z.object({
    text: z.string().optional(),
    language: z.string().default('Português'),
    difficulty: z.string().default('Intermediário'),
    studyLevel: z.string().default('ENEM'),
    studyGoal: z.string().default('Memorizar'),
    templateType: z.string().default('geral'),
    cardStyle: z.enum(['basic', 'short_answer', 'image_occlusion']).default('basic'),
    cardCount: z.union([z.string(), z.number()])
        .transform((val) => typeof val === 'string' ? parseInt(val, 10) : val)
        .optional(),
    imageCount: z.union([z.string(), z.number()])
        .transform((val) => typeof val === 'string' ? parseInt(val, 10) : val)
        .optional(),
    generateImages: z.union([z.boolean(), z.string()])
        .transform((val) => val === true || val === 'true' || val === '1')
        .default(false),
    enemMode: z.union([z.boolean(), z.string()])
        .transform((val) => val === true || val === 'true' || val === '1')
        .default(false),
    autoTags: z.union([z.boolean(), z.string()])
        .transform((val) => val === true || val === 'true' || val === '1')
        .default(false),
});

export type CreateDeckInput = z.infer<typeof CreateDeckSchema>;
export type CardInput = z.infer<typeof CardSchema>;
export type GenerateOptionsInput = z.infer<typeof GenerateOptionsSchema>;
