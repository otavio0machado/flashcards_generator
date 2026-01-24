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

  -- Biologia
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-da-natureza/biologia';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/ciencias-da-natureza/biologia'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Fundamentos e Conceitos (Auto)', 'Deck automatico de Biologia com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e citologia em Biologia?', 'Conceito basico de citologia aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e membrana plasmatica em Biologia?', 'Conceito basico de membrana plasmatica aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e organelas em Biologia?', 'Conceito basico de organelas aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e mitose em Biologia?', 'Conceito basico de mitose aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e meiose em Biologia?', 'Conceito basico de meiose aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e dna e rna em Biologia?', 'Conceito basico de dna e rna aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e genetica mendeliana em Biologia?', 'Conceito basico de genetica mendeliana aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e grupos sanguineos em Biologia?', 'Conceito basico de grupos sanguineos aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e biotecnologia em Biologia?', 'Conceito basico de biotecnologia aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e evolucao em Biologia?', 'Conceito basico de evolucao aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e selecao natural em Biologia?', 'Conceito basico de selecao natural aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e ecologia em Biologia?', 'Conceito basico de ecologia aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e cadeias alimentares em Biologia?', 'Conceito basico de cadeias alimentares aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e ciclos biogeoquimicos em Biologia?', 'Conceito basico de ciclos biogeoquimicos aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e biomas brasileiros em Biologia?', 'Conceito basico de biomas brasileiros aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e botanica em Biologia?', 'Conceito basico de botanica aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e fotossintese em Biologia?', 'Conceito basico de fotossintese aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e respiracao celular em Biologia?', 'Conceito basico de respiracao celular aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e zoologia em Biologia?', 'Conceito basico de zoologia aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e sistema digestorio em Biologia?', 'Conceito basico de sistema digestorio aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e sistema respiratorio em Biologia?', 'Conceito basico de sistema respiratorio aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e sistema circulatorio em Biologia?', 'Conceito basico de sistema circulatorio aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e sistema nervoso em Biologia?', 'Conceito basico de sistema nervoso aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e sistema endocrino em Biologia?', 'Conceito basico de sistema endocrino aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e sistema reprodutor em Biologia?', 'Conceito basico de sistema reprodutor aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e microbiologia em Biologia?', 'Conceito basico de microbiologia aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e virus e bacterias em Biologia?', 'Conceito basico de virus e bacterias aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e fungos em Biologia?', 'Conceito basico de fungos aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e protozoarios em Biologia?', 'Conceito basico de protozoarios aplicado a Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e imunologia em Biologia?', 'Conceito basico de imunologia aplicado a Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Definicoes e Terminologia (Auto)', 'Deck automatico de Biologia com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina citologia no contexto de Biologia.', 'Definicao objetiva de citologia para Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina membrana plasmatica no contexto de Biologia.', 'Definicao objetiva de membrana plasmatica para Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina organelas no contexto de Biologia.', 'Definicao objetiva de organelas para Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina mitose no contexto de Biologia.', 'Definicao objetiva de mitose para Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina meiose no contexto de Biologia.', 'Definicao objetiva de meiose para Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina dna e rna no contexto de Biologia.', 'Definicao objetiva de dna e rna para Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina genetica mendeliana no contexto de Biologia.', 'Definicao objetiva de genetica mendeliana para Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina grupos sanguineos no contexto de Biologia.', 'Definicao objetiva de grupos sanguineos para Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina biotecnologia no contexto de Biologia.', 'Definicao objetiva de biotecnologia para Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina evolucao no contexto de Biologia.', 'Definicao objetiva de evolucao para Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina selecao natural no contexto de Biologia.', 'Definicao objetiva de selecao natural para Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina ecologia no contexto de Biologia.', 'Definicao objetiva de ecologia para Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina cadeias alimentares no contexto de Biologia.', 'Definicao objetiva de cadeias alimentares para Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina ciclos biogeoquimicos no contexto de Biologia.', 'Definicao objetiva de ciclos biogeoquimicos para Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina biomas brasileiros no contexto de Biologia.', 'Definicao objetiva de biomas brasileiros para Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina botanica no contexto de Biologia.', 'Definicao objetiva de botanica para Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina fotossintese no contexto de Biologia.', 'Definicao objetiva de fotossintese para Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina respiracao celular no contexto de Biologia.', 'Definicao objetiva de respiracao celular para Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina zoologia no contexto de Biologia.', 'Definicao objetiva de zoologia para Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina sistema digestorio no contexto de Biologia.', 'Definicao objetiva de sistema digestorio para Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina sistema respiratorio no contexto de Biologia.', 'Definicao objetiva de sistema respiratorio para Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina sistema circulatorio no contexto de Biologia.', 'Definicao objetiva de sistema circulatorio para Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina sistema nervoso no contexto de Biologia.', 'Definicao objetiva de sistema nervoso para Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina sistema endocrino no contexto de Biologia.', 'Definicao objetiva de sistema endocrino para Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina sistema reprodutor no contexto de Biologia.', 'Definicao objetiva de sistema reprodutor para Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina microbiologia no contexto de Biologia.', 'Definicao objetiva de microbiologia para Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina virus e bacterias no contexto de Biologia.', 'Definicao objetiva de virus e bacterias para Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina fungos no contexto de Biologia.', 'Definicao objetiva de fungos para Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina protozoarios no contexto de Biologia.', 'Definicao objetiva de protozoarios para Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina imunologia no contexto de Biologia.', 'Definicao objetiva de imunologia para Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Processos e Aplicacoes (Auto)', 'Deck automatico de Biologia com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como citologia se aplica em Biologia?', 'Resumo do processo de citologia e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como membrana plasmatica se aplica em Biologia?', 'Resumo do processo de membrana plasmatica e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como organelas se aplica em Biologia?', 'Resumo do processo de organelas e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como mitose se aplica em Biologia?', 'Resumo do processo de mitose e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como meiose se aplica em Biologia?', 'Resumo do processo de meiose e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como dna e rna se aplica em Biologia?', 'Resumo do processo de dna e rna e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como genetica mendeliana se aplica em Biologia?', 'Resumo do processo de genetica mendeliana e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como grupos sanguineos se aplica em Biologia?', 'Resumo do processo de grupos sanguineos e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como biotecnologia se aplica em Biologia?', 'Resumo do processo de biotecnologia e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como evolucao se aplica em Biologia?', 'Resumo do processo de evolucao e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como selecao natural se aplica em Biologia?', 'Resumo do processo de selecao natural e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como ecologia se aplica em Biologia?', 'Resumo do processo de ecologia e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como cadeias alimentares se aplica em Biologia?', 'Resumo do processo de cadeias alimentares e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como ciclos biogeoquimicos se aplica em Biologia?', 'Resumo do processo de ciclos biogeoquimicos e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como biomas brasileiros se aplica em Biologia?', 'Resumo do processo de biomas brasileiros e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como botanica se aplica em Biologia?', 'Resumo do processo de botanica e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como fotossintese se aplica em Biologia?', 'Resumo do processo de fotossintese e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como respiracao celular se aplica em Biologia?', 'Resumo do processo de respiracao celular e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como zoologia se aplica em Biologia?', 'Resumo do processo de zoologia e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como sistema digestorio se aplica em Biologia?', 'Resumo do processo de sistema digestorio e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como sistema respiratorio se aplica em Biologia?', 'Resumo do processo de sistema respiratorio e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como sistema circulatorio se aplica em Biologia?', 'Resumo do processo de sistema circulatorio e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como sistema nervoso se aplica em Biologia?', 'Resumo do processo de sistema nervoso e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como sistema endocrino se aplica em Biologia?', 'Resumo do processo de sistema endocrino e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como sistema reprodutor se aplica em Biologia?', 'Resumo do processo de sistema reprodutor e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como microbiologia se aplica em Biologia?', 'Resumo do processo de microbiologia e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como virus e bacterias se aplica em Biologia?', 'Resumo do processo de virus e bacterias e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como fungos se aplica em Biologia?', 'Resumo do processo de fungos e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como protozoarios se aplica em Biologia?', 'Resumo do processo de protozoarios e sua aplicacao em Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como imunologia se aplica em Biologia?', 'Resumo do processo de imunologia e sua aplicacao em Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Regras e Principios (Auto)', 'Deck automatico de Biologia com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de citologia em Biologia?', 'Principio central de citologia usado em Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de membrana plasmatica em Biologia?', 'Principio central de membrana plasmatica usado em Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de organelas em Biologia?', 'Principio central de organelas usado em Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de mitose em Biologia?', 'Principio central de mitose usado em Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de meiose em Biologia?', 'Principio central de meiose usado em Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de dna e rna em Biologia?', 'Principio central de dna e rna usado em Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de genetica mendeliana em Biologia?', 'Principio central de genetica mendeliana usado em Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de grupos sanguineos em Biologia?', 'Principio central de grupos sanguineos usado em Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de biotecnologia em Biologia?', 'Principio central de biotecnologia usado em Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de evolucao em Biologia?', 'Principio central de evolucao usado em Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de selecao natural em Biologia?', 'Principio central de selecao natural usado em Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de ecologia em Biologia?', 'Principio central de ecologia usado em Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de cadeias alimentares em Biologia?', 'Principio central de cadeias alimentares usado em Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de ciclos biogeoquimicos em Biologia?', 'Principio central de ciclos biogeoquimicos usado em Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de biomas brasileiros em Biologia?', 'Principio central de biomas brasileiros usado em Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de botanica em Biologia?', 'Principio central de botanica usado em Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de fotossintese em Biologia?', 'Principio central de fotossintese usado em Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de respiracao celular em Biologia?', 'Principio central de respiracao celular usado em Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de zoologia em Biologia?', 'Principio central de zoologia usado em Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de sistema digestorio em Biologia?', 'Principio central de sistema digestorio usado em Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de sistema respiratorio em Biologia?', 'Principio central de sistema respiratorio usado em Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de sistema circulatorio em Biologia?', 'Principio central de sistema circulatorio usado em Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de sistema nervoso em Biologia?', 'Principio central de sistema nervoso usado em Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de sistema endocrino em Biologia?', 'Principio central de sistema endocrino usado em Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de sistema reprodutor em Biologia?', 'Principio central de sistema reprodutor usado em Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de microbiologia em Biologia?', 'Principio central de microbiologia usado em Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de virus e bacterias em Biologia?', 'Principio central de virus e bacterias usado em Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de fungos em Biologia?', 'Principio central de fungos usado em Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de protozoarios em Biologia?', 'Principio central de protozoarios usado em Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de imunologia em Biologia?', 'Principio central de imunologia usado em Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Resolucao de Problemas (Auto)', 'Deck automatico de Biologia com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar citologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de citologia e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar membrana plasmatica em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de membrana plasmatica e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar organelas em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de organelas e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar mitose em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de mitose e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar meiose em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de meiose e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar dna e rna em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de dna e rna e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar genetica mendeliana em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de genetica mendeliana e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar grupos sanguineos em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de grupos sanguineos e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar biotecnologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de biotecnologia e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar evolucao em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de evolucao e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar selecao natural em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de selecao natural e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar ecologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de ecologia e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar cadeias alimentares em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de cadeias alimentares e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar ciclos biogeoquimicos em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de ciclos biogeoquimicos e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar biomas brasileiros em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de biomas brasileiros e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar botanica em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de botanica e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar fotossintese em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de fotossintese e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar respiracao celular em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de respiracao celular e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar zoologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de zoologia e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar sistema digestorio em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema digestorio e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar sistema respiratorio em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema respiratorio e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar sistema circulatorio em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema circulatorio e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar sistema nervoso em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema nervoso e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar sistema endocrino em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema endocrino e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar sistema reprodutor em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de sistema reprodutor e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar microbiologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de microbiologia e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar virus e bacterias em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de virus e bacterias e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar fungos em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de fungos e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar protozoarios em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de protozoarios e concluir no contexto de Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar imunologia em Biologia?', 'Sequencia simples: identificar dados, aplicar regras de imunologia e concluir no contexto de Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Erros Comuns e Dicas (Auto)', 'Deck automatico de Biologia com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com citologia em Biologia?', 'Erro comum: confundir conceito ou etapa de citologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com membrana plasmatica em Biologia?', 'Erro comum: confundir conceito ou etapa de membrana plasmatica; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com organelas em Biologia?', 'Erro comum: confundir conceito ou etapa de organelas; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com mitose em Biologia?', 'Erro comum: confundir conceito ou etapa de mitose; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com meiose em Biologia?', 'Erro comum: confundir conceito ou etapa de meiose; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com dna e rna em Biologia?', 'Erro comum: confundir conceito ou etapa de dna e rna; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com genetica mendeliana em Biologia?', 'Erro comum: confundir conceito ou etapa de genetica mendeliana; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com grupos sanguineos em Biologia?', 'Erro comum: confundir conceito ou etapa de grupos sanguineos; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com biotecnologia em Biologia?', 'Erro comum: confundir conceito ou etapa de biotecnologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com evolucao em Biologia?', 'Erro comum: confundir conceito ou etapa de evolucao; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com selecao natural em Biologia?', 'Erro comum: confundir conceito ou etapa de selecao natural; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com ecologia em Biologia?', 'Erro comum: confundir conceito ou etapa de ecologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com cadeias alimentares em Biologia?', 'Erro comum: confundir conceito ou etapa de cadeias alimentares; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com ciclos biogeoquimicos em Biologia?', 'Erro comum: confundir conceito ou etapa de ciclos biogeoquimicos; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com biomas brasileiros em Biologia?', 'Erro comum: confundir conceito ou etapa de biomas brasileiros; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com botanica em Biologia?', 'Erro comum: confundir conceito ou etapa de botanica; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com fotossintese em Biologia?', 'Erro comum: confundir conceito ou etapa de fotossintese; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com respiracao celular em Biologia?', 'Erro comum: confundir conceito ou etapa de respiracao celular; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com zoologia em Biologia?', 'Erro comum: confundir conceito ou etapa de zoologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com sistema digestorio em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema digestorio; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com sistema respiratorio em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema respiratorio; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com sistema circulatorio em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema circulatorio; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com sistema nervoso em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema nervoso; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com sistema endocrino em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema endocrino; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com sistema reprodutor em Biologia?', 'Erro comum: confundir conceito ou etapa de sistema reprodutor; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com microbiologia em Biologia?', 'Erro comum: confundir conceito ou etapa de microbiologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com virus e bacterias em Biologia?', 'Erro comum: confundir conceito ou etapa de virus e bacterias; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com fungos em Biologia?', 'Erro comum: confundir conceito ou etapa de fungos; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com protozoarios em Biologia?', 'Erro comum: confundir conceito ou etapa de protozoarios; evite revisando definicoes e condicoes em Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com imunologia em Biologia?', 'Erro comum: confundir conceito ou etapa de imunologia; evite revisando definicoes e condicoes em Biologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Biologia - Revisao Rapida (Auto)', 'Deck automatico de Biologia com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'science', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: citologia em Biologia.', 'Resumo: pontos essenciais de citologia e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: membrana plasmatica em Biologia.', 'Resumo: pontos essenciais de membrana plasmatica e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: organelas em Biologia.', 'Resumo: pontos essenciais de organelas e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: mitose em Biologia.', 'Resumo: pontos essenciais de mitose e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: meiose em Biologia.', 'Resumo: pontos essenciais de meiose e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: dna e rna em Biologia.', 'Resumo: pontos essenciais de dna e rna e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: genetica mendeliana em Biologia.', 'Resumo: pontos essenciais de genetica mendeliana e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: grupos sanguineos em Biologia.', 'Resumo: pontos essenciais de grupos sanguineos e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: biotecnologia em Biologia.', 'Resumo: pontos essenciais de biotecnologia e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: evolucao em Biologia.', 'Resumo: pontos essenciais de evolucao e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: selecao natural em Biologia.', 'Resumo: pontos essenciais de selecao natural e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: ecologia em Biologia.', 'Resumo: pontos essenciais de ecologia e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: cadeias alimentares em Biologia.', 'Resumo: pontos essenciais de cadeias alimentares e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: ciclos biogeoquimicos em Biologia.', 'Resumo: pontos essenciais de ciclos biogeoquimicos e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: biomas brasileiros em Biologia.', 'Resumo: pontos essenciais de biomas brasileiros e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: botanica em Biologia.', 'Resumo: pontos essenciais de botanica e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: fotossintese em Biologia.', 'Resumo: pontos essenciais de fotossintese e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: respiracao celular em Biologia.', 'Resumo: pontos essenciais de respiracao celular e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: zoologia em Biologia.', 'Resumo: pontos essenciais de zoologia e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: sistema digestorio em Biologia.', 'Resumo: pontos essenciais de sistema digestorio e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: sistema respiratorio em Biologia.', 'Resumo: pontos essenciais de sistema respiratorio e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: sistema circulatorio em Biologia.', 'Resumo: pontos essenciais de sistema circulatorio e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: sistema nervoso em Biologia.', 'Resumo: pontos essenciais de sistema nervoso e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: sistema endocrino em Biologia.', 'Resumo: pontos essenciais de sistema endocrino e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: sistema reprodutor em Biologia.', 'Resumo: pontos essenciais de sistema reprodutor e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: microbiologia em Biologia.', 'Resumo: pontos essenciais de microbiologia e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: virus e bacterias em Biologia.', 'Resumo: pontos essenciais de virus e bacterias e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: fungos em Biologia.', 'Resumo: pontos essenciais de fungos e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: protozoarios em Biologia.', 'Resumo: pontos essenciais de protozoarios e sua utilidade em Biologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: imunologia em Biologia.', 'Resumo: pontos essenciais de imunologia e sua utilidade em Biologia.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Biologia';
END $$;
