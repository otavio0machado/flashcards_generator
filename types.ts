export interface Category {
  id: string;
  name: string;
  slug: string;
  parent_id: string | null;
  created_at: string;
}

export interface Deck {
  id: string;
  user_id: string; // Unified from author_id
  title: string;
  description?: string | null;
  price: number;
  category_id?: string | null;
  tags: string[];
  is_verified: boolean;
  rating: number;
  rating_count: number;
  is_public: boolean;
  published_at?: string | null;
  created_at: string;
  updated_at: string;
}

export type CardType = 'basic' | 'cloze' | 'image_occlusion';

export interface Card {
  id: string;
  deck_id: string;
  order: number;
  type: CardType;
  front_content?: string | null;
  back_content?: string | null;
  image_url?: string | null;
  source_citation: string;
  created_at: string;
  updated_at: string;
}

export type FlashcardMedia = { type: 'image' | 'latex'; url_or_content: string };

export interface Flashcard {
  id: string;
  front: string; // Atomicity: short prompt
  back: string; // Atomicity: direct answer
  media?: FlashcardMedia;
  meta: {
    source: string;
    tags: string[];
    difficulty_rating?: number;
  };
}
