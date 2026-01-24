-- Auto-generated marketplace decks seed (template-based).
-- Generated at: 2026-01-24 08:13:15 UTC

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuario nao encontrado'; END IF;

  -- Portugues
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/linguagens/portugues';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/linguagens/portugues'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Fundamentos e Conceitos (Auto)', 'Deck automatico de Portugues com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e fonetica em Portugues?', 'Conceito basico de fonetica aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e morfologia em Portugues?', 'Conceito basico de morfologia aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e classes de palavras em Portugues?', 'Conceito basico de classes de palavras aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e sintaxe em Portugues?', 'Conceito basico de sintaxe aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e concordancia verbal em Portugues?', 'Conceito basico de concordancia verbal aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e concordancia nominal em Portugues?', 'Conceito basico de concordancia nominal aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e regencia verbal em Portugues?', 'Conceito basico de regencia verbal aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e regencia nominal em Portugues?', 'Conceito basico de regencia nominal aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e crase em Portugues?', 'Conceito basico de crase aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e coesao em Portugues?', 'Conceito basico de coesao aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e coerencia em Portugues?', 'Conceito basico de coerencia aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e figuras de linguagem em Portugues?', 'Conceito basico de figuras de linguagem aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e funcoes da linguagem em Portugues?', 'Conceito basico de funcoes da linguagem aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e generos textuais em Portugues?', 'Conceito basico de generos textuais aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e tipos textuais em Portugues?', 'Conceito basico de tipos textuais aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e semantica em Portugues?', 'Conceito basico de semantica aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e polissemia em Portugues?', 'Conceito basico de polissemia aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e ambiguidade em Portugues?', 'Conceito basico de ambiguidade aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e denotacao e conotacao em Portugues?', 'Conceito basico de denotacao e conotacao aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e ortografia em Portugues?', 'Conceito basico de ortografia aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e acentuacao em Portugues?', 'Conceito basico de acentuacao aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e pontuacao em Portugues?', 'Conceito basico de pontuacao aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e voz ativa e passiva em Portugues?', 'Conceito basico de voz ativa e passiva aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e tempos verbais em Portugues?', 'Conceito basico de tempos verbais aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e pronomes em Portugues?', 'Conceito basico de pronomes aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e numerais em Portugues?', 'Conceito basico de numerais aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e formacao de palavras em Portugues?', 'Conceito basico de formacao de palavras aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e variedade linguistica em Portugues?', 'Conceito basico de variedade linguistica aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e discurso direto e indireto em Portugues?', 'Conceito basico de discurso direto e indireto aplicado a Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e intertextualidade em Portugues?', 'Conceito basico de intertextualidade aplicado a Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Definicoes e Terminologia (Auto)', 'Deck automatico de Portugues com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina fonetica no contexto de Portugues.', 'Definicao objetiva de fonetica para Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina morfologia no contexto de Portugues.', 'Definicao objetiva de morfologia para Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina classes de palavras no contexto de Portugues.', 'Definicao objetiva de classes de palavras para Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina sintaxe no contexto de Portugues.', 'Definicao objetiva de sintaxe para Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina concordancia verbal no contexto de Portugues.', 'Definicao objetiva de concordancia verbal para Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina concordancia nominal no contexto de Portugues.', 'Definicao objetiva de concordancia nominal para Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina regencia verbal no contexto de Portugues.', 'Definicao objetiva de regencia verbal para Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina regencia nominal no contexto de Portugues.', 'Definicao objetiva de regencia nominal para Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina crase no contexto de Portugues.', 'Definicao objetiva de crase para Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina coesao no contexto de Portugues.', 'Definicao objetiva de coesao para Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina coerencia no contexto de Portugues.', 'Definicao objetiva de coerencia para Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina figuras de linguagem no contexto de Portugues.', 'Definicao objetiva de figuras de linguagem para Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina funcoes da linguagem no contexto de Portugues.', 'Definicao objetiva de funcoes da linguagem para Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina generos textuais no contexto de Portugues.', 'Definicao objetiva de generos textuais para Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina tipos textuais no contexto de Portugues.', 'Definicao objetiva de tipos textuais para Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina semantica no contexto de Portugues.', 'Definicao objetiva de semantica para Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina polissemia no contexto de Portugues.', 'Definicao objetiva de polissemia para Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina ambiguidade no contexto de Portugues.', 'Definicao objetiva de ambiguidade para Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina denotacao e conotacao no contexto de Portugues.', 'Definicao objetiva de denotacao e conotacao para Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina ortografia no contexto de Portugues.', 'Definicao objetiva de ortografia para Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina acentuacao no contexto de Portugues.', 'Definicao objetiva de acentuacao para Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina pontuacao no contexto de Portugues.', 'Definicao objetiva de pontuacao para Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina voz ativa e passiva no contexto de Portugues.', 'Definicao objetiva de voz ativa e passiva para Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina tempos verbais no contexto de Portugues.', 'Definicao objetiva de tempos verbais para Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina pronomes no contexto de Portugues.', 'Definicao objetiva de pronomes para Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina numerais no contexto de Portugues.', 'Definicao objetiva de numerais para Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina formacao de palavras no contexto de Portugues.', 'Definicao objetiva de formacao de palavras para Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina variedade linguistica no contexto de Portugues.', 'Definicao objetiva de variedade linguistica para Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina discurso direto e indireto no contexto de Portugues.', 'Definicao objetiva de discurso direto e indireto para Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina intertextualidade no contexto de Portugues.', 'Definicao objetiva de intertextualidade para Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Processos e Aplicacoes (Auto)', 'Deck automatico de Portugues com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como fonetica se aplica em Portugues?', 'Resumo do processo de fonetica e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como morfologia se aplica em Portugues?', 'Resumo do processo de morfologia e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como classes de palavras se aplica em Portugues?', 'Resumo do processo de classes de palavras e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como sintaxe se aplica em Portugues?', 'Resumo do processo de sintaxe e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como concordancia verbal se aplica em Portugues?', 'Resumo do processo de concordancia verbal e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como concordancia nominal se aplica em Portugues?', 'Resumo do processo de concordancia nominal e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como regencia verbal se aplica em Portugues?', 'Resumo do processo de regencia verbal e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como regencia nominal se aplica em Portugues?', 'Resumo do processo de regencia nominal e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como crase se aplica em Portugues?', 'Resumo do processo de crase e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como coesao se aplica em Portugues?', 'Resumo do processo de coesao e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como coerencia se aplica em Portugues?', 'Resumo do processo de coerencia e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como figuras de linguagem se aplica em Portugues?', 'Resumo do processo de figuras de linguagem e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como funcoes da linguagem se aplica em Portugues?', 'Resumo do processo de funcoes da linguagem e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como generos textuais se aplica em Portugues?', 'Resumo do processo de generos textuais e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como tipos textuais se aplica em Portugues?', 'Resumo do processo de tipos textuais e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como semantica se aplica em Portugues?', 'Resumo do processo de semantica e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como polissemia se aplica em Portugues?', 'Resumo do processo de polissemia e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como ambiguidade se aplica em Portugues?', 'Resumo do processo de ambiguidade e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como denotacao e conotacao se aplica em Portugues?', 'Resumo do processo de denotacao e conotacao e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como ortografia se aplica em Portugues?', 'Resumo do processo de ortografia e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como acentuacao se aplica em Portugues?', 'Resumo do processo de acentuacao e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como pontuacao se aplica em Portugues?', 'Resumo do processo de pontuacao e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como voz ativa e passiva se aplica em Portugues?', 'Resumo do processo de voz ativa e passiva e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como tempos verbais se aplica em Portugues?', 'Resumo do processo de tempos verbais e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como pronomes se aplica em Portugues?', 'Resumo do processo de pronomes e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como numerais se aplica em Portugues?', 'Resumo do processo de numerais e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como formacao de palavras se aplica em Portugues?', 'Resumo do processo de formacao de palavras e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como variedade linguistica se aplica em Portugues?', 'Resumo do processo de variedade linguistica e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como discurso direto e indireto se aplica em Portugues?', 'Resumo do processo de discurso direto e indireto e sua aplicacao em Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como intertextualidade se aplica em Portugues?', 'Resumo do processo de intertextualidade e sua aplicacao em Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Regras e Principios (Auto)', 'Deck automatico de Portugues com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de fonetica em Portugues?', 'Principio central de fonetica usado em Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de morfologia em Portugues?', 'Principio central de morfologia usado em Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de classes de palavras em Portugues?', 'Principio central de classes de palavras usado em Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de sintaxe em Portugues?', 'Principio central de sintaxe usado em Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de concordancia verbal em Portugues?', 'Principio central de concordancia verbal usado em Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de concordancia nominal em Portugues?', 'Principio central de concordancia nominal usado em Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de regencia verbal em Portugues?', 'Principio central de regencia verbal usado em Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de regencia nominal em Portugues?', 'Principio central de regencia nominal usado em Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de crase em Portugues?', 'Principio central de crase usado em Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de coesao em Portugues?', 'Principio central de coesao usado em Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de coerencia em Portugues?', 'Principio central de coerencia usado em Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de figuras de linguagem em Portugues?', 'Principio central de figuras de linguagem usado em Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de funcoes da linguagem em Portugues?', 'Principio central de funcoes da linguagem usado em Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de generos textuais em Portugues?', 'Principio central de generos textuais usado em Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de tipos textuais em Portugues?', 'Principio central de tipos textuais usado em Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de semantica em Portugues?', 'Principio central de semantica usado em Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de polissemia em Portugues?', 'Principio central de polissemia usado em Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de ambiguidade em Portugues?', 'Principio central de ambiguidade usado em Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de denotacao e conotacao em Portugues?', 'Principio central de denotacao e conotacao usado em Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de ortografia em Portugues?', 'Principio central de ortografia usado em Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de acentuacao em Portugues?', 'Principio central de acentuacao usado em Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de pontuacao em Portugues?', 'Principio central de pontuacao usado em Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de voz ativa e passiva em Portugues?', 'Principio central de voz ativa e passiva usado em Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de tempos verbais em Portugues?', 'Principio central de tempos verbais usado em Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de pronomes em Portugues?', 'Principio central de pronomes usado em Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de numerais em Portugues?', 'Principio central de numerais usado em Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de formacao de palavras em Portugues?', 'Principio central de formacao de palavras usado em Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de variedade linguistica em Portugues?', 'Principio central de variedade linguistica usado em Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de discurso direto e indireto em Portugues?', 'Principio central de discurso direto e indireto usado em Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de intertextualidade em Portugues?', 'Principio central de intertextualidade usado em Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Resolucao de Problemas (Auto)', 'Deck automatico de Portugues com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar fonetica em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de fonetica e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar morfologia em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de morfologia e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar classes de palavras em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de classes de palavras e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar sintaxe em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de sintaxe e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar concordancia verbal em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de concordancia verbal e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar concordancia nominal em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de concordancia nominal e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar regencia verbal em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de regencia verbal e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar regencia nominal em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de regencia nominal e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar crase em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de crase e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar coesao em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de coesao e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar coerencia em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de coerencia e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar figuras de linguagem em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de figuras de linguagem e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar funcoes da linguagem em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de funcoes da linguagem e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar generos textuais em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de generos textuais e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar tipos textuais em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de tipos textuais e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar semantica em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de semantica e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar polissemia em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de polissemia e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar ambiguidade em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de ambiguidade e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar denotacao e conotacao em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de denotacao e conotacao e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar ortografia em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de ortografia e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar acentuacao em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de acentuacao e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar pontuacao em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de pontuacao e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar voz ativa e passiva em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de voz ativa e passiva e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar tempos verbais em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de tempos verbais e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar pronomes em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de pronomes e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar numerais em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de numerais e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar formacao de palavras em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de formacao de palavras e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar variedade linguistica em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de variedade linguistica e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar discurso direto e indireto em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de discurso direto e indireto e concluir no contexto de Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar intertextualidade em Portugues?', 'Sequencia simples: identificar dados, aplicar regras de intertextualidade e concluir no contexto de Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Erros Comuns e Dicas (Auto)', 'Deck automatico de Portugues com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com fonetica em Portugues?', 'Erro comum: confundir conceito ou etapa de fonetica; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com morfologia em Portugues?', 'Erro comum: confundir conceito ou etapa de morfologia; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com classes de palavras em Portugues?', 'Erro comum: confundir conceito ou etapa de classes de palavras; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com sintaxe em Portugues?', 'Erro comum: confundir conceito ou etapa de sintaxe; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com concordancia verbal em Portugues?', 'Erro comum: confundir conceito ou etapa de concordancia verbal; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com concordancia nominal em Portugues?', 'Erro comum: confundir conceito ou etapa de concordancia nominal; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com regencia verbal em Portugues?', 'Erro comum: confundir conceito ou etapa de regencia verbal; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com regencia nominal em Portugues?', 'Erro comum: confundir conceito ou etapa de regencia nominal; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com crase em Portugues?', 'Erro comum: confundir conceito ou etapa de crase; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com coesao em Portugues?', 'Erro comum: confundir conceito ou etapa de coesao; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com coerencia em Portugues?', 'Erro comum: confundir conceito ou etapa de coerencia; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com figuras de linguagem em Portugues?', 'Erro comum: confundir conceito ou etapa de figuras de linguagem; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com funcoes da linguagem em Portugues?', 'Erro comum: confundir conceito ou etapa de funcoes da linguagem; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com generos textuais em Portugues?', 'Erro comum: confundir conceito ou etapa de generos textuais; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com tipos textuais em Portugues?', 'Erro comum: confundir conceito ou etapa de tipos textuais; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com semantica em Portugues?', 'Erro comum: confundir conceito ou etapa de semantica; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com polissemia em Portugues?', 'Erro comum: confundir conceito ou etapa de polissemia; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com ambiguidade em Portugues?', 'Erro comum: confundir conceito ou etapa de ambiguidade; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com denotacao e conotacao em Portugues?', 'Erro comum: confundir conceito ou etapa de denotacao e conotacao; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com ortografia em Portugues?', 'Erro comum: confundir conceito ou etapa de ortografia; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com acentuacao em Portugues?', 'Erro comum: confundir conceito ou etapa de acentuacao; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com pontuacao em Portugues?', 'Erro comum: confundir conceito ou etapa de pontuacao; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com voz ativa e passiva em Portugues?', 'Erro comum: confundir conceito ou etapa de voz ativa e passiva; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com tempos verbais em Portugues?', 'Erro comum: confundir conceito ou etapa de tempos verbais; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com pronomes em Portugues?', 'Erro comum: confundir conceito ou etapa de pronomes; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com numerais em Portugues?', 'Erro comum: confundir conceito ou etapa de numerais; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com formacao de palavras em Portugues?', 'Erro comum: confundir conceito ou etapa de formacao de palavras; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com variedade linguistica em Portugues?', 'Erro comum: confundir conceito ou etapa de variedade linguistica; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com discurso direto e indireto em Portugues?', 'Erro comum: confundir conceito ou etapa de discurso direto e indireto; evite revisando definicoes e condicoes em Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com intertextualidade em Portugues?', 'Erro comum: confundir conceito ou etapa de intertextualidade; evite revisando definicoes e condicoes em Portugues.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Portugues - Revisao Rapida (Auto)', 'Deck automatico de Portugues com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['portugues', 'language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: fonetica em Portugues.', 'Resumo: pontos essenciais de fonetica e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: morfologia em Portugues.', 'Resumo: pontos essenciais de morfologia e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: classes de palavras em Portugues.', 'Resumo: pontos essenciais de classes de palavras e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: sintaxe em Portugues.', 'Resumo: pontos essenciais de sintaxe e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: concordancia verbal em Portugues.', 'Resumo: pontos essenciais de concordancia verbal e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: concordancia nominal em Portugues.', 'Resumo: pontos essenciais de concordancia nominal e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: regencia verbal em Portugues.', 'Resumo: pontos essenciais de regencia verbal e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: regencia nominal em Portugues.', 'Resumo: pontos essenciais de regencia nominal e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: crase em Portugues.', 'Resumo: pontos essenciais de crase e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: coesao em Portugues.', 'Resumo: pontos essenciais de coesao e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: coerencia em Portugues.', 'Resumo: pontos essenciais de coerencia e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: figuras de linguagem em Portugues.', 'Resumo: pontos essenciais de figuras de linguagem e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: funcoes da linguagem em Portugues.', 'Resumo: pontos essenciais de funcoes da linguagem e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: generos textuais em Portugues.', 'Resumo: pontos essenciais de generos textuais e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: tipos textuais em Portugues.', 'Resumo: pontos essenciais de tipos textuais e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: semantica em Portugues.', 'Resumo: pontos essenciais de semantica e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: polissemia em Portugues.', 'Resumo: pontos essenciais de polissemia e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: ambiguidade em Portugues.', 'Resumo: pontos essenciais de ambiguidade e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: denotacao e conotacao em Portugues.', 'Resumo: pontos essenciais de denotacao e conotacao e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: ortografia em Portugues.', 'Resumo: pontos essenciais de ortografia e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: acentuacao em Portugues.', 'Resumo: pontos essenciais de acentuacao e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: pontuacao em Portugues.', 'Resumo: pontos essenciais de pontuacao e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: voz ativa e passiva em Portugues.', 'Resumo: pontos essenciais de voz ativa e passiva e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: tempos verbais em Portugues.', 'Resumo: pontos essenciais de tempos verbais e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: pronomes em Portugues.', 'Resumo: pontos essenciais de pronomes e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: numerais em Portugues.', 'Resumo: pontos essenciais de numerais e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: formacao de palavras em Portugues.', 'Resumo: pontos essenciais de formacao de palavras e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: variedade linguistica em Portugues.', 'Resumo: pontos essenciais de variedade linguistica e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: discurso direto e indireto em Portugues.', 'Resumo: pontos essenciais de discurso direto e indireto e sua utilidade em Portugues.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: intertextualidade em Portugues.', 'Resumo: pontos essenciais de intertextualidade e sua utilidade em Portugues.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Portugues';
END $$;
