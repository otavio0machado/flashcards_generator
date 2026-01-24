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

  -- Ciclo Clinico
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/ciclo-clinico';
  IF v_cat_id IS NULL THEN RAISE EXCEPTION 'Categoria nao encontrada: ensino-superior/ciencias-da-saude/medicina/ciclo-clinico'; END IF;

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Fundamentos e Conceitos (Auto)', 'Deck automatico de Ciclo Clinico com foco em fundamentos e conceitos.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que e anatomia basica em Ciclo Clinico?', 'Conceito basico de anatomia basica aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'O que e fisiologia basica em Ciclo Clinico?', 'Conceito basico de fisiologia basica aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'O que e sinais vitais em Ciclo Clinico?', 'Conceito basico de sinais vitais aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'O que e exame fisico em Ciclo Clinico?', 'Conceito basico de exame fisico aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'O que e anamnese em Ciclo Clinico?', 'Conceito basico de anamnese aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'O que e hipertensao em Ciclo Clinico?', 'Conceito basico de hipertensao aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'O que e diabetes em Ciclo Clinico?', 'Conceito basico de diabetes aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'O que e asma em Ciclo Clinico?', 'Conceito basico de asma aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'O que e dpoc em Ciclo Clinico?', 'Conceito basico de dpoc aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'O que e pneumonia em Ciclo Clinico?', 'Conceito basico de pneumonia aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'O que e tuberculose em Ciclo Clinico?', 'Conceito basico de tuberculose aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'O que e insuficiencia cardiaca em Ciclo Clinico?', 'Conceito basico de insuficiencia cardiaca aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'O que e infarto em Ciclo Clinico?', 'Conceito basico de infarto aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'O que e arritmias em Ciclo Clinico?', 'Conceito basico de arritmias aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'O que e hepatites em Ciclo Clinico?', 'Conceito basico de hepatites aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'O que e cirrose em Ciclo Clinico?', 'Conceito basico de cirrose aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'O que e ulcera em Ciclo Clinico?', 'Conceito basico de ulcera aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'O que e drge em Ciclo Clinico?', 'Conceito basico de drge aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'O que e doencas renais em Ciclo Clinico?', 'Conceito basico de doencas renais aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'O que e litiase renal em Ciclo Clinico?', 'Conceito basico de litiase renal aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'O que e sepse em Ciclo Clinico?', 'Conceito basico de sepse aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'O que e anemia em Ciclo Clinico?', 'Conceito basico de anemia aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'O que e doencas infecciosas em Ciclo Clinico?', 'Conceito basico de doencas infecciosas aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'O que e vacinas em Ciclo Clinico?', 'Conceito basico de vacinas aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'O que e farmacologia basica em Ciclo Clinico?', 'Conceito basico de farmacologia basica aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'O que e antibioticos em Ciclo Clinico?', 'Conceito basico de antibioticos aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'O que e analgesicos em Ciclo Clinico?', 'Conceito basico de analgesicos aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'O que e saude mental em Ciclo Clinico?', 'Conceito basico de saude mental aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'O que e etica em saude em Ciclo Clinico?', 'Conceito basico de etica em saude aplicado a Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'O que e seguranca do paciente em Ciclo Clinico?', 'Conceito basico de seguranca do paciente aplicado a Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Definicoes e Terminologia (Auto)', 'Deck automatico de Ciclo Clinico com foco em definicoes e terminologia.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Defina anatomia basica no contexto de Ciclo Clinico.', 'Definicao objetiva de anatomia basica para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Defina fisiologia basica no contexto de Ciclo Clinico.', 'Definicao objetiva de fisiologia basica para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Defina sinais vitais no contexto de Ciclo Clinico.', 'Definicao objetiva de sinais vitais para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Defina exame fisico no contexto de Ciclo Clinico.', 'Definicao objetiva de exame fisico para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Defina anamnese no contexto de Ciclo Clinico.', 'Definicao objetiva de anamnese para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Defina hipertensao no contexto de Ciclo Clinico.', 'Definicao objetiva de hipertensao para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Defina diabetes no contexto de Ciclo Clinico.', 'Definicao objetiva de diabetes para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Defina asma no contexto de Ciclo Clinico.', 'Definicao objetiva de asma para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Defina dpoc no contexto de Ciclo Clinico.', 'Definicao objetiva de dpoc para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Defina pneumonia no contexto de Ciclo Clinico.', 'Definicao objetiva de pneumonia para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Defina tuberculose no contexto de Ciclo Clinico.', 'Definicao objetiva de tuberculose para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Defina insuficiencia cardiaca no contexto de Ciclo Clinico.', 'Definicao objetiva de insuficiencia cardiaca para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Defina infarto no contexto de Ciclo Clinico.', 'Definicao objetiva de infarto para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Defina arritmias no contexto de Ciclo Clinico.', 'Definicao objetiva de arritmias para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Defina hepatites no contexto de Ciclo Clinico.', 'Definicao objetiva de hepatites para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Defina cirrose no contexto de Ciclo Clinico.', 'Definicao objetiva de cirrose para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Defina ulcera no contexto de Ciclo Clinico.', 'Definicao objetiva de ulcera para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Defina drge no contexto de Ciclo Clinico.', 'Definicao objetiva de drge para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Defina doencas renais no contexto de Ciclo Clinico.', 'Definicao objetiva de doencas renais para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Defina litiase renal no contexto de Ciclo Clinico.', 'Definicao objetiva de litiase renal para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Defina sepse no contexto de Ciclo Clinico.', 'Definicao objetiva de sepse para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Defina anemia no contexto de Ciclo Clinico.', 'Definicao objetiva de anemia para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Defina doencas infecciosas no contexto de Ciclo Clinico.', 'Definicao objetiva de doencas infecciosas para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Defina vacinas no contexto de Ciclo Clinico.', 'Definicao objetiva de vacinas para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Defina farmacologia basica no contexto de Ciclo Clinico.', 'Definicao objetiva de farmacologia basica para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Defina antibioticos no contexto de Ciclo Clinico.', 'Definicao objetiva de antibioticos para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Defina analgesicos no contexto de Ciclo Clinico.', 'Definicao objetiva de analgesicos para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Defina saude mental no contexto de Ciclo Clinico.', 'Definicao objetiva de saude mental para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Defina etica em saude no contexto de Ciclo Clinico.', 'Definicao objetiva de etica em saude para Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Defina seguranca do paciente no contexto de Ciclo Clinico.', 'Definicao objetiva de seguranca do paciente para Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Processos e Aplicacoes (Auto)', 'Deck automatico de Ciclo Clinico com foco em processos e aplicacoes.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Como anatomia basica se aplica em Ciclo Clinico?', 'Resumo do processo de anatomia basica e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Como fisiologia basica se aplica em Ciclo Clinico?', 'Resumo do processo de fisiologia basica e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Como sinais vitais se aplica em Ciclo Clinico?', 'Resumo do processo de sinais vitais e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Como exame fisico se aplica em Ciclo Clinico?', 'Resumo do processo de exame fisico e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Como anamnese se aplica em Ciclo Clinico?', 'Resumo do processo de anamnese e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Como hipertensao se aplica em Ciclo Clinico?', 'Resumo do processo de hipertensao e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Como diabetes se aplica em Ciclo Clinico?', 'Resumo do processo de diabetes e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Como asma se aplica em Ciclo Clinico?', 'Resumo do processo de asma e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Como dpoc se aplica em Ciclo Clinico?', 'Resumo do processo de dpoc e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Como pneumonia se aplica em Ciclo Clinico?', 'Resumo do processo de pneumonia e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Como tuberculose se aplica em Ciclo Clinico?', 'Resumo do processo de tuberculose e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Como insuficiencia cardiaca se aplica em Ciclo Clinico?', 'Resumo do processo de insuficiencia cardiaca e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Como infarto se aplica em Ciclo Clinico?', 'Resumo do processo de infarto e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Como arritmias se aplica em Ciclo Clinico?', 'Resumo do processo de arritmias e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Como hepatites se aplica em Ciclo Clinico?', 'Resumo do processo de hepatites e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Como cirrose se aplica em Ciclo Clinico?', 'Resumo do processo de cirrose e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Como ulcera se aplica em Ciclo Clinico?', 'Resumo do processo de ulcera e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Como drge se aplica em Ciclo Clinico?', 'Resumo do processo de drge e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Como doencas renais se aplica em Ciclo Clinico?', 'Resumo do processo de doencas renais e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Como litiase renal se aplica em Ciclo Clinico?', 'Resumo do processo de litiase renal e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Como sepse se aplica em Ciclo Clinico?', 'Resumo do processo de sepse e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Como anemia se aplica em Ciclo Clinico?', 'Resumo do processo de anemia e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Como doencas infecciosas se aplica em Ciclo Clinico?', 'Resumo do processo de doencas infecciosas e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Como vacinas se aplica em Ciclo Clinico?', 'Resumo do processo de vacinas e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Como farmacologia basica se aplica em Ciclo Clinico?', 'Resumo do processo de farmacologia basica e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Como antibioticos se aplica em Ciclo Clinico?', 'Resumo do processo de antibioticos e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Como analgesicos se aplica em Ciclo Clinico?', 'Resumo do processo de analgesicos e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Como saude mental se aplica em Ciclo Clinico?', 'Resumo do processo de saude mental e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Como etica em saude se aplica em Ciclo Clinico?', 'Resumo do processo de etica em saude e sua aplicacao em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Como seguranca do paciente se aplica em Ciclo Clinico?', 'Resumo do processo de seguranca do paciente e sua aplicacao em Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Regras e Principios (Auto)', 'Deck automatico de Ciclo Clinico com foco em regras e principios.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a regra ou principio-chave de anatomia basica em Ciclo Clinico?', 'Principio central de anatomia basica usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual a regra ou principio-chave de fisiologia basica em Ciclo Clinico?', 'Principio central de fisiologia basica usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual a regra ou principio-chave de sinais vitais em Ciclo Clinico?', 'Principio central de sinais vitais usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual a regra ou principio-chave de exame fisico em Ciclo Clinico?', 'Principio central de exame fisico usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual a regra ou principio-chave de anamnese em Ciclo Clinico?', 'Principio central de anamnese usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual a regra ou principio-chave de hipertensao em Ciclo Clinico?', 'Principio central de hipertensao usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual a regra ou principio-chave de diabetes em Ciclo Clinico?', 'Principio central de diabetes usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual a regra ou principio-chave de asma em Ciclo Clinico?', 'Principio central de asma usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual a regra ou principio-chave de dpoc em Ciclo Clinico?', 'Principio central de dpoc usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual a regra ou principio-chave de pneumonia em Ciclo Clinico?', 'Principio central de pneumonia usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual a regra ou principio-chave de tuberculose em Ciclo Clinico?', 'Principio central de tuberculose usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual a regra ou principio-chave de insuficiencia cardiaca em Ciclo Clinico?', 'Principio central de insuficiencia cardiaca usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual a regra ou principio-chave de infarto em Ciclo Clinico?', 'Principio central de infarto usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual a regra ou principio-chave de arritmias em Ciclo Clinico?', 'Principio central de arritmias usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual a regra ou principio-chave de hepatites em Ciclo Clinico?', 'Principio central de hepatites usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual a regra ou principio-chave de cirrose em Ciclo Clinico?', 'Principio central de cirrose usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual a regra ou principio-chave de ulcera em Ciclo Clinico?', 'Principio central de ulcera usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual a regra ou principio-chave de drge em Ciclo Clinico?', 'Principio central de drge usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual a regra ou principio-chave de doencas renais em Ciclo Clinico?', 'Principio central de doencas renais usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual a regra ou principio-chave de litiase renal em Ciclo Clinico?', 'Principio central de litiase renal usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual a regra ou principio-chave de sepse em Ciclo Clinico?', 'Principio central de sepse usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual a regra ou principio-chave de anemia em Ciclo Clinico?', 'Principio central de anemia usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual a regra ou principio-chave de doencas infecciosas em Ciclo Clinico?', 'Principio central de doencas infecciosas usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual a regra ou principio-chave de vacinas em Ciclo Clinico?', 'Principio central de vacinas usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual a regra ou principio-chave de farmacologia basica em Ciclo Clinico?', 'Principio central de farmacologia basica usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual a regra ou principio-chave de antibioticos em Ciclo Clinico?', 'Principio central de antibioticos usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual a regra ou principio-chave de analgesicos em Ciclo Clinico?', 'Principio central de analgesicos usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual a regra ou principio-chave de saude mental em Ciclo Clinico?', 'Principio central de saude mental usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual a regra ou principio-chave de etica em saude em Ciclo Clinico?', 'Principio central de etica em saude usado em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual a regra ou principio-chave de seguranca do paciente em Ciclo Clinico?', 'Principio central de seguranca do paciente usado em Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Resolucao de Problemas (Auto)', 'Deck automatico de Ciclo Clinico com foco em resolucao de problemas.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual o passo a passo basico para trabalhar anatomia basica em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de anatomia basica e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual o passo a passo basico para trabalhar fisiologia basica em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de fisiologia basica e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual o passo a passo basico para trabalhar sinais vitais em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de sinais vitais e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual o passo a passo basico para trabalhar exame fisico em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de exame fisico e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual o passo a passo basico para trabalhar anamnese em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de anamnese e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual o passo a passo basico para trabalhar hipertensao em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de hipertensao e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual o passo a passo basico para trabalhar diabetes em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de diabetes e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual o passo a passo basico para trabalhar asma em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de asma e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual o passo a passo basico para trabalhar dpoc em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de dpoc e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual o passo a passo basico para trabalhar pneumonia em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de pneumonia e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual o passo a passo basico para trabalhar tuberculose em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de tuberculose e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual o passo a passo basico para trabalhar insuficiencia cardiaca em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de insuficiencia cardiaca e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual o passo a passo basico para trabalhar infarto em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de infarto e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual o passo a passo basico para trabalhar arritmias em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de arritmias e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual o passo a passo basico para trabalhar hepatites em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de hepatites e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual o passo a passo basico para trabalhar cirrose em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de cirrose e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual o passo a passo basico para trabalhar ulcera em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de ulcera e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual o passo a passo basico para trabalhar drge em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de drge e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual o passo a passo basico para trabalhar doencas renais em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de doencas renais e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual o passo a passo basico para trabalhar litiase renal em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de litiase renal e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual o passo a passo basico para trabalhar sepse em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de sepse e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual o passo a passo basico para trabalhar anemia em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de anemia e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual o passo a passo basico para trabalhar doencas infecciosas em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de doencas infecciosas e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual o passo a passo basico para trabalhar vacinas em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de vacinas e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual o passo a passo basico para trabalhar farmacologia basica em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de farmacologia basica e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual o passo a passo basico para trabalhar antibioticos em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de antibioticos e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual o passo a passo basico para trabalhar analgesicos em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de analgesicos e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual o passo a passo basico para trabalhar saude mental em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de saude mental e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual o passo a passo basico para trabalhar etica em saude em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de etica em saude e concluir no contexto de Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual o passo a passo basico para trabalhar seguranca do paciente em Ciclo Clinico?', 'Sequencia simples: identificar dados, aplicar regras de seguranca do paciente e concluir no contexto de Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Erros Comuns e Dicas (Auto)', 'Deck automatico de Ciclo Clinico com foco em erros comuns e dicas.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual erro comum ao lidar com anatomia basica em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de anatomia basica; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Qual erro comum ao lidar com fisiologia basica em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de fisiologia basica; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Qual erro comum ao lidar com sinais vitais em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de sinais vitais; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Qual erro comum ao lidar com exame fisico em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de exame fisico; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Qual erro comum ao lidar com anamnese em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de anamnese; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Qual erro comum ao lidar com hipertensao em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de hipertensao; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Qual erro comum ao lidar com diabetes em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de diabetes; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Qual erro comum ao lidar com asma em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de asma; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Qual erro comum ao lidar com dpoc em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de dpoc; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Qual erro comum ao lidar com pneumonia em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de pneumonia; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Qual erro comum ao lidar com tuberculose em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de tuberculose; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Qual erro comum ao lidar com insuficiencia cardiaca em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de insuficiencia cardiaca; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Qual erro comum ao lidar com infarto em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de infarto; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Qual erro comum ao lidar com arritmias em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de arritmias; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Qual erro comum ao lidar com hepatites em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de hepatites; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Qual erro comum ao lidar com cirrose em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de cirrose; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Qual erro comum ao lidar com ulcera em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de ulcera; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Qual erro comum ao lidar com drge em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de drge; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Qual erro comum ao lidar com doencas renais em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de doencas renais; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Qual erro comum ao lidar com litiase renal em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de litiase renal; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Qual erro comum ao lidar com sepse em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de sepse; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Qual erro comum ao lidar com anemia em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de anemia; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Qual erro comum ao lidar com doencas infecciosas em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de doencas infecciosas; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Qual erro comum ao lidar com vacinas em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de vacinas; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Qual erro comum ao lidar com farmacologia basica em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de farmacologia basica; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Qual erro comum ao lidar com antibioticos em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de antibioticos; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Qual erro comum ao lidar com analgesicos em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de analgesicos; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Qual erro comum ao lidar com saude mental em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de saude mental; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Qual erro comum ao lidar com etica em saude em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de etica em saude; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Qual erro comum ao lidar com seguranca do paciente em Ciclo Clinico?', 'Erro comum: confundir conceito ou etapa de seguranca do paciente; evite revisando definicoes e condicoes em Ciclo Clinico.', 'Template automatico');

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ciclo Clinico - Revisao Rapida (Auto)', 'Deck automatico de Ciclo Clinico com foco em revisao rapida.', 0, v_user_id, v_cat_id, ARRAY['ciclo-clinico', 'health', 'auto', 'template'], true, true, 4.6)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Resumo rapido: anatomia basica em Ciclo Clinico.', 'Resumo: pontos essenciais de anatomia basica e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 2, 'basic', 'Resumo rapido: fisiologia basica em Ciclo Clinico.', 'Resumo: pontos essenciais de fisiologia basica e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 3, 'basic', 'Resumo rapido: sinais vitais em Ciclo Clinico.', 'Resumo: pontos essenciais de sinais vitais e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 4, 'basic', 'Resumo rapido: exame fisico em Ciclo Clinico.', 'Resumo: pontos essenciais de exame fisico e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 5, 'basic', 'Resumo rapido: anamnese em Ciclo Clinico.', 'Resumo: pontos essenciais de anamnese e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 6, 'basic', 'Resumo rapido: hipertensao em Ciclo Clinico.', 'Resumo: pontos essenciais de hipertensao e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 7, 'basic', 'Resumo rapido: diabetes em Ciclo Clinico.', 'Resumo: pontos essenciais de diabetes e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 8, 'basic', 'Resumo rapido: asma em Ciclo Clinico.', 'Resumo: pontos essenciais de asma e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 9, 'basic', 'Resumo rapido: dpoc em Ciclo Clinico.', 'Resumo: pontos essenciais de dpoc e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 10, 'basic', 'Resumo rapido: pneumonia em Ciclo Clinico.', 'Resumo: pontos essenciais de pneumonia e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 11, 'basic', 'Resumo rapido: tuberculose em Ciclo Clinico.', 'Resumo: pontos essenciais de tuberculose e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 12, 'basic', 'Resumo rapido: insuficiencia cardiaca em Ciclo Clinico.', 'Resumo: pontos essenciais de insuficiencia cardiaca e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 13, 'basic', 'Resumo rapido: infarto em Ciclo Clinico.', 'Resumo: pontos essenciais de infarto e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 14, 'basic', 'Resumo rapido: arritmias em Ciclo Clinico.', 'Resumo: pontos essenciais de arritmias e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 15, 'basic', 'Resumo rapido: hepatites em Ciclo Clinico.', 'Resumo: pontos essenciais de hepatites e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 16, 'basic', 'Resumo rapido: cirrose em Ciclo Clinico.', 'Resumo: pontos essenciais de cirrose e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 17, 'basic', 'Resumo rapido: ulcera em Ciclo Clinico.', 'Resumo: pontos essenciais de ulcera e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 18, 'basic', 'Resumo rapido: drge em Ciclo Clinico.', 'Resumo: pontos essenciais de drge e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 19, 'basic', 'Resumo rapido: doencas renais em Ciclo Clinico.', 'Resumo: pontos essenciais de doencas renais e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 20, 'basic', 'Resumo rapido: litiase renal em Ciclo Clinico.', 'Resumo: pontos essenciais de litiase renal e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 21, 'basic', 'Resumo rapido: sepse em Ciclo Clinico.', 'Resumo: pontos essenciais de sepse e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 22, 'basic', 'Resumo rapido: anemia em Ciclo Clinico.', 'Resumo: pontos essenciais de anemia e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 23, 'basic', 'Resumo rapido: doencas infecciosas em Ciclo Clinico.', 'Resumo: pontos essenciais de doencas infecciosas e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 24, 'basic', 'Resumo rapido: vacinas em Ciclo Clinico.', 'Resumo: pontos essenciais de vacinas e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 25, 'basic', 'Resumo rapido: farmacologia basica em Ciclo Clinico.', 'Resumo: pontos essenciais de farmacologia basica e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 26, 'basic', 'Resumo rapido: antibioticos em Ciclo Clinico.', 'Resumo: pontos essenciais de antibioticos e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 27, 'basic', 'Resumo rapido: analgesicos em Ciclo Clinico.', 'Resumo: pontos essenciais de analgesicos e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 28, 'basic', 'Resumo rapido: saude mental em Ciclo Clinico.', 'Resumo: pontos essenciais de saude mental e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 29, 'basic', 'Resumo rapido: etica em saude em Ciclo Clinico.', 'Resumo: pontos essenciais de etica em saude e sua utilidade em Ciclo Clinico.', 'Template automatico'),
  (v_deck_id, 30, 'basic', 'Resumo rapido: seguranca do paciente em Ciclo Clinico.', 'Resumo: pontos essenciais de seguranca do paciente e sua utilidade em Ciclo Clinico.', 'Template automatico');


  RAISE NOTICE 'Auto decks inseridos: Ciclo Clinico';
END $$;
