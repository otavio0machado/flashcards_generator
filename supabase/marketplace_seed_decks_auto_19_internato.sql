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

  -- Internato
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/internato';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/ciencias-da-saude/medicina/internato'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Fundamentos e Conceitos (Auto)', 'Deck automatico de Internato com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e anatomia basica em Internato?', 'Conceito basico de anatomia basica aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e fisiologia basica em Internato?', 'Conceito basico de fisiologia basica aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e sinais vitais em Internato?', 'Conceito basico de sinais vitais aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e exame fisico em Internato?', 'Conceito basico de exame fisico aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e anamnese em Internato?', 'Conceito basico de anamnese aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e hipertensao em Internato?', 'Conceito basico de hipertensao aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e diabetes em Internato?', 'Conceito basico de diabetes aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e asma em Internato?', 'Conceito basico de asma aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e dpoc em Internato?', 'Conceito basico de dpoc aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e pneumonia em Internato?', 'Conceito basico de pneumonia aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e tuberculose em Internato?', 'Conceito basico de tuberculose aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e insuficiencia cardiaca em Internato?', 'Conceito basico de insuficiencia cardiaca aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e infarto em Internato?', 'Conceito basico de infarto aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e arritmias em Internato?', 'Conceito basico de arritmias aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e hepatites em Internato?', 'Conceito basico de hepatites aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e cirrose em Internato?', 'Conceito basico de cirrose aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e ulcera em Internato?', 'Conceito basico de ulcera aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e drge em Internato?', 'Conceito basico de drge aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e doencas renais em Internato?', 'Conceito basico de doencas renais aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e litiase renal em Internato?', 'Conceito basico de litiase renal aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e sepse em Internato?', 'Conceito basico de sepse aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e anemia em Internato?', 'Conceito basico de anemia aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e doencas infecciosas em Internato?', 'Conceito basico de doencas infecciosas aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e vacinas em Internato?', 'Conceito basico de vacinas aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e farmacologia basica em Internato?', 'Conceito basico de farmacologia basica aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e antibioticos em Internato?', 'Conceito basico de antibioticos aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e analgesicos em Internato?', 'Conceito basico de analgesicos aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e saude mental em Internato?', 'Conceito basico de saude mental aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e etica em saude em Internato?', 'Conceito basico de etica em saude aplicado a Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e seguranca do paciente em Internato?', 'Conceito basico de seguranca do paciente aplicado a Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Definicoes e Terminologia (Auto)', 'Deck automatico de Internato com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina anatomia basica no contexto de Internato.', 'Definicao objetiva de anatomia basica para Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina fisiologia basica no contexto de Internato.', 'Definicao objetiva de fisiologia basica para Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina sinais vitais no contexto de Internato.', 'Definicao objetiva de sinais vitais para Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina exame fisico no contexto de Internato.', 'Definicao objetiva de exame fisico para Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina anamnese no contexto de Internato.', 'Definicao objetiva de anamnese para Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina hipertensao no contexto de Internato.', 'Definicao objetiva de hipertensao para Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina diabetes no contexto de Internato.', 'Definicao objetiva de diabetes para Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina asma no contexto de Internato.', 'Definicao objetiva de asma para Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina dpoc no contexto de Internato.', 'Definicao objetiva de dpoc para Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina pneumonia no contexto de Internato.', 'Definicao objetiva de pneumonia para Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina tuberculose no contexto de Internato.', 'Definicao objetiva de tuberculose para Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina insuficiencia cardiaca no contexto de Internato.', 'Definicao objetiva de insuficiencia cardiaca para Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina infarto no contexto de Internato.', 'Definicao objetiva de infarto para Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina arritmias no contexto de Internato.', 'Definicao objetiva de arritmias para Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina hepatites no contexto de Internato.', 'Definicao objetiva de hepatites para Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina cirrose no contexto de Internato.', 'Definicao objetiva de cirrose para Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina ulcera no contexto de Internato.', 'Definicao objetiva de ulcera para Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina drge no contexto de Internato.', 'Definicao objetiva de drge para Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina doencas renais no contexto de Internato.', 'Definicao objetiva de doencas renais para Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina litiase renal no contexto de Internato.', 'Definicao objetiva de litiase renal para Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina sepse no contexto de Internato.', 'Definicao objetiva de sepse para Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina anemia no contexto de Internato.', 'Definicao objetiva de anemia para Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina doencas infecciosas no contexto de Internato.', 'Definicao objetiva de doencas infecciosas para Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina vacinas no contexto de Internato.', 'Definicao objetiva de vacinas para Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina farmacologia basica no contexto de Internato.', 'Definicao objetiva de farmacologia basica para Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina antibioticos no contexto de Internato.', 'Definicao objetiva de antibioticos para Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina analgesicos no contexto de Internato.', 'Definicao objetiva de analgesicos para Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina saude mental no contexto de Internato.', 'Definicao objetiva de saude mental para Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina etica em saude no contexto de Internato.', 'Definicao objetiva de etica em saude para Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina seguranca do paciente no contexto de Internato.', 'Definicao objetiva de seguranca do paciente para Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Processos e Aplicacoes (Auto)', 'Deck automatico de Internato com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como anatomia basica se aplica em Internato?', 'Resumo do processo de anatomia basica e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como fisiologia basica se aplica em Internato?', 'Resumo do processo de fisiologia basica e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como sinais vitais se aplica em Internato?', 'Resumo do processo de sinais vitais e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como exame fisico se aplica em Internato?', 'Resumo do processo de exame fisico e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como anamnese se aplica em Internato?', 'Resumo do processo de anamnese e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como hipertensao se aplica em Internato?', 'Resumo do processo de hipertensao e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como diabetes se aplica em Internato?', 'Resumo do processo de diabetes e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como asma se aplica em Internato?', 'Resumo do processo de asma e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como dpoc se aplica em Internato?', 'Resumo do processo de dpoc e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como pneumonia se aplica em Internato?', 'Resumo do processo de pneumonia e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como tuberculose se aplica em Internato?', 'Resumo do processo de tuberculose e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como insuficiencia cardiaca se aplica em Internato?', 'Resumo do processo de insuficiencia cardiaca e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como infarto se aplica em Internato?', 'Resumo do processo de infarto e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como arritmias se aplica em Internato?', 'Resumo do processo de arritmias e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como hepatites se aplica em Internato?', 'Resumo do processo de hepatites e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como cirrose se aplica em Internato?', 'Resumo do processo de cirrose e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como ulcera se aplica em Internato?', 'Resumo do processo de ulcera e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como drge se aplica em Internato?', 'Resumo do processo de drge e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como doencas renais se aplica em Internato?', 'Resumo do processo de doencas renais e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como litiase renal se aplica em Internato?', 'Resumo do processo de litiase renal e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como sepse se aplica em Internato?', 'Resumo do processo de sepse e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como anemia se aplica em Internato?', 'Resumo do processo de anemia e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como doencas infecciosas se aplica em Internato?', 'Resumo do processo de doencas infecciosas e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como vacinas se aplica em Internato?', 'Resumo do processo de vacinas e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como farmacologia basica se aplica em Internato?', 'Resumo do processo de farmacologia basica e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como antibioticos se aplica em Internato?', 'Resumo do processo de antibioticos e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como analgesicos se aplica em Internato?', 'Resumo do processo de analgesicos e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como saude mental se aplica em Internato?', 'Resumo do processo de saude mental e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como etica em saude se aplica em Internato?', 'Resumo do processo de etica em saude e sua aplicacao em Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como seguranca do paciente se aplica em Internato?', 'Resumo do processo de seguranca do paciente e sua aplicacao em Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Regras e Principios (Auto)', 'Deck automatico de Internato com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de anatomia basica em Internato?', 'Principio central de anatomia basica usado em Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de fisiologia basica em Internato?', 'Principio central de fisiologia basica usado em Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de sinais vitais em Internato?', 'Principio central de sinais vitais usado em Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de exame fisico em Internato?', 'Principio central de exame fisico usado em Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de anamnese em Internato?', 'Principio central de anamnese usado em Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de hipertensao em Internato?', 'Principio central de hipertensao usado em Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de diabetes em Internato?', 'Principio central de diabetes usado em Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de asma em Internato?', 'Principio central de asma usado em Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de dpoc em Internato?', 'Principio central de dpoc usado em Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de pneumonia em Internato?', 'Principio central de pneumonia usado em Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de tuberculose em Internato?', 'Principio central de tuberculose usado em Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de insuficiencia cardiaca em Internato?', 'Principio central de insuficiencia cardiaca usado em Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de infarto em Internato?', 'Principio central de infarto usado em Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de arritmias em Internato?', 'Principio central de arritmias usado em Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de hepatites em Internato?', 'Principio central de hepatites usado em Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de cirrose em Internato?', 'Principio central de cirrose usado em Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de ulcera em Internato?', 'Principio central de ulcera usado em Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de drge em Internato?', 'Principio central de drge usado em Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de doencas renais em Internato?', 'Principio central de doencas renais usado em Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de litiase renal em Internato?', 'Principio central de litiase renal usado em Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de sepse em Internato?', 'Principio central de sepse usado em Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de anemia em Internato?', 'Principio central de anemia usado em Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de doencas infecciosas em Internato?', 'Principio central de doencas infecciosas usado em Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de vacinas em Internato?', 'Principio central de vacinas usado em Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de farmacologia basica em Internato?', 'Principio central de farmacologia basica usado em Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de antibioticos em Internato?', 'Principio central de antibioticos usado em Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de analgesicos em Internato?', 'Principio central de analgesicos usado em Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de saude mental em Internato?', 'Principio central de saude mental usado em Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de etica em saude em Internato?', 'Principio central de etica em saude usado em Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de seguranca do paciente em Internato?', 'Principio central de seguranca do paciente usado em Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Resolucao de Problemas (Auto)', 'Deck automatico de Internato com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar anatomia basica em Internato?', 'Sequencia simples: identificar dados, aplicar regras de anatomia basica e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar fisiologia basica em Internato?', 'Sequencia simples: identificar dados, aplicar regras de fisiologia basica e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar sinais vitais em Internato?', 'Sequencia simples: identificar dados, aplicar regras de sinais vitais e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar exame fisico em Internato?', 'Sequencia simples: identificar dados, aplicar regras de exame fisico e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar anamnese em Internato?', 'Sequencia simples: identificar dados, aplicar regras de anamnese e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar hipertensao em Internato?', 'Sequencia simples: identificar dados, aplicar regras de hipertensao e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar diabetes em Internato?', 'Sequencia simples: identificar dados, aplicar regras de diabetes e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar asma em Internato?', 'Sequencia simples: identificar dados, aplicar regras de asma e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar dpoc em Internato?', 'Sequencia simples: identificar dados, aplicar regras de dpoc e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar pneumonia em Internato?', 'Sequencia simples: identificar dados, aplicar regras de pneumonia e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar tuberculose em Internato?', 'Sequencia simples: identificar dados, aplicar regras de tuberculose e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar insuficiencia cardiaca em Internato?', 'Sequencia simples: identificar dados, aplicar regras de insuficiencia cardiaca e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar infarto em Internato?', 'Sequencia simples: identificar dados, aplicar regras de infarto e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar arritmias em Internato?', 'Sequencia simples: identificar dados, aplicar regras de arritmias e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar hepatites em Internato?', 'Sequencia simples: identificar dados, aplicar regras de hepatites e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar cirrose em Internato?', 'Sequencia simples: identificar dados, aplicar regras de cirrose e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar ulcera em Internato?', 'Sequencia simples: identificar dados, aplicar regras de ulcera e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar drge em Internato?', 'Sequencia simples: identificar dados, aplicar regras de drge e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar doencas renais em Internato?', 'Sequencia simples: identificar dados, aplicar regras de doencas renais e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar litiase renal em Internato?', 'Sequencia simples: identificar dados, aplicar regras de litiase renal e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar sepse em Internato?', 'Sequencia simples: identificar dados, aplicar regras de sepse e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar anemia em Internato?', 'Sequencia simples: identificar dados, aplicar regras de anemia e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar doencas infecciosas em Internato?', 'Sequencia simples: identificar dados, aplicar regras de doencas infecciosas e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar vacinas em Internato?', 'Sequencia simples: identificar dados, aplicar regras de vacinas e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar farmacologia basica em Internato?', 'Sequencia simples: identificar dados, aplicar regras de farmacologia basica e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar antibioticos em Internato?', 'Sequencia simples: identificar dados, aplicar regras de antibioticos e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar analgesicos em Internato?', 'Sequencia simples: identificar dados, aplicar regras de analgesicos e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar saude mental em Internato?', 'Sequencia simples: identificar dados, aplicar regras de saude mental e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar etica em saude em Internato?', 'Sequencia simples: identificar dados, aplicar regras de etica em saude e concluir no contexto de Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar seguranca do paciente em Internato?', 'Sequencia simples: identificar dados, aplicar regras de seguranca do paciente e concluir no contexto de Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Erros Comuns e Dicas (Auto)', 'Deck automatico de Internato com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com anatomia basica em Internato?', 'Erro comum: confundir conceito ou etapa de anatomia basica; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com fisiologia basica em Internato?', 'Erro comum: confundir conceito ou etapa de fisiologia basica; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com sinais vitais em Internato?', 'Erro comum: confundir conceito ou etapa de sinais vitais; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com exame fisico em Internato?', 'Erro comum: confundir conceito ou etapa de exame fisico; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com anamnese em Internato?', 'Erro comum: confundir conceito ou etapa de anamnese; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com hipertensao em Internato?', 'Erro comum: confundir conceito ou etapa de hipertensao; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com diabetes em Internato?', 'Erro comum: confundir conceito ou etapa de diabetes; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com asma em Internato?', 'Erro comum: confundir conceito ou etapa de asma; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com dpoc em Internato?', 'Erro comum: confundir conceito ou etapa de dpoc; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com pneumonia em Internato?', 'Erro comum: confundir conceito ou etapa de pneumonia; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com tuberculose em Internato?', 'Erro comum: confundir conceito ou etapa de tuberculose; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com insuficiencia cardiaca em Internato?', 'Erro comum: confundir conceito ou etapa de insuficiencia cardiaca; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com infarto em Internato?', 'Erro comum: confundir conceito ou etapa de infarto; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com arritmias em Internato?', 'Erro comum: confundir conceito ou etapa de arritmias; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com hepatites em Internato?', 'Erro comum: confundir conceito ou etapa de hepatites; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com cirrose em Internato?', 'Erro comum: confundir conceito ou etapa de cirrose; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com ulcera em Internato?', 'Erro comum: confundir conceito ou etapa de ulcera; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com drge em Internato?', 'Erro comum: confundir conceito ou etapa de drge; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com doencas renais em Internato?', 'Erro comum: confundir conceito ou etapa de doencas renais; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com litiase renal em Internato?', 'Erro comum: confundir conceito ou etapa de litiase renal; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com sepse em Internato?', 'Erro comum: confundir conceito ou etapa de sepse; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com anemia em Internato?', 'Erro comum: confundir conceito ou etapa de anemia; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com doencas infecciosas em Internato?', 'Erro comum: confundir conceito ou etapa de doencas infecciosas; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com vacinas em Internato?', 'Erro comum: confundir conceito ou etapa de vacinas; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com farmacologia basica em Internato?', 'Erro comum: confundir conceito ou etapa de farmacologia basica; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com antibioticos em Internato?', 'Erro comum: confundir conceito ou etapa de antibioticos; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com analgesicos em Internato?', 'Erro comum: confundir conceito ou etapa de analgesicos; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com saude mental em Internato?', 'Erro comum: confundir conceito ou etapa de saude mental; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com etica em saude em Internato?', 'Erro comum: confundir conceito ou etapa de etica em saude; evite revisando definicoes e condicoes em Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com seguranca do paciente em Internato?', 'Erro comum: confundir conceito ou etapa de seguranca do paciente; evite revisando definicoes e condicoes em Internato.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Internato - Revisao Rapida (Auto)', 'Deck automatico de Internato com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['internato', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: anatomia basica em Internato.', 'Resumo: pontos essenciais de anatomia basica e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: fisiologia basica em Internato.', 'Resumo: pontos essenciais de fisiologia basica e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: sinais vitais em Internato.', 'Resumo: pontos essenciais de sinais vitais e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: exame fisico em Internato.', 'Resumo: pontos essenciais de exame fisico e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: anamnese em Internato.', 'Resumo: pontos essenciais de anamnese e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: hipertensao em Internato.', 'Resumo: pontos essenciais de hipertensao e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: diabetes em Internato.', 'Resumo: pontos essenciais de diabetes e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: asma em Internato.', 'Resumo: pontos essenciais de asma e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: dpoc em Internato.', 'Resumo: pontos essenciais de dpoc e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: pneumonia em Internato.', 'Resumo: pontos essenciais de pneumonia e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: tuberculose em Internato.', 'Resumo: pontos essenciais de tuberculose e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: insuficiencia cardiaca em Internato.', 'Resumo: pontos essenciais de insuficiencia cardiaca e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: infarto em Internato.', 'Resumo: pontos essenciais de infarto e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: arritmias em Internato.', 'Resumo: pontos essenciais de arritmias e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: hepatites em Internato.', 'Resumo: pontos essenciais de hepatites e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: cirrose em Internato.', 'Resumo: pontos essenciais de cirrose e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: ulcera em Internato.', 'Resumo: pontos essenciais de ulcera e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: drge em Internato.', 'Resumo: pontos essenciais de drge e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: doencas renais em Internato.', 'Resumo: pontos essenciais de doencas renais e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: litiase renal em Internato.', 'Resumo: pontos essenciais de litiase renal e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: sepse em Internato.', 'Resumo: pontos essenciais de sepse e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: anemia em Internato.', 'Resumo: pontos essenciais de anemia e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: doencas infecciosas em Internato.', 'Resumo: pontos essenciais de doencas infecciosas e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: vacinas em Internato.', 'Resumo: pontos essenciais de vacinas e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: farmacologia basica em Internato.', 'Resumo: pontos essenciais de farmacologia basica e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: antibioticos em Internato.', 'Resumo: pontos essenciais de antibioticos e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: analgesicos em Internato.', 'Resumo: pontos essenciais de analgesicos e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: saude mental em Internato.', 'Resumo: pontos essenciais de saude mental e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: etica em saude em Internato.', 'Resumo: pontos essenciais de etica em saude e sua utilidade em Internato.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: seguranca do paciente em Internato.', 'Resumo: pontos essenciais de seguranca do paciente e sua utilidade em Internato.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Internato';
END $$;
