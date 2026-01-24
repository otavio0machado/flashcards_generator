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

  -- Direito Civil
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/direito/civil';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/direito/civil'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Fundamentos e Conceitos (Auto)', 'Deck automatico de Direito Civil com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e constituicao em Direito Civil?', 'Conceito basico de constituicao aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e poder constituinte em Direito Civil?', 'Conceito basico de poder constituinte aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e direitos fundamentais em Direito Civil?', 'Conceito basico de direitos fundamentais aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e controle de constitucionalidade em Direito Civil?', 'Conceito basico de controle de constitucionalidade aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e principios administrativos em Direito Civil?', 'Conceito basico de principios administrativos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e atos administrativos em Direito Civil?', 'Conceito basico de atos administrativos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e licitacoes em Direito Civil?', 'Conceito basico de licitacoes aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e responsabilidade civil do estado em Direito Civil?', 'Conceito basico de responsabilidade civil do estado aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e servidores publicos em Direito Civil?', 'Conceito basico de servidores publicos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e processo legislativo em Direito Civil?', 'Conceito basico de processo legislativo aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e separacao de poderes em Direito Civil?', 'Conceito basico de separacao de poderes aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e organizacao do estado em Direito Civil?', 'Conceito basico de organizacao do estado aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e competencias em Direito Civil?', 'Conceito basico de competencias aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e bens publicos em Direito Civil?', 'Conceito basico de bens publicos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e processo civil em Direito Civil?', 'Conceito basico de processo civil aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e processo penal em Direito Civil?', 'Conceito basico de processo penal aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e contratos em Direito Civil?', 'Conceito basico de contratos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e obrigacoes em Direito Civil?', 'Conceito basico de obrigacoes aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e responsabilidade penal em Direito Civil?', 'Conceito basico de responsabilidade penal aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e tipicidade em Direito Civil?', 'Conceito basico de tipicidade aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e ilicitude em Direito Civil?', 'Conceito basico de ilicitude aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e culpabilidade em Direito Civil?', 'Conceito basico de culpabilidade aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e penas em Direito Civil?', 'Conceito basico de penas aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e crimes contra a pessoa em Direito Civil?', 'Conceito basico de crimes contra a pessoa aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e crimes contra o patrimonio em Direito Civil?', 'Conceito basico de crimes contra o patrimonio aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e crimes contra a administracao em Direito Civil?', 'Conceito basico de crimes contra a administracao aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e prescricao em Direito Civil?', 'Conceito basico de prescricao aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e recursos em Direito Civil?', 'Conceito basico de recursos aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e jurisprudencia em Direito Civil?', 'Conceito basico de jurisprudencia aplicado a Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e direito do consumidor em Direito Civil?', 'Conceito basico de direito do consumidor aplicado a Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Definicoes e Terminologia (Auto)', 'Deck automatico de Direito Civil com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina constituicao no contexto de Direito Civil.', 'Definicao objetiva de constituicao para Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina poder constituinte no contexto de Direito Civil.', 'Definicao objetiva de poder constituinte para Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina direitos fundamentais no contexto de Direito Civil.', 'Definicao objetiva de direitos fundamentais para Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina controle de constitucionalidade no contexto de Direito Civil.', 'Definicao objetiva de controle de constitucionalidade para Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina principios administrativos no contexto de Direito Civil.', 'Definicao objetiva de principios administrativos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina atos administrativos no contexto de Direito Civil.', 'Definicao objetiva de atos administrativos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina licitacoes no contexto de Direito Civil.', 'Definicao objetiva de licitacoes para Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina responsabilidade civil do estado no contexto de Direito Civil.', 'Definicao objetiva de responsabilidade civil do estado para Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina servidores publicos no contexto de Direito Civil.', 'Definicao objetiva de servidores publicos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina processo legislativo no contexto de Direito Civil.', 'Definicao objetiva de processo legislativo para Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina separacao de poderes no contexto de Direito Civil.', 'Definicao objetiva de separacao de poderes para Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina organizacao do estado no contexto de Direito Civil.', 'Definicao objetiva de organizacao do estado para Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina competencias no contexto de Direito Civil.', 'Definicao objetiva de competencias para Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina bens publicos no contexto de Direito Civil.', 'Definicao objetiva de bens publicos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina processo civil no contexto de Direito Civil.', 'Definicao objetiva de processo civil para Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina processo penal no contexto de Direito Civil.', 'Definicao objetiva de processo penal para Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina contratos no contexto de Direito Civil.', 'Definicao objetiva de contratos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina obrigacoes no contexto de Direito Civil.', 'Definicao objetiva de obrigacoes para Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina responsabilidade penal no contexto de Direito Civil.', 'Definicao objetiva de responsabilidade penal para Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina tipicidade no contexto de Direito Civil.', 'Definicao objetiva de tipicidade para Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina ilicitude no contexto de Direito Civil.', 'Definicao objetiva de ilicitude para Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina culpabilidade no contexto de Direito Civil.', 'Definicao objetiva de culpabilidade para Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina penas no contexto de Direito Civil.', 'Definicao objetiva de penas para Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina crimes contra a pessoa no contexto de Direito Civil.', 'Definicao objetiva de crimes contra a pessoa para Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina crimes contra o patrimonio no contexto de Direito Civil.', 'Definicao objetiva de crimes contra o patrimonio para Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina crimes contra a administracao no contexto de Direito Civil.', 'Definicao objetiva de crimes contra a administracao para Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina prescricao no contexto de Direito Civil.', 'Definicao objetiva de prescricao para Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina recursos no contexto de Direito Civil.', 'Definicao objetiva de recursos para Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina jurisprudencia no contexto de Direito Civil.', 'Definicao objetiva de jurisprudencia para Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina direito do consumidor no contexto de Direito Civil.', 'Definicao objetiva de direito do consumidor para Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Processos e Aplicacoes (Auto)', 'Deck automatico de Direito Civil com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como constituicao se aplica em Direito Civil?', 'Resumo do processo de constituicao e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como poder constituinte se aplica em Direito Civil?', 'Resumo do processo de poder constituinte e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como direitos fundamentais se aplica em Direito Civil?', 'Resumo do processo de direitos fundamentais e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como controle de constitucionalidade se aplica em Direito Civil?', 'Resumo do processo de controle de constitucionalidade e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como principios administrativos se aplica em Direito Civil?', 'Resumo do processo de principios administrativos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como atos administrativos se aplica em Direito Civil?', 'Resumo do processo de atos administrativos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como licitacoes se aplica em Direito Civil?', 'Resumo do processo de licitacoes e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como responsabilidade civil do estado se aplica em Direito Civil?', 'Resumo do processo de responsabilidade civil do estado e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como servidores publicos se aplica em Direito Civil?', 'Resumo do processo de servidores publicos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como processo legislativo se aplica em Direito Civil?', 'Resumo do processo de processo legislativo e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como separacao de poderes se aplica em Direito Civil?', 'Resumo do processo de separacao de poderes e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como organizacao do estado se aplica em Direito Civil?', 'Resumo do processo de organizacao do estado e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como competencias se aplica em Direito Civil?', 'Resumo do processo de competencias e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como bens publicos se aplica em Direito Civil?', 'Resumo do processo de bens publicos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como processo civil se aplica em Direito Civil?', 'Resumo do processo de processo civil e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como processo penal se aplica em Direito Civil?', 'Resumo do processo de processo penal e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como contratos se aplica em Direito Civil?', 'Resumo do processo de contratos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como obrigacoes se aplica em Direito Civil?', 'Resumo do processo de obrigacoes e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como responsabilidade penal se aplica em Direito Civil?', 'Resumo do processo de responsabilidade penal e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como tipicidade se aplica em Direito Civil?', 'Resumo do processo de tipicidade e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como ilicitude se aplica em Direito Civil?', 'Resumo do processo de ilicitude e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como culpabilidade se aplica em Direito Civil?', 'Resumo do processo de culpabilidade e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como penas se aplica em Direito Civil?', 'Resumo do processo de penas e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como crimes contra a pessoa se aplica em Direito Civil?', 'Resumo do processo de crimes contra a pessoa e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como crimes contra o patrimonio se aplica em Direito Civil?', 'Resumo do processo de crimes contra o patrimonio e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como crimes contra a administracao se aplica em Direito Civil?', 'Resumo do processo de crimes contra a administracao e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como prescricao se aplica em Direito Civil?', 'Resumo do processo de prescricao e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como recursos se aplica em Direito Civil?', 'Resumo do processo de recursos e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como jurisprudencia se aplica em Direito Civil?', 'Resumo do processo de jurisprudencia e sua aplicacao em Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como direito do consumidor se aplica em Direito Civil?', 'Resumo do processo de direito do consumidor e sua aplicacao em Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Regras e Principios (Auto)', 'Deck automatico de Direito Civil com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de constituicao em Direito Civil?', 'Principio central de constituicao usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de poder constituinte em Direito Civil?', 'Principio central de poder constituinte usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de direitos fundamentais em Direito Civil?', 'Principio central de direitos fundamentais usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de controle de constitucionalidade em Direito Civil?', 'Principio central de controle de constitucionalidade usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de principios administrativos em Direito Civil?', 'Principio central de principios administrativos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de atos administrativos em Direito Civil?', 'Principio central de atos administrativos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de licitacoes em Direito Civil?', 'Principio central de licitacoes usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de responsabilidade civil do estado em Direito Civil?', 'Principio central de responsabilidade civil do estado usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de servidores publicos em Direito Civil?', 'Principio central de servidores publicos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de processo legislativo em Direito Civil?', 'Principio central de processo legislativo usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de separacao de poderes em Direito Civil?', 'Principio central de separacao de poderes usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de organizacao do estado em Direito Civil?', 'Principio central de organizacao do estado usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de competencias em Direito Civil?', 'Principio central de competencias usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de bens publicos em Direito Civil?', 'Principio central de bens publicos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de processo civil em Direito Civil?', 'Principio central de processo civil usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de processo penal em Direito Civil?', 'Principio central de processo penal usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de contratos em Direito Civil?', 'Principio central de contratos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de obrigacoes em Direito Civil?', 'Principio central de obrigacoes usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de responsabilidade penal em Direito Civil?', 'Principio central de responsabilidade penal usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de tipicidade em Direito Civil?', 'Principio central de tipicidade usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de ilicitude em Direito Civil?', 'Principio central de ilicitude usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de culpabilidade em Direito Civil?', 'Principio central de culpabilidade usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de penas em Direito Civil?', 'Principio central de penas usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de crimes contra a pessoa em Direito Civil?', 'Principio central de crimes contra a pessoa usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de crimes contra o patrimonio em Direito Civil?', 'Principio central de crimes contra o patrimonio usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de crimes contra a administracao em Direito Civil?', 'Principio central de crimes contra a administracao usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de prescricao em Direito Civil?', 'Principio central de prescricao usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de recursos em Direito Civil?', 'Principio central de recursos usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de jurisprudencia em Direito Civil?', 'Principio central de jurisprudencia usado em Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de direito do consumidor em Direito Civil?', 'Principio central de direito do consumidor usado em Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Resolucao de Problemas (Auto)', 'Deck automatico de Direito Civil com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar constituicao em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de constituicao e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar poder constituinte em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de poder constituinte e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar direitos fundamentais em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de direitos fundamentais e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar controle de constitucionalidade em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de controle de constitucionalidade e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar principios administrativos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de principios administrativos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar atos administrativos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de atos administrativos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar licitacoes em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de licitacoes e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar responsabilidade civil do estado em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de responsabilidade civil do estado e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar servidores publicos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de servidores publicos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar processo legislativo em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de processo legislativo e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar separacao de poderes em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de separacao de poderes e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar organizacao do estado em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de organizacao do estado e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar competencias em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de competencias e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar bens publicos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de bens publicos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar processo civil em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de processo civil e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar processo penal em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de processo penal e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar contratos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de contratos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar obrigacoes em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de obrigacoes e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar responsabilidade penal em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de responsabilidade penal e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar tipicidade em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de tipicidade e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar ilicitude em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de ilicitude e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar culpabilidade em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de culpabilidade e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar penas em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de penas e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar crimes contra a pessoa em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de crimes contra a pessoa e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar crimes contra o patrimonio em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de crimes contra o patrimonio e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar crimes contra a administracao em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de crimes contra a administracao e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar prescricao em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de prescricao e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar recursos em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de recursos e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar jurisprudencia em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de jurisprudencia e concluir no contexto de Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar direito do consumidor em Direito Civil?', 'Sequencia simples: identificar dados, aplicar regras de direito do consumidor e concluir no contexto de Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Erros Comuns e Dicas (Auto)', 'Deck automatico de Direito Civil com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com constituicao em Direito Civil?', 'Erro comum: confundir conceito ou etapa de constituicao; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com poder constituinte em Direito Civil?', 'Erro comum: confundir conceito ou etapa de poder constituinte; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com direitos fundamentais em Direito Civil?', 'Erro comum: confundir conceito ou etapa de direitos fundamentais; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com controle de constitucionalidade em Direito Civil?', 'Erro comum: confundir conceito ou etapa de controle de constitucionalidade; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com principios administrativos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de principios administrativos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com atos administrativos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de atos administrativos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com licitacoes em Direito Civil?', 'Erro comum: confundir conceito ou etapa de licitacoes; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com responsabilidade civil do estado em Direito Civil?', 'Erro comum: confundir conceito ou etapa de responsabilidade civil do estado; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com servidores publicos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de servidores publicos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com processo legislativo em Direito Civil?', 'Erro comum: confundir conceito ou etapa de processo legislativo; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com separacao de poderes em Direito Civil?', 'Erro comum: confundir conceito ou etapa de separacao de poderes; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com organizacao do estado em Direito Civil?', 'Erro comum: confundir conceito ou etapa de organizacao do estado; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com competencias em Direito Civil?', 'Erro comum: confundir conceito ou etapa de competencias; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com bens publicos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de bens publicos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com processo civil em Direito Civil?', 'Erro comum: confundir conceito ou etapa de processo civil; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com processo penal em Direito Civil?', 'Erro comum: confundir conceito ou etapa de processo penal; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com contratos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de contratos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com obrigacoes em Direito Civil?', 'Erro comum: confundir conceito ou etapa de obrigacoes; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com responsabilidade penal em Direito Civil?', 'Erro comum: confundir conceito ou etapa de responsabilidade penal; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com tipicidade em Direito Civil?', 'Erro comum: confundir conceito ou etapa de tipicidade; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com ilicitude em Direito Civil?', 'Erro comum: confundir conceito ou etapa de ilicitude; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com culpabilidade em Direito Civil?', 'Erro comum: confundir conceito ou etapa de culpabilidade; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com penas em Direito Civil?', 'Erro comum: confundir conceito ou etapa de penas; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com crimes contra a pessoa em Direito Civil?', 'Erro comum: confundir conceito ou etapa de crimes contra a pessoa; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com crimes contra o patrimonio em Direito Civil?', 'Erro comum: confundir conceito ou etapa de crimes contra o patrimonio; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com crimes contra a administracao em Direito Civil?', 'Erro comum: confundir conceito ou etapa de crimes contra a administracao; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com prescricao em Direito Civil?', 'Erro comum: confundir conceito ou etapa de prescricao; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com recursos em Direito Civil?', 'Erro comum: confundir conceito ou etapa de recursos; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com jurisprudencia em Direito Civil?', 'Erro comum: confundir conceito ou etapa de jurisprudencia; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com direito do consumidor em Direito Civil?', 'Erro comum: confundir conceito ou etapa de direito do consumidor; evite revisando definicoes e condicoes em Direito Civil.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil - Revisao Rapida (Auto)', 'Deck automatico de Direito Civil com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['civil', 'law', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: constituicao em Direito Civil.', 'Resumo: pontos essenciais de constituicao e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: poder constituinte em Direito Civil.', 'Resumo: pontos essenciais de poder constituinte e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: direitos fundamentais em Direito Civil.', 'Resumo: pontos essenciais de direitos fundamentais e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: controle de constitucionalidade em Direito Civil.', 'Resumo: pontos essenciais de controle de constitucionalidade e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: principios administrativos em Direito Civil.', 'Resumo: pontos essenciais de principios administrativos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: atos administrativos em Direito Civil.', 'Resumo: pontos essenciais de atos administrativos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: licitacoes em Direito Civil.', 'Resumo: pontos essenciais de licitacoes e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: responsabilidade civil do estado em Direito Civil.', 'Resumo: pontos essenciais de responsabilidade civil do estado e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: servidores publicos em Direito Civil.', 'Resumo: pontos essenciais de servidores publicos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: processo legislativo em Direito Civil.', 'Resumo: pontos essenciais de processo legislativo e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: separacao de poderes em Direito Civil.', 'Resumo: pontos essenciais de separacao de poderes e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: organizacao do estado em Direito Civil.', 'Resumo: pontos essenciais de organizacao do estado e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: competencias em Direito Civil.', 'Resumo: pontos essenciais de competencias e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: bens publicos em Direito Civil.', 'Resumo: pontos essenciais de bens publicos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: processo civil em Direito Civil.', 'Resumo: pontos essenciais de processo civil e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: processo penal em Direito Civil.', 'Resumo: pontos essenciais de processo penal e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: contratos em Direito Civil.', 'Resumo: pontos essenciais de contratos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: obrigacoes em Direito Civil.', 'Resumo: pontos essenciais de obrigacoes e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: responsabilidade penal em Direito Civil.', 'Resumo: pontos essenciais de responsabilidade penal e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: tipicidade em Direito Civil.', 'Resumo: pontos essenciais de tipicidade e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: ilicitude em Direito Civil.', 'Resumo: pontos essenciais de ilicitude e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: culpabilidade em Direito Civil.', 'Resumo: pontos essenciais de culpabilidade e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: penas em Direito Civil.', 'Resumo: pontos essenciais de penas e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: crimes contra a pessoa em Direito Civil.', 'Resumo: pontos essenciais de crimes contra a pessoa e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: crimes contra o patrimonio em Direito Civil.', 'Resumo: pontos essenciais de crimes contra o patrimonio e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: crimes contra a administracao em Direito Civil.', 'Resumo: pontos essenciais de crimes contra a administracao e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: prescricao em Direito Civil.', 'Resumo: pontos essenciais de prescricao e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: recursos em Direito Civil.', 'Resumo: pontos essenciais de recursos e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: jurisprudencia em Direito Civil.', 'Resumo: pontos essenciais de jurisprudencia e sua utilidade em Direito Civil.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: direito do consumidor em Direito Civil.', 'Resumo: pontos essenciais de direito do consumidor e sua utilidade em Direito Civil.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Direito Civil';
END $$;
