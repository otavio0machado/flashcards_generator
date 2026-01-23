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
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela de Flashcards
CREATE TABLE cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deck_id UUID NOT NULL REFERENCES decks(id) ON DELETE CASCADE,
  front TEXT NOT NULL,
  back TEXT NOT NULL,
  "order" INT DEFAULT 0
);

-- TAREFA 2: Segurança (RLS - Row Level Security)

-- Ativar RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

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
