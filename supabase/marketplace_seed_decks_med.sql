-- Marketplace Seed: Decks de Medicina e Engenharia

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  -- ANATOMIA
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico/anatomia';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Anatomia Humana: Sistemas e Regiões', 'Estudo dos sistemas corporais e anatomia topográfica para medicina e áreas da saúde.', 0, v_user_id, v_cat_id, ARRAY['medicina', 'anatomia', 'sistemas', 'saúde'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais os planos anatômicos?', 'Sagital (divide em direito/esquerdo), Frontal/Coronal (anterior/posterior), Transversal/Horizontal (superior/inferior).', 'Gray Anatomia'),
  (v_deck_id, 2, 'basic', 'Quantos ossos tem o corpo humano adulto?', '206 ossos. Classificados em longos (fêmur), curtos (carpo), planos (escápula), irregulares (vértebras), sesamoides (patela).', 'Gray Anatomia'),
  (v_deck_id, 3, 'basic', 'Quantas vértebras tem a coluna vertebral?', '33 vértebras: 7 cervicais (C1-C7), 12 torácicas (T1-T12), 5 lombares (L1-L5), 5 sacrais (fundidas), 4 coccígeas (fundidas).', 'Gray Anatomia'),
  (v_deck_id, 4, 'basic', 'Quais os ossos do crânio?', 'Frontal, parietais (2), temporais (2), occipital, esfenoide, etmoide. Faces: mandíbula, maxila, zigomático, nasal, etc.', 'Gray Anatomia'),
  (v_deck_id, 5, 'basic', 'Quais os tipos de articulações?', 'Fibrosas (suturas, sindesmoses), Cartilaginosas (sínfises, sincondroses), Sinoviais (móveis: dobradiça, esfera, pivô).', 'Gray Anatomia'),
  (v_deck_id, 6, 'basic', 'Quais os músculos da mímica facial?', 'Orbicular do olho, orbicular da boca, bucinador, zigomático maior/menor, frontal, risório. Inervados pelo nervo facial (VII).', 'Gray Anatomia'),
  (v_deck_id, 7, 'basic', 'Quais os músculos da mastigação?', 'Masseter, temporal, pterigoideos medial e lateral. Inervados pelo trigêmeo (V3). Elevam e movimentam a mandíbula.', 'Gray Anatomia'),
  (v_deck_id, 8, 'basic', 'Quais os músculos do manguito rotador?', 'SITS: Supraespinal (abdução), Infraespinal (rotação lateral), Redondo menor (rotação lateral), Subescapular (rotação medial).', 'Gray Anatomia'),
  (v_deck_id, 9, 'basic', 'Quais as câmaras cardíacas e suas funções?', 'AD: recebe sangue venoso. VD: bombeia para pulmões. AE: recebe sangue oxigenado. VE: bombeia para o corpo.', 'Gray Anatomia'),
  (v_deck_id, 10, 'basic', 'Quais as valvas cardíacas?', 'Tricúspide (AD-VD), Mitral/Bicúspide (AE-VE), Pulmonar (VD-artéria pulmonar), Aórtica (VE-aorta).', 'Gray Anatomia'),
  (v_deck_id, 11, 'basic', 'Quais as artérias coronárias?', 'Coronária direita: parede inferior/posterior. Coronária esquerda: tronco → interventricular anterior + circunflexa (parede lateral).', 'Gray Anatomia'),
  (v_deck_id, 12, 'basic', 'Quais os lobos pulmonares?', 'Direito: 3 lobos (superior, médio, inferior). Esquerdo: 2 lobos (superior com língula, inferior). Fissuras oblíquas e horizontal.', 'Gray Anatomia'),
  (v_deck_id, 13, 'basic', 'Qual o trajeto do ar inspirado?', 'Narinas → Cavidade nasal → Faringe → Laringe → Traqueia → Brônquios → Bronquíolos → Alvéolos.', 'Gray Anatomia'),
  (v_deck_id, 14, 'basic', 'Quais as partes do intestino delgado?', 'Duodeno (25cm, C-shaped, retroperitoneal fixo), Jejuno (proximal, mais vascularizado), Íleo (distal, placas de Peyer).', 'Gray Anatomia'),
  (v_deck_id, 15, 'basic', 'Quais as partes do intestino grosso?', 'Ceco (apêndice), Cólon ascendente, Transverso, Descendente, Sigmoide, Reto, Canal anal. Tênias, haustrações.', 'Gray Anatomia'),
  (v_deck_id, 16, 'basic', 'Qual a localização do fígado?', 'Hipocôndrio direito e epigástrio. Maior glândula do corpo. Lobos: direito, esquerdo, caudado, quadrado. Vesícula biliar.', 'Gray Anatomia'),
  (v_deck_id, 17, 'basic', 'Quais as partes do néfron?', 'Corpúsculo renal (glomérulo + cápsula de Bowman), TCP, Alça de Henle (descendente/ascendente), TCD, Ducto coletor.', 'Gray Anatomia'),
  (v_deck_id, 18, 'basic', 'Quais os nervos cranianos?', 'I-Olfatório, II-Óptico, III-Oculomotor, IV-Troclear, V-Trigêmeo, VI-Abducente, VII-Facial, VIII-Vestibulococlear, IX-Glossofaríngeo, X-Vago, XI-Acessório, XII-Hipoglosso.', 'Gray Anatomia'),
  (v_deck_id, 19, 'basic', 'Quais as partes do encéfalo?', 'Cérebro (hemisférios, córtex, substância branca), Diencéfalo (tálamo, hipotálamo), Tronco (mesencéfalo, ponte, bulbo), Cerebelo.', 'Gray Anatomia'),
  (v_deck_id, 20, 'basic', 'Quais as meninges?', 'Dura-máter (externa, resistente), Aracnoide (intermediária, espaço subaracnóideo com LCR), Pia-máter (interna, vascularizada).', 'Gray Anatomia'),
  (v_deck_id, 21, 'basic', 'Qual a origem e inserção do diafragma?', 'Origem: esterno, costelas inferiores, vértebras lombares. Inserção: centro tendíneo. Inervado pelo nervo frênico (C3-C5).', 'Gray Anatomia'),
  (v_deck_id, 22, 'basic', 'Quais os triângulos do pescoço?', 'Anterior (submentoniano, submandibular, carotídeo, muscular). Posterior (occipital, supraclavicular). Esternocleidomastoideo divide.', 'Gray Anatomia'),
  (v_deck_id, 23, 'basic', 'Quais as regiões do abdome?', '9 regiões: hipocôndrios (D/E), epigástrio, flancos (D/E), mesogástrio, fossas ilíacas (D/E), hipogástrio.', 'Gray Anatomia'),
  (v_deck_id, 24, 'basic', 'Qual a irrigação do estômago?', 'Tronco celíaco → gástrica esquerda, hepática comum (gástrica direita, gastroduodenal), esplênica (gastroepiploica esquerda).', 'Gray Anatomia'),
  (v_deck_id, 25, 'basic', 'Quais os plexos braquial e lombar?', 'Braquial (C5-T1): musculocutâneo, mediano, ulnar, radial, axilar. Lombar (L1-L4): femoral, obturador. Sacral: ciático.', 'Gray Anatomia'),
  (v_deck_id, 26, 'basic', 'Qual a função do hipotálamo?', 'Controle endócrino (via hipófise), temperatura, fome, sede, sono, emoções, sistema nervoso autônomo.', 'Gray Anatomia'),
  (v_deck_id, 27, 'basic', 'Quais as glândulas endócrinas?', 'Hipófise, tireoide, paratireoides, suprarrenais, pâncreas (ilhotas), gônadas, pineal, timo.', 'Gray Anatomia'),
  (v_deck_id, 28, 'basic', 'Qual a drenagem linfática da mama?', 'Principalmente axilar (75%), também paraesternal (mamária interna). Importante em metástases de câncer de mama.', 'Gray Anatomia'),
  (v_deck_id, 29, 'basic', 'Quais os forames da base do crânio?', 'Magno (medula), Jugular (IX, X, XI, veia jugular), Oval (V3), Redondo (V2), Óptico (II, artéria oftálmica).', 'Gray Anatomia'),
  (v_deck_id, 30, 'basic', 'Qual o trajeto da veia cava inferior?', 'Formada pelas ilíacas comuns (L5), sobe à direita da aorta, atravessa diafragma, drena no átrio direito.', 'Gray Anatomia');

  -- FISIOLOGIA
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico/fisiologia';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia Humana: Sistemas e Mecanismos', 'Funcionamento dos sistemas corporais: cardiovascular, respiratório, renal, nervoso e endócrino.', 0, v_user_id, v_cat_id, ARRAY['medicina', 'fisiologia', 'sistemas', 'saúde'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é potencial de repouso da membrana?', '~-70mV em neurônios. Mantido pela bomba Na⁺/K⁺-ATPase (3 Na⁺ para fora, 2 K⁺ para dentro) e vazamento de K⁺.', 'Guyton Fisiologia'),
  (v_deck_id, 2, 'basic', 'Como ocorre o potencial de ação?', 'Despolarização: canais Na⁺ abrem, Na⁺ entra (+30mV). Repolarização: canais K⁺ abrem, K⁺ sai. Período refratário.', 'Guyton Fisiologia'),
  (v_deck_id, 3, 'basic', 'O que é sinapse química?', 'Neurotransmissor liberado na fenda sináptica liga-se a receptores pós-sinápticos. Excitatória (PPSE) ou inibitória (PPSI).', 'Guyton Fisiologia'),
  (v_deck_id, 4, 'basic', 'Quais os principais neurotransmissores?', 'Acetilcolina, norepinefrina, dopamina, serotonina, GABA (inibitório), glutamato (excitatório), glicina.', 'Guyton Fisiologia'),
  (v_deck_id, 5, 'basic', 'Como funciona o ciclo cardíaco?', 'Sístole atrial → Sístole ventricular (isovolumétrica → ejeção) → Diástole (relaxamento isovolumétrico → enchimento).', 'Guyton Fisiologia'),
  (v_deck_id, 6, 'basic', 'O que é débito cardíaco?', 'DC = FC × VS. Volume de sangue bombeado por minuto (~5 L/min em repouso). Aumenta com exercício.', 'Guyton Fisiologia'),
  (v_deck_id, 7, 'basic', 'O que é a lei de Frank-Starling?', 'Quanto maior o enchimento ventricular (pré-carga), maior a força de contração. Dentro de limites fisiológicos.', 'Guyton Fisiologia'),
  (v_deck_id, 8, 'basic', 'Como é regulada a pressão arterial?', 'Barorreceptores (curto prazo), sistema renina-angiotensina-aldosterona (médio prazo), renal-líquidos (longo prazo).', 'Guyton Fisiologia'),
  (v_deck_id, 9, 'basic', 'O que é o sistema renina-angiotensina-aldosterona?', 'Renina (rim) → angiotensina I → ECA (pulmão) → angiotensina II (vasoconstrição) → aldosterona (retenção Na⁺).', 'Guyton Fisiologia'),
  (v_deck_id, 10, 'basic', 'Como ocorre a hematose?', 'Troca gasosa nos alvéolos por difusão passiva. O₂ entra no sangue (Hb), CO₂ sai. ΔPO₂ e ΔPO₂ são as forças motrizes.', 'Guyton Fisiologia'),
  (v_deck_id, 11, 'basic', 'O que é a curva de dissociação da hemoglobina?', 'Curva sigmoide: cooperatividade da Hb. Desvio para direita (acidose, ↑temp, ↑2,3-DPG): libera mais O₂. Efeito Bohr.', 'Guyton Fisiologia'),
  (v_deck_id, 12, 'basic', 'Como é controlada a respiração?', 'Centro respiratório no bulbo/ponte. Quimiorreceptores: centrais (CO₂/pH) e periféricos (PO₂, PCO₂). CO₂ é principal estímulo.', 'Guyton Fisiologia'),
  (v_deck_id, 13, 'basic', 'Qual a taxa de filtração glomerular (TFG)?', '~180 L/dia. Filtração: pressão hidrostática - oncótica - cápsula. Autorregulação mantém TFG constante (PA 80-180 mmHg).', 'Guyton Fisiologia'),
  (v_deck_id, 14, 'basic', 'O que é reabsorção tubular?', 'TCP: reabsorve 65% de Na⁺, glicose (cotransporte), aminoácidos, HCO₃⁻. Alça de Henle: mecanismo contracorrente.', 'Guyton Fisiologia'),
  (v_deck_id, 15, 'basic', 'Como o ADH regula a osmolalidade?', 'ADH (vasopressina) do hipotálamo/neurohipófise: aumenta permeabilidade à água no ducto coletor. Baixa osmolalidade: suprime ADH.', 'Guyton Fisiologia'),
  (v_deck_id, 16, 'basic', 'Como funciona o eixo hipotálamo-hipófise-tireoide?', 'TRH (hipotálamo) → TSH (adenohipófise) → T3/T4 (tireoide). T3/T4 fazem feedback negativo.', 'Guyton Fisiologia'),
  (v_deck_id, 17, 'basic', 'Quais os efeitos dos hormônios tireoidianos?', 'Aumentam metabolismo basal, consumo de O₂, produção de calor. Essenciais para desenvolvimento neural. Hipertireoidismo: taquicardia, perda peso.', 'Guyton Fisiologia'),
  (v_deck_id, 18, 'basic', 'Como é regulada a glicemia?', 'Insulina (células β): diminui glicemia (captação, glicogênese). Glucagon (células α): aumenta (glicogenólise, gliconeogênese).', 'Guyton Fisiologia'),
  (v_deck_id, 19, 'basic', 'Qual o mecanismo de ação da insulina?', 'Liga receptor tirosina-quinase → cascata PI3K/Akt → translocação GLUT4 → captação de glicose (músculo, adiposo).', 'Guyton Fisiologia'),
  (v_deck_id, 20, 'basic', 'O que é o cortisol e seus efeitos?', 'Hormônio do estresse (suprarrenal). Aumenta glicemia (gliconeogênese), anti-inflamatório, imunossupressor, catabolismo proteico.', 'Guyton Fisiologia'),
  (v_deck_id, 21, 'basic', 'Quais os hormônios da suprarrenal?', 'Córtex: glicocorticoides (cortisol), mineralocorticoides (aldosterona), androgênios. Medula: catecolaminas (adrenalina, noradrenalina).', 'Guyton Fisiologia'),
  (v_deck_id, 22, 'basic', 'Como funciona a contração muscular esquelética?', 'Ca²⁺ liberado do RS → liga troponina → expõe miosina → ciclo das pontes cruzadas (ATP) → encurtamento do sarcômero.', 'Guyton Fisiologia'),
  (v_deck_id, 23, 'basic', 'O que é o sistema nervoso autônomo?', 'Simpático (fight or flight): noradrenalina. Parassimpático (rest and digest): acetilcolina. Dupla inervação.', 'Guyton Fisiologia'),
  (v_deck_id, 24, 'basic', 'O que é o reflexo miotático?', 'Estiramento do músculo → fuso muscular → neurônio aferente → medula → neurônio motor → contração. Ex: reflexo patelar.', 'Guyton Fisiologia'),
  (v_deck_id, 25, 'basic', 'Quais as fases da digestão?', 'Cefálica (antecipa): vago. Gástrica (estômago): gastrina. Intestinal: CCK (contração vesícula), secretina (suco pancreático).', 'Guyton Fisiologia'),
  (v_deck_id, 26, 'basic', 'O que é a barreira hematoencefálica?', 'Endotélio com junções apertadas + astrócitos. Limita passagem de substâncias para SNC. Protege, mas dificulta tratamentos.', 'Guyton Fisiologia'),
  (v_deck_id, 27, 'basic', 'Como funciona a coagulação sanguínea?', 'Via intrínseca (fator XII), extrínseca (fator VII + fator tecidual) → via comum (X → protrombina → trombina → fibrina).', 'Guyton Fisiologia'),
  (v_deck_id, 28, 'basic', 'O que é o ciclo menstrual?', 'Fase folicular: FSH → folículo cresce → estrogênio. Ovulação: pico LH. Fase lútea: corpo lúteo → progesterona. 28 dias.', 'Guyton Fisiologia'),
  (v_deck_id, 29, 'basic', 'Quais os hormônios da gravidez?', 'hCG (mantém corpo lúteo), progesterona (útero, mamas), estrogênio, prolactina, lactogênio placentário, ocitocina (parto).', 'Guyton Fisiologia'),
  (v_deck_id, 30, 'basic', 'O que é o potencial de membrana em repouso no músculo cardíaco?', '~-90mV. Fase 0: Na⁺ rápido. Fase 1: K⁺ out. Fase 2: platô (Ca²⁺ in, K⁺ out). Fase 3: repolarização. Fase 4: repouso.', 'Guyton Fisiologia');

  -- CÁLCULO
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/engenharias-e-exatas/calculo';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Cálculo Diferencial e Integral I', 'Limites, derivadas, integrais e aplicações. Fundamentos do cálculo para engenharias e exatas.', 0, v_user_id, v_cat_id, ARRAY['cálculo', 'engenharia', 'matemática', 'exatas'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é limite de uma função?', 'lim(x→a) f(x) = L significa que f(x) se aproxima de L quando x se aproxima de a. Não depende do valor em a.', 'Stewart Cálculo'),
  (v_deck_id, 2, 'basic', 'Quais as propriedades dos limites?', 'lim(f±g) = lim f ± lim g. lim(cf) = c·lim f. lim(fg) = lim f · lim g. lim(f/g) = lim f / lim g (se lim g ≠ 0).', 'Stewart Cálculo'),
  (v_deck_id, 3, 'basic', 'O que é o limite fundamental trigonométrico?', 'lim(x→0) sen(x)/x = 1. Também: lim(x→0) (1-cos(x))/x = 0.', 'Stewart Cálculo'),
  (v_deck_id, 4, 'basic', 'O que é o limite fundamental exponencial?', 'lim(x→0) (1+x)^(1/x) = e. Ou: lim(n→∞) (1+1/n)^n = e ≈ 2,71828.', 'Stewart Cálculo'),
  (v_deck_id, 5, 'basic', 'O que é continuidade?', 'f é contínua em a se: f(a) existe, lim(x→a) f(x) existe, e lim(x→a) f(x) = f(a). Sem "buracos" ou "saltos".', 'Stewart Cálculo'),
  (v_deck_id, 6, 'basic', 'O que é derivada?', 'f''(x) = lim(h→0) [f(x+h)-f(x)]/h. Taxa de variação instantânea. Inclinação da reta tangente.', 'Stewart Cálculo'),
  (v_deck_id, 7, 'basic', 'Quais as regras básicas de derivação?', 'd/dx(xⁿ) = nxⁿ⁻¹. d/dx(eˣ) = eˣ. d/dx(ln x) = 1/x. d/dx(sen x) = cos x. d/dx(cos x) = -sen x.', 'Stewart Cálculo'),
  (v_deck_id, 8, 'basic', 'O que é a regra do produto?', '(fg)'' = f''g + fg''. Derivada do primeiro vezes segundo mais primeiro vezes derivada do segundo.', 'Stewart Cálculo'),
  (v_deck_id, 9, 'basic', 'O que é a regra do quociente?', '(f/g)'' = (f''g - fg'')/g². "Linha de cima vezes embaixo menos cima vezes linha de baixo, sobre baixo ao quadrado."', 'Stewart Cálculo'),
  (v_deck_id, 10, 'basic', 'O que é a regra da cadeia?', '(f∘g)''(x) = f''(g(x))·g''(x). Derivada da externa avaliada na interna vezes derivada da interna.', 'Stewart Cálculo'),
  (v_deck_id, 11, 'basic', 'O que são pontos críticos?', 'Pontos onde f''(x) = 0 ou f''(x) não existe. Candidatos a máximos e mínimos locais.', 'Stewart Cálculo'),
  (v_deck_id, 12, 'basic', 'O que diz o teste da primeira derivada?', 'f'' muda de + para - em c: máximo local. f'' muda de - para + em c: mínimo local.', 'Stewart Cálculo'),
  (v_deck_id, 13, 'basic', 'O que diz o teste da segunda derivada?', 'Se f''(c)=0 e f''''(c)>0: mínimo. Se f''''(c)<0: máximo. Se f''''(c)=0: inconclusivo.', 'Stewart Cálculo'),
  (v_deck_id, 14, 'basic', 'O que é ponto de inflexão?', 'Ponto onde a concavidade muda (de côncava para cima para côncava para baixo ou vice-versa). f''''(x) = 0 ou não existe.', 'Stewart Cálculo'),
  (v_deck_id, 15, 'basic', 'O que é integral indefinida?', '∫f(x)dx = F(x) + C, onde F''(x) = f(x). Antiderivada. C é constante arbitrária.', 'Stewart Cálculo'),
  (v_deck_id, 16, 'basic', 'Quais as integrais básicas?', '∫xⁿdx = xⁿ⁺¹/(n+1). ∫eˣdx = eˣ. ∫1/x dx = ln|x|. ∫cos x dx = sen x. ∫sen x dx = -cos x.', 'Stewart Cálculo'),
  (v_deck_id, 17, 'basic', 'O que é a integral definida?', '∫[a,b] f(x)dx = área sob a curva entre a e b. Pode ser negativa se f(x) < 0.', 'Stewart Cálculo'),
  (v_deck_id, 18, 'basic', 'O que diz o Teorema Fundamental do Cálculo?', 'Parte 1: d/dx ∫[a,x] f(t)dt = f(x). Parte 2: ∫[a,b] f(x)dx = F(b) - F(a).', 'Stewart Cálculo'),
  (v_deck_id, 19, 'basic', 'O que é integração por substituição?', 'Trocar variável para simplificar. Se u = g(x), então ∫f(g(x))g''(x)dx = ∫f(u)du.', 'Stewart Cálculo'),
  (v_deck_id, 20, 'basic', 'O que é integração por partes?', '∫u dv = uv - ∫v du. Útil para produtos (LIATE: log, inversa trig, algébrica, trig, exponencial).', 'Stewart Cálculo'),
  (v_deck_id, 21, 'basic', 'Como calcular área entre curvas?', 'A = ∫[a,b] |f(x) - g(x)| dx. Curva de cima menos curva de baixo.', 'Stewart Cálculo'),
  (v_deck_id, 22, 'basic', 'Como calcular volume de sólido de revolução?', 'Discos: V = π∫r²dx. Cascas: V = 2π∫r·h dx. Depende do eixo de rotação.', 'Stewart Cálculo'),
  (v_deck_id, 23, 'basic', 'O que é a Regra de L''Hôpital?', 'Para formas indeterminadas 0/0 ou ∞/∞: lim f/g = lim f''/g'' (se o limite da direita existe).', 'Stewart Cálculo'),
  (v_deck_id, 24, 'basic', 'O que é série de Taylor?', 'f(x) = Σ f⁽ⁿ⁾(a)(x-a)ⁿ/n!. Aproximação polinomial de funções. Maclaurin: a = 0.', 'Stewart Cálculo'),
  (v_deck_id, 25, 'basic', 'Qual a série de Taylor de eˣ?', 'eˣ = 1 + x + x²/2! + x³/3! + ... = Σ xⁿ/n!. Converge para todo x.', 'Stewart Cálculo'),
  (v_deck_id, 26, 'basic', 'O que é convergência de séries?', 'Série converge se a soma parcial tem limite finito. Testes: razão, raiz, integral, comparação.', 'Stewart Cálculo'),
  (v_deck_id, 27, 'basic', 'O que é derivação implícita?', 'Derivar equação implícita F(x,y)=0 em relação a x, tratando y como função de x. Aparece dy/dx.', 'Stewart Cálculo'),
  (v_deck_id, 28, 'basic', 'O que são taxas relacionadas?', 'Problemas onde duas quantidades variam com o tempo e precisamos relacionar suas derivadas temporais.', 'Stewart Cálculo'),
  (v_deck_id, 29, 'basic', 'O que é integral imprópria?', 'Integral com limites infinitos ou integrando com descontinuidade. Converge se o limite existe.', 'Stewart Cálculo'),
  (v_deck_id, 30, 'basic', 'O que é o Teorema do Valor Médio?', 'Se f é contínua em [a,b] e derivável em (a,b), existe c tal que f''(c) = [f(b)-f(a)]/(b-a).', 'Stewart Cálculo');

  RAISE NOTICE 'Decks de Medicina e Engenharia inseridos com sucesso!';
END $$;
