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

  -- Algebra
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/algebra';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/matematica/algebra'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Fundamentos e Conceitos (Auto)', 'Deck automatico de Algebra com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e conjuntos numericos em Algebra?', 'Conceito basico de conjuntos numericos aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e operacoes com conjuntos em Algebra?', 'Conceito basico de operacoes com conjuntos aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e intervalos em Algebra?', 'Conceito basico de intervalos aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e modulo em Algebra?', 'Conceito basico de modulo aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e expressoes algebricas em Algebra?', 'Conceito basico de expressoes algebricas aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e equacoes lineares em Algebra?', 'Conceito basico de equacoes lineares aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e sistemas lineares em Algebra?', 'Conceito basico de sistemas lineares aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e equacoes quadraticas em Algebra?', 'Conceito basico de equacoes quadraticas aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e inequacoes em Algebra?', 'Conceito basico de inequacoes aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e funcoes afins em Algebra?', 'Conceito basico de funcoes afins aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e funcoes quadraticas em Algebra?', 'Conceito basico de funcoes quadraticas aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e funcoes modulares em Algebra?', 'Conceito basico de funcoes modulares aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e funcoes exponenciais em Algebra?', 'Conceito basico de funcoes exponenciais aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e funcoes logaritmicas em Algebra?', 'Conceito basico de funcoes logaritmicas aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e grafico de funcoes em Algebra?', 'Conceito basico de grafico de funcoes aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e zeros de funcao em Algebra?', 'Conceito basico de zeros de funcao aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e crescimento e decrescimento em Algebra?', 'Conceito basico de crescimento e decrescimento aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e progressao aritmetica em Algebra?', 'Conceito basico de progressao aritmetica aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e progressao geometrica em Algebra?', 'Conceito basico de progressao geometrica aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e juros simples em Algebra?', 'Conceito basico de juros simples aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e juros compostos em Algebra?', 'Conceito basico de juros compostos aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e porcentagem em Algebra?', 'Conceito basico de porcentagem aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e raizes e potencias em Algebra?', 'Conceito basico de raizes e potencias aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e fatoracao em Algebra?', 'Conceito basico de fatoracao aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e polinomios em Algebra?', 'Conceito basico de polinomios aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e identidades notaveis em Algebra?', 'Conceito basico de identidades notaveis aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e logaritmos em Algebra?', 'Conceito basico de logaritmos aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e equacoes exponenciais em Algebra?', 'Conceito basico de equacoes exponenciais aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e equacoes logaritmicas em Algebra?', 'Conceito basico de equacoes logaritmicas aplicado a Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e analise de sinal em Algebra?', 'Conceito basico de analise de sinal aplicado a Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Definicoes e Terminologia (Auto)', 'Deck automatico de Algebra com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina conjuntos numericos no contexto de Algebra.', 'Definicao objetiva de conjuntos numericos para Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina operacoes com conjuntos no contexto de Algebra.', 'Definicao objetiva de operacoes com conjuntos para Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina intervalos no contexto de Algebra.', 'Definicao objetiva de intervalos para Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina modulo no contexto de Algebra.', 'Definicao objetiva de modulo para Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina expressoes algebricas no contexto de Algebra.', 'Definicao objetiva de expressoes algebricas para Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina equacoes lineares no contexto de Algebra.', 'Definicao objetiva de equacoes lineares para Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina sistemas lineares no contexto de Algebra.', 'Definicao objetiva de sistemas lineares para Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina equacoes quadraticas no contexto de Algebra.', 'Definicao objetiva de equacoes quadraticas para Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina inequacoes no contexto de Algebra.', 'Definicao objetiva de inequacoes para Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina funcoes afins no contexto de Algebra.', 'Definicao objetiva de funcoes afins para Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina funcoes quadraticas no contexto de Algebra.', 'Definicao objetiva de funcoes quadraticas para Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina funcoes modulares no contexto de Algebra.', 'Definicao objetiva de funcoes modulares para Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina funcoes exponenciais no contexto de Algebra.', 'Definicao objetiva de funcoes exponenciais para Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina funcoes logaritmicas no contexto de Algebra.', 'Definicao objetiva de funcoes logaritmicas para Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina grafico de funcoes no contexto de Algebra.', 'Definicao objetiva de grafico de funcoes para Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina zeros de funcao no contexto de Algebra.', 'Definicao objetiva de zeros de funcao para Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina crescimento e decrescimento no contexto de Algebra.', 'Definicao objetiva de crescimento e decrescimento para Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina progressao aritmetica no contexto de Algebra.', 'Definicao objetiva de progressao aritmetica para Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina progressao geometrica no contexto de Algebra.', 'Definicao objetiva de progressao geometrica para Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina juros simples no contexto de Algebra.', 'Definicao objetiva de juros simples para Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina juros compostos no contexto de Algebra.', 'Definicao objetiva de juros compostos para Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina porcentagem no contexto de Algebra.', 'Definicao objetiva de porcentagem para Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina raizes e potencias no contexto de Algebra.', 'Definicao objetiva de raizes e potencias para Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina fatoracao no contexto de Algebra.', 'Definicao objetiva de fatoracao para Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina polinomios no contexto de Algebra.', 'Definicao objetiva de polinomios para Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina identidades notaveis no contexto de Algebra.', 'Definicao objetiva de identidades notaveis para Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina logaritmos no contexto de Algebra.', 'Definicao objetiva de logaritmos para Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina equacoes exponenciais no contexto de Algebra.', 'Definicao objetiva de equacoes exponenciais para Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina equacoes logaritmicas no contexto de Algebra.', 'Definicao objetiva de equacoes logaritmicas para Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina analise de sinal no contexto de Algebra.', 'Definicao objetiva de analise de sinal para Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Processos e Aplicacoes (Auto)', 'Deck automatico de Algebra com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como conjuntos numericos se aplica em Algebra?', 'Resumo do processo de conjuntos numericos e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como operacoes com conjuntos se aplica em Algebra?', 'Resumo do processo de operacoes com conjuntos e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como intervalos se aplica em Algebra?', 'Resumo do processo de intervalos e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como modulo se aplica em Algebra?', 'Resumo do processo de modulo e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como expressoes algebricas se aplica em Algebra?', 'Resumo do processo de expressoes algebricas e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como equacoes lineares se aplica em Algebra?', 'Resumo do processo de equacoes lineares e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como sistemas lineares se aplica em Algebra?', 'Resumo do processo de sistemas lineares e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como equacoes quadraticas se aplica em Algebra?', 'Resumo do processo de equacoes quadraticas e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como inequacoes se aplica em Algebra?', 'Resumo do processo de inequacoes e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como funcoes afins se aplica em Algebra?', 'Resumo do processo de funcoes afins e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como funcoes quadraticas se aplica em Algebra?', 'Resumo do processo de funcoes quadraticas e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como funcoes modulares se aplica em Algebra?', 'Resumo do processo de funcoes modulares e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como funcoes exponenciais se aplica em Algebra?', 'Resumo do processo de funcoes exponenciais e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como funcoes logaritmicas se aplica em Algebra?', 'Resumo do processo de funcoes logaritmicas e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como grafico de funcoes se aplica em Algebra?', 'Resumo do processo de grafico de funcoes e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como zeros de funcao se aplica em Algebra?', 'Resumo do processo de zeros de funcao e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como crescimento e decrescimento se aplica em Algebra?', 'Resumo do processo de crescimento e decrescimento e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como progressao aritmetica se aplica em Algebra?', 'Resumo do processo de progressao aritmetica e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como progressao geometrica se aplica em Algebra?', 'Resumo do processo de progressao geometrica e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como juros simples se aplica em Algebra?', 'Resumo do processo de juros simples e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como juros compostos se aplica em Algebra?', 'Resumo do processo de juros compostos e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como porcentagem se aplica em Algebra?', 'Resumo do processo de porcentagem e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como raizes e potencias se aplica em Algebra?', 'Resumo do processo de raizes e potencias e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como fatoracao se aplica em Algebra?', 'Resumo do processo de fatoracao e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como polinomios se aplica em Algebra?', 'Resumo do processo de polinomios e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como identidades notaveis se aplica em Algebra?', 'Resumo do processo de identidades notaveis e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como logaritmos se aplica em Algebra?', 'Resumo do processo de logaritmos e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como equacoes exponenciais se aplica em Algebra?', 'Resumo do processo de equacoes exponenciais e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como equacoes logaritmicas se aplica em Algebra?', 'Resumo do processo de equacoes logaritmicas e sua aplicacao em Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como analise de sinal se aplica em Algebra?', 'Resumo do processo de analise de sinal e sua aplicacao em Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Regras e Principios (Auto)', 'Deck automatico de Algebra com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de conjuntos numericos em Algebra?', 'Principio central de conjuntos numericos usado em Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de operacoes com conjuntos em Algebra?', 'Principio central de operacoes com conjuntos usado em Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de intervalos em Algebra?', 'Principio central de intervalos usado em Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de modulo em Algebra?', 'Principio central de modulo usado em Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de expressoes algebricas em Algebra?', 'Principio central de expressoes algebricas usado em Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de equacoes lineares em Algebra?', 'Principio central de equacoes lineares usado em Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de sistemas lineares em Algebra?', 'Principio central de sistemas lineares usado em Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de equacoes quadraticas em Algebra?', 'Principio central de equacoes quadraticas usado em Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de inequacoes em Algebra?', 'Principio central de inequacoes usado em Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de funcoes afins em Algebra?', 'Principio central de funcoes afins usado em Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de funcoes quadraticas em Algebra?', 'Principio central de funcoes quadraticas usado em Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de funcoes modulares em Algebra?', 'Principio central de funcoes modulares usado em Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de funcoes exponenciais em Algebra?', 'Principio central de funcoes exponenciais usado em Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de funcoes logaritmicas em Algebra?', 'Principio central de funcoes logaritmicas usado em Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de grafico de funcoes em Algebra?', 'Principio central de grafico de funcoes usado em Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de zeros de funcao em Algebra?', 'Principio central de zeros de funcao usado em Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de crescimento e decrescimento em Algebra?', 'Principio central de crescimento e decrescimento usado em Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de progressao aritmetica em Algebra?', 'Principio central de progressao aritmetica usado em Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de progressao geometrica em Algebra?', 'Principio central de progressao geometrica usado em Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de juros simples em Algebra?', 'Principio central de juros simples usado em Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de juros compostos em Algebra?', 'Principio central de juros compostos usado em Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de porcentagem em Algebra?', 'Principio central de porcentagem usado em Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de raizes e potencias em Algebra?', 'Principio central de raizes e potencias usado em Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de fatoracao em Algebra?', 'Principio central de fatoracao usado em Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de polinomios em Algebra?', 'Principio central de polinomios usado em Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de identidades notaveis em Algebra?', 'Principio central de identidades notaveis usado em Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de logaritmos em Algebra?', 'Principio central de logaritmos usado em Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de equacoes exponenciais em Algebra?', 'Principio central de equacoes exponenciais usado em Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de equacoes logaritmicas em Algebra?', 'Principio central de equacoes logaritmicas usado em Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de analise de sinal em Algebra?', 'Principio central de analise de sinal usado em Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Resolucao de Problemas (Auto)', 'Deck automatico de Algebra com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar conjuntos numericos em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de conjuntos numericos e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar operacoes com conjuntos em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de operacoes com conjuntos e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar intervalos em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de intervalos e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar modulo em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de modulo e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar expressoes algebricas em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de expressoes algebricas e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar equacoes lineares em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de equacoes lineares e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar sistemas lineares em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de sistemas lineares e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar equacoes quadraticas em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de equacoes quadraticas e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar inequacoes em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de inequacoes e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar funcoes afins em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de funcoes afins e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar funcoes quadraticas em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de funcoes quadraticas e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar funcoes modulares em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de funcoes modulares e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar funcoes exponenciais em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de funcoes exponenciais e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar funcoes logaritmicas em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de funcoes logaritmicas e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar grafico de funcoes em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de grafico de funcoes e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar zeros de funcao em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de zeros de funcao e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar crescimento e decrescimento em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de crescimento e decrescimento e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar progressao aritmetica em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de progressao aritmetica e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar progressao geometrica em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de progressao geometrica e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar juros simples em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de juros simples e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar juros compostos em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de juros compostos e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar porcentagem em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de porcentagem e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar raizes e potencias em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de raizes e potencias e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar fatoracao em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de fatoracao e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar polinomios em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de polinomios e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar identidades notaveis em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de identidades notaveis e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar logaritmos em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de logaritmos e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar equacoes exponenciais em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de equacoes exponenciais e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar equacoes logaritmicas em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de equacoes logaritmicas e concluir no contexto de Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar analise de sinal em Algebra?', 'Sequencia simples: identificar dados, aplicar regras de analise de sinal e concluir no contexto de Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Erros Comuns e Dicas (Auto)', 'Deck automatico de Algebra com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com conjuntos numericos em Algebra?', 'Erro comum: confundir conceito ou etapa de conjuntos numericos; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com operacoes com conjuntos em Algebra?', 'Erro comum: confundir conceito ou etapa de operacoes com conjuntos; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com intervalos em Algebra?', 'Erro comum: confundir conceito ou etapa de intervalos; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com modulo em Algebra?', 'Erro comum: confundir conceito ou etapa de modulo; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com expressoes algebricas em Algebra?', 'Erro comum: confundir conceito ou etapa de expressoes algebricas; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com equacoes lineares em Algebra?', 'Erro comum: confundir conceito ou etapa de equacoes lineares; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com sistemas lineares em Algebra?', 'Erro comum: confundir conceito ou etapa de sistemas lineares; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com equacoes quadraticas em Algebra?', 'Erro comum: confundir conceito ou etapa de equacoes quadraticas; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com inequacoes em Algebra?', 'Erro comum: confundir conceito ou etapa de inequacoes; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com funcoes afins em Algebra?', 'Erro comum: confundir conceito ou etapa de funcoes afins; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com funcoes quadraticas em Algebra?', 'Erro comum: confundir conceito ou etapa de funcoes quadraticas; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com funcoes modulares em Algebra?', 'Erro comum: confundir conceito ou etapa de funcoes modulares; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com funcoes exponenciais em Algebra?', 'Erro comum: confundir conceito ou etapa de funcoes exponenciais; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com funcoes logaritmicas em Algebra?', 'Erro comum: confundir conceito ou etapa de funcoes logaritmicas; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com grafico de funcoes em Algebra?', 'Erro comum: confundir conceito ou etapa de grafico de funcoes; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com zeros de funcao em Algebra?', 'Erro comum: confundir conceito ou etapa de zeros de funcao; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com crescimento e decrescimento em Algebra?', 'Erro comum: confundir conceito ou etapa de crescimento e decrescimento; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com progressao aritmetica em Algebra?', 'Erro comum: confundir conceito ou etapa de progressao aritmetica; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com progressao geometrica em Algebra?', 'Erro comum: confundir conceito ou etapa de progressao geometrica; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com juros simples em Algebra?', 'Erro comum: confundir conceito ou etapa de juros simples; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com juros compostos em Algebra?', 'Erro comum: confundir conceito ou etapa de juros compostos; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com porcentagem em Algebra?', 'Erro comum: confundir conceito ou etapa de porcentagem; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com raizes e potencias em Algebra?', 'Erro comum: confundir conceito ou etapa de raizes e potencias; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com fatoracao em Algebra?', 'Erro comum: confundir conceito ou etapa de fatoracao; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com polinomios em Algebra?', 'Erro comum: confundir conceito ou etapa de polinomios; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com identidades notaveis em Algebra?', 'Erro comum: confundir conceito ou etapa de identidades notaveis; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com logaritmos em Algebra?', 'Erro comum: confundir conceito ou etapa de logaritmos; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com equacoes exponenciais em Algebra?', 'Erro comum: confundir conceito ou etapa de equacoes exponenciais; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com equacoes logaritmicas em Algebra?', 'Erro comum: confundir conceito ou etapa de equacoes logaritmicas; evite revisando definicoes e condicoes em Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com analise de sinal em Algebra?', 'Erro comum: confundir conceito ou etapa de analise de sinal; evite revisando definicoes e condicoes em Algebra.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algebra - Revisao Rapida (Auto)', 'Deck automatico de Algebra com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['algebra', 'math', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: conjuntos numericos em Algebra.', 'Resumo: pontos essenciais de conjuntos numericos e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: operacoes com conjuntos em Algebra.', 'Resumo: pontos essenciais de operacoes com conjuntos e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: intervalos em Algebra.', 'Resumo: pontos essenciais de intervalos e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: modulo em Algebra.', 'Resumo: pontos essenciais de modulo e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: expressoes algebricas em Algebra.', 'Resumo: pontos essenciais de expressoes algebricas e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: equacoes lineares em Algebra.', 'Resumo: pontos essenciais de equacoes lineares e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: sistemas lineares em Algebra.', 'Resumo: pontos essenciais de sistemas lineares e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: equacoes quadraticas em Algebra.', 'Resumo: pontos essenciais de equacoes quadraticas e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: inequacoes em Algebra.', 'Resumo: pontos essenciais de inequacoes e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: funcoes afins em Algebra.', 'Resumo: pontos essenciais de funcoes afins e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: funcoes quadraticas em Algebra.', 'Resumo: pontos essenciais de funcoes quadraticas e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: funcoes modulares em Algebra.', 'Resumo: pontos essenciais de funcoes modulares e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: funcoes exponenciais em Algebra.', 'Resumo: pontos essenciais de funcoes exponenciais e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: funcoes logaritmicas em Algebra.', 'Resumo: pontos essenciais de funcoes logaritmicas e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: grafico de funcoes em Algebra.', 'Resumo: pontos essenciais de grafico de funcoes e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: zeros de funcao em Algebra.', 'Resumo: pontos essenciais de zeros de funcao e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: crescimento e decrescimento em Algebra.', 'Resumo: pontos essenciais de crescimento e decrescimento e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: progressao aritmetica em Algebra.', 'Resumo: pontos essenciais de progressao aritmetica e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: progressao geometrica em Algebra.', 'Resumo: pontos essenciais de progressao geometrica e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: juros simples em Algebra.', 'Resumo: pontos essenciais de juros simples e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: juros compostos em Algebra.', 'Resumo: pontos essenciais de juros compostos e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: porcentagem em Algebra.', 'Resumo: pontos essenciais de porcentagem e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: raizes e potencias em Algebra.', 'Resumo: pontos essenciais de raizes e potencias e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: fatoracao em Algebra.', 'Resumo: pontos essenciais de fatoracao e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: polinomios em Algebra.', 'Resumo: pontos essenciais de polinomios e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: identidades notaveis em Algebra.', 'Resumo: pontos essenciais de identidades notaveis e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: logaritmos em Algebra.', 'Resumo: pontos essenciais de logaritmos e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: equacoes exponenciais em Algebra.', 'Resumo: pontos essenciais de equacoes exponenciais e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: equacoes logaritmicas em Algebra.', 'Resumo: pontos essenciais de equacoes logaritmicas e sua utilidade em Algebra.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: analise de sinal em Algebra.', 'Resumo: pontos essenciais de analise de sinal e sua utilidade em Algebra.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Algebra';
END $$;
