-- Add SRS fields to cards and create update_card_progress RPC (SM-2).

ALTER TABLE cards
  ADD COLUMN IF NOT EXISTS next_review TIMESTAMPTZ DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS "interval" INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS ease_factor FLOAT DEFAULT 2.5,
  ADD COLUMN IF NOT EXISTS repetitions INT DEFAULT 0;

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

  RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION update_card_progress(UUID, INT) TO authenticated;
