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

  -- Quimica Geral
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/engenharias-e-exatas/quimica-geral';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/engenharias-e-exatas/quimica-geral'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Fundamentos e Conceitos (Auto)', 'Deck automatico de Quimica Geral com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e limites e continuidade em Quimica Geral?', 'Conceito basico de limites e continuidade aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e derivadas em Quimica Geral?', 'Conceito basico de derivadas aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e integrais em Quimica Geral?', 'Conceito basico de integrais aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e equacoes diferenciais em Quimica Geral?', 'Conceito basico de equacoes diferenciais aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e mecanica classica em Quimica Geral?', 'Conceito basico de mecanica classica aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e dinamica rotacional em Quimica Geral?', 'Conceito basico de dinamica rotacional aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e momento angular em Quimica Geral?', 'Conceito basico de momento angular aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e gravidade em Quimica Geral?', 'Conceito basico de gravidade aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e eletromagnetismo em Quimica Geral?', 'Conceito basico de eletromagnetismo aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e lei de gauss em Quimica Geral?', 'Conceito basico de lei de gauss aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e circuitos eletricos em Quimica Geral?', 'Conceito basico de circuitos eletricos aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e capacitancia em Quimica Geral?', 'Conceito basico de capacitancia aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e indutancia em Quimica Geral?', 'Conceito basico de indutancia aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e ondas e oscilacoes em Quimica Geral?', 'Conceito basico de ondas e oscilacoes aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e termodinamica em Quimica Geral?', 'Conceito basico de termodinamica aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e transferencia de calor em Quimica Geral?', 'Conceito basico de transferencia de calor aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e mecanica dos fluidos em Quimica Geral?', 'Conceito basico de mecanica dos fluidos aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e viscosidade em Quimica Geral?', 'Conceito basico de viscosidade aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e escoamento em Quimica Geral?', 'Conceito basico de escoamento aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e perda de carga em Quimica Geral?', 'Conceito basico de perda de carga aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e resistencia dos materiais em Quimica Geral?', 'Conceito basico de resistencia dos materiais aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e tensao e deformacao em Quimica Geral?', 'Conceito basico de tensao e deformacao aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e lei de hooke em Quimica Geral?', 'Conceito basico de lei de hooke aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e flexao em Quimica Geral?', 'Conceito basico de flexao aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e torcao em Quimica Geral?', 'Conceito basico de torcao aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e fadiga em Quimica Geral?', 'Conceito basico de fadiga aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e materiais em Quimica Geral?', 'Conceito basico de materiais aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e quimica geral em Quimica Geral?', 'Conceito basico de quimica geral aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e estequiometria em Quimica Geral?', 'Conceito basico de estequiometria aplicado a Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e fenomenos de transporte em Quimica Geral?', 'Conceito basico de fenomenos de transporte aplicado a Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Definicoes e Terminologia (Auto)', 'Deck automatico de Quimica Geral com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina limites e continuidade no contexto de Quimica Geral.', 'Definicao objetiva de limites e continuidade para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina derivadas no contexto de Quimica Geral.', 'Definicao objetiva de derivadas para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina integrais no contexto de Quimica Geral.', 'Definicao objetiva de integrais para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina equacoes diferenciais no contexto de Quimica Geral.', 'Definicao objetiva de equacoes diferenciais para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina mecanica classica no contexto de Quimica Geral.', 'Definicao objetiva de mecanica classica para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina dinamica rotacional no contexto de Quimica Geral.', 'Definicao objetiva de dinamica rotacional para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina momento angular no contexto de Quimica Geral.', 'Definicao objetiva de momento angular para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina gravidade no contexto de Quimica Geral.', 'Definicao objetiva de gravidade para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina eletromagnetismo no contexto de Quimica Geral.', 'Definicao objetiva de eletromagnetismo para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina lei de gauss no contexto de Quimica Geral.', 'Definicao objetiva de lei de gauss para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina circuitos eletricos no contexto de Quimica Geral.', 'Definicao objetiva de circuitos eletricos para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina capacitancia no contexto de Quimica Geral.', 'Definicao objetiva de capacitancia para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina indutancia no contexto de Quimica Geral.', 'Definicao objetiva de indutancia para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina ondas e oscilacoes no contexto de Quimica Geral.', 'Definicao objetiva de ondas e oscilacoes para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina termodinamica no contexto de Quimica Geral.', 'Definicao objetiva de termodinamica para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina transferencia de calor no contexto de Quimica Geral.', 'Definicao objetiva de transferencia de calor para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina mecanica dos fluidos no contexto de Quimica Geral.', 'Definicao objetiva de mecanica dos fluidos para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina viscosidade no contexto de Quimica Geral.', 'Definicao objetiva de viscosidade para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina escoamento no contexto de Quimica Geral.', 'Definicao objetiva de escoamento para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina perda de carga no contexto de Quimica Geral.', 'Definicao objetiva de perda de carga para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina resistencia dos materiais no contexto de Quimica Geral.', 'Definicao objetiva de resistencia dos materiais para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina tensao e deformacao no contexto de Quimica Geral.', 'Definicao objetiva de tensao e deformacao para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina lei de hooke no contexto de Quimica Geral.', 'Definicao objetiva de lei de hooke para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina flexao no contexto de Quimica Geral.', 'Definicao objetiva de flexao para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina torcao no contexto de Quimica Geral.', 'Definicao objetiva de torcao para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina fadiga no contexto de Quimica Geral.', 'Definicao objetiva de fadiga para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina materiais no contexto de Quimica Geral.', 'Definicao objetiva de materiais para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina quimica geral no contexto de Quimica Geral.', 'Definicao objetiva de quimica geral para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina estequiometria no contexto de Quimica Geral.', 'Definicao objetiva de estequiometria para Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina fenomenos de transporte no contexto de Quimica Geral.', 'Definicao objetiva de fenomenos de transporte para Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Processos e Aplicacoes (Auto)', 'Deck automatico de Quimica Geral com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como limites e continuidade se aplica em Quimica Geral?', 'Resumo do processo de limites e continuidade e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como derivadas se aplica em Quimica Geral?', 'Resumo do processo de derivadas e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como integrais se aplica em Quimica Geral?', 'Resumo do processo de integrais e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como equacoes diferenciais se aplica em Quimica Geral?', 'Resumo do processo de equacoes diferenciais e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como mecanica classica se aplica em Quimica Geral?', 'Resumo do processo de mecanica classica e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como dinamica rotacional se aplica em Quimica Geral?', 'Resumo do processo de dinamica rotacional e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como momento angular se aplica em Quimica Geral?', 'Resumo do processo de momento angular e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como gravidade se aplica em Quimica Geral?', 'Resumo do processo de gravidade e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como eletromagnetismo se aplica em Quimica Geral?', 'Resumo do processo de eletromagnetismo e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como lei de gauss se aplica em Quimica Geral?', 'Resumo do processo de lei de gauss e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como circuitos eletricos se aplica em Quimica Geral?', 'Resumo do processo de circuitos eletricos e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como capacitancia se aplica em Quimica Geral?', 'Resumo do processo de capacitancia e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como indutancia se aplica em Quimica Geral?', 'Resumo do processo de indutancia e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como ondas e oscilacoes se aplica em Quimica Geral?', 'Resumo do processo de ondas e oscilacoes e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como termodinamica se aplica em Quimica Geral?', 'Resumo do processo de termodinamica e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como transferencia de calor se aplica em Quimica Geral?', 'Resumo do processo de transferencia de calor e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como mecanica dos fluidos se aplica em Quimica Geral?', 'Resumo do processo de mecanica dos fluidos e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como viscosidade se aplica em Quimica Geral?', 'Resumo do processo de viscosidade e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como escoamento se aplica em Quimica Geral?', 'Resumo do processo de escoamento e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como perda de carga se aplica em Quimica Geral?', 'Resumo do processo de perda de carga e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como resistencia dos materiais se aplica em Quimica Geral?', 'Resumo do processo de resistencia dos materiais e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como tensao e deformacao se aplica em Quimica Geral?', 'Resumo do processo de tensao e deformacao e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como lei de hooke se aplica em Quimica Geral?', 'Resumo do processo de lei de hooke e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como flexao se aplica em Quimica Geral?', 'Resumo do processo de flexao e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como torcao se aplica em Quimica Geral?', 'Resumo do processo de torcao e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como fadiga se aplica em Quimica Geral?', 'Resumo do processo de fadiga e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como materiais se aplica em Quimica Geral?', 'Resumo do processo de materiais e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como quimica geral se aplica em Quimica Geral?', 'Resumo do processo de quimica geral e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como estequiometria se aplica em Quimica Geral?', 'Resumo do processo de estequiometria e sua aplicacao em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como fenomenos de transporte se aplica em Quimica Geral?', 'Resumo do processo de fenomenos de transporte e sua aplicacao em Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Regras e Principios (Auto)', 'Deck automatico de Quimica Geral com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de limites e continuidade em Quimica Geral?', 'Principio central de limites e continuidade usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de derivadas em Quimica Geral?', 'Principio central de derivadas usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de integrais em Quimica Geral?', 'Principio central de integrais usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de equacoes diferenciais em Quimica Geral?', 'Principio central de equacoes diferenciais usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de mecanica classica em Quimica Geral?', 'Principio central de mecanica classica usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de dinamica rotacional em Quimica Geral?', 'Principio central de dinamica rotacional usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de momento angular em Quimica Geral?', 'Principio central de momento angular usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de gravidade em Quimica Geral?', 'Principio central de gravidade usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de eletromagnetismo em Quimica Geral?', 'Principio central de eletromagnetismo usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de lei de gauss em Quimica Geral?', 'Principio central de lei de gauss usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de circuitos eletricos em Quimica Geral?', 'Principio central de circuitos eletricos usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de capacitancia em Quimica Geral?', 'Principio central de capacitancia usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de indutancia em Quimica Geral?', 'Principio central de indutancia usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de ondas e oscilacoes em Quimica Geral?', 'Principio central de ondas e oscilacoes usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de termodinamica em Quimica Geral?', 'Principio central de termodinamica usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de transferencia de calor em Quimica Geral?', 'Principio central de transferencia de calor usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de mecanica dos fluidos em Quimica Geral?', 'Principio central de mecanica dos fluidos usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de viscosidade em Quimica Geral?', 'Principio central de viscosidade usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de escoamento em Quimica Geral?', 'Principio central de escoamento usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de perda de carga em Quimica Geral?', 'Principio central de perda de carga usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de resistencia dos materiais em Quimica Geral?', 'Principio central de resistencia dos materiais usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de tensao e deformacao em Quimica Geral?', 'Principio central de tensao e deformacao usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de lei de hooke em Quimica Geral?', 'Principio central de lei de hooke usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de flexao em Quimica Geral?', 'Principio central de flexao usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de torcao em Quimica Geral?', 'Principio central de torcao usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de fadiga em Quimica Geral?', 'Principio central de fadiga usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de materiais em Quimica Geral?', 'Principio central de materiais usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de quimica geral em Quimica Geral?', 'Principio central de quimica geral usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de estequiometria em Quimica Geral?', 'Principio central de estequiometria usado em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de fenomenos de transporte em Quimica Geral?', 'Principio central de fenomenos de transporte usado em Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Resolucao de Problemas (Auto)', 'Deck automatico de Quimica Geral com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar limites e continuidade em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de limites e continuidade e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar derivadas em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de derivadas e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar integrais em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de integrais e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar equacoes diferenciais em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de equacoes diferenciais e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar mecanica classica em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de mecanica classica e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar dinamica rotacional em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de dinamica rotacional e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar momento angular em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de momento angular e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar gravidade em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de gravidade e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar eletromagnetismo em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de eletromagnetismo e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar lei de gauss em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de lei de gauss e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar circuitos eletricos em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de circuitos eletricos e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar capacitancia em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de capacitancia e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar indutancia em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de indutancia e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar ondas e oscilacoes em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de ondas e oscilacoes e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar termodinamica em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de termodinamica e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar transferencia de calor em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de transferencia de calor e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar mecanica dos fluidos em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de mecanica dos fluidos e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar viscosidade em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de viscosidade e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar escoamento em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de escoamento e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar perda de carga em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de perda de carga e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar resistencia dos materiais em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de resistencia dos materiais e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar tensao e deformacao em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de tensao e deformacao e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar lei de hooke em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de lei de hooke e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar flexao em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de flexao e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar torcao em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de torcao e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar fadiga em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de fadiga e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar materiais em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de materiais e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar quimica geral em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de quimica geral e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar estequiometria em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de estequiometria e concluir no contexto de Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar fenomenos de transporte em Quimica Geral?', 'Sequencia simples: identificar dados, aplicar regras de fenomenos de transporte e concluir no contexto de Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Erros Comuns e Dicas (Auto)', 'Deck automatico de Quimica Geral com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com limites e continuidade em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de limites e continuidade; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com derivadas em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de derivadas; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com integrais em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de integrais; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com equacoes diferenciais em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de equacoes diferenciais; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com mecanica classica em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de mecanica classica; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com dinamica rotacional em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de dinamica rotacional; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com momento angular em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de momento angular; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com gravidade em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de gravidade; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com eletromagnetismo em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de eletromagnetismo; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com lei de gauss em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de lei de gauss; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com circuitos eletricos em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de circuitos eletricos; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com capacitancia em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de capacitancia; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com indutancia em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de indutancia; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com ondas e oscilacoes em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de ondas e oscilacoes; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com termodinamica em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de termodinamica; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com transferencia de calor em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de transferencia de calor; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com mecanica dos fluidos em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de mecanica dos fluidos; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com viscosidade em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de viscosidade; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com escoamento em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de escoamento; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com perda de carga em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de perda de carga; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com resistencia dos materiais em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de resistencia dos materiais; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com tensao e deformacao em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de tensao e deformacao; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com lei de hooke em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de lei de hooke; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com flexao em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de flexao; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com torcao em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de torcao; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com fadiga em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de fadiga; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com materiais em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de materiais; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com quimica geral em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de quimica geral; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com estequiometria em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de estequiometria; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com fenomenos de transporte em Quimica Geral?', 'Erro comum: confundir conceito ou etapa de fenomenos de transporte; evite revisando definicoes e condicoes em Quimica Geral.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Quimica Geral - Revisao Rapida (Auto)', 'Deck automatico de Quimica Geral com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['quimica-geral', 'engineering', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: limites e continuidade em Quimica Geral.', 'Resumo: pontos essenciais de limites e continuidade e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: derivadas em Quimica Geral.', 'Resumo: pontos essenciais de derivadas e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: integrais em Quimica Geral.', 'Resumo: pontos essenciais de integrais e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: equacoes diferenciais em Quimica Geral.', 'Resumo: pontos essenciais de equacoes diferenciais e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: mecanica classica em Quimica Geral.', 'Resumo: pontos essenciais de mecanica classica e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: dinamica rotacional em Quimica Geral.', 'Resumo: pontos essenciais de dinamica rotacional e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: momento angular em Quimica Geral.', 'Resumo: pontos essenciais de momento angular e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: gravidade em Quimica Geral.', 'Resumo: pontos essenciais de gravidade e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: eletromagnetismo em Quimica Geral.', 'Resumo: pontos essenciais de eletromagnetismo e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: lei de gauss em Quimica Geral.', 'Resumo: pontos essenciais de lei de gauss e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: circuitos eletricos em Quimica Geral.', 'Resumo: pontos essenciais de circuitos eletricos e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: capacitancia em Quimica Geral.', 'Resumo: pontos essenciais de capacitancia e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: indutancia em Quimica Geral.', 'Resumo: pontos essenciais de indutancia e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: ondas e oscilacoes em Quimica Geral.', 'Resumo: pontos essenciais de ondas e oscilacoes e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: termodinamica em Quimica Geral.', 'Resumo: pontos essenciais de termodinamica e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: transferencia de calor em Quimica Geral.', 'Resumo: pontos essenciais de transferencia de calor e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: mecanica dos fluidos em Quimica Geral.', 'Resumo: pontos essenciais de mecanica dos fluidos e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: viscosidade em Quimica Geral.', 'Resumo: pontos essenciais de viscosidade e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: escoamento em Quimica Geral.', 'Resumo: pontos essenciais de escoamento e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: perda de carga em Quimica Geral.', 'Resumo: pontos essenciais de perda de carga e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: resistencia dos materiais em Quimica Geral.', 'Resumo: pontos essenciais de resistencia dos materiais e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: tensao e deformacao em Quimica Geral.', 'Resumo: pontos essenciais de tensao e deformacao e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: lei de hooke em Quimica Geral.', 'Resumo: pontos essenciais de lei de hooke e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: flexao em Quimica Geral.', 'Resumo: pontos essenciais de flexao e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: torcao em Quimica Geral.', 'Resumo: pontos essenciais de torcao e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: fadiga em Quimica Geral.', 'Resumo: pontos essenciais de fadiga e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: materiais em Quimica Geral.', 'Resumo: pontos essenciais de materiais e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: quimica geral em Quimica Geral.', 'Resumo: pontos essenciais de quimica geral e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: estequiometria em Quimica Geral.', 'Resumo: pontos essenciais de estequiometria e sua utilidade em Quimica Geral.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: fenomenos de transporte em Quimica Geral.', 'Resumo: pontos essenciais de fenomenos de transporte e sua utilidade em Quimica Geral.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Quimica Geral';
END $$;
