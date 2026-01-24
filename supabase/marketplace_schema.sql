-- Marketplace schema for categories, decks, and cards.
-- NOTE: This file is for a FRESH database (it creates new tables named `decks`/`cards`).
-- If your project already has `decks`/`cards` (like this repo), use:
--   `supabase/marketplace_schema_existing.sql`

CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  parent_id UUID REFERENCES categories(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX categories_slug_idx ON categories (slug);
CREATE INDEX categories_parent_idx ON categories (parent_id);

CREATE TABLE decks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  price NUMERIC(10, 2) NOT NULL DEFAULT 0,
  author_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  tags TEXT[] NOT NULL DEFAULT '{}',
  is_verified BOOLEAN NOT NULL DEFAULT false,
  rating NUMERIC(3, 2) NOT NULL DEFAULT 0,
  rating_count INT NOT NULL DEFAULT 0,
  is_public BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX decks_author_idx ON decks (author_id);
CREATE INDEX decks_category_idx ON decks (category_id);
CREATE INDEX decks_public_idx ON decks (is_public);

CREATE TABLE cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  "order" INT NOT NULL DEFAULT 0,
  type TEXT NOT NULL CHECK (type IN ('basic', 'cloze', 'image_occlusion')),
  front_content TEXT,
  back_content TEXT,
  image_url TEXT,
  source_citation TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (
    (
      type IN ('basic', 'cloze')
      AND front_content IS NOT NULL
      AND char_length(trim(front_content)) > 0
      AND back_content IS NOT NULL
      AND char_length(trim(back_content)) > 0
    )
    OR (
      type = 'image_occlusion'
      AND image_url IS NOT NULL
      AND char_length(trim(image_url)) > 0
      AND back_content IS NOT NULL
      AND char_length(trim(back_content)) > 0
    )
  ),
  CHECK (char_length(trim(source_citation)) > 0)
);

CREATE INDEX cards_deck_idx ON cards (deck_id);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view categories" ON categories;
CREATE POLICY "Anyone can view categories"
ON categories FOR SELECT
USING (true);

DROP POLICY IF EXISTS "Authors can manage their decks" ON decks;
CREATE POLICY "Authors can manage their decks"
ON decks FOR ALL
USING (auth.uid() = author_id)
WITH CHECK (auth.uid() = author_id);

DROP POLICY IF EXISTS "Anyone can view public decks" ON decks;
CREATE POLICY "Anyone can view public decks"
ON decks FOR SELECT
USING (is_public = true);

DROP POLICY IF EXISTS "Authors can manage cards in their decks" ON cards;
CREATE POLICY "Authors can manage cards in their decks"
ON cards FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM decks
    WHERE decks.id = cards.deck_id
    AND decks.author_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM decks
    WHERE decks.id = cards.deck_id
    AND decks.author_id = auth.uid()
  )
);

DROP POLICY IF EXISTS "Anyone can view cards in public decks" ON cards;
CREATE POLICY "Anyone can view cards in public decks"
ON cards FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM decks
    WHERE decks.id = cards.deck_id
    AND decks.is_public = true
  )
);
