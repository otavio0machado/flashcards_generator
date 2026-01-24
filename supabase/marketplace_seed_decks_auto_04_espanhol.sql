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

  -- Espanhol
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/linguagens/espanhol';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-medio/linguagens/espanhol'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Fundamentos e Conceitos (Auto)', 'Deck automatico de Espanhol com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e compreensao leitora em Espanhol?', 'Conceito basico de compreensao leitora aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e estrategias de leitura em Espanhol?', 'Conceito basico de estrategias de leitura aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e ideia principal em Espanhol?', 'Conceito basico de ideia principal aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e contexto e inferencia em Espanhol?', 'Conceito basico de contexto e inferencia aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e false cognates em Espanhol?', 'Conceito basico de false cognates aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e pronouns em Espanhol?', 'Conceito basico de pronouns aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e modals em Espanhol?', 'Conceito basico de modals aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e simple present em Espanhol?', 'Conceito basico de simple present aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e simple past em Espanhol?', 'Conceito basico de simple past aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e present perfect em Espanhol?', 'Conceito basico de present perfect aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e future forms em Espanhol?', 'Conceito basico de future forms aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e passive voice em Espanhol?', 'Conceito basico de passive voice aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e reported speech em Espanhol?', 'Conceito basico de reported speech aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e conditionals em Espanhol?', 'Conceito basico de conditionals aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e comparatives em Espanhol?', 'Conceito basico de comparatives aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e superlatives em Espanhol?', 'Conceito basico de superlatives aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e connectors em Espanhol?', 'Conceito basico de connectors aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e prepositions em Espanhol?', 'Conceito basico de prepositions aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e phrasal verbs em Espanhol?', 'Conceito basico de phrasal verbs aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e adjectives em Espanhol?', 'Conceito basico de adjectives aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e adverbs em Espanhol?', 'Conceito basico de adverbs aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e relative clauses em Espanhol?', 'Conceito basico de relative clauses aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e gerunds and infinitives em Espanhol?', 'Conceito basico de gerunds and infinitives aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e countable and uncountable em Espanhol?', 'Conceito basico de countable and uncountable aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e articles em Espanhol?', 'Conceito basico de articles aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e quantifiers em Espanhol?', 'Conceito basico de quantifiers aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e wh-questions em Espanhol?', 'Conceito basico de wh-questions aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e tag questions em Espanhol?', 'Conceito basico de tag questions aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e word formation em Espanhol?', 'Conceito basico de word formation aplicado a Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e collocations em Espanhol?', 'Conceito basico de collocations aplicado a Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Definicoes e Terminologia (Auto)', 'Deck automatico de Espanhol com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina compreensao leitora no contexto de Espanhol.', 'Definicao objetiva de compreensao leitora para Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina estrategias de leitura no contexto de Espanhol.', 'Definicao objetiva de estrategias de leitura para Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina ideia principal no contexto de Espanhol.', 'Definicao objetiva de ideia principal para Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina contexto e inferencia no contexto de Espanhol.', 'Definicao objetiva de contexto e inferencia para Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina false cognates no contexto de Espanhol.', 'Definicao objetiva de false cognates para Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina pronouns no contexto de Espanhol.', 'Definicao objetiva de pronouns para Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina modals no contexto de Espanhol.', 'Definicao objetiva de modals para Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina simple present no contexto de Espanhol.', 'Definicao objetiva de simple present para Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina simple past no contexto de Espanhol.', 'Definicao objetiva de simple past para Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina present perfect no contexto de Espanhol.', 'Definicao objetiva de present perfect para Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina future forms no contexto de Espanhol.', 'Definicao objetiva de future forms para Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina passive voice no contexto de Espanhol.', 'Definicao objetiva de passive voice para Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina reported speech no contexto de Espanhol.', 'Definicao objetiva de reported speech para Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina conditionals no contexto de Espanhol.', 'Definicao objetiva de conditionals para Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina comparatives no contexto de Espanhol.', 'Definicao objetiva de comparatives para Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina superlatives no contexto de Espanhol.', 'Definicao objetiva de superlatives para Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina connectors no contexto de Espanhol.', 'Definicao objetiva de connectors para Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina prepositions no contexto de Espanhol.', 'Definicao objetiva de prepositions para Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina phrasal verbs no contexto de Espanhol.', 'Definicao objetiva de phrasal verbs para Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina adjectives no contexto de Espanhol.', 'Definicao objetiva de adjectives para Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina adverbs no contexto de Espanhol.', 'Definicao objetiva de adverbs para Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina relative clauses no contexto de Espanhol.', 'Definicao objetiva de relative clauses para Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina gerunds and infinitives no contexto de Espanhol.', 'Definicao objetiva de gerunds and infinitives para Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina countable and uncountable no contexto de Espanhol.', 'Definicao objetiva de countable and uncountable para Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina articles no contexto de Espanhol.', 'Definicao objetiva de articles para Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina quantifiers no contexto de Espanhol.', 'Definicao objetiva de quantifiers para Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina wh-questions no contexto de Espanhol.', 'Definicao objetiva de wh-questions para Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina tag questions no contexto de Espanhol.', 'Definicao objetiva de tag questions para Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina word formation no contexto de Espanhol.', 'Definicao objetiva de word formation para Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina collocations no contexto de Espanhol.', 'Definicao objetiva de collocations para Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Processos e Aplicacoes (Auto)', 'Deck automatico de Espanhol com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como compreensao leitora se aplica em Espanhol?', 'Resumo do processo de compreensao leitora e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como estrategias de leitura se aplica em Espanhol?', 'Resumo do processo de estrategias de leitura e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como ideia principal se aplica em Espanhol?', 'Resumo do processo de ideia principal e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como contexto e inferencia se aplica em Espanhol?', 'Resumo do processo de contexto e inferencia e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como false cognates se aplica em Espanhol?', 'Resumo do processo de false cognates e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como pronouns se aplica em Espanhol?', 'Resumo do processo de pronouns e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como modals se aplica em Espanhol?', 'Resumo do processo de modals e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como simple present se aplica em Espanhol?', 'Resumo do processo de simple present e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como simple past se aplica em Espanhol?', 'Resumo do processo de simple past e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como present perfect se aplica em Espanhol?', 'Resumo do processo de present perfect e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como future forms se aplica em Espanhol?', 'Resumo do processo de future forms e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como passive voice se aplica em Espanhol?', 'Resumo do processo de passive voice e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como reported speech se aplica em Espanhol?', 'Resumo do processo de reported speech e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como conditionals se aplica em Espanhol?', 'Resumo do processo de conditionals e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como comparatives se aplica em Espanhol?', 'Resumo do processo de comparatives e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como superlatives se aplica em Espanhol?', 'Resumo do processo de superlatives e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como connectors se aplica em Espanhol?', 'Resumo do processo de connectors e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como prepositions se aplica em Espanhol?', 'Resumo do processo de prepositions e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como phrasal verbs se aplica em Espanhol?', 'Resumo do processo de phrasal verbs e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como adjectives se aplica em Espanhol?', 'Resumo do processo de adjectives e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como adverbs se aplica em Espanhol?', 'Resumo do processo de adverbs e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como relative clauses se aplica em Espanhol?', 'Resumo do processo de relative clauses e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como gerunds and infinitives se aplica em Espanhol?', 'Resumo do processo de gerunds and infinitives e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como countable and uncountable se aplica em Espanhol?', 'Resumo do processo de countable and uncountable e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como articles se aplica em Espanhol?', 'Resumo do processo de articles e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como quantifiers se aplica em Espanhol?', 'Resumo do processo de quantifiers e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como wh-questions se aplica em Espanhol?', 'Resumo do processo de wh-questions e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como tag questions se aplica em Espanhol?', 'Resumo do processo de tag questions e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como word formation se aplica em Espanhol?', 'Resumo do processo de word formation e sua aplicacao em Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como collocations se aplica em Espanhol?', 'Resumo do processo de collocations e sua aplicacao em Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Regras e Principios (Auto)', 'Deck automatico de Espanhol com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de compreensao leitora em Espanhol?', 'Principio central de compreensao leitora usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de estrategias de leitura em Espanhol?', 'Principio central de estrategias de leitura usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de ideia principal em Espanhol?', 'Principio central de ideia principal usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de contexto e inferencia em Espanhol?', 'Principio central de contexto e inferencia usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de false cognates em Espanhol?', 'Principio central de false cognates usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de pronouns em Espanhol?', 'Principio central de pronouns usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de modals em Espanhol?', 'Principio central de modals usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de simple present em Espanhol?', 'Principio central de simple present usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de simple past em Espanhol?', 'Principio central de simple past usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de present perfect em Espanhol?', 'Principio central de present perfect usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de future forms em Espanhol?', 'Principio central de future forms usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de passive voice em Espanhol?', 'Principio central de passive voice usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de reported speech em Espanhol?', 'Principio central de reported speech usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de conditionals em Espanhol?', 'Principio central de conditionals usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de comparatives em Espanhol?', 'Principio central de comparatives usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de superlatives em Espanhol?', 'Principio central de superlatives usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de connectors em Espanhol?', 'Principio central de connectors usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de prepositions em Espanhol?', 'Principio central de prepositions usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de phrasal verbs em Espanhol?', 'Principio central de phrasal verbs usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de adjectives em Espanhol?', 'Principio central de adjectives usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de adverbs em Espanhol?', 'Principio central de adverbs usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de relative clauses em Espanhol?', 'Principio central de relative clauses usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de gerunds and infinitives em Espanhol?', 'Principio central de gerunds and infinitives usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de countable and uncountable em Espanhol?', 'Principio central de countable and uncountable usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de articles em Espanhol?', 'Principio central de articles usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de quantifiers em Espanhol?', 'Principio central de quantifiers usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de wh-questions em Espanhol?', 'Principio central de wh-questions usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de tag questions em Espanhol?', 'Principio central de tag questions usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de word formation em Espanhol?', 'Principio central de word formation usado em Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de collocations em Espanhol?', 'Principio central de collocations usado em Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Resolucao de Problemas (Auto)', 'Deck automatico de Espanhol com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar compreensao leitora em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de compreensao leitora e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar estrategias de leitura em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de estrategias de leitura e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar ideia principal em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de ideia principal e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar contexto e inferencia em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de contexto e inferencia e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar false cognates em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de false cognates e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar pronouns em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de pronouns e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar modals em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de modals e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar simple present em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de simple present e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar simple past em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de simple past e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar present perfect em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de present perfect e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar future forms em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de future forms e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar passive voice em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de passive voice e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar reported speech em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de reported speech e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar conditionals em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de conditionals e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar comparatives em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de comparatives e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar superlatives em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de superlatives e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar connectors em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de connectors e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar prepositions em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de prepositions e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar phrasal verbs em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de phrasal verbs e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar adjectives em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de adjectives e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar adverbs em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de adverbs e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar relative clauses em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de relative clauses e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar gerunds and infinitives em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de gerunds and infinitives e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar countable and uncountable em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de countable and uncountable e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar articles em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de articles e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar quantifiers em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de quantifiers e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar wh-questions em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de wh-questions e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar tag questions em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de tag questions e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar word formation em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de word formation e concluir no contexto de Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar collocations em Espanhol?', 'Sequencia simples: identificar dados, aplicar regras de collocations e concluir no contexto de Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Erros Comuns e Dicas (Auto)', 'Deck automatico de Espanhol com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com compreensao leitora em Espanhol?', 'Erro comum: confundir conceito ou etapa de compreensao leitora; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com estrategias de leitura em Espanhol?', 'Erro comum: confundir conceito ou etapa de estrategias de leitura; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com ideia principal em Espanhol?', 'Erro comum: confundir conceito ou etapa de ideia principal; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com contexto e inferencia em Espanhol?', 'Erro comum: confundir conceito ou etapa de contexto e inferencia; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com false cognates em Espanhol?', 'Erro comum: confundir conceito ou etapa de false cognates; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com pronouns em Espanhol?', 'Erro comum: confundir conceito ou etapa de pronouns; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com modals em Espanhol?', 'Erro comum: confundir conceito ou etapa de modals; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com simple present em Espanhol?', 'Erro comum: confundir conceito ou etapa de simple present; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com simple past em Espanhol?', 'Erro comum: confundir conceito ou etapa de simple past; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com present perfect em Espanhol?', 'Erro comum: confundir conceito ou etapa de present perfect; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com future forms em Espanhol?', 'Erro comum: confundir conceito ou etapa de future forms; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com passive voice em Espanhol?', 'Erro comum: confundir conceito ou etapa de passive voice; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com reported speech em Espanhol?', 'Erro comum: confundir conceito ou etapa de reported speech; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com conditionals em Espanhol?', 'Erro comum: confundir conceito ou etapa de conditionals; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com comparatives em Espanhol?', 'Erro comum: confundir conceito ou etapa de comparatives; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com superlatives em Espanhol?', 'Erro comum: confundir conceito ou etapa de superlatives; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com connectors em Espanhol?', 'Erro comum: confundir conceito ou etapa de connectors; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com prepositions em Espanhol?', 'Erro comum: confundir conceito ou etapa de prepositions; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com phrasal verbs em Espanhol?', 'Erro comum: confundir conceito ou etapa de phrasal verbs; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com adjectives em Espanhol?', 'Erro comum: confundir conceito ou etapa de adjectives; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com adverbs em Espanhol?', 'Erro comum: confundir conceito ou etapa de adverbs; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com relative clauses em Espanhol?', 'Erro comum: confundir conceito ou etapa de relative clauses; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com gerunds and infinitives em Espanhol?', 'Erro comum: confundir conceito ou etapa de gerunds and infinitives; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com countable and uncountable em Espanhol?', 'Erro comum: confundir conceito ou etapa de countable and uncountable; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com articles em Espanhol?', 'Erro comum: confundir conceito ou etapa de articles; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com quantifiers em Espanhol?', 'Erro comum: confundir conceito ou etapa de quantifiers; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com wh-questions em Espanhol?', 'Erro comum: confundir conceito ou etapa de wh-questions; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com tag questions em Espanhol?', 'Erro comum: confundir conceito ou etapa de tag questions; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com word formation em Espanhol?', 'Erro comum: confundir conceito ou etapa de word formation; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com collocations em Espanhol?', 'Erro comum: confundir conceito ou etapa de collocations; evite revisando definicoes e condicoes em Espanhol.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Espanhol - Revisao Rapida (Auto)', 'Deck automatico de Espanhol com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['espanhol', 'foreign_language', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: compreensao leitora em Espanhol.', 'Resumo: pontos essenciais de compreensao leitora e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: estrategias de leitura em Espanhol.', 'Resumo: pontos essenciais de estrategias de leitura e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: ideia principal em Espanhol.', 'Resumo: pontos essenciais de ideia principal e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: contexto e inferencia em Espanhol.', 'Resumo: pontos essenciais de contexto e inferencia e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: false cognates em Espanhol.', 'Resumo: pontos essenciais de false cognates e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: pronouns em Espanhol.', 'Resumo: pontos essenciais de pronouns e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: modals em Espanhol.', 'Resumo: pontos essenciais de modals e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: simple present em Espanhol.', 'Resumo: pontos essenciais de simple present e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: simple past em Espanhol.', 'Resumo: pontos essenciais de simple past e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: present perfect em Espanhol.', 'Resumo: pontos essenciais de present perfect e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: future forms em Espanhol.', 'Resumo: pontos essenciais de future forms e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: passive voice em Espanhol.', 'Resumo: pontos essenciais de passive voice e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: reported speech em Espanhol.', 'Resumo: pontos essenciais de reported speech e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: conditionals em Espanhol.', 'Resumo: pontos essenciais de conditionals e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: comparatives em Espanhol.', 'Resumo: pontos essenciais de comparatives e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: superlatives em Espanhol.', 'Resumo: pontos essenciais de superlatives e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: connectors em Espanhol.', 'Resumo: pontos essenciais de connectors e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: prepositions em Espanhol.', 'Resumo: pontos essenciais de prepositions e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: phrasal verbs em Espanhol.', 'Resumo: pontos essenciais de phrasal verbs e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: adjectives em Espanhol.', 'Resumo: pontos essenciais de adjectives e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: adverbs em Espanhol.', 'Resumo: pontos essenciais de adverbs e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: relative clauses em Espanhol.', 'Resumo: pontos essenciais de relative clauses e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: gerunds and infinitives em Espanhol.', 'Resumo: pontos essenciais de gerunds and infinitives e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: countable and uncountable em Espanhol.', 'Resumo: pontos essenciais de countable and uncountable e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: articles em Espanhol.', 'Resumo: pontos essenciais de articles e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: quantifiers em Espanhol.', 'Resumo: pontos essenciais de quantifiers e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: wh-questions em Espanhol.', 'Resumo: pontos essenciais de wh-questions e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: tag questions em Espanhol.', 'Resumo: pontos essenciais de tag questions e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: word formation em Espanhol.', 'Resumo: pontos essenciais de word formation e sua utilidade em Espanhol.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: collocations em Espanhol.', 'Resumo: pontos essenciais de collocations e sua utilidade em Espanhol.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Espanhol';
END $$;
