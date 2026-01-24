-- TAREFA 1: Criação do Schema (SQL)

-- Tabela de Perfis (Extensão de auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  plan_tier TEXT DEFAULT 'free' CHECK (plan_tier IN ('free', 'pro', 'ultimate')),
  daily_generations INT DEFAULT 0,
  last_reset_date DATE DEFAULT CURRENT_DATE,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de Baralhos (Decks)
CREATE TABLE decks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  is_public BOOLEAN NOT NULL DEFAULT false,
  published_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX decks_public_published_idx
  ON decks (is_public, published_at DESC);

-- Tabela de Flashcards
CREATE TABLE cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  front TEXT NOT NULL,
  back TEXT NOT NULL,
  "order" INT DEFAULT 0,
  next_review TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "interval" INT DEFAULT 0,
  ease_factor FLOAT DEFAULT 2.5,
  repetitions INT DEFAULT 0
);

-- Tabela de atividade de estudo (resumo diario)
CREATE TABLE study_activity (
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  day DATE NOT NULL,
  count INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (user_id, day)
);

-- TAREFA 2: Segurança (RLS - Row Level Security)

-- Ativar RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE study_activity ENABLE ROW LEVEL SECURITY;

-- Políticas para Profiles
CREATE POLICY "Users can view their own profile"
ON profiles FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
ON profiles FOR UPDATE
USING (auth.uid() = id);

-- Políticas para Decks
CREATE POLICY "Users can manage their own decks"
ON decks FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Anyone can view public decks"
ON decks FOR SELECT
USING (is_public = true);

-- Políticas para Cards
-- Nota: Aqui usamos uma subquery para verificar se o deck pertence ao usuário
CREATE POLICY "Users can manage cards in their own decks"
ON cards FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM decks
    WHERE decks.id = cards.deck_id
    AND decks.user_id = auth.uid()
  )
);

CREATE POLICY "Users can manage their study activity"
ON study_activity FOR ALL
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Anyone can view cards in public decks"
ON cards FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM decks
    WHERE decks.id = cards.deck_id
    AND decks.is_public = true
  )
);

-- TAREFA 4: Trigger Automático para novos usuários
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, plan_tier)
  VALUES (new.id, 'free');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- TAREFA EXTRA: Função para incrementar uso e resetar data (atômico)
CREATE OR REPLACE FUNCTION increment_daily_usage(p_user_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE profiles
  SET 
    daily_generations = CASE 
      WHEN last_reset_date < CURRENT_DATE THEN 1 
      ELSE daily_generations + 1 
    END,
    last_reset_date = CURRENT_DATE
  WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION update_card_progress(UUID, INT) TO authenticated;

-- Feedback table
CREATE TABLE feedback (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL DEFAULT auth.uid(),
  email TEXT,
  message TEXT NOT NULL,
  page_path TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit feedback"
ON feedback
FOR INSERT
WITH CHECK (true);

-- SRS: SM-2 progress update RPC
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
