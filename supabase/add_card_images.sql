-- Adicionar colunas de imagem na tabela cards
-- Execute este script no Supabase SQL Editor

-- Adiciona coluna para imagem da pergunta
ALTER TABLE cards 
ADD COLUMN IF NOT EXISTS question_image_url TEXT;

-- Adiciona coluna para imagem da resposta
ALTER TABLE cards 
ADD COLUMN IF NOT EXISTS answer_image_url TEXT;

-- Comentários para documentação
COMMENT ON COLUMN cards.question_image_url IS 'URL ou base64 da imagem associada à pergunta do flashcard';
COMMENT ON COLUMN cards.answer_image_url IS 'URL ou base64 da imagem associada à resposta do flashcard';
