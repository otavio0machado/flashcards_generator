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

  -- Literatura
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/linguagens/literatura';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/linguagens/literatura'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Fundamentos e Conceitos (Auto)', 'Deck automatico de Literatura com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e teoria literaria em Literatura?', 'Conceito basico de teoria literaria aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e generos literarios em Literatura?', 'Conceito basico de generos literarios aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e lirico em Literatura?', 'Conceito basico de lirico aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e epico em Literatura?', 'Conceito basico de epico aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e dramatico em Literatura?', 'Conceito basico de dramatico aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e trovadorismo em Literatura?', 'Conceito basico de trovadorismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e humanismo em Literatura?', 'Conceito basico de humanismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e classicismo em Literatura?', 'Conceito basico de classicismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e quinhentismo em Literatura?', 'Conceito basico de quinhentismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e barroco em Literatura?', 'Conceito basico de barroco aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e arcadismo em Literatura?', 'Conceito basico de arcadismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e romantismo em Literatura?', 'Conceito basico de romantismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e realismo em Literatura?', 'Conceito basico de realismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e naturalismo em Literatura?', 'Conceito basico de naturalismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e parnasianismo em Literatura?', 'Conceito basico de parnasianismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e simbolismo em Literatura?', 'Conceito basico de simbolismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e pre-modernismo em Literatura?', 'Conceito basico de pre-modernismo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e modernismo 1a geracao em Literatura?', 'Conceito basico de modernismo 1a geracao aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e modernismo 2a geracao em Literatura?', 'Conceito basico de modernismo 2a geracao aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e modernismo 3a geracao em Literatura?', 'Conceito basico de modernismo 3a geracao aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e literatura contemporanea em Literatura?', 'Conceito basico de literatura contemporanea aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e narrador em Literatura?', 'Conceito basico de narrador aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e foco narrativo em Literatura?', 'Conceito basico de foco narrativo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e tempo narrativo em Literatura?', 'Conceito basico de tempo narrativo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e espaco narrativo em Literatura?', 'Conceito basico de espaco narrativo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e personagens em Literatura?', 'Conceito basico de personagens aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e enredo em Literatura?', 'Conceito basico de enredo aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e intertextualidade em Literatura?', 'Conceito basico de intertextualidade aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e metalinguagem em Literatura?', 'Conceito basico de metalinguagem aplicado a Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e poetica em Literatura?', 'Conceito basico de poetica aplicado a Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Definicoes e Terminologia (Auto)', 'Deck automatico de Literatura com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina teoria literaria no contexto de Literatura.', 'Definicao objetiva de teoria literaria para Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina generos literarios no contexto de Literatura.', 'Definicao objetiva de generos literarios para Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina lirico no contexto de Literatura.', 'Definicao objetiva de lirico para Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina epico no contexto de Literatura.', 'Definicao objetiva de epico para Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina dramatico no contexto de Literatura.', 'Definicao objetiva de dramatico para Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina trovadorismo no contexto de Literatura.', 'Definicao objetiva de trovadorismo para Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina humanismo no contexto de Literatura.', 'Definicao objetiva de humanismo para Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina classicismo no contexto de Literatura.', 'Definicao objetiva de classicismo para Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina quinhentismo no contexto de Literatura.', 'Definicao objetiva de quinhentismo para Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina barroco no contexto de Literatura.', 'Definicao objetiva de barroco para Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina arcadismo no contexto de Literatura.', 'Definicao objetiva de arcadismo para Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina romantismo no contexto de Literatura.', 'Definicao objetiva de romantismo para Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina realismo no contexto de Literatura.', 'Definicao objetiva de realismo para Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina naturalismo no contexto de Literatura.', 'Definicao objetiva de naturalismo para Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina parnasianismo no contexto de Literatura.', 'Definicao objetiva de parnasianismo para Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina simbolismo no contexto de Literatura.', 'Definicao objetiva de simbolismo para Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina pre-modernismo no contexto de Literatura.', 'Definicao objetiva de pre-modernismo para Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina modernismo 1a geracao no contexto de Literatura.', 'Definicao objetiva de modernismo 1a geracao para Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina modernismo 2a geracao no contexto de Literatura.', 'Definicao objetiva de modernismo 2a geracao para Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina modernismo 3a geracao no contexto de Literatura.', 'Definicao objetiva de modernismo 3a geracao para Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina literatura contemporanea no contexto de Literatura.', 'Definicao objetiva de literatura contemporanea para Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina narrador no contexto de Literatura.', 'Definicao objetiva de narrador para Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina foco narrativo no contexto de Literatura.', 'Definicao objetiva de foco narrativo para Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina tempo narrativo no contexto de Literatura.', 'Definicao objetiva de tempo narrativo para Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina espaco narrativo no contexto de Literatura.', 'Definicao objetiva de espaco narrativo para Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina personagens no contexto de Literatura.', 'Definicao objetiva de personagens para Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina enredo no contexto de Literatura.', 'Definicao objetiva de enredo para Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina intertextualidade no contexto de Literatura.', 'Definicao objetiva de intertextualidade para Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina metalinguagem no contexto de Literatura.', 'Definicao objetiva de metalinguagem para Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina poetica no contexto de Literatura.', 'Definicao objetiva de poetica para Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Processos e Aplicacoes (Auto)', 'Deck automatico de Literatura com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como teoria literaria se aplica em Literatura?', 'Resumo do processo de teoria literaria e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como generos literarios se aplica em Literatura?', 'Resumo do processo de generos literarios e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como lirico se aplica em Literatura?', 'Resumo do processo de lirico e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como epico se aplica em Literatura?', 'Resumo do processo de epico e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como dramatico se aplica em Literatura?', 'Resumo do processo de dramatico e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como trovadorismo se aplica em Literatura?', 'Resumo do processo de trovadorismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como humanismo se aplica em Literatura?', 'Resumo do processo de humanismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como classicismo se aplica em Literatura?', 'Resumo do processo de classicismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como quinhentismo se aplica em Literatura?', 'Resumo do processo de quinhentismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como barroco se aplica em Literatura?', 'Resumo do processo de barroco e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como arcadismo se aplica em Literatura?', 'Resumo do processo de arcadismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como romantismo se aplica em Literatura?', 'Resumo do processo de romantismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como realismo se aplica em Literatura?', 'Resumo do processo de realismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como naturalismo se aplica em Literatura?', 'Resumo do processo de naturalismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como parnasianismo se aplica em Literatura?', 'Resumo do processo de parnasianismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como simbolismo se aplica em Literatura?', 'Resumo do processo de simbolismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como pre-modernismo se aplica em Literatura?', 'Resumo do processo de pre-modernismo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como modernismo 1a geracao se aplica em Literatura?', 'Resumo do processo de modernismo 1a geracao e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como modernismo 2a geracao se aplica em Literatura?', 'Resumo do processo de modernismo 2a geracao e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como modernismo 3a geracao se aplica em Literatura?', 'Resumo do processo de modernismo 3a geracao e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como literatura contemporanea se aplica em Literatura?', 'Resumo do processo de literatura contemporanea e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como narrador se aplica em Literatura?', 'Resumo do processo de narrador e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como foco narrativo se aplica em Literatura?', 'Resumo do processo de foco narrativo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como tempo narrativo se aplica em Literatura?', 'Resumo do processo de tempo narrativo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como espaco narrativo se aplica em Literatura?', 'Resumo do processo de espaco narrativo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como personagens se aplica em Literatura?', 'Resumo do processo de personagens e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como enredo se aplica em Literatura?', 'Resumo do processo de enredo e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como intertextualidade se aplica em Literatura?', 'Resumo do processo de intertextualidade e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como metalinguagem se aplica em Literatura?', 'Resumo do processo de metalinguagem e sua aplicacao em Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como poetica se aplica em Literatura?', 'Resumo do processo de poetica e sua aplicacao em Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Regras e Principios (Auto)', 'Deck automatico de Literatura com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de teoria literaria em Literatura?', 'Principio central de teoria literaria usado em Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de generos literarios em Literatura?', 'Principio central de generos literarios usado em Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de lirico em Literatura?', 'Principio central de lirico usado em Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de epico em Literatura?', 'Principio central de epico usado em Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de dramatico em Literatura?', 'Principio central de dramatico usado em Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de trovadorismo em Literatura?', 'Principio central de trovadorismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de humanismo em Literatura?', 'Principio central de humanismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de classicismo em Literatura?', 'Principio central de classicismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de quinhentismo em Literatura?', 'Principio central de quinhentismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de barroco em Literatura?', 'Principio central de barroco usado em Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de arcadismo em Literatura?', 'Principio central de arcadismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de romantismo em Literatura?', 'Principio central de romantismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de realismo em Literatura?', 'Principio central de realismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de naturalismo em Literatura?', 'Principio central de naturalismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de parnasianismo em Literatura?', 'Principio central de parnasianismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de simbolismo em Literatura?', 'Principio central de simbolismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de pre-modernismo em Literatura?', 'Principio central de pre-modernismo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de modernismo 1a geracao em Literatura?', 'Principio central de modernismo 1a geracao usado em Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de modernismo 2a geracao em Literatura?', 'Principio central de modernismo 2a geracao usado em Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de modernismo 3a geracao em Literatura?', 'Principio central de modernismo 3a geracao usado em Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de literatura contemporanea em Literatura?', 'Principio central de literatura contemporanea usado em Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de narrador em Literatura?', 'Principio central de narrador usado em Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de foco narrativo em Literatura?', 'Principio central de foco narrativo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de tempo narrativo em Literatura?', 'Principio central de tempo narrativo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de espaco narrativo em Literatura?', 'Principio central de espaco narrativo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de personagens em Literatura?', 'Principio central de personagens usado em Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de enredo em Literatura?', 'Principio central de enredo usado em Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de intertextualidade em Literatura?', 'Principio central de intertextualidade usado em Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de metalinguagem em Literatura?', 'Principio central de metalinguagem usado em Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de poetica em Literatura?', 'Principio central de poetica usado em Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Resolucao de Problemas (Auto)', 'Deck automatico de Literatura com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar teoria literaria em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de teoria literaria e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar generos literarios em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de generos literarios e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar lirico em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de lirico e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar epico em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de epico e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar dramatico em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de dramatico e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar trovadorismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de trovadorismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar humanismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de humanismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar classicismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de classicismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar quinhentismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de quinhentismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar barroco em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de barroco e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar arcadismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de arcadismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar romantismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de romantismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar realismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de realismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar naturalismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de naturalismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar parnasianismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de parnasianismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar simbolismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de simbolismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar pre-modernismo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de pre-modernismo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar modernismo 1a geracao em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de modernismo 1a geracao e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar modernismo 2a geracao em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de modernismo 2a geracao e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar modernismo 3a geracao em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de modernismo 3a geracao e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar literatura contemporanea em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de literatura contemporanea e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar narrador em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de narrador e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar foco narrativo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de foco narrativo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar tempo narrativo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de tempo narrativo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar espaco narrativo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de espaco narrativo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar personagens em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de personagens e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar enredo em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de enredo e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar intertextualidade em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de intertextualidade e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar metalinguagem em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de metalinguagem e concluir no contexto de Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar poetica em Literatura?', 'Sequencia simples: identificar dados, aplicar regras de poetica e concluir no contexto de Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Erros Comuns e Dicas (Auto)', 'Deck automatico de Literatura com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com teoria literaria em Literatura?', 'Erro comum: confundir conceito ou etapa de teoria literaria; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com generos literarios em Literatura?', 'Erro comum: confundir conceito ou etapa de generos literarios; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com lirico em Literatura?', 'Erro comum: confundir conceito ou etapa de lirico; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com epico em Literatura?', 'Erro comum: confundir conceito ou etapa de epico; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com dramatico em Literatura?', 'Erro comum: confundir conceito ou etapa de dramatico; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com trovadorismo em Literatura?', 'Erro comum: confundir conceito ou etapa de trovadorismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com humanismo em Literatura?', 'Erro comum: confundir conceito ou etapa de humanismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com classicismo em Literatura?', 'Erro comum: confundir conceito ou etapa de classicismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com quinhentismo em Literatura?', 'Erro comum: confundir conceito ou etapa de quinhentismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com barroco em Literatura?', 'Erro comum: confundir conceito ou etapa de barroco; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com arcadismo em Literatura?', 'Erro comum: confundir conceito ou etapa de arcadismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com romantismo em Literatura?', 'Erro comum: confundir conceito ou etapa de romantismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com realismo em Literatura?', 'Erro comum: confundir conceito ou etapa de realismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com naturalismo em Literatura?', 'Erro comum: confundir conceito ou etapa de naturalismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com parnasianismo em Literatura?', 'Erro comum: confundir conceito ou etapa de parnasianismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com simbolismo em Literatura?', 'Erro comum: confundir conceito ou etapa de simbolismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com pre-modernismo em Literatura?', 'Erro comum: confundir conceito ou etapa de pre-modernismo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com modernismo 1a geracao em Literatura?', 'Erro comum: confundir conceito ou etapa de modernismo 1a geracao; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com modernismo 2a geracao em Literatura?', 'Erro comum: confundir conceito ou etapa de modernismo 2a geracao; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com modernismo 3a geracao em Literatura?', 'Erro comum: confundir conceito ou etapa de modernismo 3a geracao; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com literatura contemporanea em Literatura?', 'Erro comum: confundir conceito ou etapa de literatura contemporanea; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com narrador em Literatura?', 'Erro comum: confundir conceito ou etapa de narrador; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com foco narrativo em Literatura?', 'Erro comum: confundir conceito ou etapa de foco narrativo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com tempo narrativo em Literatura?', 'Erro comum: confundir conceito ou etapa de tempo narrativo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com espaco narrativo em Literatura?', 'Erro comum: confundir conceito ou etapa de espaco narrativo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com personagens em Literatura?', 'Erro comum: confundir conceito ou etapa de personagens; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com enredo em Literatura?', 'Erro comum: confundir conceito ou etapa de enredo; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com intertextualidade em Literatura?', 'Erro comum: confundir conceito ou etapa de intertextualidade; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com metalinguagem em Literatura?', 'Erro comum: confundir conceito ou etapa de metalinguagem; evite revisando definicoes e condicoes em Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com poetica em Literatura?', 'Erro comum: confundir conceito ou etapa de poetica; evite revisando definicoes e condicoes em Literatura.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Literatura - Revisao Rapida (Auto)', 'Deck automatico de Literatura com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['literatura', 'literature', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: teoria literaria em Literatura.', 'Resumo: pontos essenciais de teoria literaria e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: generos literarios em Literatura.', 'Resumo: pontos essenciais de generos literarios e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: lirico em Literatura.', 'Resumo: pontos essenciais de lirico e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: epico em Literatura.', 'Resumo: pontos essenciais de epico e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: dramatico em Literatura.', 'Resumo: pontos essenciais de dramatico e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: trovadorismo em Literatura.', 'Resumo: pontos essenciais de trovadorismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: humanismo em Literatura.', 'Resumo: pontos essenciais de humanismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: classicismo em Literatura.', 'Resumo: pontos essenciais de classicismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: quinhentismo em Literatura.', 'Resumo: pontos essenciais de quinhentismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: barroco em Literatura.', 'Resumo: pontos essenciais de barroco e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: arcadismo em Literatura.', 'Resumo: pontos essenciais de arcadismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: romantismo em Literatura.', 'Resumo: pontos essenciais de romantismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: realismo em Literatura.', 'Resumo: pontos essenciais de realismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: naturalismo em Literatura.', 'Resumo: pontos essenciais de naturalismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: parnasianismo em Literatura.', 'Resumo: pontos essenciais de parnasianismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: simbolismo em Literatura.', 'Resumo: pontos essenciais de simbolismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: pre-modernismo em Literatura.', 'Resumo: pontos essenciais de pre-modernismo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: modernismo 1a geracao em Literatura.', 'Resumo: pontos essenciais de modernismo 1a geracao e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: modernismo 2a geracao em Literatura.', 'Resumo: pontos essenciais de modernismo 2a geracao e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: modernismo 3a geracao em Literatura.', 'Resumo: pontos essenciais de modernismo 3a geracao e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: literatura contemporanea em Literatura.', 'Resumo: pontos essenciais de literatura contemporanea e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: narrador em Literatura.', 'Resumo: pontos essenciais de narrador e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: foco narrativo em Literatura.', 'Resumo: pontos essenciais de foco narrativo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: tempo narrativo em Literatura.', 'Resumo: pontos essenciais de tempo narrativo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: espaco narrativo em Literatura.', 'Resumo: pontos essenciais de espaco narrativo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: personagens em Literatura.', 'Resumo: pontos essenciais de personagens e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: enredo em Literatura.', 'Resumo: pontos essenciais de enredo e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: intertextualidade em Literatura.', 'Resumo: pontos essenciais de intertextualidade e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: metalinguagem em Literatura.', 'Resumo: pontos essenciais de metalinguagem e sua utilidade em Literatura.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: poetica em Literatura.', 'Resumo: pontos essenciais de poetica e sua utilidade em Literatura.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Literatura';
END $$;
