-- SCHEMAS UNIFICADOS DO FLASHCARDS GENERATOR
-- Este arquivo consolida schema.sql e marketplace_schema.sql para evitar conflitos.
-- Use este arquivo como fonte da verdade para o banco de dados.

-- 1. CONFIGURAÇÕES INICIAIS
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. TABELAS DE BASE

-- Tabela: Profiles (Extensão de auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  plan_tier TEXT DEFAULT 'free' CHECK (plan_tier IN ('free', 'pro', 'ultimate')),
  daily_generations INT DEFAULT 0,
  last_reset_date DATE DEFAULT CURRENT_DATE,
  full_name TEXT,
  avatar_url TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela: Categories (Marketplace)
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  parent_id UUID REFERENCES categories(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabela: Decks (Unificada: Core + Marketplace)
CREATE TABLE IF NOT EXISTS decks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE, -- Standardized to user_id
  
  -- Core Fields
  title TEXT NOT NULL,
  description TEXT,
  is_public BOOLEAN NOT NULL DEFAULT false,
  tags TEXT[] DEFAULT '{}',
  
  -- Marketplace Fields
  price NUMERIC(10, 2) NOT NULL DEFAULT 0,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  is_verified BOOLEAN NOT NULL DEFAULT false,
  rating NUMERIC(3, 2) NOT NULL DEFAULT 0,
  rating_count INT NOT NULL DEFAULT 0,
  published_at TIMESTAMP WITH TIME ZONE,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para Decks
CREATE INDEX IF NOT EXISTS decks_user_idx ON decks (user_id);
CREATE INDEX IF NOT EXISTS decks_public_published_idx ON decks (is_public, published_at DESC);
CREATE INDEX IF NOT EXISTS decks_category_idx ON decks (category_id);


-- Tabela: Cards (Unificada)
CREATE TABLE IF NOT EXISTS cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  "order" INT DEFAULT 0,
  
  -- Conteúdo
  front TEXT NOT NULL,
  back TEXT NOT NULL,
  type TEXT DEFAULT 'basic' CHECK (type IN ('basic', 'cloze', 'image_occlusion')),
  
  -- Mídia
  image_url TEXT,            -- Legado / Geral
  question_image_url TEXT,   -- Específico Pergunta
  answer_image_url TEXT,     -- Específico Resposta
  source_citation TEXT,
  
  -- SRS (Spaced Repetition System) Fields
  next_review TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  "interval" INT DEFAULT 0,
  ease_factor FLOAT DEFAULT 2.5,
  repetitions INT DEFAULT 0,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para Cards
CREATE INDEX IF NOT EXISTS cards_deck_order_idx ON cards (deck_id, "order"); -- Melhoria de Performance solicitada
CREATE INDEX IF NOT EXISTS cards_review_idx ON cards (deck_id, next_review); -- Para queries de "O que estudar hoje"


-- Tabela: Study Activity (Core)
CREATE TABLE IF NOT EXISTS study_activity (
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  day DATE NOT NULL,
  count INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (user_id, day)
);

-- Tabela: Feedback
CREATE TABLE IF NOT EXISTS feedback (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL DEFAULT auth.uid(),
  email TEXT,
  message TEXT NOT NULL,
  page_path TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);


-- 3. SEGURANÇA (RLS)

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE study_activity ENABLE ROW LEVEL SECURITY;
ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;

-- Policies: Profiles
CREATE POLICY "Users view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Policies: Categories
CREATE POLICY "Public view categories" ON categories FOR SELECT USING (true);

-- Policies: Decks
CREATE POLICY "Users manage own decks" ON decks FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Public view published decks" ON decks FOR SELECT USING (is_public = true);

-- Policies: Cards
CREATE POLICY "Users manage own cards" ON cards FOR ALL USING (
  EXISTS (SELECT 1 FROM decks WHERE decks.id = cards.deck_id AND decks.user_id = auth.uid())
);
CREATE POLICY "Public view public cards" ON cards FOR SELECT USING (
  EXISTS (SELECT 1 FROM decks WHERE decks.id = cards.deck_id AND decks.is_public = true)
);

-- Policies: Study Activity
CREATE POLICY "Users manage own activity" ON study_activity FOR ALL USING (auth.uid() = user_id);

-- Policies: Feedback
CREATE POLICY "Anyone submit feedback" ON feedback FOR INSERT WITH CHECK (true);


-- 4. TRIGGERS E FUNÇÕES AUTOMÁTICAS

-- Trigger: New User Handler
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, plan_tier)
  VALUES (new.id, 'free')
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();


-- RPC: Increment Daily Usage (Atômico)
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


-- RPC: Update Card Progress (Algoritmo SM-2)
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

  v_new_ease_factor := v_ease_factor + (0.1 - (5 - v_quality) * (0.08 + (5 - v_quality) * 0.02));
  if v_new_ease_factor < 1.3 THEN v_new_ease_factor := 1.3; END IF;

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
