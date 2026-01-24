-- Marketplace Seed: Decks de Biologia

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-da-natureza/biologia';

  -- CITOLOGIA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Citologia: Célula, Organelas e Divisão Celular', 'Estrutura celular, membrana, organelas, metabolismo energético e divisão celular.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'citologia', 'célula', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a diferença entre célula procarionte e eucarionte?', 'Procarionte: sem núcleo organizado, DNA no nucleoide (bactérias). Eucarionte: núcleo com envelope, organelas membranosas (animais, plantas, fungos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 2, 'basic', 'Quais as principais estruturas da membrana plasmática?', 'Bicamada lipídica (fosfolipídios), proteínas (integrais e periféricas), colesterol, glicoproteínas. Modelo do mosaico fluido.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 3, 'basic', 'O que é transporte passivo?', 'Sem gasto de ATP, a favor do gradiente. Difusão simples, difusão facilitada e osmose.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 4, 'basic', 'O que é transporte ativo?', 'Com gasto de ATP, contra o gradiente. Ex: bomba de sódio-potássio (3 Na⁺ para fora, 2 K⁺ para dentro).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 5, 'basic', 'O que é osmose?', 'Passagem de água do meio hipotônico para hipertônico através de membrana semipermeável.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 6, 'basic', 'Qual a função do núcleo celular?', 'Armazena DNA, controla atividades celulares, local de replicação do DNA e transcrição do RNA.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 7, 'basic', 'Quais as funções do retículo endoplasmático?', 'RE Rugoso: síntese de proteínas (ribossomos). RE Liso: síntese de lipídios, desintoxicação.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 8, 'basic', 'Qual a função do complexo de Golgi?', 'Modifica, empacota e secreta proteínas. Forma lisossomos. Produz o acrossomo do espermatozoide.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 9, 'basic', 'O que são lisossomos?', 'Vesículas com enzimas digestivas. Digestão intracelular (autofagia e heterofagia).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 10, 'basic', 'Qual a função das mitocôndrias?', 'Respiração celular aeróbica: produção de ATP. Possuem DNA próprio. Teoria endossimbiótica.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 11, 'basic', 'Qual a função dos cloroplastos?', 'Fotossíntese: converte energia luminosa em química (glicose). Possuem DNA próprio. Só em células vegetais.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 12, 'basic', 'Qual a equação geral da respiração celular?', 'C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O + ATP. Glicólise → Ciclo de Krebs → Cadeia respiratória.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 13, 'basic', 'Qual a equação geral da fotossíntese?', '6CO₂ + 6H₂O + luz → C₆H₁₂O₆ + 6O₂. Fase clara (tilacoides) → Fase escura (estroma).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 14, 'basic', 'O que é fermentação?', 'Respiração anaeróbica parcial. Alcoólica: glicose → etanol + CO₂. Láctica: glicose → ácido láctico.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 15, 'basic', 'Quais as fases do ciclo celular?', 'Interfase (G1, S, G2) + Divisão (Mitose ou Meiose). S: replicação do DNA.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 16, 'basic', 'Quais as fases da mitose?', 'Prófase, Metáfase, Anáfase, Telófase (PMAT). Divide célula 2n em 2 células 2n idênticas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 17, 'basic', 'O que ocorre na prófase da mitose?', 'Condensação dos cromossomos, formação do fuso, desaparecimento do nucléolo e envelope nuclear.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 18, 'basic', 'O que ocorre na metáfase?', 'Cromossomos alinhados na placa equatorial, máxima condensação, fuso ligado aos centrômeros.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 19, 'basic', 'Quais as características da meiose?', 'Duas divisões (Meiose I e II). Célula 2n → 4 células n. Redução e variabilidade genética.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 20, 'basic', 'O que é crossing-over?', 'Troca de segmentos entre cromátides homólogas na prófase I. Aumenta variabilidade genética.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 21, 'basic', 'Qual a diferença entre mitose e meiose?', 'Mitose: 1 divisão, 2 células 2n, idênticas (crescimento). Meiose: 2 divisões, 4 células n, variáveis (gametas).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 22, 'basic', 'O que são ribossomos?', 'Organelas de síntese proteica. Formados por RNA ribossômico e proteínas. Livres ou aderidos ao RE.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 23, 'basic', 'Qual a função do citoesqueleto?', 'Suporte estrutural, movimento celular, transporte interno. Microtúbulos, microfilamentos, filamentos intermediários.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 24, 'basic', 'O que é a parede celular?', 'Envoltório rígido de celulose (plantas), quitina (fungos) ou peptidoglicano (bactérias). Dá forma e proteção.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 25, 'basic', 'O que é o vacúolo?', 'Grande vesícula na célula vegetal. Armazena água, nutrientes, pigmentos. Mantém turgência.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 26, 'basic', 'O que são centríolos?', 'Organelas cilíndricas que organizam o fuso mitótico. Formam cílios e flagelos. Ausentes em plantas superiores.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 27, 'basic', 'O que é ATP e qual sua função?', 'Adenosina trifosfato: moeda energética da célula. Libera energia ao perder fosfato (ATP → ADP + Pi).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 28, 'basic', 'O que são peroxissomos?', 'Vesículas com enzimas oxidativas. Degradam H₂O₂ e ácidos graxos. Importante no fígado.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 29, 'basic', 'O que é endocitose e exocitose?', 'Endocitose: entrada de materiais (fagocitose, pinocitose). Exocitose: saída de materiais (secreção).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 30, 'basic', 'O que são células-tronco?', 'Células indiferenciadas capazes de se dividir e diferenciar em tipos especializados. Totipotentes, pluripotentes, multipotentes.', 'Biologia - Amabis & Martho');

  -- GENÉTICA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Genética: Mendel, DNA e Biotecnologia', 'Leis de Mendel, grupos sanguíneos, DNA, RNA e engenharia genética.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'genética', 'dna', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que diz a 1ª Lei de Mendel?', 'Lei da Segregação: cada característica é determinada por 2 fatores (alelos) que se separam na formação dos gametas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 2, 'basic', 'O que são alelos dominantes e recessivos?', 'Dominante (A): manifesta-se em homozigose e heterozigose. Recessivo (a): só manifesta em homozigose (aa).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 3, 'basic', 'Qual a proporção fenotípica de Aa × Aa?', '3:1 (3 dominantes : 1 recessivo). Genotípica: 1 AA : 2 Aa : 1 aa.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 4, 'basic', 'O que diz a 2ª Lei de Mendel?', 'Lei da Segregação Independente: genes em cromossomos diferentes segregam-se independentemente. AaBb → 9:3:3:1.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 5, 'basic', 'O que é codominância?', 'Ambos alelos se expressam no heterozigoto. Ex: grupo sanguíneo AB (Iᴬ e Iᴮ expressos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 6, 'basic', 'Quais os genótipos dos grupos sanguíneos ABO?', 'A: IᴬIᴬ ou Iᴬi. B: IᴮIᴮ ou Iᴮi. AB: IᴬIᴮ. O: ii.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 7, 'basic', 'O que é o fator Rh?', 'Antígeno na superfície das hemácias. Rh⁺: possui (DD ou Dd). Rh⁻: não possui (dd). Eritroblastose fetal.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 8, 'basic', 'O que é herança ligada ao sexo?', 'Genes nos cromossomos sexuais (X ou Y). Daltonismo e hemofilia ligados ao X. Homem = XY, Mulher = XX.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 9, 'basic', 'O que é o DNA?', 'Ácido desoxirribonucleico: dupla hélice de nucleotídeos (A-T, G-C). Armazena informação genética.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 10, 'basic', 'Quais as diferenças entre DNA e RNA?', 'DNA: dupla fita, desoxirribose, timina. RNA: fita simples, ribose, uracila.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 11, 'basic', 'O que é replicação do DNA?', 'Duplicação semiconservativa: cada fita serve de molde. DNA polimerase adiciona nucleotídeos 5''→3''.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 12, 'basic', 'O que é transcrição?', 'Síntese de RNA a partir de DNA. RNA polimerase lê o DNA 3''→5'' e produz RNA 5''→3''.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 13, 'basic', 'O que é tradução?', 'Síntese de proteína a partir do mRNA. Ribossomos leem códons (3 nucleotídeos) e adicionam aminoácidos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 14, 'basic', 'Quais os tipos de RNA?', 'mRNA (mensageiro): leva informação. tRNA (transportador): traz aminoácidos. rRNA (ribossômico): forma ribossomos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 15, 'basic', 'O que é mutação?', 'Alteração na sequência de DNA. Pode ser pontual, cromossômica, gênica. Fonte de variabilidade.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 16, 'basic', 'O que é PCR?', 'Reação em Cadeia da Polimerase: amplifica DNA. Usa DNA polimerase termoestável, primers e ciclos térmicos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 17, 'basic', 'O que são enzimas de restrição?', 'Cortam DNA em sequências específicas. Usadas em engenharia genética para criar DNA recombinante.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 18, 'basic', 'O que é clonagem?', 'Produção de cópias geneticamente idênticas. Clonagem molecular (genes) ou reprodutiva (organismos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 19, 'basic', 'O que são organismos transgênicos?', 'Organismos com genes de outra espécie inseridos. Ex: soja Roundup Ready, insulina recombinante.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 20, 'basic', 'O que é CRISPR-Cas9?', 'Ferramenta de edição genética precisa. "Tesoura molecular" que corta DNA em locais específicos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 21, 'basic', 'O que é teste de DNA?', 'Compara perfis genéticos usando marcadores (STRs). Usado em paternidade e forense.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 22, 'basic', 'O que é terapia gênica?', 'Inserção de genes funcionais para tratar doenças genéticas. Usa vetores virais ou não-virais.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 23, 'basic', 'O que é epistasia?', 'Um gene afeta a expressão de outro. Ex: cor de pelos em camundongos (gene C epistático sobre B).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 24, 'basic', 'O que é pleiotropia?', 'Um gene afeta múltiplas características. Ex: gene da anemia falciforme afeta hemácias, baço, coração.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 25, 'basic', 'O que é herança quantitativa?', 'Múltiplos genes contribuem para característica (poligenia). Efeito aditivo. Ex: cor da pele, altura.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 26, 'basic', 'O que é um heredograma?', 'Diagrama de árvore genealógica mostrando herança de características em famílias.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 27, 'basic', 'O que é linkage (ligação gênica)?', 'Genes no mesmo cromossomo tendem a ser herdados juntos. Crossing-over pode separá-los.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 28, 'basic', 'O que é mapa genético?', 'Mostra posições relativas de genes no cromossomo. Baseado em frequência de recombinação.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 29, 'basic', 'O que é o Projeto Genoma Humano?', 'Sequenciou os ~3 bilhões de pares de bases do DNA humano. Concluído em 2003.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 30, 'basic', 'O que são células HeLa?', 'Primeira linhagem celular humana imortalizada (1951). De Henrietta Lacks. Usadas em pesquisas.', 'Biologia - Amabis & Martho');

  -- EVOLUÇÃO
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Evolução: Darwin, Seleção Natural e Especiação', 'Teorias evolutivas, evidências da evolução, seleção natural e formação de espécies.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'evolução', 'darwin', 'enem'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a teoria de Lamarck?', 'Lei do Uso e Desuso + Herança de caracteres adquiridos. Ex: pescoço da girafa alongou pelo uso. Incorreta, mas histórica.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 2, 'basic', 'Qual a teoria de Darwin?', 'Seleção Natural: variação + competição → sobrevivência dos mais aptos → reprodução diferencial → evolução.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 3, 'basic', 'O que é o Neodarwinismo (Síntese Moderna)?', 'Darwin + Genética. Mutações e recombinação geram variação. Seleção natural atua sobre variação genética.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 4, 'basic', 'O que é seleção natural?', 'Indivíduos mais adaptados têm maior sucesso reprodutivo. Ambiente "seleciona" fenótipos vantajosos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 5, 'basic', 'Quais as evidências da evolução?', 'Fósseis, anatomia comparada (homologia), embriologia, bioquímica, biogeografia.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 6, 'basic', 'O que são órgãos homólogos?', 'Mesma origem embrionária, funções diferentes. Ex: asa de morcego e braço humano. Evidência de ancestral comum.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 7, 'basic', 'O que são órgãos análogos?', 'Origens diferentes, funções semelhantes. Ex: asa de inseto e asa de ave. Evolução convergente.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 8, 'basic', 'O que são órgãos vestigiais?', 'Estruturas reduzidas sem função aparente. Ex: apêndice, cóccix, terceira pálpebra. Herança de ancestrais.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 9, 'basic', 'O que é especiação?', 'Formação de novas espécies. Requer isolamento reprodutivo (geográfico, comportamental, temporal).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 10, 'basic', 'O que é especiação alopátrica?', 'Separação geográfica leva a divergência genética. Quando reunidas, não se cruzam mais. Mais comum.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 11, 'basic', 'O que é especiação simpátrica?', 'Especiação sem isolamento geográfico. Por poliploidia (plantas) ou nichos diferentes (peixes cíclicos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 12, 'basic', 'O que é deriva genética?', 'Mudança aleatória de frequências alélicas em populações pequenas. Efeito fundador, gargalo de garrafa.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 13, 'basic', 'O que é fluxo gênico?', 'Troca de genes entre populações por migração. Aumenta variabilidade, diminui divergência.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 14, 'basic', 'O que é seleção estabilizadora?', 'Favorece fenótipo médio. Extremos são eliminados. Ex: peso de bebês humanos ao nascer.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 15, 'basic', 'O que é seleção direcional?', 'Favorece um extremo. Muda a média da população. Ex: resistência a antibióticos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 16, 'basic', 'O que é seleção disruptiva?', 'Favorece ambos extremos, elimina intermediários. Pode levar a especiação.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 17, 'basic', 'O que é seleção sexual?', 'Características que aumentam sucesso de acasalamento. Ex: cauda do pavão, canto de pássaros.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 18, 'basic', 'O que é coevolução?', 'Evolução recíproca de espécies que interagem. Ex: flores e polinizadores, predadores e presas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 19, 'basic', 'O que é equilíbrio de Hardy-Weinberg?', 'Frequências alélicas constantes sem evolução. Condições: grande pop., panmixia, sem mutação/seleção/fluxo.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 20, 'basic', 'Qual a fórmula de Hardy-Weinberg?', 'p² + 2pq + q² = 1, onde p + q = 1. p² = AA, 2pq = Aa, q² = aa.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 21, 'basic', 'O que é irradiação adaptativa?', 'Diversificação rápida de uma linhagem em muitas espécies. Ex: tentilhões de Darwin, mamíferos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 22, 'basic', 'O que é evolução convergente?', 'Espécies não-relacionadas desenvolvem características semelhantes por pressões seletivas similares.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 23, 'basic', 'O que é o relógio molecular?', 'Mutações acumulam-se a taxa constante. Permite estimar tempo de divergência entre espécies.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 24, 'basic', 'O que é filogenia?', 'História evolutiva de um grupo. Representada por cladogramas. Baseada em características derivadas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 25, 'basic', 'O que são grupos monofiléticos?', 'Ancestral comum + todos descendentes (clado verdadeiro). Parafiléticos excluem alguns descendentes.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 26, 'basic', 'Quando surgiu a vida na Terra?', '~3,8 bilhões de anos atrás. Primeiras células procariontes. Eucariontes: ~2 bilhões.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 27, 'basic', 'O que foi a explosão cambriana?', '~540 milhões de anos. Surgimento rápido de muitos filos animais. Maioria dos planos corporais modernos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 28, 'basic', 'Quais as grandes extinções em massa?', '5 principais: Ordoviciano, Devoniano, Permiano (maior, 90%), Triássico, Cretáceo (dinossauros).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 29, 'basic', 'O que é a teoria do equilíbrio pontuado?', 'Evolução não é gradual: longos períodos de estase alternados com mudanças rápidas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 30, 'basic', 'Como surgiu o oxigênio atmosférico?', 'Cianobactérias (fotossíntese) liberaram O₂. Grande Evento de Oxidação ~2,4 bilhões de anos.', 'Biologia - Amabis & Martho');

  -- ECOLOGIA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Ecologia: Cadeias, Ciclos e Biomas', 'Ecossistemas, cadeias alimentares, relações ecológicas, ciclos biogeoquímicos e biomas.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'ecologia', 'biomas', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é ecossistema?', 'Comunidade biológica + ambiente físico. Fatores bióticos (seres vivos) + abióticos (luz, água, solo).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 2, 'basic', 'O que é cadeia alimentar?', 'Sequência de transferência de energia: produtor → consumidor primário → secundário → terciário → decompositor.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 3, 'basic', 'O que é teia alimentar?', 'Conjunto de cadeias alimentares interligadas. Representa relações alimentares complexas do ecossistema.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 4, 'basic', 'O que são níveis tróficos?', 'Posição na cadeia alimentar. 1º: produtores. 2º: herbívoros. 3º: carnívoros. Decompositores em todos níveis.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 5, 'basic', 'Por que cadeias alimentares são curtas?', 'Perda de ~90% da energia a cada nível trófico (respiração, calor). Só 10% passa ao próximo nível.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 6, 'basic', 'O que são pirâmides ecológicas?', 'Representam número, biomassa ou energia por nível trófico. Energia: sempre decresce. Biomassa: pode inverter (aquáticos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 7, 'basic', 'O que é magnificação trófica?', 'Concentração de poluentes aumenta nos níveis superiores. Ex: DDT, mercúrio. Topo da cadeia mais afetado.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 8, 'basic', 'Quais as relações ecológicas harmônicas?', 'Mutualismo (+/+), comensalismo (+/0), protocooperação (+/+). Benefício para pelo menos um.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 9, 'basic', 'Quais as relações ecológicas desarmônicas?', 'Predação (+/-), parasitismo (+/-), competição (-/-), amensalismo (-/0). Prejuízo para pelo menos um.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 10, 'basic', 'O que é mutualismo?', 'Benefício mútuo obrigatório. Ex: micorrizas (fungo + raiz), líquens (fungo + alga), cupim + protozoários.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 11, 'basic', 'O que é o ciclo do carbono?', 'CO₂ → fotossíntese → matéria orgânica → respiração/decomposição → CO₂. Combustíveis fósseis alteraram.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 12, 'basic', 'O que é o ciclo do nitrogênio?', 'N₂ atmosférico → fixação (bactérias) → nitratos → assimilação → decomposição → desnitrificação → N₂.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 13, 'basic', 'O que é fixação biológica de nitrogênio?', 'Bactérias (Rhizobium, Azotobacter) convertem N₂ em amônia. Essencial pois plantas não usam N₂.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 14, 'basic', 'O que é o ciclo da água?', 'Evaporação → condensação → precipitação → infiltração/escoamento. Sol fornece energia.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 15, 'basic', 'O que é sucessão ecológica?', 'Mudança gradual na comunidade ao longo do tempo. Primária: solo nu. Secundária: após perturbação.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 16, 'basic', 'O que é comunidade clímax?', 'Estágio final estável da sucessão. Máxima diversidade e biomassa. Equilibrada com o ambiente.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 17, 'basic', 'Quais os biomas brasileiros?', 'Amazônia, Cerrado, Mata Atlântica, Caatinga, Pampa, Pantanal. Cada um com flora e fauna características.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 18, 'basic', 'O que caracteriza a Amazônia?', 'Maior floresta tropical. Alta biodiversidade, clima equatorial, rio Amazonas. Desmatamento é problema grave.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 19, 'basic', 'O que caracteriza o Cerrado?', 'Savana brasileira. Árvores tortuosas, raízes profundas, fogo natural. Segunda maior biodiversidade. Muito devastado.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 20, 'basic', 'O que caracteriza a Caatinga?', 'Semiárido nordestino. Plantas xerófitas (cactos), caducifólias. Adaptações à seca: reserva de água, folhas modificadas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 21, 'basic', 'O que é efeito estufa?', 'Gases (CO₂, CH₄) retêm calor na atmosfera. Natural e necessário, mas intensificação causa aquecimento global.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 22, 'basic', 'O que é eutrofização?', 'Excesso de nutrientes (N, P) em água. Proliferação de algas → decomposição → falta de O₂ → morte de peixes.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 23, 'basic', 'O que são espécies invasoras?', 'Espécies introduzidas que se proliferam causando danos. Ex: mexilhão dourado, coral-sol, caramujo africano.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 24, 'basic', 'O que é biodiversidade?', 'Variedade de vida: genética, de espécies e de ecossistemas. Essencial para resiliência e serviços ecossistêmicos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 25, 'basic', 'O que são espécies-chave?', 'Espécies com papel desproporcional no ecossistema. Remoção causa efeito cascata. Ex: predadores de topo, engenheiros.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 26, 'basic', 'O que é desenvolvimento sustentável?', 'Atender necessidades atuais sem comprometer gerações futuras. Equilibra economia, sociedade e ambiente.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 27, 'basic', 'O que são unidades de conservação?', 'Áreas protegidas por lei. Proteção integral (parques) ou uso sustentável (reservas extrativistas).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 28, 'basic', 'O que é pegada ecológica?', 'Área necessária para sustentar estilo de vida. Mede impacto ambiental. Varia por país e hábitos.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 29, 'basic', 'O que é capacidade de suporte?', 'Máxima população que ambiente pode sustentar. Limitada por recursos. Crescimento logístico.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 30, 'basic', 'O que é nicho ecológico?', 'Papel funcional da espécie: o que come, onde vive, como se reproduz. "Profissão" da espécie.', 'Biologia - Amabis & Martho');

  -- FISIOLOGIA HUMANA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Fisiologia Humana: Sistemas do Corpo', 'Sistemas digestório, respiratório, circulatório, excretor, nervoso, endócrino e reprodutor.', 0, v_user_id, v_cat_id, ARRAY['biologia', 'fisiologia', 'corpo humano', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais as partes do sistema digestório?', 'Boca → Esôfago → Estômago → Intestino delgado (duodeno, jejuno, íleo) → Intestino grosso → Reto → Ânus.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 2, 'basic', 'O que ocorre no estômago?', 'Digestão de proteínas por pepsina (ativada pelo HCl). Produz quimo. pH ~2.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 3, 'basic', 'Qual a função do intestino delgado?', 'Digestão (enzimas pancreáticas e bile) e absorção de nutrientes. Vilosidades aumentam área.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 4, 'basic', 'Qual a função do pâncreas na digestão?', 'Produz suco pancreático: amilase (amido), lipase (gordura), tripsina (proteínas). Neutraliza acidez.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 5, 'basic', 'Qual a função da bile?', 'Emulsifica gorduras (sem enzimas). Produzida pelo fígado, armazenada na vesícula biliar.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 6, 'basic', 'Quais as partes do sistema respiratório?', 'Narinas → Faringe → Laringe → Traqueia → Brônquios → Bronquíolos → Alvéolos pulmonares.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 7, 'basic', 'O que ocorre nos alvéolos?', 'Hematose: troca gasosa por difusão. O₂ entra no sangue, CO₂ sai. Parede fina, muito vascularizada.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 8, 'basic', 'Como é controlada a respiração?', 'Centro respiratório no bulbo. Sensores de CO₂ e pH. Aumento de CO₂ → acelera respiração.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 9, 'basic', 'Quais as partes do coração?', '2 átrios (recebem sangue) + 2 ventrículos (bombeiam). Lado direito: sangue venoso. Esquerdo: arterial.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 10, 'basic', 'Qual o trajeto do sangue na circulação?', 'Pequena: VD → pulmões → AE (oxigenação). Grande: VE → corpo → AD (nutrição dos tecidos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 11, 'basic', 'Qual a diferença entre artérias e veias?', 'Artérias: paredes grossas, saem do coração, geralmente sangue arterial. Veias: paredes finas, têm válvulas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 12, 'basic', 'O que é pressão arterial?', 'Força do sangue nas artérias. Sistólica (contração) ~120 mmHg. Diastólica (relaxamento) ~80 mmHg.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 13, 'basic', 'Quais os componentes do sangue?', 'Plasma (55%): água e solutos. Hemácias (O₂), leucócitos (defesa), plaquetas (coagulação).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 14, 'basic', 'Qual a função do sistema linfático?', 'Drena fluido dos tecidos, transporta gorduras, defesa imune (linfonodos filtram patógenos).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 15, 'basic', 'Quais os órgãos do sistema excretor?', 'Rins (filtração), ureteres (condução), bexiga (armazenamento), uretra (eliminação).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 16, 'basic', 'O que é néfron?', 'Unidade funcional do rim. Glomérulo (filtração) + túbulos (reabsorção/secreção). ~1 milhão por rim.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 17, 'basic', 'Como os rins regulam a pressão arterial?', 'Sistema renina-angiotensina-aldosterona. Retêm Na⁺ e água → aumenta volume → aumenta PA.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 18, 'basic', 'Quais as partes do sistema nervoso?', 'SNC: encéfalo + medula. SNP: nervos + gânglios. Autônomo: simpático (acelera) e parassimpático (relaxa).', 'Biologia - Amabis & Martho'),
  (v_deck_id, 19, 'basic', 'O que é sinapse?', 'Junção entre neurônios. Neurotransmissores (acetilcolina, dopamina) transmitem sinal químico.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 20, 'basic', 'Quais as funções das partes do encéfalo?', 'Cérebro: pensamento, memória. Cerebelo: equilíbrio, coordenação. Bulbo: funções vitais.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 21, 'basic', 'O que é arco reflexo?', 'Resposta rápida sem participação consciente. Receptor → neurônio aferente → medula → eferente → efetor.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 22, 'basic', 'Quais as principais glândulas endócrinas?', 'Hipófise, tireoide, paratireoides, suprarrenais, pâncreas, gônadas, pineal, timo.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 23, 'basic', 'Qual a função da insulina e glucagon?', 'Insulina: diminui glicemia (após refeição). Glucagon: aumenta glicemia (jejum). Produzidos no pâncreas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 24, 'basic', 'Qual a função dos hormônios tireoidianos?', 'T3 e T4 regulam metabolismo. Hipotireoidismo: metabolismo lento. Hipertireoidismo: acelerado.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 25, 'basic', 'O que é o eixo hipotálamo-hipófise?', 'Hipotálamo controla hipófise por hormônios. Hipófise é "maestro" das outras glândulas.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 26, 'basic', 'Quais os órgãos do sistema reprodutor masculino?', 'Testículos (espermatozoides, testosterona), epidídimo, ducto deferente, vesícula seminal, próstata, pênis.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 27, 'basic', 'Quais os órgãos do sistema reprodutor feminino?', 'Ovários (óvulos, hormônios), tubas uterinas, útero, vagina. Ciclo menstrual ~28 dias.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 28, 'basic', 'O que ocorre no ciclo menstrual?', 'Fase folicular: FSH → folículo cresce. Ovulação: LH → libera óvulo. Fase lútea: corpo lúteo produz progesterona.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 29, 'basic', 'O que são anticoncepcionais hormonais?', 'Contêm estrogênio e progesterona sintéticos. Impedem ovulação e alteram muco cervical.', 'Biologia - Amabis & Martho'),
  (v_deck_id, 30, 'basic', 'O que é imunidade humoral e celular?', 'Humoral: anticorpos (linfócitos B) contra patógenos extracelulares. Celular: linfócitos T contra células infectadas.', 'Biologia - Amabis & Martho');

  RAISE NOTICE 'Decks de Biologia inseridos com sucesso!';
END $$;
