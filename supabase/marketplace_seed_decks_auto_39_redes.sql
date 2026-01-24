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

  -- Redes
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/tecnologia-da-informacao/redes';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/tecnologia-da-informacao/redes'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Fundamentos e Conceitos (Auto)', 'Deck automatico de Redes com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e algoritmos em Redes?', 'Conceito basico de algoritmos aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e estruturas de dados em Redes?', 'Conceito basico de estruturas de dados aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e logica de programacao em Redes?', 'Conceito basico de logica de programacao aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e complexidade em Redes?', 'Conceito basico de complexidade aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e orientacao a objetos em Redes?', 'Conceito basico de orientacao a objetos aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e estruturas lineares em Redes?', 'Conceito basico de estruturas lineares aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e arvores em Redes?', 'Conceito basico de arvores aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e grafos em Redes?', 'Conceito basico de grafos aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e ordenacao em Redes?', 'Conceito basico de ordenacao aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e busca em Redes?', 'Conceito basico de busca aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e sistemas operacionais em Redes?', 'Conceito basico de sistemas operacionais aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e memoria e processos em Redes?', 'Conceito basico de memoria e processos aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e sistemas de arquivos em Redes?', 'Conceito basico de sistemas de arquivos aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e redes de computadores em Redes?', 'Conceito basico de redes de computadores aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e modelo osi em Redes?', 'Conceito basico de modelo osi aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e tcp ip em Redes?', 'Conceito basico de tcp ip aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e roteamento em Redes?', 'Conceito basico de roteamento aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e dns em Redes?', 'Conceito basico de dns aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e http em Redes?', 'Conceito basico de http aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e banco de dados em Redes?', 'Conceito basico de banco de dados aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e modelo relacional em Redes?', 'Conceito basico de modelo relacional aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e sql basico em Redes?', 'Conceito basico de sql basico aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e normalizacao em Redes?', 'Conceito basico de normalizacao aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e transacoes em Redes?', 'Conceito basico de transacoes aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e seguranca da informacao em Redes?', 'Conceito basico de seguranca da informacao aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e criptografia basica em Redes?', 'Conceito basico de criptografia basica aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e cloud em Redes?', 'Conceito basico de cloud aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e containers em Redes?', 'Conceito basico de containers aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e ci cd em Redes?', 'Conceito basico de ci cd aplicado a Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e devops em Redes?', 'Conceito basico de devops aplicado a Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Definicoes e Terminologia (Auto)', 'Deck automatico de Redes com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina algoritmos no contexto de Redes.', 'Definicao objetiva de algoritmos para Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina estruturas de dados no contexto de Redes.', 'Definicao objetiva de estruturas de dados para Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina logica de programacao no contexto de Redes.', 'Definicao objetiva de logica de programacao para Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina complexidade no contexto de Redes.', 'Definicao objetiva de complexidade para Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina orientacao a objetos no contexto de Redes.', 'Definicao objetiva de orientacao a objetos para Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina estruturas lineares no contexto de Redes.', 'Definicao objetiva de estruturas lineares para Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina arvores no contexto de Redes.', 'Definicao objetiva de arvores para Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina grafos no contexto de Redes.', 'Definicao objetiva de grafos para Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina ordenacao no contexto de Redes.', 'Definicao objetiva de ordenacao para Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina busca no contexto de Redes.', 'Definicao objetiva de busca para Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina sistemas operacionais no contexto de Redes.', 'Definicao objetiva de sistemas operacionais para Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina memoria e processos no contexto de Redes.', 'Definicao objetiva de memoria e processos para Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina sistemas de arquivos no contexto de Redes.', 'Definicao objetiva de sistemas de arquivos para Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina redes de computadores no contexto de Redes.', 'Definicao objetiva de redes de computadores para Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina modelo osi no contexto de Redes.', 'Definicao objetiva de modelo osi para Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina tcp ip no contexto de Redes.', 'Definicao objetiva de tcp ip para Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina roteamento no contexto de Redes.', 'Definicao objetiva de roteamento para Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina dns no contexto de Redes.', 'Definicao objetiva de dns para Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina http no contexto de Redes.', 'Definicao objetiva de http para Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina banco de dados no contexto de Redes.', 'Definicao objetiva de banco de dados para Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina modelo relacional no contexto de Redes.', 'Definicao objetiva de modelo relacional para Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina sql basico no contexto de Redes.', 'Definicao objetiva de sql basico para Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina normalizacao no contexto de Redes.', 'Definicao objetiva de normalizacao para Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina transacoes no contexto de Redes.', 'Definicao objetiva de transacoes para Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina seguranca da informacao no contexto de Redes.', 'Definicao objetiva de seguranca da informacao para Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina criptografia basica no contexto de Redes.', 'Definicao objetiva de criptografia basica para Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina cloud no contexto de Redes.', 'Definicao objetiva de cloud para Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina containers no contexto de Redes.', 'Definicao objetiva de containers para Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina ci cd no contexto de Redes.', 'Definicao objetiva de ci cd para Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina devops no contexto de Redes.', 'Definicao objetiva de devops para Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Processos e Aplicacoes (Auto)', 'Deck automatico de Redes com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como algoritmos se aplica em Redes?', 'Resumo do processo de algoritmos e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como estruturas de dados se aplica em Redes?', 'Resumo do processo de estruturas de dados e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como logica de programacao se aplica em Redes?', 'Resumo do processo de logica de programacao e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como complexidade se aplica em Redes?', 'Resumo do processo de complexidade e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como orientacao a objetos se aplica em Redes?', 'Resumo do processo de orientacao a objetos e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como estruturas lineares se aplica em Redes?', 'Resumo do processo de estruturas lineares e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como arvores se aplica em Redes?', 'Resumo do processo de arvores e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como grafos se aplica em Redes?', 'Resumo do processo de grafos e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como ordenacao se aplica em Redes?', 'Resumo do processo de ordenacao e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como busca se aplica em Redes?', 'Resumo do processo de busca e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como sistemas operacionais se aplica em Redes?', 'Resumo do processo de sistemas operacionais e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como memoria e processos se aplica em Redes?', 'Resumo do processo de memoria e processos e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como sistemas de arquivos se aplica em Redes?', 'Resumo do processo de sistemas de arquivos e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como redes de computadores se aplica em Redes?', 'Resumo do processo de redes de computadores e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como modelo osi se aplica em Redes?', 'Resumo do processo de modelo osi e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como tcp ip se aplica em Redes?', 'Resumo do processo de tcp ip e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como roteamento se aplica em Redes?', 'Resumo do processo de roteamento e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como dns se aplica em Redes?', 'Resumo do processo de dns e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como http se aplica em Redes?', 'Resumo do processo de http e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como banco de dados se aplica em Redes?', 'Resumo do processo de banco de dados e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como modelo relacional se aplica em Redes?', 'Resumo do processo de modelo relacional e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como sql basico se aplica em Redes?', 'Resumo do processo de sql basico e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como normalizacao se aplica em Redes?', 'Resumo do processo de normalizacao e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como transacoes se aplica em Redes?', 'Resumo do processo de transacoes e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como seguranca da informacao se aplica em Redes?', 'Resumo do processo de seguranca da informacao e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como criptografia basica se aplica em Redes?', 'Resumo do processo de criptografia basica e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como cloud se aplica em Redes?', 'Resumo do processo de cloud e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como containers se aplica em Redes?', 'Resumo do processo de containers e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como ci cd se aplica em Redes?', 'Resumo do processo de ci cd e sua aplicacao em Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como devops se aplica em Redes?', 'Resumo do processo de devops e sua aplicacao em Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Regras e Principios (Auto)', 'Deck automatico de Redes com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de algoritmos em Redes?', 'Principio central de algoritmos usado em Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de estruturas de dados em Redes?', 'Principio central de estruturas de dados usado em Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de logica de programacao em Redes?', 'Principio central de logica de programacao usado em Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de complexidade em Redes?', 'Principio central de complexidade usado em Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de orientacao a objetos em Redes?', 'Principio central de orientacao a objetos usado em Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de estruturas lineares em Redes?', 'Principio central de estruturas lineares usado em Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de arvores em Redes?', 'Principio central de arvores usado em Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de grafos em Redes?', 'Principio central de grafos usado em Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de ordenacao em Redes?', 'Principio central de ordenacao usado em Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de busca em Redes?', 'Principio central de busca usado em Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de sistemas operacionais em Redes?', 'Principio central de sistemas operacionais usado em Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de memoria e processos em Redes?', 'Principio central de memoria e processos usado em Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de sistemas de arquivos em Redes?', 'Principio central de sistemas de arquivos usado em Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de redes de computadores em Redes?', 'Principio central de redes de computadores usado em Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de modelo osi em Redes?', 'Principio central de modelo osi usado em Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de tcp ip em Redes?', 'Principio central de tcp ip usado em Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de roteamento em Redes?', 'Principio central de roteamento usado em Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de dns em Redes?', 'Principio central de dns usado em Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de http em Redes?', 'Principio central de http usado em Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de banco de dados em Redes?', 'Principio central de banco de dados usado em Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de modelo relacional em Redes?', 'Principio central de modelo relacional usado em Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de sql basico em Redes?', 'Principio central de sql basico usado em Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de normalizacao em Redes?', 'Principio central de normalizacao usado em Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de transacoes em Redes?', 'Principio central de transacoes usado em Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de seguranca da informacao em Redes?', 'Principio central de seguranca da informacao usado em Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de criptografia basica em Redes?', 'Principio central de criptografia basica usado em Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de cloud em Redes?', 'Principio central de cloud usado em Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de containers em Redes?', 'Principio central de containers usado em Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de ci cd em Redes?', 'Principio central de ci cd usado em Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de devops em Redes?', 'Principio central de devops usado em Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Resolucao de Problemas (Auto)', 'Deck automatico de Redes com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar algoritmos em Redes?', 'Sequencia simples: identificar dados, aplicar regras de algoritmos e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar estruturas de dados em Redes?', 'Sequencia simples: identificar dados, aplicar regras de estruturas de dados e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar logica de programacao em Redes?', 'Sequencia simples: identificar dados, aplicar regras de logica de programacao e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar complexidade em Redes?', 'Sequencia simples: identificar dados, aplicar regras de complexidade e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar orientacao a objetos em Redes?', 'Sequencia simples: identificar dados, aplicar regras de orientacao a objetos e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar estruturas lineares em Redes?', 'Sequencia simples: identificar dados, aplicar regras de estruturas lineares e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar arvores em Redes?', 'Sequencia simples: identificar dados, aplicar regras de arvores e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar grafos em Redes?', 'Sequencia simples: identificar dados, aplicar regras de grafos e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar ordenacao em Redes?', 'Sequencia simples: identificar dados, aplicar regras de ordenacao e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar busca em Redes?', 'Sequencia simples: identificar dados, aplicar regras de busca e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar sistemas operacionais em Redes?', 'Sequencia simples: identificar dados, aplicar regras de sistemas operacionais e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar memoria e processos em Redes?', 'Sequencia simples: identificar dados, aplicar regras de memoria e processos e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar sistemas de arquivos em Redes?', 'Sequencia simples: identificar dados, aplicar regras de sistemas de arquivos e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar redes de computadores em Redes?', 'Sequencia simples: identificar dados, aplicar regras de redes de computadores e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar modelo osi em Redes?', 'Sequencia simples: identificar dados, aplicar regras de modelo osi e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar tcp ip em Redes?', 'Sequencia simples: identificar dados, aplicar regras de tcp ip e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar roteamento em Redes?', 'Sequencia simples: identificar dados, aplicar regras de roteamento e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar dns em Redes?', 'Sequencia simples: identificar dados, aplicar regras de dns e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar http em Redes?', 'Sequencia simples: identificar dados, aplicar regras de http e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar banco de dados em Redes?', 'Sequencia simples: identificar dados, aplicar regras de banco de dados e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar modelo relacional em Redes?', 'Sequencia simples: identificar dados, aplicar regras de modelo relacional e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar sql basico em Redes?', 'Sequencia simples: identificar dados, aplicar regras de sql basico e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar normalizacao em Redes?', 'Sequencia simples: identificar dados, aplicar regras de normalizacao e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar transacoes em Redes?', 'Sequencia simples: identificar dados, aplicar regras de transacoes e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar seguranca da informacao em Redes?', 'Sequencia simples: identificar dados, aplicar regras de seguranca da informacao e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar criptografia basica em Redes?', 'Sequencia simples: identificar dados, aplicar regras de criptografia basica e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar cloud em Redes?', 'Sequencia simples: identificar dados, aplicar regras de cloud e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar containers em Redes?', 'Sequencia simples: identificar dados, aplicar regras de containers e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar ci cd em Redes?', 'Sequencia simples: identificar dados, aplicar regras de ci cd e concluir no contexto de Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar devops em Redes?', 'Sequencia simples: identificar dados, aplicar regras de devops e concluir no contexto de Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Erros Comuns e Dicas (Auto)', 'Deck automatico de Redes com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com algoritmos em Redes?', 'Erro comum: confundir conceito ou etapa de algoritmos; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com estruturas de dados em Redes?', 'Erro comum: confundir conceito ou etapa de estruturas de dados; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com logica de programacao em Redes?', 'Erro comum: confundir conceito ou etapa de logica de programacao; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com complexidade em Redes?', 'Erro comum: confundir conceito ou etapa de complexidade; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com orientacao a objetos em Redes?', 'Erro comum: confundir conceito ou etapa de orientacao a objetos; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com estruturas lineares em Redes?', 'Erro comum: confundir conceito ou etapa de estruturas lineares; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com arvores em Redes?', 'Erro comum: confundir conceito ou etapa de arvores; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com grafos em Redes?', 'Erro comum: confundir conceito ou etapa de grafos; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com ordenacao em Redes?', 'Erro comum: confundir conceito ou etapa de ordenacao; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com busca em Redes?', 'Erro comum: confundir conceito ou etapa de busca; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com sistemas operacionais em Redes?', 'Erro comum: confundir conceito ou etapa de sistemas operacionais; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com memoria e processos em Redes?', 'Erro comum: confundir conceito ou etapa de memoria e processos; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com sistemas de arquivos em Redes?', 'Erro comum: confundir conceito ou etapa de sistemas de arquivos; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com redes de computadores em Redes?', 'Erro comum: confundir conceito ou etapa de redes de computadores; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com modelo osi em Redes?', 'Erro comum: confundir conceito ou etapa de modelo osi; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com tcp ip em Redes?', 'Erro comum: confundir conceito ou etapa de tcp ip; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com roteamento em Redes?', 'Erro comum: confundir conceito ou etapa de roteamento; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com dns em Redes?', 'Erro comum: confundir conceito ou etapa de dns; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com http em Redes?', 'Erro comum: confundir conceito ou etapa de http; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com banco de dados em Redes?', 'Erro comum: confundir conceito ou etapa de banco de dados; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com modelo relacional em Redes?', 'Erro comum: confundir conceito ou etapa de modelo relacional; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com sql basico em Redes?', 'Erro comum: confundir conceito ou etapa de sql basico; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com normalizacao em Redes?', 'Erro comum: confundir conceito ou etapa de normalizacao; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com transacoes em Redes?', 'Erro comum: confundir conceito ou etapa de transacoes; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com seguranca da informacao em Redes?', 'Erro comum: confundir conceito ou etapa de seguranca da informacao; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com criptografia basica em Redes?', 'Erro comum: confundir conceito ou etapa de criptografia basica; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com cloud em Redes?', 'Erro comum: confundir conceito ou etapa de cloud; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com containers em Redes?', 'Erro comum: confundir conceito ou etapa de containers; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com ci cd em Redes?', 'Erro comum: confundir conceito ou etapa de ci cd; evite revisando definicoes e condicoes em Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com devops em Redes?', 'Erro comum: confundir conceito ou etapa de devops; evite revisando definicoes e condicoes em Redes.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes - Revisao Rapida (Auto)', 'Deck automatico de Redes com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['redes', 'it', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: algoritmos em Redes.', 'Resumo: pontos essenciais de algoritmos e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: estruturas de dados em Redes.', 'Resumo: pontos essenciais de estruturas de dados e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: logica de programacao em Redes.', 'Resumo: pontos essenciais de logica de programacao e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: complexidade em Redes.', 'Resumo: pontos essenciais de complexidade e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: orientacao a objetos em Redes.', 'Resumo: pontos essenciais de orientacao a objetos e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: estruturas lineares em Redes.', 'Resumo: pontos essenciais de estruturas lineares e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: arvores em Redes.', 'Resumo: pontos essenciais de arvores e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: grafos em Redes.', 'Resumo: pontos essenciais de grafos e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: ordenacao em Redes.', 'Resumo: pontos essenciais de ordenacao e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: busca em Redes.', 'Resumo: pontos essenciais de busca e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: sistemas operacionais em Redes.', 'Resumo: pontos essenciais de sistemas operacionais e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: memoria e processos em Redes.', 'Resumo: pontos essenciais de memoria e processos e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: sistemas de arquivos em Redes.', 'Resumo: pontos essenciais de sistemas de arquivos e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: redes de computadores em Redes.', 'Resumo: pontos essenciais de redes de computadores e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: modelo osi em Redes.', 'Resumo: pontos essenciais de modelo osi e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: tcp ip em Redes.', 'Resumo: pontos essenciais de tcp ip e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: roteamento em Redes.', 'Resumo: pontos essenciais de roteamento e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: dns em Redes.', 'Resumo: pontos essenciais de dns e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: http em Redes.', 'Resumo: pontos essenciais de http e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: banco de dados em Redes.', 'Resumo: pontos essenciais de banco de dados e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: modelo relacional em Redes.', 'Resumo: pontos essenciais de modelo relacional e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: sql basico em Redes.', 'Resumo: pontos essenciais de sql basico e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: normalizacao em Redes.', 'Resumo: pontos essenciais de normalizacao e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: transacoes em Redes.', 'Resumo: pontos essenciais de transacoes e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: seguranca da informacao em Redes.', 'Resumo: pontos essenciais de seguranca da informacao e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: criptografia basica em Redes.', 'Resumo: pontos essenciais de criptografia basica e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: cloud em Redes.', 'Resumo: pontos essenciais de cloud e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: containers em Redes.', 'Resumo: pontos essenciais de containers e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: ci cd em Redes.', 'Resumo: pontos essenciais de ci cd e sua utilidade em Redes.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: devops em Redes.', 'Resumo: pontos essenciais de devops e sua utilidade em Redes.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Redes';
END $$;
