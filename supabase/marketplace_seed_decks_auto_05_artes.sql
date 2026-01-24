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

  -- Artes
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/linguagens/artes';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/linguagens/artes'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Fundamentos e Conceitos (Auto)', 'Deck automatico de Artes com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e pre-historia em Artes?', 'Conceito basico de pre-historia aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e arte antiga em Artes?', 'Conceito basico de arte antiga aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e arte medieval em Artes?', 'Conceito basico de arte medieval aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e renascimento em Artes?', 'Conceito basico de renascimento aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e barroco em Artes?', 'Conceito basico de barroco aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e neoclassicismo em Artes?', 'Conceito basico de neoclassicismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e romantismo em Artes?', 'Conceito basico de romantismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e realismo em Artes?', 'Conceito basico de realismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e impressionismo em Artes?', 'Conceito basico de impressionismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e pos-impressionismo em Artes?', 'Conceito basico de pos-impressionismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e expressionismo em Artes?', 'Conceito basico de expressionismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e cubismo em Artes?', 'Conceito basico de cubismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e futurismo em Artes?', 'Conceito basico de futurismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e dadaismo em Artes?', 'Conceito basico de dadaismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e surrealismo em Artes?', 'Conceito basico de surrealismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e abstracionismo em Artes?', 'Conceito basico de abstracionismo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e arte contemporanea em Artes?', 'Conceito basico de arte contemporanea aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e arte brasileira em Artes?', 'Conceito basico de arte brasileira aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e barroco mineiro em Artes?', 'Conceito basico de barroco mineiro aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e missao francesa em Artes?', 'Conceito basico de missao francesa aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e semana de 22 em Artes?', 'Conceito basico de semana de 22 aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e elementos da musica em Artes?', 'Conceito basico de elementos da musica aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e ritmo em Artes?', 'Conceito basico de ritmo aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e melodia em Artes?', 'Conceito basico de melodia aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e harmonia em Artes?', 'Conceito basico de harmonia aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e elementos do teatro em Artes?', 'Conceito basico de elementos do teatro aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e elementos da danca em Artes?', 'Conceito basico de elementos da danca aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e performance em Artes?', 'Conceito basico de performance aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e instalacao em Artes?', 'Conceito basico de instalacao aplicado a Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e arte digital em Artes?', 'Conceito basico de arte digital aplicado a Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Definicoes e Terminologia (Auto)', 'Deck automatico de Artes com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina pre-historia no contexto de Artes.', 'Definicao objetiva de pre-historia para Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina arte antiga no contexto de Artes.', 'Definicao objetiva de arte antiga para Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina arte medieval no contexto de Artes.', 'Definicao objetiva de arte medieval para Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina renascimento no contexto de Artes.', 'Definicao objetiva de renascimento para Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina barroco no contexto de Artes.', 'Definicao objetiva de barroco para Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina neoclassicismo no contexto de Artes.', 'Definicao objetiva de neoclassicismo para Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina romantismo no contexto de Artes.', 'Definicao objetiva de romantismo para Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina realismo no contexto de Artes.', 'Definicao objetiva de realismo para Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina impressionismo no contexto de Artes.', 'Definicao objetiva de impressionismo para Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina pos-impressionismo no contexto de Artes.', 'Definicao objetiva de pos-impressionismo para Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina expressionismo no contexto de Artes.', 'Definicao objetiva de expressionismo para Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina cubismo no contexto de Artes.', 'Definicao objetiva de cubismo para Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina futurismo no contexto de Artes.', 'Definicao objetiva de futurismo para Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina dadaismo no contexto de Artes.', 'Definicao objetiva de dadaismo para Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina surrealismo no contexto de Artes.', 'Definicao objetiva de surrealismo para Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina abstracionismo no contexto de Artes.', 'Definicao objetiva de abstracionismo para Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina arte contemporanea no contexto de Artes.', 'Definicao objetiva de arte contemporanea para Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina arte brasileira no contexto de Artes.', 'Definicao objetiva de arte brasileira para Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina barroco mineiro no contexto de Artes.', 'Definicao objetiva de barroco mineiro para Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina missao francesa no contexto de Artes.', 'Definicao objetiva de missao francesa para Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina semana de 22 no contexto de Artes.', 'Definicao objetiva de semana de 22 para Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina elementos da musica no contexto de Artes.', 'Definicao objetiva de elementos da musica para Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina ritmo no contexto de Artes.', 'Definicao objetiva de ritmo para Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina melodia no contexto de Artes.', 'Definicao objetiva de melodia para Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina harmonia no contexto de Artes.', 'Definicao objetiva de harmonia para Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina elementos do teatro no contexto de Artes.', 'Definicao objetiva de elementos do teatro para Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina elementos da danca no contexto de Artes.', 'Definicao objetiva de elementos da danca para Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina performance no contexto de Artes.', 'Definicao objetiva de performance para Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina instalacao no contexto de Artes.', 'Definicao objetiva de instalacao para Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina arte digital no contexto de Artes.', 'Definicao objetiva de arte digital para Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Processos e Aplicacoes (Auto)', 'Deck automatico de Artes com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como pre-historia se aplica em Artes?', 'Resumo do processo de pre-historia e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como arte antiga se aplica em Artes?', 'Resumo do processo de arte antiga e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como arte medieval se aplica em Artes?', 'Resumo do processo de arte medieval e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como renascimento se aplica em Artes?', 'Resumo do processo de renascimento e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como barroco se aplica em Artes?', 'Resumo do processo de barroco e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como neoclassicismo se aplica em Artes?', 'Resumo do processo de neoclassicismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como romantismo se aplica em Artes?', 'Resumo do processo de romantismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como realismo se aplica em Artes?', 'Resumo do processo de realismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como impressionismo se aplica em Artes?', 'Resumo do processo de impressionismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como pos-impressionismo se aplica em Artes?', 'Resumo do processo de pos-impressionismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como expressionismo se aplica em Artes?', 'Resumo do processo de expressionismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como cubismo se aplica em Artes?', 'Resumo do processo de cubismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como futurismo se aplica em Artes?', 'Resumo do processo de futurismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como dadaismo se aplica em Artes?', 'Resumo do processo de dadaismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como surrealismo se aplica em Artes?', 'Resumo do processo de surrealismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como abstracionismo se aplica em Artes?', 'Resumo do processo de abstracionismo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como arte contemporanea se aplica em Artes?', 'Resumo do processo de arte contemporanea e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como arte brasileira se aplica em Artes?', 'Resumo do processo de arte brasileira e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como barroco mineiro se aplica em Artes?', 'Resumo do processo de barroco mineiro e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como missao francesa se aplica em Artes?', 'Resumo do processo de missao francesa e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como semana de 22 se aplica em Artes?', 'Resumo do processo de semana de 22 e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como elementos da musica se aplica em Artes?', 'Resumo do processo de elementos da musica e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como ritmo se aplica em Artes?', 'Resumo do processo de ritmo e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como melodia se aplica em Artes?', 'Resumo do processo de melodia e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como harmonia se aplica em Artes?', 'Resumo do processo de harmonia e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como elementos do teatro se aplica em Artes?', 'Resumo do processo de elementos do teatro e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como elementos da danca se aplica em Artes?', 'Resumo do processo de elementos da danca e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como performance se aplica em Artes?', 'Resumo do processo de performance e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como instalacao se aplica em Artes?', 'Resumo do processo de instalacao e sua aplicacao em Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como arte digital se aplica em Artes?', 'Resumo do processo de arte digital e sua aplicacao em Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Regras e Principios (Auto)', 'Deck automatico de Artes com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de pre-historia em Artes?', 'Principio central de pre-historia usado em Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de arte antiga em Artes?', 'Principio central de arte antiga usado em Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de arte medieval em Artes?', 'Principio central de arte medieval usado em Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de renascimento em Artes?', 'Principio central de renascimento usado em Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de barroco em Artes?', 'Principio central de barroco usado em Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de neoclassicismo em Artes?', 'Principio central de neoclassicismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de romantismo em Artes?', 'Principio central de romantismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de realismo em Artes?', 'Principio central de realismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de impressionismo em Artes?', 'Principio central de impressionismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de pos-impressionismo em Artes?', 'Principio central de pos-impressionismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de expressionismo em Artes?', 'Principio central de expressionismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de cubismo em Artes?', 'Principio central de cubismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de futurismo em Artes?', 'Principio central de futurismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de dadaismo em Artes?', 'Principio central de dadaismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de surrealismo em Artes?', 'Principio central de surrealismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de abstracionismo em Artes?', 'Principio central de abstracionismo usado em Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de arte contemporanea em Artes?', 'Principio central de arte contemporanea usado em Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de arte brasileira em Artes?', 'Principio central de arte brasileira usado em Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de barroco mineiro em Artes?', 'Principio central de barroco mineiro usado em Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de missao francesa em Artes?', 'Principio central de missao francesa usado em Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de semana de 22 em Artes?', 'Principio central de semana de 22 usado em Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de elementos da musica em Artes?', 'Principio central de elementos da musica usado em Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de ritmo em Artes?', 'Principio central de ritmo usado em Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de melodia em Artes?', 'Principio central de melodia usado em Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de harmonia em Artes?', 'Principio central de harmonia usado em Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de elementos do teatro em Artes?', 'Principio central de elementos do teatro usado em Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de elementos da danca em Artes?', 'Principio central de elementos da danca usado em Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de performance em Artes?', 'Principio central de performance usado em Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de instalacao em Artes?', 'Principio central de instalacao usado em Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de arte digital em Artes?', 'Principio central de arte digital usado em Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Resolucao de Problemas (Auto)', 'Deck automatico de Artes com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar pre-historia em Artes?', 'Sequencia simples: identificar dados, aplicar regras de pre-historia e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar arte antiga em Artes?', 'Sequencia simples: identificar dados, aplicar regras de arte antiga e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar arte medieval em Artes?', 'Sequencia simples: identificar dados, aplicar regras de arte medieval e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar renascimento em Artes?', 'Sequencia simples: identificar dados, aplicar regras de renascimento e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar barroco em Artes?', 'Sequencia simples: identificar dados, aplicar regras de barroco e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar neoclassicismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de neoclassicismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar romantismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de romantismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar realismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de realismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar impressionismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de impressionismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar pos-impressionismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de pos-impressionismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar expressionismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de expressionismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar cubismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de cubismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar futurismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de futurismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar dadaismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de dadaismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar surrealismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de surrealismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar abstracionismo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de abstracionismo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar arte contemporanea em Artes?', 'Sequencia simples: identificar dados, aplicar regras de arte contemporanea e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar arte brasileira em Artes?', 'Sequencia simples: identificar dados, aplicar regras de arte brasileira e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar barroco mineiro em Artes?', 'Sequencia simples: identificar dados, aplicar regras de barroco mineiro e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar missao francesa em Artes?', 'Sequencia simples: identificar dados, aplicar regras de missao francesa e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar semana de 22 em Artes?', 'Sequencia simples: identificar dados, aplicar regras de semana de 22 e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar elementos da musica em Artes?', 'Sequencia simples: identificar dados, aplicar regras de elementos da musica e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar ritmo em Artes?', 'Sequencia simples: identificar dados, aplicar regras de ritmo e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar melodia em Artes?', 'Sequencia simples: identificar dados, aplicar regras de melodia e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar harmonia em Artes?', 'Sequencia simples: identificar dados, aplicar regras de harmonia e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar elementos do teatro em Artes?', 'Sequencia simples: identificar dados, aplicar regras de elementos do teatro e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar elementos da danca em Artes?', 'Sequencia simples: identificar dados, aplicar regras de elementos da danca e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar performance em Artes?', 'Sequencia simples: identificar dados, aplicar regras de performance e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar instalacao em Artes?', 'Sequencia simples: identificar dados, aplicar regras de instalacao e concluir no contexto de Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar arte digital em Artes?', 'Sequencia simples: identificar dados, aplicar regras de arte digital e concluir no contexto de Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Erros Comuns e Dicas (Auto)', 'Deck automatico de Artes com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com pre-historia em Artes?', 'Erro comum: confundir conceito ou etapa de pre-historia; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com arte antiga em Artes?', 'Erro comum: confundir conceito ou etapa de arte antiga; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com arte medieval em Artes?', 'Erro comum: confundir conceito ou etapa de arte medieval; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com renascimento em Artes?', 'Erro comum: confundir conceito ou etapa de renascimento; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com barroco em Artes?', 'Erro comum: confundir conceito ou etapa de barroco; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com neoclassicismo em Artes?', 'Erro comum: confundir conceito ou etapa de neoclassicismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com romantismo em Artes?', 'Erro comum: confundir conceito ou etapa de romantismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com realismo em Artes?', 'Erro comum: confundir conceito ou etapa de realismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com impressionismo em Artes?', 'Erro comum: confundir conceito ou etapa de impressionismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com pos-impressionismo em Artes?', 'Erro comum: confundir conceito ou etapa de pos-impressionismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com expressionismo em Artes?', 'Erro comum: confundir conceito ou etapa de expressionismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com cubismo em Artes?', 'Erro comum: confundir conceito ou etapa de cubismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com futurismo em Artes?', 'Erro comum: confundir conceito ou etapa de futurismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com dadaismo em Artes?', 'Erro comum: confundir conceito ou etapa de dadaismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com surrealismo em Artes?', 'Erro comum: confundir conceito ou etapa de surrealismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com abstracionismo em Artes?', 'Erro comum: confundir conceito ou etapa de abstracionismo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com arte contemporanea em Artes?', 'Erro comum: confundir conceito ou etapa de arte contemporanea; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com arte brasileira em Artes?', 'Erro comum: confundir conceito ou etapa de arte brasileira; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com barroco mineiro em Artes?', 'Erro comum: confundir conceito ou etapa de barroco mineiro; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com missao francesa em Artes?', 'Erro comum: confundir conceito ou etapa de missao francesa; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com semana de 22 em Artes?', 'Erro comum: confundir conceito ou etapa de semana de 22; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com elementos da musica em Artes?', 'Erro comum: confundir conceito ou etapa de elementos da musica; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com ritmo em Artes?', 'Erro comum: confundir conceito ou etapa de ritmo; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com melodia em Artes?', 'Erro comum: confundir conceito ou etapa de melodia; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com harmonia em Artes?', 'Erro comum: confundir conceito ou etapa de harmonia; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com elementos do teatro em Artes?', 'Erro comum: confundir conceito ou etapa de elementos do teatro; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com elementos da danca em Artes?', 'Erro comum: confundir conceito ou etapa de elementos da danca; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com performance em Artes?', 'Erro comum: confundir conceito ou etapa de performance; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com instalacao em Artes?', 'Erro comum: confundir conceito ou etapa de instalacao; evite revisando definicoes e condicoes em Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com arte digital em Artes?', 'Erro comum: confundir conceito ou etapa de arte digital; evite revisando definicoes e condicoes em Artes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Artes - Revisao Rapida (Auto)', 'Deck automatico de Artes com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['artes', 'arts', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: pre-historia em Artes.', 'Resumo: pontos essenciais de pre-historia e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: arte antiga em Artes.', 'Resumo: pontos essenciais de arte antiga e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: arte medieval em Artes.', 'Resumo: pontos essenciais de arte medieval e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: renascimento em Artes.', 'Resumo: pontos essenciais de renascimento e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: barroco em Artes.', 'Resumo: pontos essenciais de barroco e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: neoclassicismo em Artes.', 'Resumo: pontos essenciais de neoclassicismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: romantismo em Artes.', 'Resumo: pontos essenciais de romantismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: realismo em Artes.', 'Resumo: pontos essenciais de realismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: impressionismo em Artes.', 'Resumo: pontos essenciais de impressionismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: pos-impressionismo em Artes.', 'Resumo: pontos essenciais de pos-impressionismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: expressionismo em Artes.', 'Resumo: pontos essenciais de expressionismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: cubismo em Artes.', 'Resumo: pontos essenciais de cubismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: futurismo em Artes.', 'Resumo: pontos essenciais de futurismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: dadaismo em Artes.', 'Resumo: pontos essenciais de dadaismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: surrealismo em Artes.', 'Resumo: pontos essenciais de surrealismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: abstracionismo em Artes.', 'Resumo: pontos essenciais de abstracionismo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: arte contemporanea em Artes.', 'Resumo: pontos essenciais de arte contemporanea e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: arte brasileira em Artes.', 'Resumo: pontos essenciais de arte brasileira e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: barroco mineiro em Artes.', 'Resumo: pontos essenciais de barroco mineiro e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: missao francesa em Artes.', 'Resumo: pontos essenciais de missao francesa e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: semana de 22 em Artes.', 'Resumo: pontos essenciais de semana de 22 e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: elementos da musica em Artes.', 'Resumo: pontos essenciais de elementos da musica e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: ritmo em Artes.', 'Resumo: pontos essenciais de ritmo e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: melodia em Artes.', 'Resumo: pontos essenciais de melodia e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: harmonia em Artes.', 'Resumo: pontos essenciais de harmonia e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: elementos do teatro em Artes.', 'Resumo: pontos essenciais de elementos do teatro e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: elementos da danca em Artes.', 'Resumo: pontos essenciais de elementos da danca e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: performance em Artes.', 'Resumo: pontos essenciais de performance e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: instalacao em Artes.', 'Resumo: pontos essenciais de instalacao e sua utilidade em Artes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: arte digital em Artes.', 'Resumo: pontos essenciais de arte digital e sua utilidade em Artes.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Artes';
END $$;
