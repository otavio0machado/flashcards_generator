-- Marketplace Seed: Decks de Física
-- Cinemática, Dinâmica, Estática, Termologia, Óptica, Eletricidade, Magnetismo

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-da-natureza/fisica';

  -- ============================================================================
  -- FÍSICA - CINEMÁTICA
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Cinemática: MRU, MRUV, Queda Livre e Movimento Circular',
    'Estudo do movimento: velocidade, aceleração, equações horárias, gráficos e movimentos especiais.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'cinemática', 'mru', 'mruv', 'enem'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é velocidade média?', 'vₘ = Δs/Δt = (s₂ - s₁)/(t₂ - t₁). Deslocamento dividido pelo intervalo de tempo. Unidade SI: m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'Qual a diferença entre velocidade média e instantânea?', 'Média: considera todo o intervalo. Instantânea: velocidade em um instante específico (limite quando Δt→0). Velocímetro mede instantânea.', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'O que caracteriza o MRU (Movimento Retilíneo Uniforme)?', 'Velocidade constante (v = cte), aceleração nula (a = 0). O móvel percorre distâncias iguais em tempos iguais.', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'Qual a equação horária do MRU?', 's = s₀ + v·t, onde s₀ é a posição inicial, v é a velocidade constante, t é o tempo.', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'Como é o gráfico s×t no MRU?', 'Reta inclinada. Coeficiente angular = velocidade. Se v > 0, reta crescente; se v < 0, reta decrescente.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'Como é o gráfico v×t no MRU?', 'Reta horizontal (v = constante). A área sob a curva representa o deslocamento.', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'O que é aceleração?', 'a = Δv/Δt = (v - v₀)/t. Taxa de variação da velocidade. Unidade SI: m/s².', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'O que caracteriza o MRUV (Movimento Retilíneo Uniformemente Variado)?', 'Aceleração constante (a = cte ≠ 0). A velocidade varia uniformemente ao longo do tempo.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'Quais as equações do MRUV?', 'v = v₀ + at (velocidade). s = s₀ + v₀t + (1/2)at² (posição). v² = v₀² + 2aΔs (Torricelli).', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'Como é o gráfico v×t no MRUV?', 'Reta inclinada. Coeficiente angular = aceleração. Área sob a curva = deslocamento.', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'Como é o gráfico s×t no MRUV?', 'Parábola. Concavidade para cima se a > 0; para baixo se a < 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'Um carro acelera de 0 a 20 m/s em 5s. Qual a aceleração?', 'a = (20 - 0)/5 = 4 m/s².', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'Um móvel com v₀ = 10 m/s e a = 2 m/s². Qual a velocidade após 6s?', 'v = v₀ + at = 10 + 2×6 = 22 m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'O que é a Queda Livre?', 'MRUV vertical sob ação apenas da gravidade. a = g ≈ 10 m/s² (na Terra). Despreza-se resistência do ar.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'Quais as equações da queda livre (partindo do repouso)?', 'v = gt. h = (1/2)gt². v² = 2gh. Sentido positivo para baixo.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Um objeto cai do repouso por 3s. Qual sua velocidade e altura percorrida? (g=10)', 'v = 10×3 = 30 m/s. h = (1/2)×10×9 = 45 m.', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é lançamento vertical para cima?', 'Objeto lançado verticalmente contra a gravidade. Sobe desacelerando (a = -g), para no ponto mais alto, e desce acelerando.', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'Qual a altura máxima no lançamento vertical?', 'hₘₐₓ = v₀²/(2g). Usando v² = v₀² - 2gh com v = 0 no ponto mais alto.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'Qual o tempo de subida no lançamento vertical?', 'tₛᵤₐ = v₀/g. Tempo para velocidade ir de v₀ a zero.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'O que é lançamento oblíquo?', 'Lançamento com velocidade inicial formando ângulo com a horizontal. Combina MRU (horizontal) com MRUV (vertical).', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'Quais as componentes da velocidade inicial no lançamento oblíquo?', 'vₓ = v₀·cos(θ) (horizontal, constante). vᵧ = v₀·sen(θ) (vertical, varia com g).', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'Qual o alcance máximo no lançamento oblíquo?', 'R = v₀²·sen(2θ)/g. Alcance máximo em θ = 45°.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'O que é Movimento Circular Uniforme (MCU)?', 'Movimento circular com velocidade escalar constante. Há aceleração centrípeta (muda direção da velocidade).', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'O que é velocidade angular (ω)?', 'ω = Δθ/Δt = 2π/T = 2πf. Mede a rapidez da rotação. Unidade: rad/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'Qual a relação entre velocidade linear e angular?', 'v = ω·r, onde r é o raio da trajetória.', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'O que é período (T) e frequência (f)?', 'Período: tempo de uma volta completa. Frequência: número de voltas por segundo. T = 1/f. Unidade de f: Hz.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'Qual a aceleração centrípeta no MCU?', 'aᶜ = v²/r = ω²r. Aponta sempre para o centro da trajetória.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'Um disco gira a 300 rpm. Qual sua frequência em Hz?', 'f = 300/60 = 5 Hz. Período T = 1/5 = 0,2 s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'O que é movimento relativo?', 'A velocidade de um móvel depende do referencial. vₐ,ᶜ = vₐ,ᵦ + vᵦ,ᶜ (velocidade de A em relação a C).', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'Dois carros a 60 km/h em sentidos opostos. Qual a velocidade relativa?', 'vᵣₑₗ = 60 + 60 = 120 km/h. Em sentidos opostos, somam-se os módulos.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - DINÂMICA (LEIS DE NEWTON)
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Dinâmica: Leis de Newton, Forças e Energia',
    'Leis de Newton, força de atrito, trabalho, potência, energia cinética e potencial.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'dinâmica', 'newton', 'força', 'energia'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que diz a 1ª Lei de Newton (Inércia)?', 'Um corpo em repouso tende a permanecer em repouso, e um corpo em movimento tende a continuar em MRU, a menos que uma força resultante atue sobre ele.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'O que é inércia?', 'Tendência de um corpo resistir a mudanças em seu estado de movimento. Quanto maior a massa, maior a inércia.', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'O que diz a 2ª Lei de Newton (Princípio Fundamental)?', 'F = ma. A força resultante é igual ao produto da massa pela aceleração. Unidade de força: Newton (N = kg·m/s²).', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'Qual força é necessária para acelerar 2 kg a 3 m/s²?', 'F = ma = 2 × 3 = 6 N.', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'O que diz a 3ª Lei de Newton (Ação e Reação)?', 'Para toda ação há uma reação de igual intensidade e direção, mas sentido oposto. As forças atuam em corpos diferentes.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'Por que ação e reação não se anulam?', 'Porque atuam em corpos diferentes. A Terra puxa você para baixo, você puxa a Terra para cima, mas em corpos distintos.', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'O que é a força Peso (P)?', 'P = mg. Força gravitacional que a Terra exerce sobre um corpo. Aponta para o centro da Terra.', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'O que é força Normal (N)?', 'Força de contato perpendicular à superfície. Impede que objetos atravessem superfícies sólidas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'O que é força de Atrito?', 'Força que se opõe ao movimento relativo entre superfícies em contato. Paralela à superfície, sentido contrário ao movimento.', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'Qual a diferença entre atrito estático e cinético?', 'Estático: impede início do movimento, fₑ ≤ μₑN. Cinético: durante o movimento, fᶜ = μᶜN. Geralmente μₑ > μᶜ.', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'Um bloco de 5 kg está em superfície horizontal com μ = 0,4. Qual a força de atrito máxima?', 'N = P = 50 N. fₘₐₓ = μN = 0,4 × 50 = 20 N.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que é força de Tração?', 'Força transmitida por cordas, cabos ou fios. Em fios ideais (sem massa), a tração é igual em toda sua extensão.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'O que é força Elástica (Lei de Hooke)?', 'F = -kx, onde k é a constante elástica e x é a deformação. O sinal negativo indica força restauradora.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'O que é Trabalho de uma força?', 'W = F·d·cos(θ), onde θ é o ângulo entre força e deslocamento. Unidade: Joule (J). Trabalho é energia transferida.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'Quando o trabalho é positivo, negativo ou nulo?', 'Positivo: θ < 90° (força favorece movimento). Negativo: θ > 90° (força opõe movimento). Nulo: θ = 90° ou d = 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Calcule o trabalho de uma força de 10 N que desloca um objeto 5 m na mesma direção.', 'W = F·d·cos(0°) = 10 × 5 × 1 = 50 J.', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é Potência?', 'P = W/Δt = F·v. Taxa de realização de trabalho. Unidade: Watt (W = J/s).', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'Uma máquina realiza 1000 J em 5 s. Qual sua potência?', 'P = 1000/5 = 200 W.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'O que é Energia Cinética?', 'Eᶜ = (1/2)mv². Energia associada ao movimento. Sempre positiva ou zero.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'O que é o Teorema Trabalho-Energia?', 'W = ΔEᶜ = Eᶜ_final - Eᶜ_inicial. O trabalho da resultante é igual à variação da energia cinética.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'O que é Energia Potencial Gravitacional?', 'Eₚ = mgh. Energia armazenada devido à posição em um campo gravitacional. h é a altura em relação a um referencial.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que é Energia Potencial Elástica?', 'Eₚₑ = (1/2)kx². Energia armazenada em uma mola deformada.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'O que é o Princípio da Conservação da Energia Mecânica?', 'Em sistemas conservativos (sem atrito): Eₘ = Eᶜ + Eₚ = constante. Energia transforma-se mas não se cria nem se destrói.', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'Um objeto de 2 kg cai de 5 m de altura. Qual sua velocidade ao chegar ao solo? (g=10)', 'mgh = (1/2)mv² → v = √(2gh) = √(2×10×5) = √100 = 10 m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que é Impulso?', 'I = F·Δt = Δp. Produto da força pelo tempo de aplicação. Igual à variação da quantidade de movimento.', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'O que é Quantidade de Movimento (Momento Linear)?', 'p = mv. Produto da massa pela velocidade. É um vetor. Unidade: kg·m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'O que diz a Conservação da Quantidade de Movimento?', 'Em sistemas isolados (sem forças externas), a quantidade de movimento total é constante. p_antes = p_depois.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'Qual a diferença entre colisão elástica e inelástica?', 'Elástica: conserva energia cinética. Inelástica: energia cinética diminui (transforma em calor, som, deformação). Perfeitamente inelástica: corpos grudam.', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'Um projétil de 10 g a 400 m/s atinge um bloco de 2 kg em repouso e fica cravado. Qual a velocidade final?', 'Conservação: 0,01×400 = (0,01+2)v → 4 = 2,01v → v ≈ 2 m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que é força centrípeta?', 'Força resultante que mantém um corpo em trajetória circular. Fᶜ = mv²/r = mω²r. Aponta para o centro.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - ESTÁTICA E HIDROSTÁTICA
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Estática e Hidrostática: Equilíbrio e Fluidos',
    'Equilíbrio de ponto material e corpo rígido, pressão, princípios de Pascal e Arquimedes.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'estática', 'hidrostática', 'pressão', 'empuxo'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais as condições de equilíbrio de um ponto material?', 'Força resultante nula: ΣF = 0. Em componentes: ΣFₓ = 0 e ΣFᵧ = 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'Quais as condições de equilíbrio de um corpo rígido?', '1) ΣF = 0 (equilíbrio de translação). 2) Στ = 0 (equilíbrio de rotação, soma dos torques nula).', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'O que é torque (momento de força)?', 'τ = F·d·sen(θ), onde d é a distância ao eixo de rotação. Mede a tendência de uma força causar rotação.', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'O que é braço de alavanca?', 'Distância perpendicular entre a linha de ação da força e o eixo de rotação. τ = F × braço.', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'O que é centro de gravidade (CG)?', 'Ponto onde se pode considerar concentrado todo o peso do corpo. Coincide com centro de massa em campo gravitacional uniforme.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'Quando um corpo está em equilíbrio estável?', 'Quando, ao ser levemente deslocado, tende a retornar à posição original. CG na posição mais baixa possível.', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'O que é pressão?', 'p = F/A. Força por unidade de área. Unidade SI: Pascal (Pa = N/m²).', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'Qual a pressão atmosférica ao nível do mar?', 'p₀ ≈ 101.325 Pa ≈ 1 atm ≈ 760 mmHg ≈ 10,33 mH₂O.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'O que é pressão hidrostática?', 'p = ρgh. Pressão exercida por uma coluna de fluido. ρ = densidade, g = gravidade, h = profundidade.', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'Qual a pressão a 10 m de profundidade na água? (ρ=1000 kg/m³, g=10)', 'p = ρgh = 1000×10×10 = 100.000 Pa = 1 atm. Pressão total = 2 atm (+ atmosférica).', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'O que diz o Princípio de Stevin?', 'Pontos na mesma horizontal em um fluido em equilíbrio têm a mesma pressão.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que diz o Princípio de Pascal?', 'Uma variação de pressão em um fluido incompressível é transmitida integralmente a todos os pontos. Base da prensa hidráulica.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'Como funciona a prensa hidráulica?', 'F₁/A₁ = F₂/A₂. Pequena força em pistão pequeno gera grande força em pistão grande. Multiplicador de força.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'Em uma prensa, A₁=10cm² e A₂=100cm². Se F₁=50N, qual F₂?', 'F₂ = F₁×(A₂/A₁) = 50×10 = 500 N. Amplificação de 10×.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'O que diz o Princípio de Arquimedes?', 'Todo corpo imerso em um fluido recebe uma força vertical para cima (empuxo) igual ao peso do fluido deslocado.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Qual a fórmula do empuxo?', 'E = ρ_fluido × V_imerso × g. Peso do volume de fluido deslocado.', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'Quando um corpo flutua?', 'Quando ρ_corpo < ρ_fluido. O empuxo equilibra o peso. Parte do corpo fica acima da superfície.', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'Quando um corpo afunda?', 'Quando ρ_corpo > ρ_fluido. O peso é maior que o empuxo máximo (corpo totalmente imerso).', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'Um iceberg flutua com que fração submersa? (ρ_gelo=920, ρ_água=1000)', 'V_sub/V_total = ρ_gelo/ρ_água = 920/1000 = 92%. Apenas 8% fica acima da água.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'Qual o peso aparente de um corpo imerso?', 'P_aparente = P - E = P(1 - ρ_fluido/ρ_corpo). O empuxo "alivia" parte do peso.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'O que é densidade relativa?', 'Razão entre a densidade de uma substância e a densidade da água (1000 kg/m³). Adimensional.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que é o Teorema de Stevin para vasos comunicantes?', 'Em vasos comunicantes com o mesmo líquido, as superfícies livres estão no mesmo nível horizontal.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'E se os vasos comunicantes tiverem líquidos diferentes?', 'As alturas são inversamente proporcionais às densidades: ρ₁h₁ = ρ₂h₂.', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'O que é um manômetro?', 'Instrumento que mede pressão de gases usando coluna de líquido. p_gás = p_atm + ρgh.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que é um barômetro de Torricelli?', 'Tubo de vidro com mercúrio invertido em cuba. A altura do mercúrio indica a pressão atmosférica (≈760 mm).', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'Como a pressão atmosférica varia com a altitude?', 'Diminui exponencialmente. Menor coluna de ar acima significa menor peso e menor pressão.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'O que é tensão superficial?', 'Força na superfície de um líquido que faz a superfície comportar-se como uma membrana elástica. Permite insetos andarem na água.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'O que é capilaridade?', 'Subida ou descida de líquidos em tubos finos devido a forças de adesão e coesão. Água sobe, mercúrio desce.', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'O que é a Equação da Continuidade?', 'A₁v₁ = A₂v₂. Em fluidos incompressíveis, a vazão é constante. Área menor → velocidade maior.', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que é a Equação de Bernoulli?', 'p + (1/2)ρv² + ρgh = constante. Relaciona pressão, velocidade e altura em um fluido ideal. Base do funcionamento de aviões.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - TERMOLOGIA
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Termologia: Temperatura, Calor e Termodinâmica',
    'Escalas termométricas, dilatação, calorimetria, mudanças de fase, gases ideais e leis da termodinâmica.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'termologia', 'calor', 'termodinâmica', 'gases'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a diferença entre temperatura e calor?', 'Temperatura: medida da agitação molecular (energia cinética média). Calor: energia térmica em trânsito entre corpos de diferentes temperaturas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'Quais as escalas termométricas e seus pontos fixos?', 'Celsius: 0°C (fusão gelo) e 100°C (ebulição água). Fahrenheit: 32°F e 212°F. Kelvin: 273K e 373K.', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'Qual a fórmula de conversão entre Celsius e Fahrenheit?', 'F = (9/5)C + 32 ou C = (5/9)(F - 32).', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'Qual a relação entre Celsius e Kelvin?', 'K = C + 273. O Kelvin é a escala absoluta (0K é o zero absoluto, -273°C).', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'O que é zero absoluto?', '0 K = -273,15°C. Temperatura mínima teórica onde a agitação molecular cessa. Nunca foi atingida experimentalmente.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'O que é dilatação linear?', 'ΔL = L₀·α·ΔT. Aumento do comprimento de sólidos com a temperatura. α = coeficiente de dilatação linear.', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'Qual a relação entre coeficientes de dilatação?', 'β = 2α (superficial = 2× linear). γ = 3α (volumétrico = 3× linear).', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'Uma barra de 2m com α=2×10⁻⁵/°C aquece de 20°C para 120°C. Qual o aumento?', 'ΔL = 2 × 2×10⁻⁵ × 100 = 4×10⁻³ m = 4 mm.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'O que é calor específico?', 'c = quantidade de calor necessária para elevar 1g de substância em 1°C. Água: c = 1 cal/g·°C = 4186 J/kg·K.', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'Qual a equação fundamental da calorimetria?', 'Q = m·c·ΔT. Calor = massa × calor específico × variação de temperatura.', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'Quantas calorias para aquecer 200g de água de 20°C a 70°C?', 'Q = 200 × 1 × 50 = 10.000 cal = 10 kcal.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que é capacidade térmica?', 'C = m·c. Quantidade de calor para elevar a temperatura do corpo em 1°C. Unidade: cal/°C ou J/K.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'O que é calor latente?', 'L = Q/m. Calor por unidade de massa para mudança de fase (sem variação de temperatura). Fusão/Solidificação e Vaporização/Condensação.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'Qual o calor latente de fusão e vaporização da água?', 'Lf = 80 cal/g (fusão). Lv = 540 cal/g (vaporização). Vaporizar água requer muito mais energia.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'O que é equilíbrio térmico?', 'Quando dois corpos atingem a mesma temperatura e não há mais troca de calor. Q_cedido = Q_recebido.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Quais as formas de propagação do calor?', 'Condução: contato direto. Convecção: movimento de fluidos. Radiação: ondas eletromagnéticas (não precisa de meio).', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é a Lei dos Gases Ideais?', 'pV = nRT, onde n = número de mols, R = 8,314 J/mol·K. Ou pV = NkT (N = número de moléculas, k = Boltzmann).', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'O que é uma transformação isotérmica?', 'Temperatura constante (ΔT = 0). pV = constante (Lei de Boyle). Gráfico p×V: hipérbole.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'O que é uma transformação isobárica?', 'Pressão constante. V/T = constante (Lei de Gay-Lussac). Gráfico V×T: reta passando pela origem.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'O que é uma transformação isocórica (isovolumétrica)?', 'Volume constante. p/T = constante (Lei de Charles). Gráfico p×T: reta passando pela origem.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'O que é uma transformação adiabática?', 'Sem troca de calor com o ambiente (Q = 0). Rápida ou isolada termicamente. pVᵞ = constante.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que diz a 1ª Lei da Termodinâmica?', 'ΔU = Q - W. A variação da energia interna é igual ao calor menos o trabalho realizado pelo gás. Conservação da energia.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'Como calcular o trabalho de um gás em expansão isobárica?', 'W = p·ΔV. Área sob a curva no diagrama p×V. Positivo se expande, negativo se comprime.', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'Um gás recebe 500J de calor e realiza 200J de trabalho. Qual ΔU?', 'ΔU = Q - W = 500 - 200 = 300 J. A energia interna aumentou.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que diz a 2ª Lei da Termodinâmica?', 'O calor não pode fluir espontaneamente de um corpo frio para um quente. Processos naturais são irreversíveis. Entropia sempre aumenta.', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'O que é entropia?', 'Medida da desordem de um sistema. Processos espontâneos aumentam a entropia do universo. ΔS ≥ 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'O que é rendimento de uma máquina térmica?', 'η = W/Q_quente = 1 - Q_frio/Q_quente. Sempre menor que 100% (parte do calor é rejeitada).', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'O que é o ciclo de Carnot?', 'Ciclo ideal com máximo rendimento possível entre duas temperaturas. η = 1 - T_fria/T_quente (temperaturas em Kelvin).', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'Qual o rendimento máximo de Carnot entre 400K e 300K?', 'η = 1 - 300/400 = 1 - 0,75 = 0,25 = 25%.', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que é um refrigerador (bomba de calor)?', 'Máquina que transfere calor do frio para o quente usando trabalho externo. Funciona ao contrário da máquina térmica.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - ÓPTICA
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Óptica: Reflexão, Refração, Espelhos e Lentes',
    'Natureza da luz, reflexão, espelhos planos e esféricos, refração, lentes e instrumentos ópticos.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'óptica', 'luz', 'espelhos', 'lentes'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é a luz do ponto de vista físico?', 'Onda eletromagnética visível (400-700 nm). Propaga-se no vácuo a c = 3×10⁸ m/s. Também exibe comportamento de partícula (fótons).', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'O que são meios transparentes, translúcidos e opacos?', 'Transparente: luz passa e vemos através (vidro). Translúcido: luz passa difusa (vidro fosco). Opaco: não deixa passar luz.', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'O que são as leis da reflexão?', '1) Raio incidente, normal e raio refletido são coplanares. 2) Ângulo de incidência = ângulo de reflexão (i = r).', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'Como é a imagem formada por um espelho plano?', 'Virtual, direita (mesma orientação), simétrica em relação ao espelho. Distância objeto = distância imagem.', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'O que são espelhos esféricos côncavos e convexos?', 'Côncavo: superfície refletora interna, concentra luz (foco real). Convexo: superfície refletora externa, diverge luz (foco virtual).', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'Qual a relação entre raio de curvatura e distância focal?', 'f = R/2. A distância focal é metade do raio de curvatura.', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'Qual a equação de Gauss para espelhos?', '1/f = 1/p + 1/p'', onde p = distância objeto, p'' = distância imagem.', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'O que é aumento linear transversal?', 'A = -p''/p = i/o. Razão entre tamanho da imagem e do objeto. Negativo = invertida.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'Em espelho côncavo, quando a imagem é real?', 'Quando o objeto está além do foco (p > f). Imagem real é invertida e pode ser projetada.', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'Onde usar espelhos côncavos?', 'Lanternas, faróis (objeto no foco → raios paralelos), espelhos de maquiagem (objeto entre foco e vértice → imagem ampliada).', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'Onde usar espelhos convexos?', 'Retrovisores, segurança. Campo de visão amplo. Imagem sempre virtual, direita e menor.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que é refração?', 'Mudança de direção da luz ao passar de um meio para outro com diferente índice de refração.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'O que é índice de refração?', 'n = c/v. Razão entre a velocidade da luz no vácuo e no meio. n ≥ 1. Ar ≈ 1, água ≈ 1,33, vidro ≈ 1,5.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'O que diz a Lei de Snell-Descartes?', 'n₁·sen(θ₁) = n₂·sen(θ₂). Relaciona os ângulos com a normal nos dois meios.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'O que acontece quando luz passa de meio mais para menos refringente?', 'O raio se afasta da normal. Ângulo de refração > ângulo de incidência.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'O que é ângulo crítico (limite)?', 'Ângulo de incidência para o qual o ângulo de refração é 90°. sen(θc) = n₂/n₁ (só existe se n₁ > n₂).', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é reflexão total interna?', 'Quando θ > θc, toda luz é refletida, nenhuma é refratada. Usado em fibras ópticas e prismas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'O que são lentes convergentes e divergentes?', 'Convergentes: mais espessas no centro, concentram luz. Divergentes: mais finas no centro, espalham luz.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'Qual a equação dos fabricantes de lentes (Gauss)?', '1/f = 1/p + 1/p''. Mesma forma dos espelhos, com convenções de sinais apropriadas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'O que é vergência (dioptria)?', 'V = 1/f. Mede o poder de convergência. Unidade: dioptria (di) ou m⁻¹. Lentes de óculos são medidas em dioptrias.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'Uma lente tem f = 0,5 m. Qual sua vergência?', 'V = 1/0,5 = 2 di (duas dioptrias). Lente convergente.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que é miopia e como corrigir?', 'Imagem forma-se antes da retina (olho longo demais). Corrigir com lentes divergentes (vergência negativa).', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'O que é hipermetropia e como corrigir?', 'Imagem forma-se atrás da retina (olho curto demais). Corrigir com lentes convergentes (vergência positiva).', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'O que é astigmatismo?', 'Córnea não perfeitamente esférica, foca diferente em diferentes direções. Corrigir com lentes cilíndricas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que é dispersão da luz?', 'Separação das cores da luz branca devido a diferentes índices de refração para cada comprimento de onda. Arco-íris!', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'Por que o céu é azul?', 'Espalhamento Rayleigh: luz azul (λ menor) é mais espalhada pela atmosfera que a vermelha.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'O que é a relação v = λf para ondas?', 'v = velocidade, λ = comprimento de onda, f = frequência. Quando luz muda de meio, λ muda mas f permanece constante.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'O que é interferência luminosa?', 'Superposição de ondas luminosas. Construtiva: amplitude soma (claro). Destrutiva: amplitude cancela (escuro).', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'O que é difração?', 'Encurvamento de ondas ao passar por fendas ou contornar obstáculos. Mais notável quando abertura ≈ λ.', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que é polarização?', 'Restrição da vibração da onda luminosa a um plano. Óculos polarizados bloqueiam reflexos horizontais.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - ELETRICIDADE
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Eletricidade: Carga, Campo, Circuitos e Lei de Ohm',
    'Eletrostática, campo elétrico, potencial, corrente, resistência, circuitos e geradores.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'eletricidade', 'corrente', 'circuito', 'ohm'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é carga elétrica?', 'Propriedade fundamental da matéria. Prótons (+) e elétrons (-). Unidade: Coulomb (C). Carga elementar: e = 1,6×10⁻¹⁹ C.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'O que diz a Lei da Conservação da Carga?', 'A carga total de um sistema isolado permanece constante. Cargas podem ser transferidas, não criadas ou destruídas.', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'O que são condutores e isolantes?', 'Condutores: elétrons livres se movem facilmente (metais). Isolantes: elétrons fortemente presos (plástico, vidro).', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'O que diz a Lei de Coulomb?', 'F = k·|q₁·q₂|/r². Força elétrica entre duas cargas. k = 9×10⁹ N·m²/C². Atração (sinais opostos) ou repulsão (sinais iguais).', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'Duas cargas de 2μC e 3μC estão a 30cm. Qual a força? (k=9×10⁹)', 'F = 9×10⁹ × (2×10⁻⁶ × 3×10⁻⁶)/(0,3)² = 9×10⁹ × 6×10⁻¹²/0,09 = 0,6 N.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'O que é campo elétrico?', 'E = F/q. Força por unidade de carga. Unidade: N/C ou V/m. O campo de uma carga pontual: E = kQ/r².', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'O que são linhas de campo elétrico?', 'Representação visual do campo. Saem de cargas + e chegam em -. Mais densas onde campo é mais intenso.', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'O que é potencial elétrico?', 'V = U/q. Energia potencial por unidade de carga. Unidade: Volt (V = J/C). V = kQ/r para carga pontual.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'O que é diferença de potencial (ddp ou tensão)?', 'U = Vₐ - Vᵦ. Trabalho por unidade de carga para mover entre dois pontos. "Voltagem".', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'O que é um capacitor?', 'Dispositivo que armazena carga e energia elétrica. Capacitância: C = Q/V. Unidade: Farad (F).', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'Qual a energia armazenada em um capacitor?', 'U = (1/2)CV² = (1/2)Q²/C = (1/2)QV.', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que é corrente elétrica?', 'i = ΔQ/Δt. Fluxo ordenado de cargas. Unidade: Ampère (A = C/s). Sentido convencional: do + para o -.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'O que é resistência elétrica?', 'R = V/i. Oposição à passagem de corrente. Unidade: Ohm (Ω). Depende do material, comprimento e área.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'O que diz a 1ª Lei de Ohm?', 'V = R·i. Para condutores ôhmicos, a tensão é proporcional à corrente. R constante.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'O que diz a 2ª Lei de Ohm?', 'R = ρ·L/A. Resistência depende da resistividade (ρ), comprimento (L) e área da seção (A).', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Um resistor de 10Ω está submetido a 20V. Qual a corrente?', 'i = V/R = 20/10 = 2 A.', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é potência elétrica?', 'P = V·i = R·i² = V²/R. Energia por tempo. Unidade: Watt (W).', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'Uma lâmpada de 60W ligada 5h por dia. Qual o consumo mensal?', 'E = P×t = 60W × 5h × 30dias = 9000 Wh = 9 kWh.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'Como funciona associação de resistores em série?', 'Reqᵤᵢᵥ = R₁ + R₂ + ... Mesma corrente em todos. Tensão se divide. Resistência aumenta.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'Como funciona associação de resistores em paralelo?', '1/Reqᵤᵢᵥ = 1/R₁ + 1/R₂ + ... Mesma tensão em todos. Corrente se divide. Resistência diminui.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'Qual a resistência equivalente de 6Ω e 3Ω em paralelo?', '1/Req = 1/6 + 1/3 = 1/6 + 2/6 = 3/6 = 1/2 → Req = 2Ω.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que é um gerador elétrico?', 'Dispositivo que converte outra forma de energia em elétrica. fem (ε): tensão em aberto. U = ε - r·i.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'O que é um receptor elétrico?', 'Dispositivo que converte energia elétrica em outra forma (não térmica). Ex: motor. U = ε'' + r''·i.', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'O que diz a Lei das Malhas (Kirchhoff)?', 'A soma das tensões em uma malha fechada é zero. ΣV = 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que diz a Lei dos Nós (Kirchhoff)?', 'A soma das correntes que entram em um nó é igual à soma das que saem. Σi_entrada = Σi_saída.', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'O que é efeito Joule?', 'Dissipação de energia elétrica em forma de calor ao passar por um resistor. Q = R·i²·t.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'Como funcionam capacitores em série?', '1/Cequiv = 1/C₁ + 1/C₂ + ... Mesma carga em todos. Capacitância diminui.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'Como funcionam capacitores em paralelo?', 'Cequiv = C₁ + C₂ + ... Mesma tensão em todos. Capacitância aumenta.', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'O que são instrumentos de medida elétrica?', 'Voltímetro: mede tensão (em paralelo, resistência alta). Amperímetro: mede corrente (em série, resistência baixa).', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que é a potência de curto-circuito?', 'Quando os terminais do gerador são conectados diretamente. i_cc = ε/r. Toda potência vira calor na resistência interna.', 'Física - Halliday, Resnick');

  -- ============================================================================
  -- FÍSICA - MAGNETISMO
  -- ============================================================================
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Magnetismo e Eletromagnetismo: Campos e Indução',
    'Campo magnético, força magnética, indução eletromagnética e ondas eletromagnéticas.',
    0, v_user_id, v_cat_id,
    ARRAY['física', 'magnetismo', 'indução', 'faraday', 'eletromagnetismo'],
    true, true, 4.7
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que são pólos magnéticos?', 'Norte e Sul. Pólos iguais se repelem, opostos se atraem. Não existem monopolos magnéticos.', 'Física - Halliday, Resnick'),
  (v_deck_id, 2, 'basic', 'O que é um campo magnético?', 'Região onde uma carga em movimento ou ímã sofre força. Símbolo: B. Unidade: Tesla (T).', 'Física - Halliday, Resnick'),
  (v_deck_id, 3, 'basic', 'Como são as linhas de campo magnético?', 'Saem do polo Norte e entram no Sul (externamente). São fechadas (não há monopolos). Mais densas onde B é mais intenso.', 'Física - Halliday, Resnick'),
  (v_deck_id, 4, 'basic', 'Qual a força magnética sobre uma carga em movimento?', 'F = qvB·sen(θ). Perpendicular a v e B. Regra da mão direita. Se θ = 0° ou 180°, F = 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 5, 'basic', 'O que é a força de Lorentz?', 'Força total sobre carga em campos E e B: F = qE + qv×B.', 'Física - Halliday, Resnick'),
  (v_deck_id, 6, 'basic', 'O que acontece com uma carga entrando perpendicular em um campo B uniforme?', 'Descreve movimento circular uniforme. F = qvB = mv²/r → r = mv/(qB).', 'Física - Halliday, Resnick'),
  (v_deck_id, 7, 'basic', 'Qual a força sobre um fio percorrido por corrente em campo B?', 'F = BiL·sen(θ). Perpendicular a i e B. Motor elétrico usa este princípio.', 'Física - Halliday, Resnick'),
  (v_deck_id, 8, 'basic', 'O que diz a Lei de Ampère?', 'Correntes elétricas geram campo magnético. Para fio longo: B = μ₀i/(2πr). μ₀ = 4π×10⁻⁷ T·m/A.', 'Física - Halliday, Resnick'),
  (v_deck_id, 9, 'basic', 'Qual o campo magnético no centro de uma espira?', 'B = μ₀i/(2R), onde R é o raio da espira.', 'Física - Halliday, Resnick'),
  (v_deck_id, 10, 'basic', 'O que é um solenóide?', 'Bobina longa com muitas espiras. Campo interno uniforme: B = μ₀ni, onde n = N/L (espiras por comprimento).', 'Física - Halliday, Resnick'),
  (v_deck_id, 11, 'basic', 'O que é fluxo magnético?', 'Φ = B·A·cos(θ). Quantidade de campo que atravessa uma superfície. Unidade: Weber (Wb).', 'Física - Halliday, Resnick'),
  (v_deck_id, 12, 'basic', 'O que diz a Lei de Faraday?', 'ε = -dΦ/dt. Variação do fluxo magnético induz fem. Base de geradores e transformadores.', 'Física - Halliday, Resnick'),
  (v_deck_id, 13, 'basic', 'O que diz a Lei de Lenz?', 'A corrente induzida cria campo que se opõe à variação do fluxo. Explica o sinal negativo na Lei de Faraday.', 'Física - Halliday, Resnick'),
  (v_deck_id, 14, 'basic', 'O que é indução eletromagnética?', 'Fenômeno onde variação de fluxo magnético gera corrente elétrica. Descoberto por Faraday.', 'Física - Halliday, Resnick'),
  (v_deck_id, 15, 'basic', 'Como funciona um gerador elétrico?', 'Espira girando em campo magnético. Fluxo varia senoidalmente → fem alternada. Transforma energia mecânica em elétrica.', 'Física - Halliday, Resnick'),
  (v_deck_id, 16, 'basic', 'Como funciona um motor elétrico?', 'Corrente em espira dentro de campo B sofre torque. Transforma energia elétrica em mecânica. Inverso do gerador.', 'Física - Halliday, Resnick'),
  (v_deck_id, 17, 'basic', 'O que é um transformador?', 'Duas bobinas acopladas magneticamente. V₁/V₂ = N₁/N₂. Altera tensão de corrente alternada.', 'Física - Halliday, Resnick'),
  (v_deck_id, 18, 'basic', 'Um transformador com N₁=100 e N₂=500 recebe 120V. Qual a tensão de saída?', 'V₂ = V₁(N₂/N₁) = 120×5 = 600V. Elevador de tensão.', 'Física - Halliday, Resnick'),
  (v_deck_id, 19, 'basic', 'Por que transformadores funcionam apenas com corrente alternada?', 'Precisam de variação de fluxo para induzir tensão. CC produz fluxo constante → fem = 0.', 'Física - Halliday, Resnick'),
  (v_deck_id, 20, 'basic', 'O que são ondas eletromagnéticas?', 'Campos E e B oscilantes que se propagam. Não precisam de meio. No vácuo: c = 3×10⁸ m/s.', 'Física - Halliday, Resnick'),
  (v_deck_id, 21, 'basic', 'Quais são as partes do espectro eletromagnético?', 'Rádio, micro-ondas, infravermelho, luz visível, ultravioleta, raios X, raios gama. Em ordem crescente de frequência.', 'Física - Halliday, Resnick'),
  (v_deck_id, 22, 'basic', 'O que são materiais ferromagnéticos?', 'Materiais que podem ser fortemente magnetizados (ferro, níquel, cobalto). Domínios magnéticos se alinham.', 'Física - Halliday, Resnick'),
  (v_deck_id, 23, 'basic', 'O que são materiais paramagnéticos e diamagnéticos?', 'Paramagnéticos: levemente atraídos por ímãs. Diamagnéticos: levemente repelidos. Efeitos muito fracos.', 'Física - Halliday, Resnick'),
  (v_deck_id, 24, 'basic', 'O que é corrente de Foucault?', 'Correntes induzidas em massas metálicas por variação de campo B. Causam aquecimento (freios magnéticos, fornos).', 'Física - Halliday, Resnick'),
  (v_deck_id, 25, 'basic', 'O que é indutância?', 'Capacidade de um circuito de se opor a variações de corrente. L = Φ/i. Unidade: Henry (H).', 'Física - Halliday, Resnick'),
  (v_deck_id, 26, 'basic', 'O que é autoindução?', 'Fem induzida no próprio circuito quando sua corrente varia. ε = -L(di/dt). O indutor "resiste" a mudanças.', 'Física - Halliday, Resnick'),
  (v_deck_id, 27, 'basic', 'Qual a energia armazenada em um indutor?', 'U = (1/2)Li². Similar ao capacitor, mas depende da corrente em vez da tensão.', 'Física - Halliday, Resnick'),
  (v_deck_id, 28, 'basic', 'O que é corrente alternada (CA)?', 'Corrente que varia senoidalmente com o tempo. i = i₀·sen(ωt). Usada em distribuição de energia.', 'Física - Halliday, Resnick'),
  (v_deck_id, 29, 'basic', 'O que é o valor eficaz (RMS) de corrente alternada?', 'iₑf = i₀/√2 ≈ 0,707·i₀. Corrente DC equivalente que produz mesma potência média.', 'Física - Halliday, Resnick'),
  (v_deck_id, 30, 'basic', 'O que são as equações de Maxwell?', 'Quatro equações que unificam eletricidade e magnetismo. Preveem ondas eletromagnéticas. Base do eletromagnetismo.', 'Física - Halliday, Resnick');

  RAISE NOTICE 'Decks de Física inseridos com sucesso!';
END $$;
