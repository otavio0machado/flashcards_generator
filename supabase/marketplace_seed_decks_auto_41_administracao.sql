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

  -- Administracao
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/negocios/administracao';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/negocios/administracao'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Fundamentos e Conceitos (Auto)', 'Deck automatico de Administracao com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e planejamento estrategico em Administracao?', 'Conceito basico de planejamento estrategico aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e organizacao em Administracao?', 'Conceito basico de organizacao aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e lideranca em Administracao?', 'Conceito basico de lideranca aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e controle em Administracao?', 'Conceito basico de controle aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e gestao de pessoas em Administracao?', 'Conceito basico de gestao de pessoas aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e financas em Administracao?', 'Conceito basico de financas aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e fluxo de caixa em Administracao?', 'Conceito basico de fluxo de caixa aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e custo e precificacao em Administracao?', 'Conceito basico de custo e precificacao aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e economia micro em Administracao?', 'Conceito basico de economia micro aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e economia macro em Administracao?', 'Conceito basico de economia macro aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e oferta e demanda em Administracao?', 'Conceito basico de oferta e demanda aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e inflacao em Administracao?', 'Conceito basico de inflacao aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e politica monetaria em Administracao?', 'Conceito basico de politica monetaria aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e contabilidade basica em Administracao?', 'Conceito basico de contabilidade basica aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e balanco patrimonial em Administracao?', 'Conceito basico de balanco patrimonial aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e dre em Administracao?', 'Conceito basico de dre aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e capital de giro em Administracao?', 'Conceito basico de capital de giro aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e indicadores em Administracao?', 'Conceito basico de indicadores aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e marketing mix em Administracao?', 'Conceito basico de marketing mix aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e segmentacao em Administracao?', 'Conceito basico de segmentacao aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e posicionamento em Administracao?', 'Conceito basico de posicionamento aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e pesquisa de mercado em Administracao?', 'Conceito basico de pesquisa de mercado aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e comportamento do consumidor em Administracao?', 'Conceito basico de comportamento do consumidor aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e marca em Administracao?', 'Conceito basico de marca aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e canal de vendas em Administracao?', 'Conceito basico de canal de vendas aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e crm em Administracao?', 'Conceito basico de crm aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e empreendedorismo em Administracao?', 'Conceito basico de empreendedorismo aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e inovacao em Administracao?', 'Conceito basico de inovacao aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e logistica em Administracao?', 'Conceito basico de logistica aplicado a Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e gestao de projetos em Administracao?', 'Conceito basico de gestao de projetos aplicado a Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Definicoes e Terminologia (Auto)', 'Deck automatico de Administracao com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina planejamento estrategico no contexto de Administracao.', 'Definicao objetiva de planejamento estrategico para Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina organizacao no contexto de Administracao.', 'Definicao objetiva de organizacao para Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina lideranca no contexto de Administracao.', 'Definicao objetiva de lideranca para Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina controle no contexto de Administracao.', 'Definicao objetiva de controle para Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina gestao de pessoas no contexto de Administracao.', 'Definicao objetiva de gestao de pessoas para Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina financas no contexto de Administracao.', 'Definicao objetiva de financas para Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina fluxo de caixa no contexto de Administracao.', 'Definicao objetiva de fluxo de caixa para Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina custo e precificacao no contexto de Administracao.', 'Definicao objetiva de custo e precificacao para Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina economia micro no contexto de Administracao.', 'Definicao objetiva de economia micro para Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina economia macro no contexto de Administracao.', 'Definicao objetiva de economia macro para Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina oferta e demanda no contexto de Administracao.', 'Definicao objetiva de oferta e demanda para Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina inflacao no contexto de Administracao.', 'Definicao objetiva de inflacao para Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina politica monetaria no contexto de Administracao.', 'Definicao objetiva de politica monetaria para Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina contabilidade basica no contexto de Administracao.', 'Definicao objetiva de contabilidade basica para Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina balanco patrimonial no contexto de Administracao.', 'Definicao objetiva de balanco patrimonial para Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina dre no contexto de Administracao.', 'Definicao objetiva de dre para Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina capital de giro no contexto de Administracao.', 'Definicao objetiva de capital de giro para Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina indicadores no contexto de Administracao.', 'Definicao objetiva de indicadores para Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina marketing mix no contexto de Administracao.', 'Definicao objetiva de marketing mix para Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina segmentacao no contexto de Administracao.', 'Definicao objetiva de segmentacao para Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina posicionamento no contexto de Administracao.', 'Definicao objetiva de posicionamento para Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina pesquisa de mercado no contexto de Administracao.', 'Definicao objetiva de pesquisa de mercado para Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina comportamento do consumidor no contexto de Administracao.', 'Definicao objetiva de comportamento do consumidor para Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina marca no contexto de Administracao.', 'Definicao objetiva de marca para Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina canal de vendas no contexto de Administracao.', 'Definicao objetiva de canal de vendas para Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina crm no contexto de Administracao.', 'Definicao objetiva de crm para Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina empreendedorismo no contexto de Administracao.', 'Definicao objetiva de empreendedorismo para Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina inovacao no contexto de Administracao.', 'Definicao objetiva de inovacao para Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina logistica no contexto de Administracao.', 'Definicao objetiva de logistica para Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina gestao de projetos no contexto de Administracao.', 'Definicao objetiva de gestao de projetos para Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Processos e Aplicacoes (Auto)', 'Deck automatico de Administracao com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como planejamento estrategico se aplica em Administracao?', 'Resumo do processo de planejamento estrategico e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como organizacao se aplica em Administracao?', 'Resumo do processo de organizacao e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como lideranca se aplica em Administracao?', 'Resumo do processo de lideranca e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como controle se aplica em Administracao?', 'Resumo do processo de controle e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como gestao de pessoas se aplica em Administracao?', 'Resumo do processo de gestao de pessoas e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como financas se aplica em Administracao?', 'Resumo do processo de financas e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como fluxo de caixa se aplica em Administracao?', 'Resumo do processo de fluxo de caixa e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como custo e precificacao se aplica em Administracao?', 'Resumo do processo de custo e precificacao e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como economia micro se aplica em Administracao?', 'Resumo do processo de economia micro e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como economia macro se aplica em Administracao?', 'Resumo do processo de economia macro e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como oferta e demanda se aplica em Administracao?', 'Resumo do processo de oferta e demanda e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como inflacao se aplica em Administracao?', 'Resumo do processo de inflacao e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como politica monetaria se aplica em Administracao?', 'Resumo do processo de politica monetaria e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como contabilidade basica se aplica em Administracao?', 'Resumo do processo de contabilidade basica e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como balanco patrimonial se aplica em Administracao?', 'Resumo do processo de balanco patrimonial e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como dre se aplica em Administracao?', 'Resumo do processo de dre e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como capital de giro se aplica em Administracao?', 'Resumo do processo de capital de giro e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como indicadores se aplica em Administracao?', 'Resumo do processo de indicadores e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como marketing mix se aplica em Administracao?', 'Resumo do processo de marketing mix e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como segmentacao se aplica em Administracao?', 'Resumo do processo de segmentacao e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como posicionamento se aplica em Administracao?', 'Resumo do processo de posicionamento e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como pesquisa de mercado se aplica em Administracao?', 'Resumo do processo de pesquisa de mercado e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como comportamento do consumidor se aplica em Administracao?', 'Resumo do processo de comportamento do consumidor e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como marca se aplica em Administracao?', 'Resumo do processo de marca e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como canal de vendas se aplica em Administracao?', 'Resumo do processo de canal de vendas e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como crm se aplica em Administracao?', 'Resumo do processo de crm e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como empreendedorismo se aplica em Administracao?', 'Resumo do processo de empreendedorismo e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como inovacao se aplica em Administracao?', 'Resumo do processo de inovacao e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como logistica se aplica em Administracao?', 'Resumo do processo de logistica e sua aplicacao em Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como gestao de projetos se aplica em Administracao?', 'Resumo do processo de gestao de projetos e sua aplicacao em Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Regras e Principios (Auto)', 'Deck automatico de Administracao com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de planejamento estrategico em Administracao?', 'Principio central de planejamento estrategico usado em Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de organizacao em Administracao?', 'Principio central de organizacao usado em Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de lideranca em Administracao?', 'Principio central de lideranca usado em Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de controle em Administracao?', 'Principio central de controle usado em Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de gestao de pessoas em Administracao?', 'Principio central de gestao de pessoas usado em Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de financas em Administracao?', 'Principio central de financas usado em Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de fluxo de caixa em Administracao?', 'Principio central de fluxo de caixa usado em Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de custo e precificacao em Administracao?', 'Principio central de custo e precificacao usado em Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de economia micro em Administracao?', 'Principio central de economia micro usado em Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de economia macro em Administracao?', 'Principio central de economia macro usado em Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de oferta e demanda em Administracao?', 'Principio central de oferta e demanda usado em Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de inflacao em Administracao?', 'Principio central de inflacao usado em Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de politica monetaria em Administracao?', 'Principio central de politica monetaria usado em Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de contabilidade basica em Administracao?', 'Principio central de contabilidade basica usado em Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de balanco patrimonial em Administracao?', 'Principio central de balanco patrimonial usado em Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de dre em Administracao?', 'Principio central de dre usado em Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de capital de giro em Administracao?', 'Principio central de capital de giro usado em Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de indicadores em Administracao?', 'Principio central de indicadores usado em Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de marketing mix em Administracao?', 'Principio central de marketing mix usado em Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de segmentacao em Administracao?', 'Principio central de segmentacao usado em Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de posicionamento em Administracao?', 'Principio central de posicionamento usado em Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de pesquisa de mercado em Administracao?', 'Principio central de pesquisa de mercado usado em Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de comportamento do consumidor em Administracao?', 'Principio central de comportamento do consumidor usado em Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de marca em Administracao?', 'Principio central de marca usado em Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de canal de vendas em Administracao?', 'Principio central de canal de vendas usado em Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de crm em Administracao?', 'Principio central de crm usado em Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de empreendedorismo em Administracao?', 'Principio central de empreendedorismo usado em Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de inovacao em Administracao?', 'Principio central de inovacao usado em Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de logistica em Administracao?', 'Principio central de logistica usado em Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de gestao de projetos em Administracao?', 'Principio central de gestao de projetos usado em Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Resolucao de Problemas (Auto)', 'Deck automatico de Administracao com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar planejamento estrategico em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de planejamento estrategico e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar organizacao em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de organizacao e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar lideranca em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de lideranca e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar controle em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de controle e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar gestao de pessoas em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de gestao de pessoas e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar financas em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de financas e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar fluxo de caixa em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de fluxo de caixa e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar custo e precificacao em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de custo e precificacao e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar economia micro em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de economia micro e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar economia macro em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de economia macro e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar oferta e demanda em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de oferta e demanda e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar inflacao em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de inflacao e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar politica monetaria em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de politica monetaria e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar contabilidade basica em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de contabilidade basica e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar balanco patrimonial em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de balanco patrimonial e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar dre em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de dre e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar capital de giro em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de capital de giro e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar indicadores em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de indicadores e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar marketing mix em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de marketing mix e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar segmentacao em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de segmentacao e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar posicionamento em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de posicionamento e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar pesquisa de mercado em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de pesquisa de mercado e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar comportamento do consumidor em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de comportamento do consumidor e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar marca em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de marca e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar canal de vendas em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de canal de vendas e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar crm em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de crm e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar empreendedorismo em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de empreendedorismo e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar inovacao em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de inovacao e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar logistica em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de logistica e concluir no contexto de Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar gestao de projetos em Administracao?', 'Sequencia simples: identificar dados, aplicar regras de gestao de projetos e concluir no contexto de Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Erros Comuns e Dicas (Auto)', 'Deck automatico de Administracao com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com planejamento estrategico em Administracao?', 'Erro comum: confundir conceito ou etapa de planejamento estrategico; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com organizacao em Administracao?', 'Erro comum: confundir conceito ou etapa de organizacao; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com lideranca em Administracao?', 'Erro comum: confundir conceito ou etapa de lideranca; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com controle em Administracao?', 'Erro comum: confundir conceito ou etapa de controle; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com gestao de pessoas em Administracao?', 'Erro comum: confundir conceito ou etapa de gestao de pessoas; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com financas em Administracao?', 'Erro comum: confundir conceito ou etapa de financas; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com fluxo de caixa em Administracao?', 'Erro comum: confundir conceito ou etapa de fluxo de caixa; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com custo e precificacao em Administracao?', 'Erro comum: confundir conceito ou etapa de custo e precificacao; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com economia micro em Administracao?', 'Erro comum: confundir conceito ou etapa de economia micro; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com economia macro em Administracao?', 'Erro comum: confundir conceito ou etapa de economia macro; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com oferta e demanda em Administracao?', 'Erro comum: confundir conceito ou etapa de oferta e demanda; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com inflacao em Administracao?', 'Erro comum: confundir conceito ou etapa de inflacao; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com politica monetaria em Administracao?', 'Erro comum: confundir conceito ou etapa de politica monetaria; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com contabilidade basica em Administracao?', 'Erro comum: confundir conceito ou etapa de contabilidade basica; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com balanco patrimonial em Administracao?', 'Erro comum: confundir conceito ou etapa de balanco patrimonial; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com dre em Administracao?', 'Erro comum: confundir conceito ou etapa de dre; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com capital de giro em Administracao?', 'Erro comum: confundir conceito ou etapa de capital de giro; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com indicadores em Administracao?', 'Erro comum: confundir conceito ou etapa de indicadores; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com marketing mix em Administracao?', 'Erro comum: confundir conceito ou etapa de marketing mix; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com segmentacao em Administracao?', 'Erro comum: confundir conceito ou etapa de segmentacao; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com posicionamento em Administracao?', 'Erro comum: confundir conceito ou etapa de posicionamento; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com pesquisa de mercado em Administracao?', 'Erro comum: confundir conceito ou etapa de pesquisa de mercado; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com comportamento do consumidor em Administracao?', 'Erro comum: confundir conceito ou etapa de comportamento do consumidor; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com marca em Administracao?', 'Erro comum: confundir conceito ou etapa de marca; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com canal de vendas em Administracao?', 'Erro comum: confundir conceito ou etapa de canal de vendas; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com crm em Administracao?', 'Erro comum: confundir conceito ou etapa de crm; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com empreendedorismo em Administracao?', 'Erro comum: confundir conceito ou etapa de empreendedorismo; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com inovacao em Administracao?', 'Erro comum: confundir conceito ou etapa de inovacao; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com logistica em Administracao?', 'Erro comum: confundir conceito ou etapa de logistica; evite revisando definicoes e condicoes em Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com gestao de projetos em Administracao?', 'Erro comum: confundir conceito ou etapa de gestao de projetos; evite revisando definicoes e condicoes em Administracao.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Administracao - Revisao Rapida (Auto)', 'Deck automatico de Administracao com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['administracao', 'business', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: planejamento estrategico em Administracao.', 'Resumo: pontos essenciais de planejamento estrategico e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: organizacao em Administracao.', 'Resumo: pontos essenciais de organizacao e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: lideranca em Administracao.', 'Resumo: pontos essenciais de lideranca e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: controle em Administracao.', 'Resumo: pontos essenciais de controle e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: gestao de pessoas em Administracao.', 'Resumo: pontos essenciais de gestao de pessoas e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: financas em Administracao.', 'Resumo: pontos essenciais de financas e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: fluxo de caixa em Administracao.', 'Resumo: pontos essenciais de fluxo de caixa e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: custo e precificacao em Administracao.', 'Resumo: pontos essenciais de custo e precificacao e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: economia micro em Administracao.', 'Resumo: pontos essenciais de economia micro e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: economia macro em Administracao.', 'Resumo: pontos essenciais de economia macro e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: oferta e demanda em Administracao.', 'Resumo: pontos essenciais de oferta e demanda e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: inflacao em Administracao.', 'Resumo: pontos essenciais de inflacao e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: politica monetaria em Administracao.', 'Resumo: pontos essenciais de politica monetaria e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: contabilidade basica em Administracao.', 'Resumo: pontos essenciais de contabilidade basica e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: balanco patrimonial em Administracao.', 'Resumo: pontos essenciais de balanco patrimonial e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: dre em Administracao.', 'Resumo: pontos essenciais de dre e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: capital de giro em Administracao.', 'Resumo: pontos essenciais de capital de giro e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: indicadores em Administracao.', 'Resumo: pontos essenciais de indicadores e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: marketing mix em Administracao.', 'Resumo: pontos essenciais de marketing mix e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: segmentacao em Administracao.', 'Resumo: pontos essenciais de segmentacao e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: posicionamento em Administracao.', 'Resumo: pontos essenciais de posicionamento e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: pesquisa de mercado em Administracao.', 'Resumo: pontos essenciais de pesquisa de mercado e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: comportamento do consumidor em Administracao.', 'Resumo: pontos essenciais de comportamento do consumidor e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: marca em Administracao.', 'Resumo: pontos essenciais de marca e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: canal de vendas em Administracao.', 'Resumo: pontos essenciais de canal de vendas e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: crm em Administracao.', 'Resumo: pontos essenciais de crm e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: empreendedorismo em Administracao.', 'Resumo: pontos essenciais de empreendedorismo e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: inovacao em Administracao.', 'Resumo: pontos essenciais de inovacao e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: logistica em Administracao.', 'Resumo: pontos essenciais de logistica e sua utilidade em Administracao.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: gestao de projetos em Administracao.', 'Resumo: pontos essenciais de gestao de projetos e sua utilidade em Administracao.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Administracao';
END $$;
