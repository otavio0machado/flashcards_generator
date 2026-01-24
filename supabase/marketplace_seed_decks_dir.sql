-- Marketplace Seed: Decks de Direito (OAB e Concursos)

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/direito/constitucional';

  -- DIREITO CONSTITUCIONAL
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Constitucional: Princípios e Direitos Fundamentais', 'Teoria da Constituição, direitos fundamentais, organização do Estado e controle de constitucionalidade.', 0, v_user_id, v_cat_id, ARRAY['direito', 'constitucional', 'oab', 'concursos'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais os fundamentos da República Federativa do Brasil (art. 1º)?', 'I - soberania; II - cidadania; III - dignidade da pessoa humana; IV - valores sociais do trabalho e livre iniciativa; V - pluralismo político.', 'CF/88, art. 1º'),
  (v_deck_id, 2, 'basic', 'Quais os objetivos fundamentais da República (art. 3º)?', 'I - sociedade livre, justa e solidária; II - garantir desenvolvimento nacional; III - erradicar pobreza; IV - promover bem de todos sem discriminação.', 'CF/88, art. 3º'),
  (v_deck_id, 3, 'basic', 'Quais os princípios nas relações internacionais (art. 4º)?', 'Independência nacional, prevalência dos direitos humanos, autodeterminação dos povos, não-intervenção, igualdade entre Estados, defesa da paz, etc.', 'CF/88, art. 4º'),
  (v_deck_id, 4, 'basic', 'O que significa "ninguém será obrigado a fazer ou deixar de fazer algo senão em virtude de lei"?', 'Princípio da legalidade (art. 5º, II). Para particulares: tudo é permitido, exceto o proibido. Para Administração: só o permitido em lei.', 'CF/88, art. 5º, II'),
  (v_deck_id, 5, 'basic', 'O que é habeas corpus?', 'Remédio constitucional contra ilegalidade ou abuso de poder que resulte em prisão ou ameaça à liberdade de locomoção (art. 5º, LXVIII).', 'CF/88, art. 5º, LXVIII'),
  (v_deck_id, 6, 'basic', 'O que é mandado de segurança?', 'Protege direito líquido e certo não amparado por HC ou HD, contra ilegalidade de autoridade pública (art. 5º, LXIX). Prazo: 120 dias.', 'CF/88, art. 5º, LXIX'),
  (v_deck_id, 7, 'basic', 'O que é habeas data?', 'Assegura conhecimento e retificação de informações pessoais em bancos de dados públicos ou de caráter público (art. 5º, LXXII).', 'CF/88, art. 5º, LXXII'),
  (v_deck_id, 8, 'basic', 'O que é mandado de injunção?', 'Quando falta norma regulamentadora que torne inviável exercício de direitos constitucionais (art. 5º, LXXI). STF adota efeitos concretos.', 'CF/88, art. 5º, LXXI'),
  (v_deck_id, 9, 'basic', 'O que é ação popular?', 'Qualquer cidadão pode anular ato lesivo ao patrimônio público, moralidade administrativa, meio ambiente e patrimônio histórico (art. 5º, LXXIII).', 'CF/88, art. 5º, LXXIII'),
  (v_deck_id, 10, 'basic', 'Quais são os direitos sociais (art. 6º)?', 'Educação, saúde, alimentação, trabalho, moradia, transporte, lazer, segurança, previdência social, proteção à maternidade e infância, assistência.', 'CF/88, art. 6º'),
  (v_deck_id, 11, 'basic', 'Quem pode propor ADI e ADC?', 'Art. 103: Presidente, Mesas da Câmara/Senado/Assembleia, Governador, PGR, Conselho Federal OAB, partido com representação, confederação sindical.', 'CF/88, art. 103'),
  (v_deck_id, 12, 'basic', 'Qual a diferença entre ADI e ADC?', 'ADI: declara inconstitucionalidade de lei. ADC: confirma constitucionalidade de lei federal. Ambas têm efeito erga omnes e vinculante.', 'CF/88, arts. 102-103'),
  (v_deck_id, 13, 'basic', 'O que é ADPF?', 'Arguição de Descumprimento de Preceito Fundamental. Subsidiariedade. Leis municipais, direito pré-constitucional. STF.', 'CF/88, art. 102, §1º'),
  (v_deck_id, 14, 'basic', 'O que é controle difuso de constitucionalidade?', 'Qualquer juiz ou tribunal pode declarar lei inconstitucional no caso concreto. Efeito inter partes. Senado pode suspender execução (art. 52, X).', 'CF/88, art. 97, 52, X'),
  (v_deck_id, 15, 'basic', 'Quais as cláusulas pétreas (art. 60, §4º)?', 'Não pode ser objeto de abolição: forma federativa; voto direto, secreto, universal e periódico; separação dos Poderes; direitos e garantias individuais.', 'CF/88, art. 60, §4º'),
  (v_deck_id, 16, 'basic', 'Qual a organização político-administrativa do Brasil?', 'União, Estados, DF e Municípios, todos autônomos (art. 18). Forma federativa. Vedada secessão. Capital: Brasília.', 'CF/88, art. 18'),
  (v_deck_id, 17, 'basic', 'Quais as competências privativas da União (art. 22)?', 'Legislar sobre direito civil, comercial, penal, processual, eleitoral, agrário, marítimo, trabalho, etc. Parágrafo único: delegação a Estados por LC.', 'CF/88, art. 22'),
  (v_deck_id, 18, 'basic', 'O que é competência concorrente (art. 24)?', 'União estabelece normas gerais; Estados suplementam. Tributário, financeiro, penitenciário, educação, saúde, meio ambiente, etc.', 'CF/88, art. 24'),
  (v_deck_id, 19, 'basic', 'Quantos deputados e senadores há no Brasil?', 'Deputados: proporcional à população, mín. 8, máx. 70 por estado (total 513). Senadores: 3 por estado (total 81). Mandatos: 4 e 8 anos.', 'CF/88, arts. 45-46'),
  (v_deck_id, 20, 'basic', 'O que são imunidades parlamentares?', 'Material: inviolabilidade por opiniões e votos. Formal: não podem ser presos (salvo flagrante inafiançável); processo pode ser sustado pela Casa.', 'CF/88, art. 53'),
  (v_deck_id, 21, 'basic', 'Qual o quórum para Emenda Constitucional?', '3/5 dos votos em cada Casa, em dois turnos. Iniciativa: 1/3 de qualquer Casa, Presidente ou mais da metade das Assembleias Legislativas.', 'CF/88, art. 60'),
  (v_deck_id, 22, 'basic', 'O que é Lei Complementar?', 'Exige maioria absoluta. Matérias específicas previstas na CF. Hierarquia acima de lei ordinária é controversa.', 'CF/88, art. 69'),
  (v_deck_id, 23, 'basic', 'Quais os requisitos para ser Presidente da República?', 'Brasileiro nato, pleno exercício dos direitos políticos, alistamento eleitoral, filiação partidária, idade mínima de 35 anos.', 'CF/88, art. 14, §3º'),
  (v_deck_id, 24, 'basic', 'Quem pode sofrer impeachment?', 'Presidente, Vice, Ministros, STF, PGR, AGU, entre outros. Crimes de responsabilidade. Câmara autoriza (2/3), Senado julga.', 'CF/88, arts. 51-52, 85-86'),
  (v_deck_id, 25, 'basic', 'Qual a composição do STF?', '11 Ministros nomeados pelo Presidente após aprovação do Senado (maioria absoluta). Brasileiros natos, 35-65 anos, notável saber jurídico, reputação ilibada.', 'CF/88, art. 101'),
  (v_deck_id, 26, 'basic', 'Quais as funções do Ministério Público?', 'Defesa da ordem jurídica, regime democrático, interesses sociais e individuais indisponíveis. Ação penal pública. Controle externo da polícia.', 'CF/88, art. 127'),
  (v_deck_id, 27, 'basic', 'O que é reserva legal e anterioridade tributária?', 'Tributo só por lei (reserva legal). Não pode ser cobrado no mesmo exercício da publicação (anterioridade) nem antes de 90 dias (noventena).', 'CF/88, art. 150, I e III'),
  (v_deck_id, 28, 'basic', 'Quais os princípios da Administração Pública (art. 37)?', 'LIMPE: Legalidade, Impessoalidade, Moralidade, Publicidade, Eficiência. Aplicam-se à administração direta e indireta.', 'CF/88, art. 37'),
  (v_deck_id, 29, 'basic', 'O que é o princípio da presunção de inocência?', 'Ninguém será considerado culpado até o trânsito em julgado de sentença penal condenatória (art. 5º, LVII).', 'CF/88, art. 5º, LVII'),
  (v_deck_id, 30, 'basic', 'Quais são os remédios constitucionais?', 'HC (liberdade de locomoção), HD (dados pessoais), MS (direito líquido e certo), MI (norma faltante), Ação Popular (patrimônio público).', 'CF/88, art. 5º, LXVIII-LXXIII');

  -- DIREITO CIVIL
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/direito/civil';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Civil: Parte Geral e Obrigações', 'Pessoas, bens, negócio jurídico, prescrição/decadência e teoria das obrigações.', 0, v_user_id, v_cat_id, ARRAY['direito', 'civil', 'oab', 'concursos'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quando começa a personalidade civil?', 'Do nascimento com vida, mas a lei põe a salvo desde a concepção os direitos do nascituro (art. 2º CC).', 'CC, art. 2º'),
  (v_deck_id, 2, 'basic', 'Quais são os absolutamente incapazes?', 'Apenas os menores de 16 anos (art. 3º CC). Lei 13.146/2015 alterou: deficiência não é causa de incapacidade.', 'CC, art. 3º'),
  (v_deck_id, 3, 'basic', 'Quais são os relativamente incapazes?', 'Maiores de 16 e menores de 18; ébrios habituais e viciados em tóxico; pródigos; os que não puderem exprimir vontade (art. 4º).', 'CC, art. 4º'),
  (v_deck_id, 4, 'basic', 'Quando cessa a menoridade?', 'Aos 18 anos. Emancipação: concessão dos pais (16+), casamento, emprego público efetivo, colação de grau, estabelecimento próprio.', 'CC, arts. 5º e 9º'),
  (v_deck_id, 5, 'basic', 'Quais os direitos da personalidade?', 'Intransmissíveis, irrenunciáveis, imprescritíveis. Nome, imagem, honra, privacidade, integridade física. Arts. 11-21 CC.', 'CC, arts. 11-21'),
  (v_deck_id, 6, 'basic', 'O que é domicílio?', 'Lugar onde a pessoa estabelece residência com ânimo definitivo. Pode ser plural, voluntário, legal ou de eleição.', 'CC, arts. 70-78'),
  (v_deck_id, 7, 'basic', 'Quais os requisitos de validade do negócio jurídico?', 'Agente capaz, objeto lícito/possível/determinado ou determinável, forma prescrita ou não defesa em lei (art. 104).', 'CC, art. 104'),
  (v_deck_id, 8, 'basic', 'Quais os defeitos do negócio jurídico?', 'Erro, dolo, coação, estado de perigo, lesão, fraude contra credores. Tornam anulável (art. 171). Simulação é nulo (art. 167).', 'CC, arts. 138-165'),
  (v_deck_id, 9, 'basic', 'Qual a diferença entre nulidade e anulabilidade?', 'Nulidade: insanável, pode ser declarada de ofício, não convalesce. Anulabilidade: sanável, requer alegação, convalesce com o tempo.', 'CC, arts. 166-184'),
  (v_deck_id, 10, 'basic', 'O que é prescrição?', 'Perda da pretensão pelo não exercício no prazo legal. Não corre contra absolutamente incapazes. Pode ser alegada em qualquer grau.', 'CC, arts. 189-206'),
  (v_deck_id, 11, 'basic', 'Qual o prazo prescricional geral?', '10 anos quando a lei não fixar prazo menor (art. 205). Prazos especiais no art. 206: 3 anos (reparação civil), 5 anos (dívida líquida).', 'CC, arts. 205-206'),
  (v_deck_id, 12, 'basic', 'O que é decadência?', 'Extinção do próprio direito pelo não exercício no prazo. Decadência legal não pode ser renunciada; convencional pode.', 'CC, arts. 207-211'),
  (v_deck_id, 13, 'basic', 'Quais os elementos das obrigações?', 'Subjetivo (credor/devedor), objetivo (prestação: dar, fazer, não fazer) e vínculo jurídico.', 'CC, arts. 233 ss.'),
  (v_deck_id, 14, 'basic', 'Qual a diferença entre obrigação de dar e de restituir?', 'Dar: transferir propriedade. Restituir: devolver coisa alheia. Perda sem culpa: extingue em ambas, mas efeitos diferentes.', 'CC, arts. 233-242'),
  (v_deck_id, 15, 'basic', 'O que é obrigação solidária?', 'Cada credor pode exigir toda a dívida, ou cada devedor pode ser obrigado a pagá-la. Não se presume; decorre de lei ou contrato.', 'CC, arts. 264-285'),
  (v_deck_id, 16, 'basic', 'Quais as formas de pagamento?', 'Pagamento direto, consignação, sub-rogação, imputação, dação em pagamento, novação, compensação, confusão, remissão.', 'CC, arts. 304-388'),
  (v_deck_id, 17, 'basic', 'O que é novação?', 'Criação de nova obrigação para extinguir a anterior. Pode ser objetiva (muda objeto) ou subjetiva (muda partes).', 'CC, arts. 360-367'),
  (v_deck_id, 18, 'basic', 'O que é compensação?', 'Extinção de obrigações recíprocas até onde se compensarem. Requer dívidas líquidas, vencidas e fungíveis entre si.', 'CC, arts. 368-380'),
  (v_deck_id, 19, 'basic', 'Quais os requisitos da responsabilidade civil?', 'Ato ilícito (culpa ou dolo), dano (material ou moral), nexo causal. Responsabilidade objetiva: independe de culpa.', 'CC, arts. 186-188, 927'),
  (v_deck_id, 20, 'basic', 'O que são excludentes de ilicitude?', 'Legítima defesa, exercício regular de direito, estado de necessidade. Afastam a ilicitude do ato.', 'CC, art. 188'),
  (v_deck_id, 21, 'basic', 'O que é teoria do risco?', 'Base da responsabilidade objetiva. Quem exerce atividade que cria risco responde independentemente de culpa (art. 927, p.ú.).', 'CC, art. 927, parágrafo único'),
  (v_deck_id, 22, 'basic', 'O que são contratos típicos e atípicos?', 'Típicos: previstos em lei (compra e venda, locação). Atípicos: criados pelas partes. Liberdade contratual (art. 421).', 'CC, art. 421'),
  (v_deck_id, 23, 'basic', 'Quais os princípios contratuais?', 'Autonomia da vontade, obrigatoriedade (pacta sunt servanda), relatividade, boa-fé objetiva, função social do contrato.', 'CC, arts. 421-422'),
  (v_deck_id, 24, 'basic', 'O que é contrato de compra e venda?', 'Um transfere domínio de coisa e outro paga preço. Tradição móvel, registro imóvel. Vícios redibitórios e evicção.', 'CC, arts. 481-532'),
  (v_deck_id, 25, 'basic', 'O que são vícios redibitórios?', 'Defeitos ocultos que tornam a coisa imprópria para uso ou diminuem seu valor. Ação redibitória ou estimatória.', 'CC, arts. 441-446'),
  (v_deck_id, 26, 'basic', 'O que é evicção?', 'Perda da coisa adquirida por decisão judicial que reconhece direito de terceiro. Vendedor deve indenizar.', 'CC, arts. 447-457'),
  (v_deck_id, 27, 'basic', 'O que é posse e propriedade?', 'Posse: poder de fato sobre a coisa. Propriedade: direito pleno (usar, gozar, dispor, reaver). Distinção importante.', 'CC, arts. 1196, 1228'),
  (v_deck_id, 28, 'basic', 'O que é usucapião?', 'Aquisição de propriedade pela posse prolongada. Tipos: ordinária (10 anos, justo título, boa-fé), extraordinária (15 anos).', 'CC, arts. 1238-1244'),
  (v_deck_id, 29, 'basic', 'Quais os direitos reais de garantia?', 'Penhor (móveis), hipoteca (imóveis), anticrese (frutos). Garantem dívida. Preferência no pagamento.', 'CC, arts. 1419-1510'),
  (v_deck_id, 30, 'basic', 'O que é o princípio da saisine na sucessão?', 'Transmissão automática do patrimônio do falecido aos herdeiros no momento da morte. Abertura da sucessão.', 'CC, art. 1784');

  -- DIREITO PENAL
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/direito/penal';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Direito Penal: Parte Geral e Especial', 'Teoria do crime, aplicação da pena, crimes contra a pessoa, patrimônio e administração pública.', 0, v_user_id, v_cat_id, ARRAY['direito', 'penal', 'oab', 'concursos'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais os princípios fundamentais do Direito Penal?', 'Legalidade (nullum crimen sine lege), anterioridade, taxatividade, intervenção mínima, fragmentariedade, lesividade, culpabilidade.', 'CP, art. 1º; CF, art. 5º, XXXIX'),
  (v_deck_id, 2, 'basic', 'Qual a estrutura do crime segundo a teoria tripartite?', 'Fato típico + Ilicitude (antijuridicidade) + Culpabilidade. Ausência de qualquer elemento: não há crime.', 'Doutrina majoritária'),
  (v_deck_id, 3, 'basic', 'Quais os elementos do fato típico?', 'Conduta (ação/omissão), resultado, nexo causal, tipicidade (formal + conglobante/material).', 'Doutrina'),
  (v_deck_id, 4, 'basic', 'Quais as excludentes de ilicitude?', 'Estado de necessidade, legítima defesa, estrito cumprimento do dever legal, exercício regular de direito (art. 23 CP).', 'CP, art. 23'),
  (v_deck_id, 5, 'basic', 'O que é legítima defesa?', 'Repelir injusta agressão, atual ou iminente, a direito próprio ou alheio, usando moderadamente os meios necessários.', 'CP, art. 25'),
  (v_deck_id, 6, 'basic', 'Quais os elementos da culpabilidade?', 'Imputabilidade, potencial consciência da ilicitude, exigibilidade de conduta diversa. Sem eles: isento de pena.', 'Doutrina'),
  (v_deck_id, 7, 'basic', 'Quem são os inimputáveis?', 'Doentes mentais ou desenvolvimento incompleto (art. 26), menores de 18 anos (art. 27), embriaguez fortuita completa (art. 28, §1º).', 'CP, arts. 26-28'),
  (v_deck_id, 8, 'basic', 'O que é erro de tipo?', 'Falsa percepção da realidade sobre elementos do tipo. Essencial: exclui dolo; se escusável, exclui culpa. Acidental: responde.', 'CP, art. 20'),
  (v_deck_id, 9, 'basic', 'O que é erro de proibição?', 'Desconhecimento de que a conduta é ilícita. Escusável: isento de pena. Inescusável: diminui pena 1/6 a 1/3.', 'CP, art. 21'),
  (v_deck_id, 10, 'basic', 'Qual a diferença entre dolo e culpa?', 'Dolo: vontade e consciência de praticar o crime. Culpa: imprudência, negligência ou imperícia. Culpa só se prevista.', 'CP, art. 18'),
  (v_deck_id, 11, 'basic', 'O que é tentativa?', 'Crime não se consuma por circunstâncias alheias à vontade do agente. Pena reduzida 1/3 a 2/3. Crimes culposos não admitem.', 'CP, art. 14, II'),
  (v_deck_id, 12, 'basic', 'O que é desistência voluntária e arrependimento eficaz?', 'Desistência: interrompe execução. Arrependimento: após execução, impede resultado. Responde só pelos atos praticados.', 'CP, art. 15'),
  (v_deck_id, 13, 'basic', 'Quais as espécies de concurso de pessoas?', 'Coautoria (todos executam), participação (induzimento, instigação, auxílio). Comunicabilidade de circunstâncias (art. 30).', 'CP, arts. 29-31'),
  (v_deck_id, 14, 'basic', 'Quais as espécies de concurso de crimes?', 'Material (várias ações, vários crimes), formal (uma ação, vários crimes), crime continuado (mesmas condições, mesma espécie).', 'CP, arts. 69-71'),
  (v_deck_id, 15, 'basic', 'O que é homicídio qualificado?', 'Art. 121, §2º: motivo torpe/fútil, meio cruel/que dificulte defesa, feminicídio, contra autoridades. Pena: 12-30 anos.', 'CP, art. 121, §2º'),
  (v_deck_id, 16, 'basic', 'O que é feminicídio?', 'Homicídio contra mulher por razões da condição de sexo feminino: violência doméstica ou menosprezo/discriminação.', 'CP, art. 121, §2º-A'),
  (v_deck_id, 17, 'basic', 'Qual a diferença entre furto e roubo?', 'Furto (155): subtração sem violência. Roubo (157): subtração com violência ou grave ameaça. Latrocínio: roubo + morte.', 'CP, arts. 155, 157'),
  (v_deck_id, 18, 'basic', 'O que é estelionato?', 'Obter vantagem ilícita mediante fraude, induzindo ou mantendo alguém em erro. Pena: 1-5 anos. Ação penal condicionada.', 'CP, art. 171'),
  (v_deck_id, 19, 'basic', 'O que é peculato?', 'Funcionário apropria-se de dinheiro/valor público ou desvia em proveito próprio/alheio. Doloso ou culposo.', 'CP, art. 312'),
  (v_deck_id, 20, 'basic', 'O que é corrupção passiva e ativa?', 'Passiva (317): funcionário solicita/recebe vantagem. Ativa (333): particular oferece vantagem a funcionário.', 'CP, arts. 317, 333'),
  (v_deck_id, 21, 'basic', 'O que é prevaricação?', 'Funcionário retarda ou deixa de praticar ato ou o pratica contra lei para satisfazer interesse pessoal.', 'CP, art. 319'),
  (v_deck_id, 22, 'basic', 'Quais as espécies de penas?', 'Privativas de liberdade (reclusão, detenção), restritivas de direitos, multa. Regimes: fechado, semiaberto, aberto.', 'CP, arts. 32-42'),
  (v_deck_id, 23, 'basic', 'Quais são as causas de extinção da punibilidade?', 'Morte do agente, anistia/graça/indulto, prescrição, decadência, perempção, renúncia/perdão, retratação, etc.', 'CP, art. 107'),
  (v_deck_id, 24, 'basic', 'Como funciona a prescrição penal?', 'Pela pena máxima em abstrato (antes da sentença) ou pela pena aplicada (após). Prazos no art. 109 CP.', 'CP, arts. 109-119'),
  (v_deck_id, 25, 'basic', 'O que são agravantes e atenuantes?', 'Agravantes (61-62): reincidência, motivo torpe, etc. Atenuantes (65-66): menoridade, confissão, etc. Sempre na 2ª fase.', 'CP, arts. 61-66'),
  (v_deck_id, 26, 'basic', 'O que é sursis (suspensão condicional da pena)?', 'Pena de até 2 anos, réu não reincidente em crime doloso. Período de prova 2-4 anos com condições.', 'CP, arts. 77-82'),
  (v_deck_id, 27, 'basic', 'O que é livramento condicional?', 'Liberação antecipada cumprindo requisitos. Mais de 1/3 (primário), 1/2 (reincidente), 2/3 (hediondo).', 'CP, arts. 83-90'),
  (v_deck_id, 28, 'basic', 'O que são crimes hediondos?', 'Lei 8.072/90: homicídio qualificado, latrocínio, extorsão com morte, estupro, etc. Regime inicial fechado, vedações.', 'Lei 8.072/90'),
  (v_deck_id, 29, 'basic', 'O que é crime de racismo?', 'Lei 7.716/89: discriminação por raça, cor, etnia, religião, origem. Inafiançável e imprescritível (CF).', 'Lei 7.716/89; CF, art. 5º, XLII'),
  (v_deck_id, 30, 'basic', 'O que é tráfico de drogas?', 'Lei 11.343/06, art. 33: importar, vender, transportar drogas. Pena: 5-15 anos. Equiparado a hediondo.', 'Lei 11.343/06, art. 33');

  RAISE NOTICE 'Decks de Direito inseridos com sucesso!';
END $$;
