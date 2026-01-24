-- Add SRS fields to cards and create update_card_progress RPC (SM-2).

ALTER TABLE cards
  ADD COLUMN IF NOT EXISTS next_review TIMESTAMPTZ DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS "interval" INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS ease_factor FLOAT DEFAULT 2.5,
  ADD COLUMN IF NOT EXISTS repetitions INT DEFAULT 0;

CREATE TABLE IF NOT EXISTS study_activity (
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  day DATE NOT NULL,
  count INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (user_id, day)
);

ALTER TABLE study_activity ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can manage their study activity" ON study_activity;

CREATE POLICY "Users can manage their study activity"
ON study_activity FOR ALL
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

UPDATE cards
SET
  next_review = COALESCE(next_review, NOW()),
  "interval" = COALESCE("interval", 0),
  ease_factor = COALESCE(ease_factor, 2.5),
  repetitions = COALESCE(repetitions, 0);

ALTER TABLE cards
  ALTER COLUMN next_review SET NOT NULL,
  ALTER COLUMN "interval" SET NOT NULL,
  ALTER COLUMN ease_factor SET NOT NULL,
  ALTER COLUMN repetitions SET NOT NULL;

CREATE OR REPLACE FUNCTION update_card_progress(p_card_id UUID, p_quality INT)
RETURNS TABLE (
  id UUID,
  next_review TIMESTAMPTZ,
  "interval" INT,
  ease_factor FLOAT,
  repetitions INT
) AS $$
DECLARE
  v_quality INT := LEAST(GREATEST(p_quality, 0), 5);
  v_repetitions INT;
  v_interval INT;
  v_ease_factor FLOAT;
  v_new_repetitions INT;
  v_new_interval INT;
  v_new_ease_factor FLOAT;
  v_next_review TIMESTAMPTZ;
BEGIN
  SELECT repetitions, "interval", ease_factor
    INTO v_repetitions, v_interval, v_ease_factor
  FROM cards
  WHERE id = p_card_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Card not found';
  END IF;

  IF v_quality < 3 THEN
    v_new_repetitions := 0;
    v_new_interval := 1;
  ELSE
    IF v_repetitions = 0 THEN
      v_new_interval := 1;
    ELSIF v_repetitions = 1 THEN
      v_new_interval := 6;
    ELSE
      v_new_interval := ROUND(v_interval * v_ease_factor)::INT;
    END IF;

    v_new_repetitions := v_repetitions + 1;
  END IF;

  v_new_ease_factor := v_ease_factor + (
    0.1 - (5 - v_quality) * (0.08 + (5 - v_quality) * 0.02)
  );

  IF v_new_ease_factor < 1.3 THEN
    v_new_ease_factor := 1.3;
  END IF;

  v_next_review := NOW() + (v_new_interval || ' days')::interval;

  UPDATE cards
  SET
    "interval" = v_new_interval,
    repetitions = v_new_repetitions,
    ease_factor = v_new_ease_factor,
    next_review = v_next_review
  WHERE id = p_card_id
  RETURNING cards.id, cards.next_review, cards."interval", cards.ease_factor, cards.repetitions
    INTO id, next_review, "interval", ease_factor, repetitions;

  IF auth.uid() IS NOT NULL THEN
    INSERT INTO study_activity (user_id, day, count, updated_at)
    VALUES (auth.uid(), CURRENT_DATE, 1, NOW())
    ON CONFLICT (user_id, day)
    DO UPDATE SET count = study_activity.count + 1, updated_at = NOW();
  END IF;

  RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION update_card_progress(UUID, INT) TO authenticated;
