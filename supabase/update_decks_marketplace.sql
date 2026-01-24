-- Marketplace: allow publishing decks and public browsing/cloning.

ALTER TABLE decks
  ADD COLUMN IF NOT EXISTS is_public BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS published_at TIMESTAMPTZ;

UPDATE decks
SET is_public = COALESCE(is_public, false);

UPDATE decks
SET published_at = COALESCE(published_at, created_at)
WHERE is_public = true;

ALTER TABLE decks
  ALTER COLUMN is_public SET NOT NULL;

CREATE INDEX IF NOT EXISTS decks_public_published_idx
  ON decks (is_public, published_at DESC);

ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view public decks" ON decks;
CREATE POLICY "Anyone can view public decks"
ON decks FOR SELECT
USING (is_public = true);

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
