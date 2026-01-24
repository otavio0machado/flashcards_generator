-- Marketplace Seed: Decks de Matemática (Parte 3)
-- Geometria Espacial, Analítica, Trigonometria, Estatística, Matrizes

DO $$
DECLARE
  v_author_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_author_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_author_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/geometria';

  -- ============================================================================
  -- MATEMÁTICA - GEOMETRIA ESPACIAL
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Geometria Espacial: Prismas, Pirâmides, Cilindros, Cones e Esferas',
    'Estudo dos sólidos geométricos: poliedros, corpos redondos, áreas e volumes.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'geometria espacial', 'volume', 'enem', 'vestibular'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que são poliedros?', 'Sólidos geométricos limitados por faces planas poligonais. Possuem vértices, arestas e faces. Exemplos: prismas, pirâmides, cubo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que diz a Relação de Euler para poliedros convexos?', 'V - A + F = 2, onde V = vértices, A = arestas, F = faces. Cubo: 8 - 12 + 6 = 2 ✓', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'O que é um prisma?', 'Poliedro com duas bases paralelas e congruentes, ligadas por faces laterais que são paralelogramos. Se reto, faces são retângulos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Qual o volume de um prisma?', 'V = Área da base × altura = Ab × h. Válido para qualquer prisma (triangular, hexagonal, etc.).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'Qual o volume de um paralelepípedo retângulo (caixa)?', 'V = a × b × c (comprimento × largura × altura). É um prisma de base retangular.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Qual o volume e a área total de um cubo de aresta a?', 'Volume: V = a³. Área total: At = 6a² (6 faces quadradas).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Qual a diagonal do cubo de aresta a?', 'd = a√3. Obtida por Pitágoras duas vezes: diagonal da face = a√2, depois d² = a² + (a√2)² = 3a².', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'O que é uma pirâmide?', 'Poliedro com uma base poligonal e faces laterais triangulares que se encontram em um vértice comum (ápice).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'Qual o volume de uma pirâmide?', 'V = (1/3) × Ab × h. É 1/3 do volume de um prisma de mesma base e altura.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'O que é apótema da pirâmide?', 'É a altura de uma face lateral triangular, medida do ápice ao ponto médio de uma aresta da base.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'O que é um cilindro?', 'Corpo redondo com duas bases circulares paralelas e congruentes. A superfície lateral é curva (retângulo "enrolado").', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Qual o volume de um cilindro?', 'V = πr²h, onde r é o raio da base e h é a altura.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Qual a área lateral de um cilindro?', 'Al = 2πrh (retângulo de base = circunferência e altura h). Área total: At = 2πr² + 2πrh = 2πr(r+h).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'O que é um cone?', 'Corpo redondo com base circular e superfície lateral que converge para um ponto (vértice). Seção axial é triângulo isósceles.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual o volume de um cone?', 'V = (1/3)πr²h. É 1/3 do volume de um cilindro de mesma base e altura.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Qual a área lateral do cone?', 'Al = πrg, onde g é a geratriz (distância do vértice à circunferência da base). g² = r² + h².', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Qual o volume de uma esfera?', 'V = (4/3)πr³. Exemplo: r = 3 → V = (4/3)π(27) = 36π.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Qual a área da superfície de uma esfera?', 'A = 4πr². Curiosidade: é igual à área lateral de um cilindro circunscrito.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'O que é um tronco de cone?', 'Parte de um cone cortada por um plano paralelo à base. Tem duas bases circulares de raios diferentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual o volume de um tronco de cone?', 'V = (πh/3)(R² + Rr + r²), onde R e r são os raios das bases maior e menor.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'O que são sólidos de Platão?', 'Os 5 poliedros regulares: tetraedro (4 faces), cubo/hexaedro (6), octaedro (8), dodecaedro (12), icosaedro (20).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Qual a relação entre volumes de sólidos semelhantes?', 'Se a razão de semelhança é k, os volumes estão na razão k³. Se dobrar as dimensões, volume fica 8× maior.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Qual a relação entre áreas de sólidos semelhantes?', 'Se a razão de semelhança é k, as áreas estão na razão k². Se dobrar as dimensões, área fica 4× maior.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Uma esfera está inscrita em um cubo de aresta 6. Qual seu volume?', 'Raio = metade da aresta = 3. V = (4/3)π(27) = 36π ≈ 113,1 unidades³.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Como calcular a diagonal de um paralelepípedo retângulo?', 'd² = a² + b² + c², onde a, b, c são as dimensões. É a maior distância entre dois vértices.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'O que é seção transversal de um cilindro?', 'Corte perpendicular ao eixo: resulta em um círculo de raio r. Qualquer seção transversal é igual à base.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'O que é seção meridiana de uma esfera?', 'Corte que passa pelo centro: resulta em um círculo máximo de raio igual ao da esfera.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Qual o volume do tetraedro regular de aresta a?', 'V = (a³√2)/12. Exemplo: a = 6 → V = (216√2)/12 = 18√2.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'O que é inscrição e circunscrição de sólidos?', 'Inscrito: tangencia internamente. Circunscrito: envolve externamente. Esfera inscrita no cubo toca as faces; circunscrita passa pelos vértices.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Qual o raio da esfera circunscrita a um cubo de aresta a?', 'R = a√3/2. É metade da diagonal do cubo, pois a esfera passa pelos vértices.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - GEOMETRIA ANALÍTICA
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Geometria Analítica: Ponto, Reta, Circunferência e Cônicas',
    'Estudo da geometria no plano cartesiano: distâncias, equações de retas, circunferências e cônicas.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'geometria analítica', 'reta', 'circunferência', 'enem'],
    true, true, 4.7
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a fórmula da distância entre dois pontos?', 'd = √[(x₂-x₁)² + (y₂-y₁)²]. Baseada no Teorema de Pitágoras aplicado ao triângulo formado.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'Qual a distância entre A(1,2) e B(4,6)?', 'd = √[(4-1)² + (6-2)²] = √[9 + 16] = √25 = 5 unidades.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Qual a fórmula do ponto médio de um segmento?', 'M = ((x₁+x₂)/2, (y₁+y₂)/2). Média aritmética das coordenadas.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Qual o ponto médio do segmento de extremos A(2,3) e B(8,7)?', 'M = ((2+8)/2, (3+7)/2) = (5, 5).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que é o baricentro de um triângulo?', 'Ponto de encontro das medianas. G = ((x₁+x₂+x₃)/3, (y₁+y₂+y₃)/3). Média das coordenadas dos vértices.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Qual a equação geral da reta?', 'ax + by + c = 0, onde a, b, c são constantes e a² + b² ≠ 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Qual a equação reduzida da reta?', 'y = mx + n, onde m = coeficiente angular (inclinação) e n = coeficiente linear (intercepto em y).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'O que representa o coeficiente angular m?', 'm = tg(θ), onde θ é o ângulo que a reta faz com o eixo x. m = (y₂-y₁)/(x₂-x₁) para dois pontos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'Qual a equação da reta que passa por A(1,3) e B(4,9)?', 'm = (9-3)/(4-1) = 2. Usando y - 3 = 2(x - 1): y = 2x + 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Quando duas retas são paralelas?', 'Quando têm o mesmo coeficiente angular: m₁ = m₂ (ou ambas verticais).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Quando duas retas são perpendiculares?', 'Quando m₁ × m₂ = -1. Os coeficientes angulares são inversos e opostos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Qual a distância de um ponto P(x₀,y₀) a uma reta ax+by+c=0?', 'd = |ax₀ + by₀ + c| / √(a² + b²). Valor absoluto garante distância positiva.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Qual a distância do ponto (3,4) à reta 3x + 4y - 10 = 0?', 'd = |3(3) + 4(4) - 10| / √(9+16) = |9+16-10| / 5 = 15/5 = 3 unidades.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Qual a equação reduzida da circunferência?', '(x-a)² + (y-b)² = r², onde (a,b) é o centro e r é o raio.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual a equação geral da circunferência?', 'x² + y² - 2ax - 2by + (a² + b² - r²) = 0, ou x² + y² + Dx + Ey + F = 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Qual o centro e raio da circunferência x² + y² - 6x + 4y - 12 = 0?', 'Completando quadrados: (x-3)² + (y+2)² = 25. Centro (3,-2), raio r = 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Como verificar a posição de um ponto em relação a uma circunferência?', 'Substitua na equação. Se < r²: interno. Se = r²: pertence. Se > r²: externo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'O que são cônicas?', 'Curvas obtidas pela interseção de um plano com um cone: elipse, hipérbole e parábola.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'Qual a equação reduzida da elipse com centro na origem?', 'x²/a² + y²/b² = 1, onde a > b. Eixo maior = 2a, eixo menor = 2b.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'O que são os focos da elipse?', 'Dois pontos fixos tais que a soma das distâncias de qualquer ponto da elipse até eles é constante (2a). c² = a² - b².', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'Qual a equação reduzida da hipérbole com centro na origem?', 'x²/a² - y²/b² = 1 (eixo real em x) ou y²/a² - x²/b² = 1 (eixo real em y).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'O que são as assíntotas da hipérbole?', 'Retas y = ±(b/a)x para as quais a hipérbole se aproxima indefinidamente sem tocar.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Qual a equação reduzida da parábola com vértice na origem?', 'y² = 4px (eixo em x) ou x² = 4py (eixo em y). p = parâmetro (distância foco-vértice).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'O que é a diretriz de uma parábola?', 'Reta fixa tal que todo ponto da parábola é equidistante do foco e da diretriz.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Qual a área do triângulo de vértices A(1,2), B(4,6), C(7,2)?', 'A = (1/2)|x₁(y₂-y₃) + x₂(y₃-y₁) + x₃(y₁-y₂)| = (1/2)|1(4) + 4(0) + 7(-4)| = (1/2)|4-28| = 12.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'O que significa três pontos serem colineares?', 'Pertencem à mesma reta. Condição: área do triângulo = 0, ou determinante = 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'Qual a equação da reta tangente à circunferência no ponto de tangência?', 'A tangente é perpendicular ao raio no ponto de tangência. Se raio tem inclinação m, tangente tem -1/m.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'O que é excentricidade de uma cônica?', 'e = c/a. Elipse: 0 < e < 1. Parábola: e = 1. Hipérbole: e > 1. Circunferência: e = 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Qual a posição relativa de duas retas no plano?', 'Paralelas (m₁ = m₂), concorrentes (m₁ ≠ m₂, com um ponto comum), ou coincidentes (mesma reta).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Como encontrar o ponto de interseção de duas retas?', 'Resolver o sistema formado pelas duas equações. A solução (x,y) é o ponto de interseção.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - TRIGONOMETRIA
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Trigonometria: Razões, Ciclo e Funções',
    'Trigonometria no triângulo retângulo, ciclo trigonométrico, funções seno/cosseno/tangente e identidades.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'trigonometria', 'seno', 'cosseno', 'enem'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é seno de um ângulo no triângulo retângulo?', 'sen(θ) = cateto oposto / hipotenusa = CO/H. Razão entre o lado oposto ao ângulo e a hipotenusa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que é cosseno de um ângulo no triângulo retângulo?', 'cos(θ) = cateto adjacente / hipotenusa = CA/H. Razão entre o lado adjacente ao ângulo e a hipotenusa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'O que é tangente de um ângulo no triângulo retângulo?', 'tg(θ) = cateto oposto / cateto adjacente = CO/CA = sen(θ)/cos(θ).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Quais os valores de sen, cos e tg de 30°?', 'sen(30°) = 1/2, cos(30°) = √3/2, tg(30°) = √3/3 = 1/√3.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'Quais os valores de sen, cos e tg de 45°?', 'sen(45°) = √2/2, cos(45°) = √2/2, tg(45°) = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Quais os valores de sen, cos e tg de 60°?', 'sen(60°) = √3/2, cos(60°) = 1/2, tg(60°) = √3.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Qual a relação fundamental da trigonometria?', 'sen²(θ) + cos²(θ) = 1. Válida para qualquer ângulo. Deriva de Pitágoras.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'O que é o ciclo trigonométrico?', 'Circunferência de raio 1 centrada na origem. O ângulo θ é medido a partir do eixo x positivo no sentido anti-horário.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'No ciclo trigonométrico, como ler sen(θ) e cos(θ)?', 'cos(θ) = abscissa (coordenada x) do ponto. sen(θ) = ordenada (coordenada y) do ponto.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Como converter graus para radianos?', 'Radianos = (π/180°) × Graus. Ex: 180° = π rad, 90° = π/2 rad, 60° = π/3 rad.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Em qual quadrante seno é positivo?', '1º e 2º quadrantes (0° a 180°). Acima do eixo x, coordenada y é positiva.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Em qual quadrante cosseno é positivo?', '1º e 4º quadrantes (-90° a 90°). À direita do eixo y, coordenada x é positiva.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Em qual quadrante tangente é positiva?', '1º e 3º quadrantes. Onde sen e cos têm mesmo sinal (ambos + ou ambos -).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Qual o valor de sen(0°), cos(0°), tg(0°)?', 'sen(0°) = 0, cos(0°) = 1, tg(0°) = 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual o valor de sen(90°), cos(90°), tg(90°)?', 'sen(90°) = 1, cos(90°) = 0, tg(90°) = não existe (divisão por zero).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'O que é arco cosseno, arco seno e arco tangente?', 'São as funções inversas. arccos(x), arcsen(x), arctg(x) retornam o ângulo cujo cos/sen/tg é x.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Qual a Lei dos Senos?', 'a/sen(A) = b/sen(B) = c/sen(C) = 2R, onde R é o raio da circunferência circunscrita.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Qual a Lei dos Cossenos?', 'a² = b² + c² - 2bc·cos(A). Generalização de Pitágoras para qualquer triângulo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'Qual o período da função f(x) = sen(x)?', 'Período = 2π (ou 360°). A função se repete a cada 2π radianos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual o período da função f(x) = tg(x)?', 'Período = π (ou 180°). A tangente tem período menor que seno e cosseno.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'Qual a imagem da função seno e cosseno?', 'Im = [-1, 1]. Os valores variam entre -1 e 1, inclusive.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Qual a imagem da função tangente?', 'Im = ℝ (todos os reais). A tangente não é limitada.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Qual a fórmula do seno da soma: sen(a+b)?', 'sen(a+b) = sen(a)·cos(b) + sen(b)·cos(a).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Qual a fórmula do cosseno da soma: cos(a+b)?', 'cos(a+b) = cos(a)·cos(b) - sen(a)·sen(b).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Qual a fórmula do arco duplo para seno: sen(2x)?', 'sen(2x) = 2·sen(x)·cos(x).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'Qual a fórmula do arco duplo para cosseno: cos(2x)?', 'cos(2x) = cos²(x) - sen²(x) = 2cos²(x) - 1 = 1 - 2sen²(x). Três formas equivalentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'Como resolver sen(x) = 1/2?', 'x = 30° + k·360° ou x = 150° + k·360° (k ∈ ℤ). Ou em radianos: x = π/6 + 2kπ ou x = 5π/6 + 2kπ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'O que é secante, cossecante e cotangente?', 'sec(θ) = 1/cos(θ), csc(θ) = 1/sen(θ), cotg(θ) = 1/tg(θ) = cos(θ)/sen(θ).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Qual a identidade 1 + tg²(x) = ?', '1 + tg²(x) = sec²(x). Deriva da relação fundamental dividindo por cos²(x).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Qual a área do triângulo usando seno?', 'A = (1/2)·a·b·sen(C), onde C é o ângulo entre os lados a e b.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - ESTATÍSTICA
  -- ============================================================================
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/estatistica';

  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Estatística: Média, Moda, Mediana e Desvio Padrão',
    'Medidas de tendência central e dispersão: média, moda, mediana, variância e desvio padrão.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'estatística', 'média', 'desvio padrão', 'enem'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é média aritmética?', 'Soma de todos os valores dividida pela quantidade: x̄ = (x₁ + x₂ + ... + xₙ) / n. Representa o "centro de gravidade" dos dados.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 2, 'basic', 'Calcule a média de: 4, 7, 8, 10, 11.', 'x̄ = (4+7+8+10+11)/5 = 40/5 = 8.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 3, 'basic', 'O que é média ponderada?', 'Média onde cada valor tem um peso: x̄ = Σ(xᵢ·wᵢ) / Σwᵢ. Útil para médias escolares, por exemplo.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 4, 'basic', 'Notas 7, 8, 6 com pesos 2, 3, 5. Qual a média?', 'x̄ = (7×2 + 8×3 + 6×5)/(2+3+5) = (14+24+30)/10 = 68/10 = 6,8.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 5, 'basic', 'O que é moda?', 'Valor que mais se repete no conjunto. Pode haver mais de uma moda (bimodal) ou nenhuma (amodal).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 6, 'basic', 'Qual a moda de: 2, 3, 3, 5, 7, 7, 7, 9?', 'Mo = 7 (aparece 3 vezes, mais que qualquer outro).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 7, 'basic', 'O que é mediana?', 'Valor central quando os dados estão ordenados. Se n ímpar: valor do meio. Se n par: média dos dois centrais.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 8, 'basic', 'Qual a mediana de: 3, 5, 7, 9, 11?', 'n = 5 (ímpar). Md = 7 (3º valor, que é o central).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 9, 'basic', 'Qual a mediana de: 2, 4, 6, 8?', 'n = 4 (par). Md = (4+6)/2 = 5 (média dos dois centrais).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 10, 'basic', 'Qual a vantagem da mediana sobre a média?', 'A mediana é resistente a valores extremos (outliers). Salários usam mediana pois bilionários distorcem a média.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 11, 'basic', 'O que são quartis?', 'Dividem os dados ordenados em 4 partes iguais. Q₁ (25%), Q₂ = mediana (50%), Q₃ (75%).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 12, 'basic', 'O que é amplitude?', 'Diferença entre o maior e o menor valor: A = xₘₐₓ - xₘᵢₙ. Medida simples de dispersão.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 13, 'basic', 'O que é variância?', 'Média dos quadrados dos desvios: s² = Σ(xᵢ - x̄)² / n. Mede o espalhamento em relação à média.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 14, 'basic', 'Por que se usa o quadrado dos desvios na variância?', 'Para evitar que desvios positivos e negativos se cancelem. O quadrado também penaliza mais desvios grandes.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 15, 'basic', 'O que é desvio padrão?', 's = √variância = √s². Tem a mesma unidade dos dados originais, facilitando interpretação.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 16, 'basic', 'Dados: 2, 4, 6. Calcule a variância e o desvio padrão.', 'x̄ = 4. Desvios: -2, 0, 2. Quadrados: 4, 0, 4. s² = 8/3 ≈ 2,67. s ≈ 1,63.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 17, 'basic', 'O que é coeficiente de variação?', 'CV = (s / x̄) × 100%. Permite comparar dispersões de conjuntos com médias diferentes.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 18, 'basic', 'O que é um gráfico de caixa (boxplot)?', 'Representa Q₁, mediana, Q₃, mínimo e máximo. Visualiza a distribuição e identifica outliers.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 19, 'basic', 'O que é intervalo interquartil (IQR)?', 'IQR = Q₃ - Q₁. Representa a dispersão dos 50% centrais dos dados. Usado para identificar outliers.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 20, 'basic', 'Como identificar um outlier pelo boxplot?', 'Outlier: valor < Q₁ - 1,5×IQR ou > Q₃ + 1,5×IQR. São pontos isolados além dos "bigodes".', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 21, 'basic', 'O que é distribuição simétrica?', 'Quando média ≈ mediana ≈ moda. Os dados estão equilibrados em torno do centro.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 22, 'basic', 'O que é assimetria à direita (positiva)?', 'Quando média > mediana > moda. Há valores extremos altos puxando a média para cima. Cauda longa à direita.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 23, 'basic', 'O que é assimetria à esquerda (negativa)?', 'Quando média < mediana < moda. Há valores extremos baixos. Cauda longa à esquerda.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 24, 'basic', 'O que é frequência absoluta?', 'Número de vezes que um valor aparece. Soma das frequências = n (total de dados).', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 25, 'basic', 'O que é frequência relativa?', 'Proporção de ocorrências: fᵣ = frequência absoluta / n. Expressa como fração ou porcentagem.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 26, 'basic', 'O que é frequência acumulada?', 'Soma das frequências até determinado valor. Útil para encontrar mediana em tabelas de frequência.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 27, 'basic', 'Como calcular a média de dados agrupados em classes?', 'Usa-se o ponto médio de cada classe. x̄ = Σ(ponto médio × frequência) / n.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 28, 'basic', 'O que é histograma?', 'Gráfico de barras contíguas para dados quantitativos contínuos. Altura = frequência, largura = intervalo de classe.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 29, 'basic', 'Qual a diferença entre população e amostra?', 'População: todos os elementos de interesse. Amostra: subconjunto da população usado para inferência.', 'Fundamentos de Estatística - Bussab'),
  (v_deck_id, 30, 'basic', 'Por que usar n-1 (ao invés de n) na variância amostral?', 'Correção de Bessel: compensa o viés de usar a média amostral. Torna a estimativa não-viesada para a variância populacional.', 'Fundamentos de Estatística - Bussab');

  -- ============================================================================
  -- MATEMÁTICA - MATRIZES E SISTEMAS LINEARES
  -- ============================================================================
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/algebra';

  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Matrizes e Sistemas Lineares: Operações e Determinantes',
    'Matrizes, operações, determinantes e resolução de sistemas lineares.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'matrizes', 'sistemas', 'determinante', 'enem'],
    true, true, 4.7
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é uma matriz?', 'Tabela retangular de números organizados em m linhas e n colunas. Notação: A = [aᵢⱼ]ₘₓₙ, onde aᵢⱼ é o elemento da linha i e coluna j.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que é uma matriz quadrada?', 'Matriz onde o número de linhas = número de colunas (m = n). Pode ter determinante.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'O que é a diagonal principal de uma matriz?', 'Elementos aᵢᵢ onde i = j (linha = coluna): a₁₁, a₂₂, a₃₃, etc. Vai do canto superior esquerdo ao inferior direito.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'O que é matriz identidade (I)?', 'Matriz quadrada com 1s na diagonal principal e 0s nas demais posições. A × I = I × A = A.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que é matriz nula?', 'Matriz onde todos os elementos são zero. Funciona como o zero na adição: A + 0 = A.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'O que é matriz transposta (Aᵀ)?', 'Matriz obtida trocando linhas por colunas. Se A é m×n, então Aᵀ é n×m. (Aᵀ)ᵢⱼ = Aⱼᵢ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Quando podemos somar duas matrizes?', 'Quando têm a mesma ordem (mesmo número de linhas e colunas). Soma-se elemento a elemento.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'Como multiplicar uma matriz por um escalar?', 'Multiplica-se cada elemento pelo escalar: (k·A)ᵢⱼ = k·aᵢⱼ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'Quando podemos multiplicar duas matrizes A×B?', 'Quando o número de colunas de A = número de linhas de B. Se A é m×n e B é n×p, então AB é m×p.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Como calcular o elemento (AB)ᵢⱼ?', 'Soma dos produtos linha i de A por coluna j de B: (AB)ᵢⱼ = Σₖ aᵢₖ·bₖⱼ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'A multiplicação de matrizes é comutativa?', 'NÃO! Em geral, AB ≠ BA. A ordem importa na multiplicação de matrizes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'O que é o determinante de uma matriz?', 'Número associado a matrizes quadradas. det(A) = 0 indica matriz singular (não inversível).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Como calcular o determinante de uma matriz 2×2?', 'det[a b; c d] = ad - bc. Produto da diagonal principal menos produto da diagonal secundária.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Calcule o determinante de [3 2; 1 4].', 'det = 3×4 - 2×1 = 12 - 2 = 10.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'O que é a Regra de Sarrus?', 'Método para calcular determinante 3×3: soma dos produtos das diagonais principais menos soma dos produtos das diagonais secundárias.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'O que acontece com o determinante se trocarmos duas linhas?', 'O sinal do determinante inverte: det(nova) = -det(original).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'O que acontece com o determinante se multiplicarmos uma linha por k?', 'O determinante fica multiplicado por k: det(nova) = k × det(original).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Se uma matriz tem duas linhas iguais, qual seu determinante?', 'det = 0. Também vale para linhas proporcionais ou linha de zeros.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'Qual a relação det(AB) = ?', 'det(AB) = det(A) × det(B). O determinante do produto é o produto dos determinantes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'O que é a matriz inversa (A⁻¹)?', 'Matriz tal que A × A⁻¹ = A⁻¹ × A = I. Só existe se det(A) ≠ 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'Como calcular a inversa de uma matriz 2×2?', 'A⁻¹ = (1/det)[d -b; -c a] para A = [a b; c d]. Troca diagonal principal, inverte sinais da secundária.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'O que é um sistema linear?', 'Conjunto de equações lineares (grau 1). Pode ser representado como AX = B, onde A é matriz de coeficientes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'O que é a Regra de Cramer?', 'xᵢ = det(Aᵢ)/det(A), onde Aᵢ é A com a coluna i substituída por B. Só funciona se det(A) ≠ 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Quando um sistema linear tem solução única?', 'Quando det(A) ≠ 0. O sistema é Possível e Determinado (SPD).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'O que é um sistema indeterminado (SPI)?', 'Sistema com infinitas soluções. det(A) = 0, mas o sistema é consistente. Há variáveis livres.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'O que é um sistema impossível (SI)?', 'Sistema sem solução. As equações são contraditórias (ex: 0x = 5).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'O que é escalonamento de matrizes?', 'Técnica para simplificar sistemas: transformar a matriz aumentada em forma escalonada usando operações elementares.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Quais são as operações elementares sobre linhas?', '1) Trocar duas linhas. 2) Multiplicar linha por escalar não-nulo. 3) Somar múltiplo de uma linha a outra.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Resolva: 2x + y = 5, x - y = 1 (por Cramer).', 'det(A) = -2-1 = -3. Dx = 5(-1) - 1(1) = -6, Dy = 2(1) - 5(1) = -3. x = -6/-3 = 2, y = -3/-3 = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'O que é posto (rank) de uma matriz?', 'Número de linhas não-nulas após escalonamento. Indica a quantidade de equações independentes.', 'Fundamentos de Matemática Elementar - Iezzi');

  RAISE NOTICE 'Decks de Matemática (parte 3) inseridos com sucesso!';
END $$;
