-- Migration for existing schema: add marketplace fields to decks/cards and create categories.

CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  parent_id UUID REFERENCES categories(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS categories_slug_idx ON categories (slug);
CREATE INDEX IF NOT EXISTS categories_parent_idx ON categories (parent_id);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view categories" ON categories;
CREATE POLICY "Anyone can view categories"
ON categories FOR SELECT
USING (true);

ALTER TABLE decks
  ADD COLUMN IF NOT EXISTS description TEXT,
  ADD COLUMN IF NOT EXISTS price NUMERIC(10, 2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS is_verified BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS rating NUMERIC(3, 2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS rating_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

CREATE INDEX IF NOT EXISTS decks_category_idx ON decks (category_id);

ALTER TABLE cards
  ADD COLUMN IF NOT EXISTS type TEXT NOT NULL DEFAULT 'basic',
  ADD COLUMN IF NOT EXISTS front_content TEXT,
  ADD COLUMN IF NOT EXISTS back_content TEXT,
  ADD COLUMN IF NOT EXISTS image_url TEXT,
  ADD COLUMN IF NOT EXISTS source_citation TEXT;

UPDATE cards
SET
  front_content = COALESCE(front_content, front),
  back_content = COALESCE(back_content, back)
WHERE front_content IS NULL OR back_content IS NULL;

UPDATE cards
SET source_citation = COALESCE(source_citation, 'fonte_nao_informada')
WHERE source_citation IS NULL;

ALTER TABLE cards
  ALTER COLUMN source_citation SET NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'cards_type_chk'
  ) THEN
    ALTER TABLE cards
      ADD CONSTRAINT cards_type_chk
      CHECK (type IN ('basic', 'cloze', 'image_occlusion'));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'cards_content_quality_chk'
  ) THEN
    ALTER TABLE cards
      ADD CONSTRAINT cards_content_quality_chk
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
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'cards_source_citation_chk'
  ) THEN
    ALTER TABLE cards
      ADD CONSTRAINT cards_source_citation_chk
      CHECK (char_length(trim(source_citation)) > 0);
  END IF;
END $$;
