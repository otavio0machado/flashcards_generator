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

  -- Sociologia
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-humanas/sociologia';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/ciencias-humanas/sociologia'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Fundamentos e Conceitos (Auto)', 'Deck automatico de Sociologia com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e antiguidade em Sociologia?', 'Conceito basico de antiguidade aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e grecia em Sociologia?', 'Conceito basico de grecia aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e roma em Sociologia?', 'Conceito basico de roma aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e idade media em Sociologia?', 'Conceito basico de idade media aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e feudalismo em Sociologia?', 'Conceito basico de feudalismo aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e renascimento em Sociologia?', 'Conceito basico de renascimento aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e reformas em Sociologia?', 'Conceito basico de reformas aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e absolutismo em Sociologia?', 'Conceito basico de absolutismo aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e iluminismo em Sociologia?', 'Conceito basico de iluminismo aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e revolucao francesa em Sociologia?', 'Conceito basico de revolucao francesa aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e revolucao industrial em Sociologia?', 'Conceito basico de revolucao industrial aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e imperialismo em Sociologia?', 'Conceito basico de imperialismo aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e primeira guerra em Sociologia?', 'Conceito basico de primeira guerra aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e segunda guerra em Sociologia?', 'Conceito basico de segunda guerra aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e guerra fria em Sociologia?', 'Conceito basico de guerra fria aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e mundo contemporaneo em Sociologia?', 'Conceito basico de mundo contemporaneo aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e colonizacao do brasil em Sociologia?', 'Conceito basico de colonizacao do brasil aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e ciclos economicos em Sociologia?', 'Conceito basico de ciclos economicos aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e escravidao em Sociologia?', 'Conceito basico de escravidao aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e independencia em Sociologia?', 'Conceito basico de independencia aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e primeiro reinado em Sociologia?', 'Conceito basico de primeiro reinado aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e segundo reinado em Sociologia?', 'Conceito basico de segundo reinado aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e republica velha em Sociologia?', 'Conceito basico de republica velha aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e era vargas em Sociologia?', 'Conceito basico de era vargas aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e ditadura militar em Sociologia?', 'Conceito basico de ditadura militar aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e redemocratizacao em Sociologia?', 'Conceito basico de redemocratizacao aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e movimentos sociais em Sociologia?', 'Conceito basico de movimentos sociais aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e cidadania em Sociologia?', 'Conceito basico de cidadania aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e historia da africa em Sociologia?', 'Conceito basico de historia da africa aplicado a Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e historia da america em Sociologia?', 'Conceito basico de historia da america aplicado a Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Definicoes e Terminologia (Auto)', 'Deck automatico de Sociologia com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina antiguidade no contexto de Sociologia.', 'Definicao objetiva de antiguidade para Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina grecia no contexto de Sociologia.', 'Definicao objetiva de grecia para Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina roma no contexto de Sociologia.', 'Definicao objetiva de roma para Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina idade media no contexto de Sociologia.', 'Definicao objetiva de idade media para Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina feudalismo no contexto de Sociologia.', 'Definicao objetiva de feudalismo para Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina renascimento no contexto de Sociologia.', 'Definicao objetiva de renascimento para Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina reformas no contexto de Sociologia.', 'Definicao objetiva de reformas para Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina absolutismo no contexto de Sociologia.', 'Definicao objetiva de absolutismo para Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina iluminismo no contexto de Sociologia.', 'Definicao objetiva de iluminismo para Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina revolucao francesa no contexto de Sociologia.', 'Definicao objetiva de revolucao francesa para Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina revolucao industrial no contexto de Sociologia.', 'Definicao objetiva de revolucao industrial para Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina imperialismo no contexto de Sociologia.', 'Definicao objetiva de imperialismo para Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina primeira guerra no contexto de Sociologia.', 'Definicao objetiva de primeira guerra para Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina segunda guerra no contexto de Sociologia.', 'Definicao objetiva de segunda guerra para Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina guerra fria no contexto de Sociologia.', 'Definicao objetiva de guerra fria para Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina mundo contemporaneo no contexto de Sociologia.', 'Definicao objetiva de mundo contemporaneo para Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina colonizacao do brasil no contexto de Sociologia.', 'Definicao objetiva de colonizacao do brasil para Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina ciclos economicos no contexto de Sociologia.', 'Definicao objetiva de ciclos economicos para Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina escravidao no contexto de Sociologia.', 'Definicao objetiva de escravidao para Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina independencia no contexto de Sociologia.', 'Definicao objetiva de independencia para Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina primeiro reinado no contexto de Sociologia.', 'Definicao objetiva de primeiro reinado para Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina segundo reinado no contexto de Sociologia.', 'Definicao objetiva de segundo reinado para Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina republica velha no contexto de Sociologia.', 'Definicao objetiva de republica velha para Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina era vargas no contexto de Sociologia.', 'Definicao objetiva de era vargas para Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina ditadura militar no contexto de Sociologia.', 'Definicao objetiva de ditadura militar para Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina redemocratizacao no contexto de Sociologia.', 'Definicao objetiva de redemocratizacao para Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina movimentos sociais no contexto de Sociologia.', 'Definicao objetiva de movimentos sociais para Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina cidadania no contexto de Sociologia.', 'Definicao objetiva de cidadania para Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina historia da africa no contexto de Sociologia.', 'Definicao objetiva de historia da africa para Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina historia da america no contexto de Sociologia.', 'Definicao objetiva de historia da america para Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Processos e Aplicacoes (Auto)', 'Deck automatico de Sociologia com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como antiguidade se aplica em Sociologia?', 'Resumo do processo de antiguidade e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como grecia se aplica em Sociologia?', 'Resumo do processo de grecia e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como roma se aplica em Sociologia?', 'Resumo do processo de roma e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como idade media se aplica em Sociologia?', 'Resumo do processo de idade media e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como feudalismo se aplica em Sociologia?', 'Resumo do processo de feudalismo e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como renascimento se aplica em Sociologia?', 'Resumo do processo de renascimento e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como reformas se aplica em Sociologia?', 'Resumo do processo de reformas e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como absolutismo se aplica em Sociologia?', 'Resumo do processo de absolutismo e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como iluminismo se aplica em Sociologia?', 'Resumo do processo de iluminismo e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como revolucao francesa se aplica em Sociologia?', 'Resumo do processo de revolucao francesa e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como revolucao industrial se aplica em Sociologia?', 'Resumo do processo de revolucao industrial e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como imperialismo se aplica em Sociologia?', 'Resumo do processo de imperialismo e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como primeira guerra se aplica em Sociologia?', 'Resumo do processo de primeira guerra e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como segunda guerra se aplica em Sociologia?', 'Resumo do processo de segunda guerra e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como guerra fria se aplica em Sociologia?', 'Resumo do processo de guerra fria e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como mundo contemporaneo se aplica em Sociologia?', 'Resumo do processo de mundo contemporaneo e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como colonizacao do brasil se aplica em Sociologia?', 'Resumo do processo de colonizacao do brasil e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como ciclos economicos se aplica em Sociologia?', 'Resumo do processo de ciclos economicos e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como escravidao se aplica em Sociologia?', 'Resumo do processo de escravidao e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como independencia se aplica em Sociologia?', 'Resumo do processo de independencia e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como primeiro reinado se aplica em Sociologia?', 'Resumo do processo de primeiro reinado e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como segundo reinado se aplica em Sociologia?', 'Resumo do processo de segundo reinado e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como republica velha se aplica em Sociologia?', 'Resumo do processo de republica velha e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como era vargas se aplica em Sociologia?', 'Resumo do processo de era vargas e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como ditadura militar se aplica em Sociologia?', 'Resumo do processo de ditadura militar e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como redemocratizacao se aplica em Sociologia?', 'Resumo do processo de redemocratizacao e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como movimentos sociais se aplica em Sociologia?', 'Resumo do processo de movimentos sociais e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como cidadania se aplica em Sociologia?', 'Resumo do processo de cidadania e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como historia da africa se aplica em Sociologia?', 'Resumo do processo de historia da africa e sua aplicacao em Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como historia da america se aplica em Sociologia?', 'Resumo do processo de historia da america e sua aplicacao em Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Regras e Principios (Auto)', 'Deck automatico de Sociologia com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de antiguidade em Sociologia?', 'Principio central de antiguidade usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de grecia em Sociologia?', 'Principio central de grecia usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de roma em Sociologia?', 'Principio central de roma usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de idade media em Sociologia?', 'Principio central de idade media usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de feudalismo em Sociologia?', 'Principio central de feudalismo usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de renascimento em Sociologia?', 'Principio central de renascimento usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de reformas em Sociologia?', 'Principio central de reformas usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de absolutismo em Sociologia?', 'Principio central de absolutismo usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de iluminismo em Sociologia?', 'Principio central de iluminismo usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de revolucao francesa em Sociologia?', 'Principio central de revolucao francesa usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de revolucao industrial em Sociologia?', 'Principio central de revolucao industrial usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de imperialismo em Sociologia?', 'Principio central de imperialismo usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de primeira guerra em Sociologia?', 'Principio central de primeira guerra usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de segunda guerra em Sociologia?', 'Principio central de segunda guerra usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de guerra fria em Sociologia?', 'Principio central de guerra fria usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de mundo contemporaneo em Sociologia?', 'Principio central de mundo contemporaneo usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de colonizacao do brasil em Sociologia?', 'Principio central de colonizacao do brasil usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de ciclos economicos em Sociologia?', 'Principio central de ciclos economicos usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de escravidao em Sociologia?', 'Principio central de escravidao usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de independencia em Sociologia?', 'Principio central de independencia usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de primeiro reinado em Sociologia?', 'Principio central de primeiro reinado usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de segundo reinado em Sociologia?', 'Principio central de segundo reinado usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de republica velha em Sociologia?', 'Principio central de republica velha usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de era vargas em Sociologia?', 'Principio central de era vargas usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de ditadura militar em Sociologia?', 'Principio central de ditadura militar usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de redemocratizacao em Sociologia?', 'Principio central de redemocratizacao usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de movimentos sociais em Sociologia?', 'Principio central de movimentos sociais usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de cidadania em Sociologia?', 'Principio central de cidadania usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de historia da africa em Sociologia?', 'Principio central de historia da africa usado em Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de historia da america em Sociologia?', 'Principio central de historia da america usado em Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Resolucao de Problemas (Auto)', 'Deck automatico de Sociologia com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar antiguidade em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de antiguidade e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar grecia em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de grecia e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar roma em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de roma e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar idade media em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de idade media e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar feudalismo em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de feudalismo e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar renascimento em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de renascimento e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar reformas em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de reformas e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar absolutismo em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de absolutismo e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar iluminismo em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de iluminismo e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar revolucao francesa em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de revolucao francesa e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar revolucao industrial em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de revolucao industrial e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar imperialismo em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de imperialismo e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar primeira guerra em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de primeira guerra e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar segunda guerra em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de segunda guerra e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar guerra fria em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de guerra fria e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar mundo contemporaneo em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de mundo contemporaneo e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar colonizacao do brasil em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de colonizacao do brasil e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar ciclos economicos em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de ciclos economicos e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar escravidao em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de escravidao e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar independencia em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de independencia e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar primeiro reinado em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de primeiro reinado e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar segundo reinado em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de segundo reinado e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar republica velha em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de republica velha e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar era vargas em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de era vargas e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar ditadura militar em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de ditadura militar e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar redemocratizacao em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de redemocratizacao e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar movimentos sociais em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de movimentos sociais e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar cidadania em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de cidadania e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar historia da africa em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de historia da africa e concluir no contexto de Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar historia da america em Sociologia?', 'Sequencia simples: identificar dados, aplicar regras de historia da america e concluir no contexto de Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Erros Comuns e Dicas (Auto)', 'Deck automatico de Sociologia com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com antiguidade em Sociologia?', 'Erro comum: confundir conceito ou etapa de antiguidade; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com grecia em Sociologia?', 'Erro comum: confundir conceito ou etapa de grecia; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com roma em Sociologia?', 'Erro comum: confundir conceito ou etapa de roma; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com idade media em Sociologia?', 'Erro comum: confundir conceito ou etapa de idade media; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com feudalismo em Sociologia?', 'Erro comum: confundir conceito ou etapa de feudalismo; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com renascimento em Sociologia?', 'Erro comum: confundir conceito ou etapa de renascimento; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com reformas em Sociologia?', 'Erro comum: confundir conceito ou etapa de reformas; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com absolutismo em Sociologia?', 'Erro comum: confundir conceito ou etapa de absolutismo; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com iluminismo em Sociologia?', 'Erro comum: confundir conceito ou etapa de iluminismo; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com revolucao francesa em Sociologia?', 'Erro comum: confundir conceito ou etapa de revolucao francesa; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com revolucao industrial em Sociologia?', 'Erro comum: confundir conceito ou etapa de revolucao industrial; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com imperialismo em Sociologia?', 'Erro comum: confundir conceito ou etapa de imperialismo; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com primeira guerra em Sociologia?', 'Erro comum: confundir conceito ou etapa de primeira guerra; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com segunda guerra em Sociologia?', 'Erro comum: confundir conceito ou etapa de segunda guerra; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com guerra fria em Sociologia?', 'Erro comum: confundir conceito ou etapa de guerra fria; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com mundo contemporaneo em Sociologia?', 'Erro comum: confundir conceito ou etapa de mundo contemporaneo; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com colonizacao do brasil em Sociologia?', 'Erro comum: confundir conceito ou etapa de colonizacao do brasil; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com ciclos economicos em Sociologia?', 'Erro comum: confundir conceito ou etapa de ciclos economicos; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com escravidao em Sociologia?', 'Erro comum: confundir conceito ou etapa de escravidao; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com independencia em Sociologia?', 'Erro comum: confundir conceito ou etapa de independencia; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com primeiro reinado em Sociologia?', 'Erro comum: confundir conceito ou etapa de primeiro reinado; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com segundo reinado em Sociologia?', 'Erro comum: confundir conceito ou etapa de segundo reinado; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com republica velha em Sociologia?', 'Erro comum: confundir conceito ou etapa de republica velha; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com era vargas em Sociologia?', 'Erro comum: confundir conceito ou etapa de era vargas; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com ditadura militar em Sociologia?', 'Erro comum: confundir conceito ou etapa de ditadura militar; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com redemocratizacao em Sociologia?', 'Erro comum: confundir conceito ou etapa de redemocratizacao; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com movimentos sociais em Sociologia?', 'Erro comum: confundir conceito ou etapa de movimentos sociais; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com cidadania em Sociologia?', 'Erro comum: confundir conceito ou etapa de cidadania; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com historia da africa em Sociologia?', 'Erro comum: confundir conceito ou etapa de historia da africa; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com historia da america em Sociologia?', 'Erro comum: confundir conceito ou etapa de historia da america; evite revisando definicoes e condicoes em Sociologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Sociologia - Revisao Rapida (Auto)', 'Deck automatico de Sociologia com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['sociologia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: antiguidade em Sociologia.', 'Resumo: pontos essenciais de antiguidade e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: grecia em Sociologia.', 'Resumo: pontos essenciais de grecia e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: roma em Sociologia.', 'Resumo: pontos essenciais de roma e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: idade media em Sociologia.', 'Resumo: pontos essenciais de idade media e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: feudalismo em Sociologia.', 'Resumo: pontos essenciais de feudalismo e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: renascimento em Sociologia.', 'Resumo: pontos essenciais de renascimento e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: reformas em Sociologia.', 'Resumo: pontos essenciais de reformas e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: absolutismo em Sociologia.', 'Resumo: pontos essenciais de absolutismo e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: iluminismo em Sociologia.', 'Resumo: pontos essenciais de iluminismo e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: revolucao francesa em Sociologia.', 'Resumo: pontos essenciais de revolucao francesa e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: revolucao industrial em Sociologia.', 'Resumo: pontos essenciais de revolucao industrial e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: imperialismo em Sociologia.', 'Resumo: pontos essenciais de imperialismo e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: primeira guerra em Sociologia.', 'Resumo: pontos essenciais de primeira guerra e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: segunda guerra em Sociologia.', 'Resumo: pontos essenciais de segunda guerra e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: guerra fria em Sociologia.', 'Resumo: pontos essenciais de guerra fria e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: mundo contemporaneo em Sociologia.', 'Resumo: pontos essenciais de mundo contemporaneo e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: colonizacao do brasil em Sociologia.', 'Resumo: pontos essenciais de colonizacao do brasil e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: ciclos economicos em Sociologia.', 'Resumo: pontos essenciais de ciclos economicos e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: escravidao em Sociologia.', 'Resumo: pontos essenciais de escravidao e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: independencia em Sociologia.', 'Resumo: pontos essenciais de independencia e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: primeiro reinado em Sociologia.', 'Resumo: pontos essenciais de primeiro reinado e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: segundo reinado em Sociologia.', 'Resumo: pontos essenciais de segundo reinado e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: republica velha em Sociologia.', 'Resumo: pontos essenciais de republica velha e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: era vargas em Sociologia.', 'Resumo: pontos essenciais de era vargas e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: ditadura militar em Sociologia.', 'Resumo: pontos essenciais de ditadura militar e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: redemocratizacao em Sociologia.', 'Resumo: pontos essenciais de redemocratizacao e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: movimentos sociais em Sociologia.', 'Resumo: pontos essenciais de movimentos sociais e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: cidadania em Sociologia.', 'Resumo: pontos essenciais de cidadania e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: historia da africa em Sociologia.', 'Resumo: pontos essenciais de historia da africa e sua utilidade em Sociologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: historia da america em Sociologia.', 'Resumo: pontos essenciais de historia da america e sua utilidade em Sociologia.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Sociologia';
END $$;
