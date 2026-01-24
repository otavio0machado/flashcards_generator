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

  -- Fisiologia
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico/fisiologia';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/ciencias-da-saude/medicina/ciclo-basico/fisiologia'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Fundamentos e Conceitos (Auto)', 'Deck automatico de Fisiologia com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e anatomia basica em Fisiologia?', 'Conceito basico de anatomia basica aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e fisiologia basica em Fisiologia?', 'Conceito basico de fisiologia basica aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e sinais vitais em Fisiologia?', 'Conceito basico de sinais vitais aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e exame fisico em Fisiologia?', 'Conceito basico de exame fisico aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e anamnese em Fisiologia?', 'Conceito basico de anamnese aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e hipertensao em Fisiologia?', 'Conceito basico de hipertensao aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e diabetes em Fisiologia?', 'Conceito basico de diabetes aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e asma em Fisiologia?', 'Conceito basico de asma aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e dpoc em Fisiologia?', 'Conceito basico de dpoc aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e pneumonia em Fisiologia?', 'Conceito basico de pneumonia aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e tuberculose em Fisiologia?', 'Conceito basico de tuberculose aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e insuficiencia cardiaca em Fisiologia?', 'Conceito basico de insuficiencia cardiaca aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e infarto em Fisiologia?', 'Conceito basico de infarto aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e arritmias em Fisiologia?', 'Conceito basico de arritmias aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e hepatites em Fisiologia?', 'Conceito basico de hepatites aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e cirrose em Fisiologia?', 'Conceito basico de cirrose aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e ulcera em Fisiologia?', 'Conceito basico de ulcera aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e drge em Fisiologia?', 'Conceito basico de drge aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e doencas renais em Fisiologia?', 'Conceito basico de doencas renais aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e litiase renal em Fisiologia?', 'Conceito basico de litiase renal aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e sepse em Fisiologia?', 'Conceito basico de sepse aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e anemia em Fisiologia?', 'Conceito basico de anemia aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e doencas infecciosas em Fisiologia?', 'Conceito basico de doencas infecciosas aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e vacinas em Fisiologia?', 'Conceito basico de vacinas aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e farmacologia basica em Fisiologia?', 'Conceito basico de farmacologia basica aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e antibioticos em Fisiologia?', 'Conceito basico de antibioticos aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e analgesicos em Fisiologia?', 'Conceito basico de analgesicos aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e saude mental em Fisiologia?', 'Conceito basico de saude mental aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e etica em saude em Fisiologia?', 'Conceito basico de etica em saude aplicado a Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e seguranca do paciente em Fisiologia?', 'Conceito basico de seguranca do paciente aplicado a Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Definicoes e Terminologia (Auto)', 'Deck automatico de Fisiologia com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina anatomia basica no contexto de Fisiologia.', 'Definicao objetiva de anatomia basica para Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina fisiologia basica no contexto de Fisiologia.', 'Definicao objetiva de fisiologia basica para Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina sinais vitais no contexto de Fisiologia.', 'Definicao objetiva de sinais vitais para Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina exame fisico no contexto de Fisiologia.', 'Definicao objetiva de exame fisico para Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina anamnese no contexto de Fisiologia.', 'Definicao objetiva de anamnese para Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina hipertensao no contexto de Fisiologia.', 'Definicao objetiva de hipertensao para Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina diabetes no contexto de Fisiologia.', 'Definicao objetiva de diabetes para Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina asma no contexto de Fisiologia.', 'Definicao objetiva de asma para Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina dpoc no contexto de Fisiologia.', 'Definicao objetiva de dpoc para Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina pneumonia no contexto de Fisiologia.', 'Definicao objetiva de pneumonia para Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina tuberculose no contexto de Fisiologia.', 'Definicao objetiva de tuberculose para Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina insuficiencia cardiaca no contexto de Fisiologia.', 'Definicao objetiva de insuficiencia cardiaca para Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina infarto no contexto de Fisiologia.', 'Definicao objetiva de infarto para Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina arritmias no contexto de Fisiologia.', 'Definicao objetiva de arritmias para Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina hepatites no contexto de Fisiologia.', 'Definicao objetiva de hepatites para Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina cirrose no contexto de Fisiologia.', 'Definicao objetiva de cirrose para Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina ulcera no contexto de Fisiologia.', 'Definicao objetiva de ulcera para Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina drge no contexto de Fisiologia.', 'Definicao objetiva de drge para Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina doencas renais no contexto de Fisiologia.', 'Definicao objetiva de doencas renais para Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina litiase renal no contexto de Fisiologia.', 'Definicao objetiva de litiase renal para Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina sepse no contexto de Fisiologia.', 'Definicao objetiva de sepse para Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina anemia no contexto de Fisiologia.', 'Definicao objetiva de anemia para Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina doencas infecciosas no contexto de Fisiologia.', 'Definicao objetiva de doencas infecciosas para Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina vacinas no contexto de Fisiologia.', 'Definicao objetiva de vacinas para Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina farmacologia basica no contexto de Fisiologia.', 'Definicao objetiva de farmacologia basica para Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina antibioticos no contexto de Fisiologia.', 'Definicao objetiva de antibioticos para Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina analgesicos no contexto de Fisiologia.', 'Definicao objetiva de analgesicos para Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina saude mental no contexto de Fisiologia.', 'Definicao objetiva de saude mental para Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina etica em saude no contexto de Fisiologia.', 'Definicao objetiva de etica em saude para Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina seguranca do paciente no contexto de Fisiologia.', 'Definicao objetiva de seguranca do paciente para Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Processos e Aplicacoes (Auto)', 'Deck automatico de Fisiologia com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como anatomia basica se aplica em Fisiologia?', 'Resumo do processo de anatomia basica e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como fisiologia basica se aplica em Fisiologia?', 'Resumo do processo de fisiologia basica e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como sinais vitais se aplica em Fisiologia?', 'Resumo do processo de sinais vitais e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como exame fisico se aplica em Fisiologia?', 'Resumo do processo de exame fisico e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como anamnese se aplica em Fisiologia?', 'Resumo do processo de anamnese e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como hipertensao se aplica em Fisiologia?', 'Resumo do processo de hipertensao e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como diabetes se aplica em Fisiologia?', 'Resumo do processo de diabetes e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como asma se aplica em Fisiologia?', 'Resumo do processo de asma e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como dpoc se aplica em Fisiologia?', 'Resumo do processo de dpoc e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como pneumonia se aplica em Fisiologia?', 'Resumo do processo de pneumonia e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como tuberculose se aplica em Fisiologia?', 'Resumo do processo de tuberculose e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como insuficiencia cardiaca se aplica em Fisiologia?', 'Resumo do processo de insuficiencia cardiaca e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como infarto se aplica em Fisiologia?', 'Resumo do processo de infarto e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como arritmias se aplica em Fisiologia?', 'Resumo do processo de arritmias e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como hepatites se aplica em Fisiologia?', 'Resumo do processo de hepatites e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como cirrose se aplica em Fisiologia?', 'Resumo do processo de cirrose e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como ulcera se aplica em Fisiologia?', 'Resumo do processo de ulcera e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como drge se aplica em Fisiologia?', 'Resumo do processo de drge e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como doencas renais se aplica em Fisiologia?', 'Resumo do processo de doencas renais e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como litiase renal se aplica em Fisiologia?', 'Resumo do processo de litiase renal e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como sepse se aplica em Fisiologia?', 'Resumo do processo de sepse e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como anemia se aplica em Fisiologia?', 'Resumo do processo de anemia e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como doencas infecciosas se aplica em Fisiologia?', 'Resumo do processo de doencas infecciosas e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como vacinas se aplica em Fisiologia?', 'Resumo do processo de vacinas e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como farmacologia basica se aplica em Fisiologia?', 'Resumo do processo de farmacologia basica e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como antibioticos se aplica em Fisiologia?', 'Resumo do processo de antibioticos e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como analgesicos se aplica em Fisiologia?', 'Resumo do processo de analgesicos e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como saude mental se aplica em Fisiologia?', 'Resumo do processo de saude mental e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como etica em saude se aplica em Fisiologia?', 'Resumo do processo de etica em saude e sua aplicacao em Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como seguranca do paciente se aplica em Fisiologia?', 'Resumo do processo de seguranca do paciente e sua aplicacao em Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Regras e Principios (Auto)', 'Deck automatico de Fisiologia com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de anatomia basica em Fisiologia?', 'Principio central de anatomia basica usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de fisiologia basica em Fisiologia?', 'Principio central de fisiologia basica usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de sinais vitais em Fisiologia?', 'Principio central de sinais vitais usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de exame fisico em Fisiologia?', 'Principio central de exame fisico usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de anamnese em Fisiologia?', 'Principio central de anamnese usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de hipertensao em Fisiologia?', 'Principio central de hipertensao usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de diabetes em Fisiologia?', 'Principio central de diabetes usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de asma em Fisiologia?', 'Principio central de asma usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de dpoc em Fisiologia?', 'Principio central de dpoc usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de pneumonia em Fisiologia?', 'Principio central de pneumonia usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de tuberculose em Fisiologia?', 'Principio central de tuberculose usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de insuficiencia cardiaca em Fisiologia?', 'Principio central de insuficiencia cardiaca usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de infarto em Fisiologia?', 'Principio central de infarto usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de arritmias em Fisiologia?', 'Principio central de arritmias usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de hepatites em Fisiologia?', 'Principio central de hepatites usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de cirrose em Fisiologia?', 'Principio central de cirrose usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de ulcera em Fisiologia?', 'Principio central de ulcera usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de drge em Fisiologia?', 'Principio central de drge usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de doencas renais em Fisiologia?', 'Principio central de doencas renais usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de litiase renal em Fisiologia?', 'Principio central de litiase renal usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de sepse em Fisiologia?', 'Principio central de sepse usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de anemia em Fisiologia?', 'Principio central de anemia usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de doencas infecciosas em Fisiologia?', 'Principio central de doencas infecciosas usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de vacinas em Fisiologia?', 'Principio central de vacinas usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de farmacologia basica em Fisiologia?', 'Principio central de farmacologia basica usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de antibioticos em Fisiologia?', 'Principio central de antibioticos usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de analgesicos em Fisiologia?', 'Principio central de analgesicos usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de saude mental em Fisiologia?', 'Principio central de saude mental usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de etica em saude em Fisiologia?', 'Principio central de etica em saude usado em Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de seguranca do paciente em Fisiologia?', 'Principio central de seguranca do paciente usado em Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Resolucao de Problemas (Auto)', 'Deck automatico de Fisiologia com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar anatomia basica em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de anatomia basica e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar fisiologia basica em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de fisiologia basica e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar sinais vitais em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de sinais vitais e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar exame fisico em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de exame fisico e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar anamnese em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de anamnese e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar hipertensao em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de hipertensao e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar diabetes em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de diabetes e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar asma em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de asma e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar dpoc em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de dpoc e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar pneumonia em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de pneumonia e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar tuberculose em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de tuberculose e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar insuficiencia cardiaca em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de insuficiencia cardiaca e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar infarto em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de infarto e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar arritmias em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de arritmias e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar hepatites em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de hepatites e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar cirrose em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de cirrose e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar ulcera em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de ulcera e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar drge em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de drge e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar doencas renais em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de doencas renais e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar litiase renal em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de litiase renal e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar sepse em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de sepse e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar anemia em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de anemia e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar doencas infecciosas em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de doencas infecciosas e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar vacinas em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de vacinas e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar farmacologia basica em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de farmacologia basica e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar antibioticos em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de antibioticos e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar analgesicos em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de analgesicos e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar saude mental em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de saude mental e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar etica em saude em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de etica em saude e concluir no contexto de Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar seguranca do paciente em Fisiologia?', 'Sequencia simples: identificar dados, aplicar regras de seguranca do paciente e concluir no contexto de Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Erros Comuns e Dicas (Auto)', 'Deck automatico de Fisiologia com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com anatomia basica em Fisiologia?', 'Erro comum: confundir conceito ou etapa de anatomia basica; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com fisiologia basica em Fisiologia?', 'Erro comum: confundir conceito ou etapa de fisiologia basica; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com sinais vitais em Fisiologia?', 'Erro comum: confundir conceito ou etapa de sinais vitais; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com exame fisico em Fisiologia?', 'Erro comum: confundir conceito ou etapa de exame fisico; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com anamnese em Fisiologia?', 'Erro comum: confundir conceito ou etapa de anamnese; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com hipertensao em Fisiologia?', 'Erro comum: confundir conceito ou etapa de hipertensao; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com diabetes em Fisiologia?', 'Erro comum: confundir conceito ou etapa de diabetes; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com asma em Fisiologia?', 'Erro comum: confundir conceito ou etapa de asma; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com dpoc em Fisiologia?', 'Erro comum: confundir conceito ou etapa de dpoc; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com pneumonia em Fisiologia?', 'Erro comum: confundir conceito ou etapa de pneumonia; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com tuberculose em Fisiologia?', 'Erro comum: confundir conceito ou etapa de tuberculose; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com insuficiencia cardiaca em Fisiologia?', 'Erro comum: confundir conceito ou etapa de insuficiencia cardiaca; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com infarto em Fisiologia?', 'Erro comum: confundir conceito ou etapa de infarto; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com arritmias em Fisiologia?', 'Erro comum: confundir conceito ou etapa de arritmias; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com hepatites em Fisiologia?', 'Erro comum: confundir conceito ou etapa de hepatites; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com cirrose em Fisiologia?', 'Erro comum: confundir conceito ou etapa de cirrose; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com ulcera em Fisiologia?', 'Erro comum: confundir conceito ou etapa de ulcera; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com drge em Fisiologia?', 'Erro comum: confundir conceito ou etapa de drge; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com doencas renais em Fisiologia?', 'Erro comum: confundir conceito ou etapa de doencas renais; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com litiase renal em Fisiologia?', 'Erro comum: confundir conceito ou etapa de litiase renal; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com sepse em Fisiologia?', 'Erro comum: confundir conceito ou etapa de sepse; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com anemia em Fisiologia?', 'Erro comum: confundir conceito ou etapa de anemia; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com doencas infecciosas em Fisiologia?', 'Erro comum: confundir conceito ou etapa de doencas infecciosas; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com vacinas em Fisiologia?', 'Erro comum: confundir conceito ou etapa de vacinas; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com farmacologia basica em Fisiologia?', 'Erro comum: confundir conceito ou etapa de farmacologia basica; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com antibioticos em Fisiologia?', 'Erro comum: confundir conceito ou etapa de antibioticos; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com analgesicos em Fisiologia?', 'Erro comum: confundir conceito ou etapa de analgesicos; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com saude mental em Fisiologia?', 'Erro comum: confundir conceito ou etapa de saude mental; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com etica em saude em Fisiologia?', 'Erro comum: confundir conceito ou etapa de etica em saude; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com seguranca do paciente em Fisiologia?', 'Erro comum: confundir conceito ou etapa de seguranca do paciente; evite revisando definicoes e condicoes em Fisiologia.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia - Revisao Rapida (Auto)', 'Deck automatico de Fisiologia com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['fisiologia', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: anatomia basica em Fisiologia.', 'Resumo: pontos essenciais de anatomia basica e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: fisiologia basica em Fisiologia.', 'Resumo: pontos essenciais de fisiologia basica e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: sinais vitais em Fisiologia.', 'Resumo: pontos essenciais de sinais vitais e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: exame fisico em Fisiologia.', 'Resumo: pontos essenciais de exame fisico e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: anamnese em Fisiologia.', 'Resumo: pontos essenciais de anamnese e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: hipertensao em Fisiologia.', 'Resumo: pontos essenciais de hipertensao e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: diabetes em Fisiologia.', 'Resumo: pontos essenciais de diabetes e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: asma em Fisiologia.', 'Resumo: pontos essenciais de asma e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: dpoc em Fisiologia.', 'Resumo: pontos essenciais de dpoc e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: pneumonia em Fisiologia.', 'Resumo: pontos essenciais de pneumonia e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: tuberculose em Fisiologia.', 'Resumo: pontos essenciais de tuberculose e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: insuficiencia cardiaca em Fisiologia.', 'Resumo: pontos essenciais de insuficiencia cardiaca e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: infarto em Fisiologia.', 'Resumo: pontos essenciais de infarto e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: arritmias em Fisiologia.', 'Resumo: pontos essenciais de arritmias e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: hepatites em Fisiologia.', 'Resumo: pontos essenciais de hepatites e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: cirrose em Fisiologia.', 'Resumo: pontos essenciais de cirrose e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: ulcera em Fisiologia.', 'Resumo: pontos essenciais de ulcera e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: drge em Fisiologia.', 'Resumo: pontos essenciais de drge e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: doencas renais em Fisiologia.', 'Resumo: pontos essenciais de doencas renais e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: litiase renal em Fisiologia.', 'Resumo: pontos essenciais de litiase renal e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: sepse em Fisiologia.', 'Resumo: pontos essenciais de sepse e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: anemia em Fisiologia.', 'Resumo: pontos essenciais de anemia e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: doencas infecciosas em Fisiologia.', 'Resumo: pontos essenciais de doencas infecciosas e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: vacinas em Fisiologia.', 'Resumo: pontos essenciais de vacinas e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: farmacologia basica em Fisiologia.', 'Resumo: pontos essenciais de farmacologia basica e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: antibioticos em Fisiologia.', 'Resumo: pontos essenciais de antibioticos e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: analgesicos em Fisiologia.', 'Resumo: pontos essenciais de analgesicos e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: saude mental em Fisiologia.', 'Resumo: pontos essenciais de saude mental e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: etica em saude em Fisiologia.', 'Resumo: pontos essenciais de etica em saude e sua utilidade em Fisiologia.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: seguranca do paciente em Fisiologia.', 'Resumo: pontos essenciais de seguranca do paciente e sua utilidade em Fisiologia.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Fisiologia';
END $$;
