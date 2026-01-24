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

  -- Ingles
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/linguagens/ingles';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/linguagens/ingles'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Fundamentos e Conceitos (Auto)', 'Deck automatico de Ingles com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e compreensao leitora em Ingles?', 'Conceito basico de compreensao leitora aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e estrategias de leitura em Ingles?', 'Conceito basico de estrategias de leitura aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e ideia principal em Ingles?', 'Conceito basico de ideia principal aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e contexto e inferencia em Ingles?', 'Conceito basico de contexto e inferencia aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e false cognates em Ingles?', 'Conceito basico de false cognates aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e pronouns em Ingles?', 'Conceito basico de pronouns aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e modals em Ingles?', 'Conceito basico de modals aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e simple present em Ingles?', 'Conceito basico de simple present aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e simple past em Ingles?', 'Conceito basico de simple past aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e present perfect em Ingles?', 'Conceito basico de present perfect aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e future forms em Ingles?', 'Conceito basico de future forms aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e passive voice em Ingles?', 'Conceito basico de passive voice aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e reported speech em Ingles?', 'Conceito basico de reported speech aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e conditionals em Ingles?', 'Conceito basico de conditionals aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e comparatives em Ingles?', 'Conceito basico de comparatives aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e superlatives em Ingles?', 'Conceito basico de superlatives aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e connectors em Ingles?', 'Conceito basico de connectors aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e prepositions em Ingles?', 'Conceito basico de prepositions aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e phrasal verbs em Ingles?', 'Conceito basico de phrasal verbs aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e adjectives em Ingles?', 'Conceito basico de adjectives aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e adverbs em Ingles?', 'Conceito basico de adverbs aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e relative clauses em Ingles?', 'Conceito basico de relative clauses aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e gerunds and infinitives em Ingles?', 'Conceito basico de gerunds and infinitives aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e countable and uncountable em Ingles?', 'Conceito basico de countable and uncountable aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e articles em Ingles?', 'Conceito basico de articles aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e quantifiers em Ingles?', 'Conceito basico de quantifiers aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e wh-questions em Ingles?', 'Conceito basico de wh-questions aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e tag questions em Ingles?', 'Conceito basico de tag questions aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e word formation em Ingles?', 'Conceito basico de word formation aplicado a Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e collocations em Ingles?', 'Conceito basico de collocations aplicado a Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Definicoes e Terminologia (Auto)', 'Deck automatico de Ingles com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina compreensao leitora no contexto de Ingles.', 'Definicao objetiva de compreensao leitora para Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina estrategias de leitura no contexto de Ingles.', 'Definicao objetiva de estrategias de leitura para Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina ideia principal no contexto de Ingles.', 'Definicao objetiva de ideia principal para Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina contexto e inferencia no contexto de Ingles.', 'Definicao objetiva de contexto e inferencia para Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina false cognates no contexto de Ingles.', 'Definicao objetiva de false cognates para Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina pronouns no contexto de Ingles.', 'Definicao objetiva de pronouns para Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina modals no contexto de Ingles.', 'Definicao objetiva de modals para Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina simple present no contexto de Ingles.', 'Definicao objetiva de simple present para Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina simple past no contexto de Ingles.', 'Definicao objetiva de simple past para Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina present perfect no contexto de Ingles.', 'Definicao objetiva de present perfect para Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina future forms no contexto de Ingles.', 'Definicao objetiva de future forms para Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina passive voice no contexto de Ingles.', 'Definicao objetiva de passive voice para Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina reported speech no contexto de Ingles.', 'Definicao objetiva de reported speech para Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina conditionals no contexto de Ingles.', 'Definicao objetiva de conditionals para Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina comparatives no contexto de Ingles.', 'Definicao objetiva de comparatives para Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina superlatives no contexto de Ingles.', 'Definicao objetiva de superlatives para Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina connectors no contexto de Ingles.', 'Definicao objetiva de connectors para Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina prepositions no contexto de Ingles.', 'Definicao objetiva de prepositions para Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina phrasal verbs no contexto de Ingles.', 'Definicao objetiva de phrasal verbs para Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina adjectives no contexto de Ingles.', 'Definicao objetiva de adjectives para Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina adverbs no contexto de Ingles.', 'Definicao objetiva de adverbs para Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina relative clauses no contexto de Ingles.', 'Definicao objetiva de relative clauses para Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina gerunds and infinitives no contexto de Ingles.', 'Definicao objetiva de gerunds and infinitives para Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina countable and uncountable no contexto de Ingles.', 'Definicao objetiva de countable and uncountable para Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina articles no contexto de Ingles.', 'Definicao objetiva de articles para Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina quantifiers no contexto de Ingles.', 'Definicao objetiva de quantifiers para Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina wh-questions no contexto de Ingles.', 'Definicao objetiva de wh-questions para Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina tag questions no contexto de Ingles.', 'Definicao objetiva de tag questions para Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina word formation no contexto de Ingles.', 'Definicao objetiva de word formation para Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina collocations no contexto de Ingles.', 'Definicao objetiva de collocations para Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Processos e Aplicacoes (Auto)', 'Deck automatico de Ingles com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como compreensao leitora se aplica em Ingles?', 'Resumo do processo de compreensao leitora e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como estrategias de leitura se aplica em Ingles?', 'Resumo do processo de estrategias de leitura e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como ideia principal se aplica em Ingles?', 'Resumo do processo de ideia principal e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como contexto e inferencia se aplica em Ingles?', 'Resumo do processo de contexto e inferencia e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como false cognates se aplica em Ingles?', 'Resumo do processo de false cognates e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como pronouns se aplica em Ingles?', 'Resumo do processo de pronouns e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como modals se aplica em Ingles?', 'Resumo do processo de modals e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como simple present se aplica em Ingles?', 'Resumo do processo de simple present e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como simple past se aplica em Ingles?', 'Resumo do processo de simple past e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como present perfect se aplica em Ingles?', 'Resumo do processo de present perfect e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como future forms se aplica em Ingles?', 'Resumo do processo de future forms e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como passive voice se aplica em Ingles?', 'Resumo do processo de passive voice e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como reported speech se aplica em Ingles?', 'Resumo do processo de reported speech e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como conditionals se aplica em Ingles?', 'Resumo do processo de conditionals e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como comparatives se aplica em Ingles?', 'Resumo do processo de comparatives e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como superlatives se aplica em Ingles?', 'Resumo do processo de superlatives e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como connectors se aplica em Ingles?', 'Resumo do processo de connectors e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como prepositions se aplica em Ingles?', 'Resumo do processo de prepositions e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como phrasal verbs se aplica em Ingles?', 'Resumo do processo de phrasal verbs e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como adjectives se aplica em Ingles?', 'Resumo do processo de adjectives e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como adverbs se aplica em Ingles?', 'Resumo do processo de adverbs e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como relative clauses se aplica em Ingles?', 'Resumo do processo de relative clauses e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como gerunds and infinitives se aplica em Ingles?', 'Resumo do processo de gerunds and infinitives e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como countable and uncountable se aplica em Ingles?', 'Resumo do processo de countable and uncountable e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como articles se aplica em Ingles?', 'Resumo do processo de articles e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como quantifiers se aplica em Ingles?', 'Resumo do processo de quantifiers e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como wh-questions se aplica em Ingles?', 'Resumo do processo de wh-questions e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como tag questions se aplica em Ingles?', 'Resumo do processo de tag questions e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como word formation se aplica em Ingles?', 'Resumo do processo de word formation e sua aplicacao em Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como collocations se aplica em Ingles?', 'Resumo do processo de collocations e sua aplicacao em Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Regras e Principios (Auto)', 'Deck automatico de Ingles com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de compreensao leitora em Ingles?', 'Principio central de compreensao leitora usado em Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de estrategias de leitura em Ingles?', 'Principio central de estrategias de leitura usado em Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de ideia principal em Ingles?', 'Principio central de ideia principal usado em Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de contexto e inferencia em Ingles?', 'Principio central de contexto e inferencia usado em Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de false cognates em Ingles?', 'Principio central de false cognates usado em Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de pronouns em Ingles?', 'Principio central de pronouns usado em Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de modals em Ingles?', 'Principio central de modals usado em Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de simple present em Ingles?', 'Principio central de simple present usado em Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de simple past em Ingles?', 'Principio central de simple past usado em Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de present perfect em Ingles?', 'Principio central de present perfect usado em Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de future forms em Ingles?', 'Principio central de future forms usado em Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de passive voice em Ingles?', 'Principio central de passive voice usado em Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de reported speech em Ingles?', 'Principio central de reported speech usado em Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de conditionals em Ingles?', 'Principio central de conditionals usado em Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de comparatives em Ingles?', 'Principio central de comparatives usado em Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de superlatives em Ingles?', 'Principio central de superlatives usado em Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de connectors em Ingles?', 'Principio central de connectors usado em Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de prepositions em Ingles?', 'Principio central de prepositions usado em Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de phrasal verbs em Ingles?', 'Principio central de phrasal verbs usado em Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de adjectives em Ingles?', 'Principio central de adjectives usado em Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de adverbs em Ingles?', 'Principio central de adverbs usado em Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de relative clauses em Ingles?', 'Principio central de relative clauses usado em Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de gerunds and infinitives em Ingles?', 'Principio central de gerunds and infinitives usado em Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de countable and uncountable em Ingles?', 'Principio central de countable and uncountable usado em Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de articles em Ingles?', 'Principio central de articles usado em Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de quantifiers em Ingles?', 'Principio central de quantifiers usado em Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de wh-questions em Ingles?', 'Principio central de wh-questions usado em Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de tag questions em Ingles?', 'Principio central de tag questions usado em Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de word formation em Ingles?', 'Principio central de word formation usado em Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de collocations em Ingles?', 'Principio central de collocations usado em Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Resolucao de Problemas (Auto)', 'Deck automatico de Ingles com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar compreensao leitora em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de compreensao leitora e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar estrategias de leitura em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de estrategias de leitura e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar ideia principal em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de ideia principal e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar contexto e inferencia em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de contexto e inferencia e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar false cognates em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de false cognates e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar pronouns em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de pronouns e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar modals em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de modals e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar simple present em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de simple present e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar simple past em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de simple past e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar present perfect em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de present perfect e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar future forms em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de future forms e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar passive voice em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de passive voice e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar reported speech em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de reported speech e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar conditionals em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de conditionals e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar comparatives em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de comparatives e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar superlatives em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de superlatives e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar connectors em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de connectors e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar prepositions em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de prepositions e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar phrasal verbs em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de phrasal verbs e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar adjectives em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de adjectives e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar adverbs em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de adverbs e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar relative clauses em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de relative clauses e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar gerunds and infinitives em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de gerunds and infinitives e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar countable and uncountable em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de countable and uncountable e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar articles em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de articles e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar quantifiers em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de quantifiers e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar wh-questions em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de wh-questions e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar tag questions em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de tag questions e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar word formation em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de word formation e concluir no contexto de Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar collocations em Ingles?', 'Sequencia simples: identificar dados, aplicar regras de collocations e concluir no contexto de Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Erros Comuns e Dicas (Auto)', 'Deck automatico de Ingles com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com compreensao leitora em Ingles?', 'Erro comum: confundir conceito ou etapa de compreensao leitora; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com estrategias de leitura em Ingles?', 'Erro comum: confundir conceito ou etapa de estrategias de leitura; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com ideia principal em Ingles?', 'Erro comum: confundir conceito ou etapa de ideia principal; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com contexto e inferencia em Ingles?', 'Erro comum: confundir conceito ou etapa de contexto e inferencia; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com false cognates em Ingles?', 'Erro comum: confundir conceito ou etapa de false cognates; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com pronouns em Ingles?', 'Erro comum: confundir conceito ou etapa de pronouns; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com modals em Ingles?', 'Erro comum: confundir conceito ou etapa de modals; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com simple present em Ingles?', 'Erro comum: confundir conceito ou etapa de simple present; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com simple past em Ingles?', 'Erro comum: confundir conceito ou etapa de simple past; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com present perfect em Ingles?', 'Erro comum: confundir conceito ou etapa de present perfect; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com future forms em Ingles?', 'Erro comum: confundir conceito ou etapa de future forms; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com passive voice em Ingles?', 'Erro comum: confundir conceito ou etapa de passive voice; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com reported speech em Ingles?', 'Erro comum: confundir conceito ou etapa de reported speech; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com conditionals em Ingles?', 'Erro comum: confundir conceito ou etapa de conditionals; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com comparatives em Ingles?', 'Erro comum: confundir conceito ou etapa de comparatives; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com superlatives em Ingles?', 'Erro comum: confundir conceito ou etapa de superlatives; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com connectors em Ingles?', 'Erro comum: confundir conceito ou etapa de connectors; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com prepositions em Ingles?', 'Erro comum: confundir conceito ou etapa de prepositions; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com phrasal verbs em Ingles?', 'Erro comum: confundir conceito ou etapa de phrasal verbs; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com adjectives em Ingles?', 'Erro comum: confundir conceito ou etapa de adjectives; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com adverbs em Ingles?', 'Erro comum: confundir conceito ou etapa de adverbs; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com relative clauses em Ingles?', 'Erro comum: confundir conceito ou etapa de relative clauses; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com gerunds and infinitives em Ingles?', 'Erro comum: confundir conceito ou etapa de gerunds and infinitives; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com countable and uncountable em Ingles?', 'Erro comum: confundir conceito ou etapa de countable and uncountable; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com articles em Ingles?', 'Erro comum: confundir conceito ou etapa de articles; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com quantifiers em Ingles?', 'Erro comum: confundir conceito ou etapa de quantifiers; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com wh-questions em Ingles?', 'Erro comum: confundir conceito ou etapa de wh-questions; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com tag questions em Ingles?', 'Erro comum: confundir conceito ou etapa de tag questions; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com word formation em Ingles?', 'Erro comum: confundir conceito ou etapa de word formation; evite revisando definicoes e condicoes em Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com collocations em Ingles?', 'Erro comum: confundir conceito ou etapa de collocations; evite revisando definicoes e condicoes em Ingles.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ingles - Revisao Rapida (Auto)', 'Deck automatico de Ingles com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['ingles', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: compreensao leitora em Ingles.', 'Resumo: pontos essenciais de compreensao leitora e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: estrategias de leitura em Ingles.', 'Resumo: pontos essenciais de estrategias de leitura e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: ideia principal em Ingles.', 'Resumo: pontos essenciais de ideia principal e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: contexto e inferencia em Ingles.', 'Resumo: pontos essenciais de contexto e inferencia e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: false cognates em Ingles.', 'Resumo: pontos essenciais de false cognates e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: pronouns em Ingles.', 'Resumo: pontos essenciais de pronouns e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: modals em Ingles.', 'Resumo: pontos essenciais de modals e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: simple present em Ingles.', 'Resumo: pontos essenciais de simple present e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: simple past em Ingles.', 'Resumo: pontos essenciais de simple past e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: present perfect em Ingles.', 'Resumo: pontos essenciais de present perfect e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: future forms em Ingles.', 'Resumo: pontos essenciais de future forms e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: passive voice em Ingles.', 'Resumo: pontos essenciais de passive voice e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: reported speech em Ingles.', 'Resumo: pontos essenciais de reported speech e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: conditionals em Ingles.', 'Resumo: pontos essenciais de conditionals e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: comparatives em Ingles.', 'Resumo: pontos essenciais de comparatives e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: superlatives em Ingles.', 'Resumo: pontos essenciais de superlatives e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: connectors em Ingles.', 'Resumo: pontos essenciais de connectors e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: prepositions em Ingles.', 'Resumo: pontos essenciais de prepositions e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: phrasal verbs em Ingles.', 'Resumo: pontos essenciais de phrasal verbs e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: adjectives em Ingles.', 'Resumo: pontos essenciais de adjectives e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: adverbs em Ingles.', 'Resumo: pontos essenciais de adverbs e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: relative clauses em Ingles.', 'Resumo: pontos essenciais de relative clauses e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: gerunds and infinitives em Ingles.', 'Resumo: pontos essenciais de gerunds and infinitives e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: countable and uncountable em Ingles.', 'Resumo: pontos essenciais de countable and uncountable e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: articles em Ingles.', 'Resumo: pontos essenciais de articles e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: quantifiers em Ingles.', 'Resumo: pontos essenciais de quantifiers e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: wh-questions em Ingles.', 'Resumo: pontos essenciais de wh-questions e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: tag questions em Ingles.', 'Resumo: pontos essenciais de tag questions e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: word formation em Ingles.', 'Resumo: pontos essenciais de word formation e sua utilidade em Ingles.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: collocations em Ingles.', 'Resumo: pontos essenciais de collocations e sua utilidade em Ingles.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Ingles';
END $$;
