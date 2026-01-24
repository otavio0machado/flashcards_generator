-- Marketplace Seed: Decks de Química

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-da-natureza/quimica';

  -- QUÍMICA GERAL
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Química Geral: Atomística, Tabela Periódica e Ligações', 'Modelos atômicos, distribuição eletrônica, tabela periódica, ligações químicas e geometria molecular.', 0, v_user_id, v_cat_id, ARRAY['química', 'atomística', 'tabela periódica', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais as partículas subatômicas e suas características?', 'Prótons (p⁺): carga +1, massa 1u, no núcleo. Nêutrons (n): carga 0, massa 1u, no núcleo. Elétrons (e⁻): carga -1, massa desprezível, na eletrosfera.', 'Química - Feltre'),
  (v_deck_id, 2, 'basic', 'O que é número atômico (Z) e número de massa (A)?', 'Z = nº de prótons (define o elemento). A = p + n (prótons + nêutrons). Elétrons = prótons em átomo neutro.', 'Química - Feltre'),
  (v_deck_id, 3, 'basic', 'O que são isótopos, isóbaros e isótonos?', 'Isótopos: mesmo Z (mesmo elemento, A diferente). Isóbaros: mesmo A. Isótonos: mesmo nº de nêutrons.', 'Química - Feltre'),
  (v_deck_id, 4, 'basic', 'Descreva o modelo atômico de Bohr.', 'Elétrons em órbitas circulares com energia quantizada. Ao absorver energia, salta para nível superior; ao emitir, retorna.', 'Química - Feltre'),
  (v_deck_id, 5, 'basic', 'Qual a ordem de preenchimento dos subníveis (diagrama de Pauling)?', '1s² 2s² 2p⁶ 3s² 3p⁶ 4s² 3d¹⁰ 4p⁶ 5s² 4d¹⁰ 5p⁶ 6s² 4f¹⁴ 5d¹⁰ 6p⁶ 7s² 5f¹⁴ 6d¹⁰ 7p⁶', 'Química - Feltre'),
  (v_deck_id, 6, 'basic', 'Faça a distribuição eletrônica do Fe (Z=26).', '1s² 2s² 2p⁶ 3s² 3p⁶ 4s² 3d⁶. Camada de valência: 4s² 3d⁶. Ferro tem 8 elétrons na camada de valência.', 'Química - Feltre'),
  (v_deck_id, 7, 'basic', 'O que são os números quânticos?', 'n (principal): camada. l (secundário): subcamada (s,p,d,f). ml (magnético): orbital. ms (spin): +1/2 ou -1/2.', 'Química - Feltre'),
  (v_deck_id, 8, 'basic', 'Como a tabela periódica está organizada?', 'Períodos (linhas): níveis de energia. Grupos/Famílias (colunas): mesma configuração de valência, propriedades similares.', 'Química - Feltre'),
  (v_deck_id, 9, 'basic', 'Quais são os metais alcalinos e alcalino-terrosos?', 'Alcalinos (grupo 1): Li, Na, K, Rb, Cs, Fr. Alcalino-terrosos (grupo 2): Be, Mg, Ca, Sr, Ba, Ra.', 'Química - Feltre'),
  (v_deck_id, 10, 'basic', 'Quais são os halogênios e gases nobres?', 'Halogênios (grupo 17): F, Cl, Br, I, At. Gases Nobres (grupo 18): He, Ne, Ar, Kr, Xe, Rn.', 'Química - Feltre'),
  (v_deck_id, 11, 'basic', 'Como varia o raio atômico na tabela periódica?', 'Aumenta para baixo (mais camadas) e para esquerda (menos prótons atraindo). Maior raio: canto inferior esquerdo.', 'Química - Feltre'),
  (v_deck_id, 12, 'basic', 'O que é energia de ionização?', 'Energia para remover um elétron de um átomo gasoso. Aumenta para cima e para direita (gases nobres têm maior).', 'Química - Feltre'),
  (v_deck_id, 13, 'basic', 'O que é eletronegatividade?', 'Tendência de atrair elétrons em uma ligação. Aumenta para cima e para direita. Flúor é o mais eletronegativo.', 'Química - Feltre'),
  (v_deck_id, 14, 'basic', 'O que é ligação iônica?', 'Transferência de elétrons entre metal e não-metal. Forma íons (cátions e ânions). Compostos com alto PF e PE, conduzem dissolvidos.', 'Química - Feltre'),
  (v_deck_id, 15, 'basic', 'O que é ligação covalente?', 'Compartilhamento de elétrons entre não-metais. Pode ser simples, dupla ou tripla. Forma moléculas.', 'Química - Feltre'),
  (v_deck_id, 16, 'basic', 'O que é ligação metálica?', 'Elétrons livres ("mar de elétrons") entre cátions metálicos. Explica condutividade, brilho e maleabilidade dos metais.', 'Química - Feltre'),
  (v_deck_id, 17, 'basic', 'O que é a regra do octeto?', 'Átomos tendem a adquirir 8 elétrons na camada de valência (configuração de gás nobre). Exceções existem.', 'Química - Feltre'),
  (v_deck_id, 18, 'basic', 'O que são ligações sigma (σ) e pi (π)?', 'Sigma: sobreposição frontal, mais forte, primeira ligação. Pi: sobreposição lateral, mais fraca, ligações duplas/triplas.', 'Química - Feltre'),
  (v_deck_id, 19, 'basic', 'Qual a geometria da molécula de CO₂?', 'Linear. C faz 2 ligações duplas com O. Sem pares isolados no central. Ângulo de 180°.', 'Química - Feltre'),
  (v_deck_id, 20, 'basic', 'Qual a geometria da molécula de H₂O?', 'Angular. O faz 2 ligações com H e tem 2 pares isolados. Ângulo de ~104,5°.', 'Química - Feltre'),
  (v_deck_id, 21, 'basic', 'Qual a geometria da molécula de NH₃?', 'Piramidal. N faz 3 ligações com H e tem 1 par isolado. Ângulo de ~107°.', 'Química - Feltre'),
  (v_deck_id, 22, 'basic', 'Qual a geometria da molécula de CH₄?', 'Tetraédrica. C faz 4 ligações com H, sem pares isolados. Ângulo de 109,5°.', 'Química - Feltre'),
  (v_deck_id, 23, 'basic', 'O que determina se uma molécula é polar ou apolar?', 'Polar: vetor momento dipolar resultante ≠ 0. Apolar: simétrica ou só ligações apolares. H₂O polar, CO₂ apolar.', 'Química - Feltre'),
  (v_deck_id, 24, 'basic', 'Quais as forças intermoleculares e suas intensidades?', 'Ligação de hidrogênio > dipolo-dipolo > forças de London. Afetam PF, PE e solubilidade.', 'Química - Feltre'),
  (v_deck_id, 25, 'basic', 'Quando ocorre ligação de hidrogênio?', 'H ligado a F, O ou N interage com F, O ou N de outra molécula. Explica alto PE da água.', 'Química - Feltre'),
  (v_deck_id, 26, 'basic', 'O que são forças de London (dispersão)?', 'Forças fracas entre dipolos instantâneos/induzidos. Presentes em todas as moléculas, aumentam com massa molar.', 'Química - Feltre'),
  (v_deck_id, 27, 'basic', 'Por que a água tem alto ponto de ebulição?', 'Fortes ligações de hidrogênio entre as moléculas. Muita energia para romper essas ligações.', 'Química - Feltre'),
  (v_deck_id, 28, 'basic', 'O que é hibridização sp³?', '1 orbital s + 3 orbitais p = 4 orbitais sp³ equivalentes. Geometria tetraédrica. Ex: CH₄.', 'Química - Feltre'),
  (v_deck_id, 29, 'basic', 'O que é hibridização sp²?', '1 orbital s + 2 orbitais p = 3 orbitais sp². Geometria trigonal plana + 1 orbital p puro (ligação π). Ex: C₂H₄.', 'Química - Feltre'),
  (v_deck_id, 30, 'basic', 'O que é hibridização sp?', '1 orbital s + 1 orbital p = 2 orbitais sp. Geometria linear + 2 orbitais p puros (2 ligações π). Ex: C₂H₂.', 'Química - Feltre');

  -- QUÍMICA INORGÂNICA E REAÇÕES
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Química Inorgânica: Funções e Reações', 'Ácidos, bases, sais, óxidos, reações químicas e balanceamento estequiométrico.', 0, v_user_id, v_cat_id, ARRAY['química', 'inorgânica', 'reações', 'enem'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que caracteriza um ácido segundo Arrhenius?', 'Libera H⁺ (H₃O⁺) em solução aquosa. Exemplos: HCl, H₂SO₄, HNO₃. Têm sabor azedo e conduzem eletricidade.', 'Química - Feltre'),
  (v_deck_id, 2, 'basic', 'O que caracteriza uma base segundo Arrhenius?', 'Libera OH⁻ em solução aquosa. Exemplos: NaOH, Ca(OH)₂, NH₃. Têm sabor adstringente e são escorregadias.', 'Química - Feltre'),
  (v_deck_id, 3, 'basic', 'O que é um sal?', 'Composto iônico formado por cátion (de base) e ânion (de ácido). Produto de neutralização. Ex: NaCl, CaSO₄.', 'Química - Feltre'),
  (v_deck_id, 4, 'basic', 'Quais os principais ácidos e seus nomes?', 'HCl (clorídrico), H₂SO₄ (sulfúrico), HNO₃ (nítrico), H₃PO₄ (fosfórico), H₂CO₃ (carbônico), CH₃COOH (acético).', 'Química - Feltre'),
  (v_deck_id, 5, 'basic', 'Quais as bases mais comuns?', 'NaOH (soda cáustica), KOH (potassa), Ca(OH)₂ (cal hidratada), Mg(OH)₂ (leite de magnésia), NH₃ (amônia).', 'Química - Feltre'),
  (v_deck_id, 6, 'basic', 'O que são óxidos?', 'Compostos binários com oxigênio. Óxidos ácidos (CO₂, SO₃) reagem com água formando ácidos. Óxidos básicos (Na₂O, CaO) formam bases.', 'Química - Feltre'),
  (v_deck_id, 7, 'basic', 'Qual a reação de neutralização?', 'Ácido + Base → Sal + Água. Ex: HCl + NaOH → NaCl + H₂O.', 'Química - Feltre'),
  (v_deck_id, 8, 'basic', 'O que é uma reação de síntese (adição)?', 'A + B → AB. Dois ou mais reagentes formam um produto. Ex: 2H₂ + O₂ → 2H₂O.', 'Química - Feltre'),
  (v_deck_id, 9, 'basic', 'O que é uma reação de análise (decomposição)?', 'AB → A + B. Um reagente se decompõe em dois ou mais produtos. Ex: 2H₂O → 2H₂ + O₂.', 'Química - Feltre'),
  (v_deck_id, 10, 'basic', 'O que é uma reação de simples troca?', 'A + BC → AC + B. Elemento desloca outro de um composto. Ex: Zn + 2HCl → ZnCl₂ + H₂.', 'Química - Feltre'),
  (v_deck_id, 11, 'basic', 'O que é uma reação de dupla troca?', 'AB + CD → AD + CB. Troca de íons entre compostos. Ocorre se forma precipitado, gás ou água.', 'Química - Feltre'),
  (v_deck_id, 12, 'basic', 'O que é número de oxidação (NOx)?', 'Carga real ou aparente de um átomo. H geralmente +1, O geralmente -2. Soma dos NOx = carga total.', 'Química - Feltre'),
  (v_deck_id, 13, 'basic', 'O que é oxidação e redução?', 'Oxidação: perda de elétrons, NOx aumenta. Redução: ganho de elétrons, NOx diminui. "LEO goes GER".', 'Química - Feltre'),
  (v_deck_id, 14, 'basic', 'Como balancear uma equação por tentativa?', 'Balancear metais, não-metais (exceto O e H), depois O, depois H. Verificar: átomos iguais dos dois lados.', 'Química - Feltre'),
  (v_deck_id, 15, 'basic', 'O que é estequiometria?', 'Cálculo de quantidades em reações químicas usando proporções molares da equação balanceada.', 'Química - Feltre'),
  (v_deck_id, 16, 'basic', 'O que é mol?', '1 mol = 6,02×10²³ partículas (número de Avogadro). Massa molar = massa de 1 mol em gramas (igual à massa atômica).', 'Química - Feltre'),
  (v_deck_id, 17, 'basic', 'Quantos mols há em 36g de água (H₂O)?', 'M(H₂O) = 2(1) + 16 = 18 g/mol. n = m/M = 36/18 = 2 mol.', 'Química - Feltre'),
  (v_deck_id, 18, 'basic', 'Na reação 2H₂ + O₂ → 2H₂O, quantos mols de H₂O formam-se com 3 mols de O₂?', 'Proporção: 1 mol O₂ : 2 mol H₂O. Com 3 mol O₂: 6 mol H₂O.', 'Química - Feltre'),
  (v_deck_id, 19, 'basic', 'O que é reagente limitante?', 'Reagente que se esgota primeiro, determinando a quantidade de produto. Outros são reagentes em excesso.', 'Química - Feltre'),
  (v_deck_id, 20, 'basic', 'O que é rendimento de uma reação?', 'η = (quantidade real / quantidade teórica) × 100%. Rendimento real é menor que teórico.', 'Química - Feltre'),
  (v_deck_id, 21, 'basic', 'O que é a escala de pH?', 'pH = -log[H⁺]. pH < 7: ácido. pH = 7: neutro. pH > 7: básico. Varia de 0 a 14.', 'Química - Feltre'),
  (v_deck_id, 22, 'basic', 'Qual o pH de uma solução com [H⁺] = 10⁻³ M?', 'pH = -log(10⁻³) = 3. Solução ácida.', 'Química - Feltre'),
  (v_deck_id, 23, 'basic', 'O que são indicadores de pH?', 'Substâncias que mudam de cor com pH. Fenolftaleína: incolor (ácido) → rosa (base). Tornassol: azul/vermelho.', 'Química - Feltre'),
  (v_deck_id, 24, 'basic', 'O que é titulação?', 'Técnica para determinar concentração usando reação de neutralização. Ponto de equivalência: nₐcᵢdₒ = n_base.', 'Química - Feltre'),
  (v_deck_id, 25, 'basic', 'O que é concentração molar (molaridade)?', 'M = n/V = mol de soluto / litros de solução. Unidade: mol/L ou M.', 'Química - Feltre'),
  (v_deck_id, 26, 'basic', 'Qual a molaridade de 0,5 mol de NaCl em 250 mL?', 'M = 0,5/0,25 = 2 mol/L ou 2 M.', 'Química - Feltre'),
  (v_deck_id, 27, 'basic', 'O que é concentração comum (g/L)?', 'C = m/V = massa de soluto / volume de solução em litros.', 'Química - Feltre'),
  (v_deck_id, 28, 'basic', 'O que é diluição?', 'Adicionar solvente para diminuir concentração. M₁V₁ = M₂V₂ (quantidade de soluto constante).', 'Química - Feltre'),
  (v_deck_id, 29, 'basic', 'Diluir 100 mL de solução 2M para 500 mL. Qual a concentração final?', 'M₂ = M₁V₁/V₂ = 2×0,1/0,5 = 0,4 M.', 'Química - Feltre'),
  (v_deck_id, 30, 'basic', 'O que são coloides?', 'Dispersões com partículas entre 1-1000 nm. Ex: leite, neblina, gelatina. Apresentam efeito Tyndall.', 'Química - Feltre');

  -- FÍSICO-QUÍMICA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Físico-Química: Termoquímica, Cinética e Equilíbrio', 'Entalpia, cinética química, equilíbrio químico, pH e eletroquímica.', 0, v_user_id, v_cat_id, ARRAY['química', 'físico-química', 'termoquímica', 'enem'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é entalpia (H)?', 'Energia armazenada em uma substância a pressão constante. ΔH = H_produtos - H_reagentes.', 'Química - Feltre'),
  (v_deck_id, 2, 'basic', 'O que é reação exotérmica e endotérmica?', 'Exotérmica: libera calor, ΔH < 0. Endotérmica: absorve calor, ΔH > 0.', 'Química - Feltre'),
  (v_deck_id, 3, 'basic', 'O que é entalpia de formação padrão?', 'ΔH°f: entalpia para formar 1 mol de substância a partir de elementos em estado padrão (25°C, 1 atm).', 'Química - Feltre'),
  (v_deck_id, 4, 'basic', 'O que diz a Lei de Hess?', 'ΔH total = soma dos ΔH das etapas. A entalpia depende só dos estados inicial e final.', 'Química - Feltre'),
  (v_deck_id, 5, 'basic', 'Como calcular ΔH usando entalpias de formação?', 'ΔH = Σ(ΔHf produtos) - Σ(ΔHf reagentes).', 'Química - Feltre'),
  (v_deck_id, 6, 'basic', 'O que é energia de ligação?', 'Energia para romper 1 mol de ligações. ΔH = Σ(ligações rompidas) - Σ(ligações formadas).', 'Química - Feltre'),
  (v_deck_id, 7, 'basic', 'O que estuda a cinética química?', 'A velocidade das reações e os fatores que a afetam.', 'Química - Feltre'),
  (v_deck_id, 8, 'basic', 'Quais fatores afetam a velocidade de reação?', 'Concentração, temperatura, superfície de contato, catalisadores, natureza dos reagentes.', 'Química - Feltre'),
  (v_deck_id, 9, 'basic', 'O que é energia de ativação?', 'Energia mínima para iniciar uma reação. Catalisadores diminuem a energia de ativação.', 'Química - Feltre'),
  (v_deck_id, 10, 'basic', 'O que é um catalisador?', 'Substância que acelera a reação sem ser consumida. Diminui Eₐ, não altera ΔH nem o equilíbrio.', 'Química - Feltre'),
  (v_deck_id, 11, 'basic', 'O que é equilíbrio químico?', 'Estado onde v_direta = v_inversa. Concentrações constantes (não iguais). Sistema fechado.', 'Química - Feltre'),
  (v_deck_id, 12, 'basic', 'O que é a constante de equilíbrio Kc?', 'Kc = [produtos]^coef / [reagentes]^coef. Só inclui espécies em solução ou gasosas.', 'Química - Feltre'),
  (v_deck_id, 13, 'basic', 'O que indica o valor de Kc?', 'Kc >> 1: equilíbrio favorece produtos. Kc << 1: favorece reagentes. Kc ≈ 1: quantidades similares.', 'Química - Feltre'),
  (v_deck_id, 14, 'basic', 'O que diz o Princípio de Le Chatelier?', 'Sistema em equilíbrio, ao sofrer perturbação, desloca-se para minimizar a perturbação.', 'Química - Feltre'),
  (v_deck_id, 15, 'basic', 'Como a temperatura afeta o equilíbrio?', 'Aumentar T favorece reação endotérmica. Diminuir T favorece reação exotérmica.', 'Química - Feltre'),
  (v_deck_id, 16, 'basic', 'Como a pressão afeta o equilíbrio gasoso?', 'Aumentar P desloca para lado com menos mols gasosos. Diminuir P, para lado com mais mols.', 'Química - Feltre'),
  (v_deck_id, 17, 'basic', 'O que é Kw (produto iônico da água)?', 'Kw = [H⁺][OH⁻] = 10⁻¹⁴ a 25°C. Em água pura: [H⁺] = [OH⁻] = 10⁻⁷ M.', 'Química - Feltre'),
  (v_deck_id, 18, 'basic', 'Qual a relação pH + pOH?', 'pH + pOH = 14 (a 25°C). Se pH = 3, então pOH = 11.', 'Química - Feltre'),
  (v_deck_id, 19, 'basic', 'O que é solução tampão?', 'Resiste a variações de pH. Formada por ácido fraco + sal ou base fraca + sal.', 'Química - Feltre'),
  (v_deck_id, 20, 'basic', 'O que é hidrólise de sal?', 'Reação de íons do sal com água, alterando pH. Sal de ácido forte + base fraca: ácido.', 'Química - Feltre'),
  (v_deck_id, 21, 'basic', 'O que é uma pilha (célula galvânica)?', 'Transforma energia química em elétrica espontaneamente. Ânodo: oxidação. Cátodo: redução.', 'Química - Feltre'),
  (v_deck_id, 22, 'basic', 'Como calcular a ddp (fem) de uma pilha?', 'E° = E°cátodo - E°ânodo. Usar potenciais de redução padrão.', 'Química - Feltre'),
  (v_deck_id, 23, 'basic', 'O que ocorre no ânodo e no cátodo?', 'Ânodo: oxidação, polo negativo na pilha. Cátodo: redução, polo positivo na pilha.', 'Química - Feltre'),
  (v_deck_id, 24, 'basic', 'O que é eletrólise?', 'Usa energia elétrica para forçar reação não-espontânea. Inverso da pilha.', 'Química - Feltre'),
  (v_deck_id, 25, 'basic', 'Na eletrólise, o que ocorre em cada polo?', 'Cátodo (negativo): redução (atrai cátions). Ânodo (positivo): oxidação (atrai ânions).', 'Química - Feltre'),
  (v_deck_id, 26, 'basic', 'O que é a Lei de Faraday?', 'm = (M×i×t)/(n×F). Massa depositada proporcional à carga. F = 96500 C/mol.', 'Química - Feltre'),
  (v_deck_id, 27, 'basic', 'O que é corrosão?', 'Oxidação espontânea de metais pelo ambiente. Ferro: 4Fe + 3O₂ + 6H₂O → 4Fe(OH)₃.', 'Química - Feltre'),
  (v_deck_id, 28, 'basic', 'Como prevenir corrosão?', 'Galvanização (Zn), pintura, metal de sacrifício, ligas (aço inox).', 'Química - Feltre'),
  (v_deck_id, 29, 'basic', 'O que são propriedades coligativas?', 'Dependem da quantidade de partículas, não da natureza. Tonoscopia, ebulioscopia, crioscopia, osmose.', 'Química - Feltre'),
  (v_deck_id, 30, 'basic', 'O que é pressão osmótica?', 'Π = MRT. Pressão necessária para impedir osmose. Usada em dessalinização por osmose reversa.', 'Química - Feltre');

  -- QUÍMICA ORGÂNICA
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Química Orgânica: Cadeias, Funções e Reações', 'Carbono, hidrocarbonetos, funções orgânicas, isomeria e reações orgânicas.', 0, v_user_id, v_cat_id, ARRAY['química', 'orgânica', 'carbono', 'enem'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais as características do átomo de carbono?', 'Tetravalente (faz 4 ligações). Forma cadeias longas e ramificadas. Hibridização sp³, sp², sp.', 'Química - Feltre'),
  (v_deck_id, 2, 'basic', 'Como classificar carbonos na cadeia?', 'Primário: ligado a 1C. Secundário: 2C. Terciário: 3C. Quaternário: 4C.', 'Química - Feltre'),
  (v_deck_id, 3, 'basic', 'O que é cadeia saturada e insaturada?', 'Saturada: só ligações simples (C-C). Insaturada: tem dupla (C=C) ou tripla (C≡C).', 'Química - Feltre'),
  (v_deck_id, 4, 'basic', 'O que é cadeia homogênea e heterogênea?', 'Homogênea: só C na cadeia. Heterogênea: heteroátomo (O, N, S) entre carbonos.', 'Química - Feltre'),
  (v_deck_id, 5, 'basic', 'Quais os tipos de hidrocarbonetos?', 'Alcanos (CnH₂n₊₂), Alcenos (CnH₂n, 1 dupla), Alcinos (CnH₂n₋₂, 1 tripla), Ciclanos, Aromáticos.', 'Química - Feltre'),
  (v_deck_id, 6, 'basic', 'Quais os 4 primeiros alcanos?', 'Metano (CH₄), Etano (C₂H₆), Propano (C₃H₈), Butano (C₄H₁₀).', 'Química - Feltre'),
  (v_deck_id, 7, 'basic', 'O que são hidrocarbonetos aromáticos?', 'Têm anel benzênico (C₆H₆). Estrutura planar com elétrons deslocalizados.', 'Química - Feltre'),
  (v_deck_id, 8, 'basic', 'O que caracteriza um álcool?', 'Grupo funcional -OH ligado a carbono saturado. Ex: metanol (CH₃OH), etanol (C₂H₅OH).', 'Química - Feltre'),
  (v_deck_id, 9, 'basic', 'O que caracteriza um fenol?', 'Grupo -OH ligado diretamente a anel aromático. Ex: fenol (C₆H₅OH). Mais ácido que álcool.', 'Química - Feltre'),
  (v_deck_id, 10, 'basic', 'O que caracteriza um éter?', 'Oxigênio entre dois carbonos: R-O-R''. Ex: éter etílico (C₂H₅-O-C₂H₅).', 'Química - Feltre'),
  (v_deck_id, 11, 'basic', 'O que caracteriza um aldeído?', 'Grupo -CHO (carbonila terminal). Ex: formaldeído (HCHO), acetaldeído (CH₃CHO).', 'Química - Feltre'),
  (v_deck_id, 12, 'basic', 'O que caracteriza uma cetona?', 'Grupo C=O entre carbonos. Ex: acetona (CH₃-CO-CH₃), propanona.', 'Química - Feltre'),
  (v_deck_id, 13, 'basic', 'O que caracteriza um ácido carboxílico?', 'Grupo -COOH. Ex: ácido acético (CH₃COOH), ácido fórmico (HCOOH).', 'Química - Feltre'),
  (v_deck_id, 14, 'basic', 'O que caracteriza um éster?', 'Grupo -COO- (carbonila + oxigênio). Formado por ácido + álcool. Aromas de frutas.', 'Química - Feltre'),
  (v_deck_id, 15, 'basic', 'O que caracteriza uma amina?', 'Derivado da amônia (NH₃) com H substituído por R. Primária, secundária ou terciária.', 'Química - Feltre'),
  (v_deck_id, 16, 'basic', 'O que caracteriza uma amida?', 'Grupo -CONH₂. Carbonila ligada a nitrogênio. Ex: ureia, acetamida.', 'Química - Feltre'),
  (v_deck_id, 17, 'basic', 'O que é isomeria plana?', 'Mesma fórmula molecular, estruturas diferentes. Tipos: cadeia, posição, função, compensação.', 'Química - Feltre'),
  (v_deck_id, 18, 'basic', 'O que é isomeria de cadeia?', 'Diferença no esqueleto carbônico. Ex: butano (linear) e isobutano (ramificado).', 'Química - Feltre'),
  (v_deck_id, 19, 'basic', 'O que é isomeria de função?', 'Mesma fórmula, funções diferentes. Ex: etanol (álcool) e metoximetano (éter).', 'Química - Feltre'),
  (v_deck_id, 20, 'basic', 'O que é isomeria geométrica (cis-trans)?', 'Em compostos com dupla. Cis: grupos iguais mesmo lado. Trans: lados opostos.', 'Química - Feltre'),
  (v_deck_id, 21, 'basic', 'O que é isomeria óptica?', 'Carbono quiral (4 ligantes diferentes). Enantiômeros são imagens especulares não sobreponíveis.', 'Química - Feltre'),
  (v_deck_id, 22, 'basic', 'O que é reação de substituição?', 'Átomo ou grupo substitui outro. Alcanos + halogênios (luz). Aromáticos + HNO₃, H₂SO₄.', 'Química - Feltre'),
  (v_deck_id, 23, 'basic', 'O que é reação de adição?', 'Adição a ligação dupla/tripla. Hidrogenação, halogenação, hidratação de alcenos.', 'Química - Feltre'),
  (v_deck_id, 24, 'basic', 'O que é reação de eliminação?', 'Remove átomos para formar dupla. Desidratação de álcoois, desidrogenação.', 'Química - Feltre'),
  (v_deck_id, 25, 'basic', 'O que é reação de esterificação?', 'Ácido + Álcool → Éster + Água. Catalisada por H₂SO₄. Reversível (hidrólise).', 'Química - Feltre'),
  (v_deck_id, 26, 'basic', 'O que é saponificação?', 'Hidrólise de éster em meio básico. Gordura + NaOH → Sabão + Glicerol.', 'Química - Feltre'),
  (v_deck_id, 27, 'basic', 'O que são polímeros?', 'Macromoléculas formadas por monômeros. Adição: polietileno. Condensação: náilon, poliéster.', 'Química - Feltre'),
  (v_deck_id, 28, 'basic', 'O que é oxidação de álcoois?', 'Primário → aldeído → ácido. Secundário → cetona. Terciário não oxida facilmente.', 'Química - Feltre'),
  (v_deck_id, 29, 'basic', 'O que são carboidratos?', 'Poliidroxialdeídos ou poliidroxicetonas. Monossacarídeos (glicose), dissacarídeos (sacarose), polissacarídeos (amido).', 'Química - Feltre'),
  (v_deck_id, 30, 'basic', 'O que são lipídeos?', 'Ésteres de ácidos graxos. Óleos (insaturados, líquidos) e gorduras (saturados, sólidos). Energia, membranas.', 'Química - Feltre');

  RAISE NOTICE 'Decks de Química inseridos com sucesso!';
END $$;
