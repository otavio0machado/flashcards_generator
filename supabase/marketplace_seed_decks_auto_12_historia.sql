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

  -- Historia
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-humanas/historia';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/ciencias-humanas/historia'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Fundamentos e Conceitos (Auto)', 'Deck automatico de Historia com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e antiguidade em Historia?', 'Conceito basico de antiguidade aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e grecia em Historia?', 'Conceito basico de grecia aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e roma em Historia?', 'Conceito basico de roma aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e idade media em Historia?', 'Conceito basico de idade media aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e feudalismo em Historia?', 'Conceito basico de feudalismo aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e renascimento em Historia?', 'Conceito basico de renascimento aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e reformas em Historia?', 'Conceito basico de reformas aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e absolutismo em Historia?', 'Conceito basico de absolutismo aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e iluminismo em Historia?', 'Conceito basico de iluminismo aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e revolucao francesa em Historia?', 'Conceito basico de revolucao francesa aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e revolucao industrial em Historia?', 'Conceito basico de revolucao industrial aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e imperialismo em Historia?', 'Conceito basico de imperialismo aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e primeira guerra em Historia?', 'Conceito basico de primeira guerra aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e segunda guerra em Historia?', 'Conceito basico de segunda guerra aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e guerra fria em Historia?', 'Conceito basico de guerra fria aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e mundo contemporaneo em Historia?', 'Conceito basico de mundo contemporaneo aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e colonizacao do brasil em Historia?', 'Conceito basico de colonizacao do brasil aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e ciclos economicos em Historia?', 'Conceito basico de ciclos economicos aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e escravidao em Historia?', 'Conceito basico de escravidao aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e independencia em Historia?', 'Conceito basico de independencia aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e primeiro reinado em Historia?', 'Conceito basico de primeiro reinado aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e segundo reinado em Historia?', 'Conceito basico de segundo reinado aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e republica velha em Historia?', 'Conceito basico de republica velha aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e era vargas em Historia?', 'Conceito basico de era vargas aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e ditadura militar em Historia?', 'Conceito basico de ditadura militar aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e redemocratizacao em Historia?', 'Conceito basico de redemocratizacao aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e movimentos sociais em Historia?', 'Conceito basico de movimentos sociais aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e cidadania em Historia?', 'Conceito basico de cidadania aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e historia da africa em Historia?', 'Conceito basico de historia da africa aplicado a Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e historia da america em Historia?', 'Conceito basico de historia da america aplicado a Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Definicoes e Terminologia (Auto)', 'Deck automatico de Historia com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina antiguidade no contexto de Historia.', 'Definicao objetiva de antiguidade para Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina grecia no contexto de Historia.', 'Definicao objetiva de grecia para Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina roma no contexto de Historia.', 'Definicao objetiva de roma para Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina idade media no contexto de Historia.', 'Definicao objetiva de idade media para Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina feudalismo no contexto de Historia.', 'Definicao objetiva de feudalismo para Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina renascimento no contexto de Historia.', 'Definicao objetiva de renascimento para Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina reformas no contexto de Historia.', 'Definicao objetiva de reformas para Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina absolutismo no contexto de Historia.', 'Definicao objetiva de absolutismo para Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina iluminismo no contexto de Historia.', 'Definicao objetiva de iluminismo para Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina revolucao francesa no contexto de Historia.', 'Definicao objetiva de revolucao francesa para Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina revolucao industrial no contexto de Historia.', 'Definicao objetiva de revolucao industrial para Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina imperialismo no contexto de Historia.', 'Definicao objetiva de imperialismo para Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina primeira guerra no contexto de Historia.', 'Definicao objetiva de primeira guerra para Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina segunda guerra no contexto de Historia.', 'Definicao objetiva de segunda guerra para Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina guerra fria no contexto de Historia.', 'Definicao objetiva de guerra fria para Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina mundo contemporaneo no contexto de Historia.', 'Definicao objetiva de mundo contemporaneo para Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina colonizacao do brasil no contexto de Historia.', 'Definicao objetiva de colonizacao do brasil para Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina ciclos economicos no contexto de Historia.', 'Definicao objetiva de ciclos economicos para Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina escravidao no contexto de Historia.', 'Definicao objetiva de escravidao para Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina independencia no contexto de Historia.', 'Definicao objetiva de independencia para Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina primeiro reinado no contexto de Historia.', 'Definicao objetiva de primeiro reinado para Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina segundo reinado no contexto de Historia.', 'Definicao objetiva de segundo reinado para Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina republica velha no contexto de Historia.', 'Definicao objetiva de republica velha para Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina era vargas no contexto de Historia.', 'Definicao objetiva de era vargas para Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina ditadura militar no contexto de Historia.', 'Definicao objetiva de ditadura militar para Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina redemocratizacao no contexto de Historia.', 'Definicao objetiva de redemocratizacao para Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina movimentos sociais no contexto de Historia.', 'Definicao objetiva de movimentos sociais para Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina cidadania no contexto de Historia.', 'Definicao objetiva de cidadania para Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina historia da africa no contexto de Historia.', 'Definicao objetiva de historia da africa para Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina historia da america no contexto de Historia.', 'Definicao objetiva de historia da america para Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Processos e Aplicacoes (Auto)', 'Deck automatico de Historia com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como antiguidade se aplica em Historia?', 'Resumo do processo de antiguidade e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como grecia se aplica em Historia?', 'Resumo do processo de grecia e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como roma se aplica em Historia?', 'Resumo do processo de roma e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como idade media se aplica em Historia?', 'Resumo do processo de idade media e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como feudalismo se aplica em Historia?', 'Resumo do processo de feudalismo e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como renascimento se aplica em Historia?', 'Resumo do processo de renascimento e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como reformas se aplica em Historia?', 'Resumo do processo de reformas e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como absolutismo se aplica em Historia?', 'Resumo do processo de absolutismo e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como iluminismo se aplica em Historia?', 'Resumo do processo de iluminismo e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como revolucao francesa se aplica em Historia?', 'Resumo do processo de revolucao francesa e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como revolucao industrial se aplica em Historia?', 'Resumo do processo de revolucao industrial e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como imperialismo se aplica em Historia?', 'Resumo do processo de imperialismo e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como primeira guerra se aplica em Historia?', 'Resumo do processo de primeira guerra e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como segunda guerra se aplica em Historia?', 'Resumo do processo de segunda guerra e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como guerra fria se aplica em Historia?', 'Resumo do processo de guerra fria e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como mundo contemporaneo se aplica em Historia?', 'Resumo do processo de mundo contemporaneo e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como colonizacao do brasil se aplica em Historia?', 'Resumo do processo de colonizacao do brasil e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como ciclos economicos se aplica em Historia?', 'Resumo do processo de ciclos economicos e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como escravidao se aplica em Historia?', 'Resumo do processo de escravidao e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como independencia se aplica em Historia?', 'Resumo do processo de independencia e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como primeiro reinado se aplica em Historia?', 'Resumo do processo de primeiro reinado e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como segundo reinado se aplica em Historia?', 'Resumo do processo de segundo reinado e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como republica velha se aplica em Historia?', 'Resumo do processo de republica velha e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como era vargas se aplica em Historia?', 'Resumo do processo de era vargas e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como ditadura militar se aplica em Historia?', 'Resumo do processo de ditadura militar e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como redemocratizacao se aplica em Historia?', 'Resumo do processo de redemocratizacao e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como movimentos sociais se aplica em Historia?', 'Resumo do processo de movimentos sociais e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como cidadania se aplica em Historia?', 'Resumo do processo de cidadania e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como historia da africa se aplica em Historia?', 'Resumo do processo de historia da africa e sua aplicacao em Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como historia da america se aplica em Historia?', 'Resumo do processo de historia da america e sua aplicacao em Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Regras e Principios (Auto)', 'Deck automatico de Historia com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de antiguidade em Historia?', 'Principio central de antiguidade usado em Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de grecia em Historia?', 'Principio central de grecia usado em Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de roma em Historia?', 'Principio central de roma usado em Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de idade media em Historia?', 'Principio central de idade media usado em Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de feudalismo em Historia?', 'Principio central de feudalismo usado em Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de renascimento em Historia?', 'Principio central de renascimento usado em Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de reformas em Historia?', 'Principio central de reformas usado em Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de absolutismo em Historia?', 'Principio central de absolutismo usado em Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de iluminismo em Historia?', 'Principio central de iluminismo usado em Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de revolucao francesa em Historia?', 'Principio central de revolucao francesa usado em Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de revolucao industrial em Historia?', 'Principio central de revolucao industrial usado em Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de imperialismo em Historia?', 'Principio central de imperialismo usado em Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de primeira guerra em Historia?', 'Principio central de primeira guerra usado em Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de segunda guerra em Historia?', 'Principio central de segunda guerra usado em Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de guerra fria em Historia?', 'Principio central de guerra fria usado em Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de mundo contemporaneo em Historia?', 'Principio central de mundo contemporaneo usado em Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de colonizacao do brasil em Historia?', 'Principio central de colonizacao do brasil usado em Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de ciclos economicos em Historia?', 'Principio central de ciclos economicos usado em Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de escravidao em Historia?', 'Principio central de escravidao usado em Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de independencia em Historia?', 'Principio central de independencia usado em Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de primeiro reinado em Historia?', 'Principio central de primeiro reinado usado em Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de segundo reinado em Historia?', 'Principio central de segundo reinado usado em Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de republica velha em Historia?', 'Principio central de republica velha usado em Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de era vargas em Historia?', 'Principio central de era vargas usado em Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de ditadura militar em Historia?', 'Principio central de ditadura militar usado em Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de redemocratizacao em Historia?', 'Principio central de redemocratizacao usado em Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de movimentos sociais em Historia?', 'Principio central de movimentos sociais usado em Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de cidadania em Historia?', 'Principio central de cidadania usado em Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de historia da africa em Historia?', 'Principio central de historia da africa usado em Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de historia da america em Historia?', 'Principio central de historia da america usado em Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Resolucao de Problemas (Auto)', 'Deck automatico de Historia com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar antiguidade em Historia?', 'Sequencia simples: identificar dados, aplicar regras de antiguidade e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar grecia em Historia?', 'Sequencia simples: identificar dados, aplicar regras de grecia e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar roma em Historia?', 'Sequencia simples: identificar dados, aplicar regras de roma e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar idade media em Historia?', 'Sequencia simples: identificar dados, aplicar regras de idade media e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar feudalismo em Historia?', 'Sequencia simples: identificar dados, aplicar regras de feudalismo e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar renascimento em Historia?', 'Sequencia simples: identificar dados, aplicar regras de renascimento e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar reformas em Historia?', 'Sequencia simples: identificar dados, aplicar regras de reformas e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar absolutismo em Historia?', 'Sequencia simples: identificar dados, aplicar regras de absolutismo e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar iluminismo em Historia?', 'Sequencia simples: identificar dados, aplicar regras de iluminismo e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar revolucao francesa em Historia?', 'Sequencia simples: identificar dados, aplicar regras de revolucao francesa e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar revolucao industrial em Historia?', 'Sequencia simples: identificar dados, aplicar regras de revolucao industrial e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar imperialismo em Historia?', 'Sequencia simples: identificar dados, aplicar regras de imperialismo e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar primeira guerra em Historia?', 'Sequencia simples: identificar dados, aplicar regras de primeira guerra e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar segunda guerra em Historia?', 'Sequencia simples: identificar dados, aplicar regras de segunda guerra e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar guerra fria em Historia?', 'Sequencia simples: identificar dados, aplicar regras de guerra fria e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar mundo contemporaneo em Historia?', 'Sequencia simples: identificar dados, aplicar regras de mundo contemporaneo e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar colonizacao do brasil em Historia?', 'Sequencia simples: identificar dados, aplicar regras de colonizacao do brasil e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar ciclos economicos em Historia?', 'Sequencia simples: identificar dados, aplicar regras de ciclos economicos e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar escravidao em Historia?', 'Sequencia simples: identificar dados, aplicar regras de escravidao e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar independencia em Historia?', 'Sequencia simples: identificar dados, aplicar regras de independencia e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar primeiro reinado em Historia?', 'Sequencia simples: identificar dados, aplicar regras de primeiro reinado e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar segundo reinado em Historia?', 'Sequencia simples: identificar dados, aplicar regras de segundo reinado e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar republica velha em Historia?', 'Sequencia simples: identificar dados, aplicar regras de republica velha e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar era vargas em Historia?', 'Sequencia simples: identificar dados, aplicar regras de era vargas e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar ditadura militar em Historia?', 'Sequencia simples: identificar dados, aplicar regras de ditadura militar e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar redemocratizacao em Historia?', 'Sequencia simples: identificar dados, aplicar regras de redemocratizacao e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar movimentos sociais em Historia?', 'Sequencia simples: identificar dados, aplicar regras de movimentos sociais e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar cidadania em Historia?', 'Sequencia simples: identificar dados, aplicar regras de cidadania e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar historia da africa em Historia?', 'Sequencia simples: identificar dados, aplicar regras de historia da africa e concluir no contexto de Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar historia da america em Historia?', 'Sequencia simples: identificar dados, aplicar regras de historia da america e concluir no contexto de Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Erros Comuns e Dicas (Auto)', 'Deck automatico de Historia com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com antiguidade em Historia?', 'Erro comum: confundir conceito ou etapa de antiguidade; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com grecia em Historia?', 'Erro comum: confundir conceito ou etapa de grecia; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com roma em Historia?', 'Erro comum: confundir conceito ou etapa de roma; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com idade media em Historia?', 'Erro comum: confundir conceito ou etapa de idade media; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com feudalismo em Historia?', 'Erro comum: confundir conceito ou etapa de feudalismo; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com renascimento em Historia?', 'Erro comum: confundir conceito ou etapa de renascimento; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com reformas em Historia?', 'Erro comum: confundir conceito ou etapa de reformas; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com absolutismo em Historia?', 'Erro comum: confundir conceito ou etapa de absolutismo; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com iluminismo em Historia?', 'Erro comum: confundir conceito ou etapa de iluminismo; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com revolucao francesa em Historia?', 'Erro comum: confundir conceito ou etapa de revolucao francesa; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com revolucao industrial em Historia?', 'Erro comum: confundir conceito ou etapa de revolucao industrial; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com imperialismo em Historia?', 'Erro comum: confundir conceito ou etapa de imperialismo; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com primeira guerra em Historia?', 'Erro comum: confundir conceito ou etapa de primeira guerra; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com segunda guerra em Historia?', 'Erro comum: confundir conceito ou etapa de segunda guerra; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com guerra fria em Historia?', 'Erro comum: confundir conceito ou etapa de guerra fria; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com mundo contemporaneo em Historia?', 'Erro comum: confundir conceito ou etapa de mundo contemporaneo; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com colonizacao do brasil em Historia?', 'Erro comum: confundir conceito ou etapa de colonizacao do brasil; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com ciclos economicos em Historia?', 'Erro comum: confundir conceito ou etapa de ciclos economicos; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com escravidao em Historia?', 'Erro comum: confundir conceito ou etapa de escravidao; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com independencia em Historia?', 'Erro comum: confundir conceito ou etapa de independencia; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com primeiro reinado em Historia?', 'Erro comum: confundir conceito ou etapa de primeiro reinado; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com segundo reinado em Historia?', 'Erro comum: confundir conceito ou etapa de segundo reinado; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com republica velha em Historia?', 'Erro comum: confundir conceito ou etapa de republica velha; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com era vargas em Historia?', 'Erro comum: confundir conceito ou etapa de era vargas; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com ditadura militar em Historia?', 'Erro comum: confundir conceito ou etapa de ditadura militar; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com redemocratizacao em Historia?', 'Erro comum: confundir conceito ou etapa de redemocratizacao; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com movimentos sociais em Historia?', 'Erro comum: confundir conceito ou etapa de movimentos sociais; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com cidadania em Historia?', 'Erro comum: confundir conceito ou etapa de cidadania; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com historia da africa em Historia?', 'Erro comum: confundir conceito ou etapa de historia da africa; evite revisando definicoes e condicoes em Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com historia da america em Historia?', 'Erro comum: confundir conceito ou etapa de historia da america; evite revisando definicoes e condicoes em Historia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Historia - Revisao Rapida (Auto)', 'Deck automatico de Historia com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['historia', 'humanities', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: antiguidade em Historia.', 'Resumo: pontos essenciais de antiguidade e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: grecia em Historia.', 'Resumo: pontos essenciais de grecia e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: roma em Historia.', 'Resumo: pontos essenciais de roma e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: idade media em Historia.', 'Resumo: pontos essenciais de idade media e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: feudalismo em Historia.', 'Resumo: pontos essenciais de feudalismo e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: renascimento em Historia.', 'Resumo: pontos essenciais de renascimento e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: reformas em Historia.', 'Resumo: pontos essenciais de reformas e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: absolutismo em Historia.', 'Resumo: pontos essenciais de absolutismo e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: iluminismo em Historia.', 'Resumo: pontos essenciais de iluminismo e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: revolucao francesa em Historia.', 'Resumo: pontos essenciais de revolucao francesa e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: revolucao industrial em Historia.', 'Resumo: pontos essenciais de revolucao industrial e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: imperialismo em Historia.', 'Resumo: pontos essenciais de imperialismo e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: primeira guerra em Historia.', 'Resumo: pontos essenciais de primeira guerra e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: segunda guerra em Historia.', 'Resumo: pontos essenciais de segunda guerra e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: guerra fria em Historia.', 'Resumo: pontos essenciais de guerra fria e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: mundo contemporaneo em Historia.', 'Resumo: pontos essenciais de mundo contemporaneo e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: colonizacao do brasil em Historia.', 'Resumo: pontos essenciais de colonizacao do brasil e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: ciclos economicos em Historia.', 'Resumo: pontos essenciais de ciclos economicos e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: escravidao em Historia.', 'Resumo: pontos essenciais de escravidao e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: independencia em Historia.', 'Resumo: pontos essenciais de independencia e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: primeiro reinado em Historia.', 'Resumo: pontos essenciais de primeiro reinado e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: segundo reinado em Historia.', 'Resumo: pontos essenciais de segundo reinado e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: republica velha em Historia.', 'Resumo: pontos essenciais de republica velha e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: era vargas em Historia.', 'Resumo: pontos essenciais de era vargas e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: ditadura militar em Historia.', 'Resumo: pontos essenciais de ditadura militar e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: redemocratizacao em Historia.', 'Resumo: pontos essenciais de redemocratizacao e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: movimentos sociais em Historia.', 'Resumo: pontos essenciais de movimentos sociais e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: cidadania em Historia.', 'Resumo: pontos essenciais de cidadania e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: historia da africa em Historia.', 'Resumo: pontos essenciais de historia da africa e sua utilidade em Historia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: historia da america em Historia.', 'Resumo: pontos essenciais de historia da america e sua utilidade em Historia.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Historia';
END $$;
