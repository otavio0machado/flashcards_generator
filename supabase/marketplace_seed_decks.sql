-- Marketplace Seed: Decks de Ensino Médio, Direito, Medicina, Engenharia e TI
-- Autor: otavio100206@gmail.com
-- Total: ~50 decks com 30 cards cada

-- Buscar o author_id do usuário
DO $$
DECLARE
  v_author_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  -- Buscar o ID do autor pelo email
  SELECT id INTO v_author_id
  FROM auth.users
  WHERE email = 'otavio100206@gmail.com';

  IF v_author_id IS NULL THEN
    RAISE EXCEPTION 'Usuário não encontrado: otavio100206@gmail.com';
  END IF;

  -- ============================================================================
  -- MATEMÁTICA - CONJUNTOS NUMÉRICOS
  -- ============================================================================
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/algebra';

  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Conjuntos Numéricos (N, Z, Q, I, R)',
    'Domínio completo dos conjuntos numéricos: naturais, inteiros, racionais, irracionais e reais. Inclui intervalos e operações.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'conjuntos', 'enem', 'vestibular', 'ensino médio'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é o conjunto dos números Naturais (ℕ)?', 'É o conjunto dos números inteiros não-negativos usados para contagem: ℕ = {0, 1, 2, 3, 4, ...}. Alguns autores excluem o zero (ℕ* = {1, 2, 3, ...}).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que é o conjunto dos números Inteiros (ℤ)?', 'É o conjunto que inclui todos os naturais e seus opostos negativos: ℤ = {..., -3, -2, -1, 0, 1, 2, 3, ...}. O símbolo vem do alemão "Zahlen" (números).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Como é definido o conjunto dos números Racionais (ℚ)?', 'É o conjunto dos números que podem ser expressos como fração a/b, onde a ∈ ℤ e b ∈ ℤ* (b ≠ 0). Inclui decimais finitos e dízimas periódicas. Ex: 1/2, -3/4, 0.333...', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'O que caracteriza os números Irracionais (𝕀)?', 'São números que NÃO podem ser expressos como fração. Possuem representação decimal infinita e não-periódica. Exemplos clássicos: π ≈ 3.14159..., √2 ≈ 1.41421..., e (número de Euler) ≈ 2.71828...', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que é o conjunto dos números Reais (ℝ)?', 'É a união de todos os racionais e irracionais: ℝ = ℚ ∪ 𝕀. Representa todos os pontos de uma reta numérica, preenchendo-a completamente sem "buracos".', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Qual a relação de inclusão entre os conjuntos numéricos?', 'ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ, e 𝕀 ⊂ ℝ. Ou seja: todo natural é inteiro, todo inteiro é racional, todo racional é real, e todo irracional é real.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'O número -5 pertence a quais conjuntos numéricos?', '-5 ∈ ℤ, ℚ, ℝ. Não pertence a ℕ (pois é negativo) nem a 𝕀 (pois é racional: -5 = -5/1).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'O número √9 pertence a quais conjuntos?', '√9 = 3, portanto pertence a ℕ, ℤ, ℚ e ℝ. Cuidado: raiz quadrada de quadrado perfeito resulta em número racional!', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'O número 0,75 é racional ou irracional? Justifique.', 'É RACIONAL. 0,75 = 75/100 = 3/4. Todo decimal finito pode ser escrito como fração com denominador potência de 10.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'A dízima periódica 0,333... é racional? Por quê?', 'SIM, é racional. 0,333... = 1/3. Toda dízima periódica (simples ou composta) pode ser convertida em fração, logo pertence a ℚ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Como converter a dízima 0,666... em fração?', 'Seja x = 0,666... → 10x = 6,666... → 10x - x = 6 → 9x = 6 → x = 6/9 = 2/3. Método: multiplicar por potência de 10 e subtrair.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'O que é um intervalo aberto (a, b)?', 'É o conjunto de todos os reais maiores que a e menores que b: (a, b) = {x ∈ ℝ | a < x < b}. Os extremos a e b NÃO pertencem ao intervalo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'O que é um intervalo fechado [a, b]?', 'É o conjunto de todos os reais entre a e b, INCLUINDO os extremos: [a, b] = {x ∈ ℝ | a ≤ x ≤ b}. Representado graficamente com bolinhas cheias.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Qual a diferença entre [a, b) e (a, b]?', '[a, b) inclui a mas exclui b: a ≤ x < b. (a, b] exclui a mas inclui b: a < x ≤ b. São intervalos semi-abertos (ou semi-fechados).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'O que representa o intervalo (-∞, 5]?', 'Representa todos os reais menores ou iguais a 5: {x ∈ ℝ | x ≤ 5}. O infinito sempre usa parênteses pois não é um número real.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Como representar "x é maior que 2 e menor ou igual a 7" em intervalo?', '(2, 7] ou {x ∈ ℝ | 2 < x ≤ 7}. O 2 é excluído (parêntese) e o 7 é incluído (colchete).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Qual o resultado de [1, 5] ∩ [3, 8]?', '[3, 5]. A interseção contém apenas os elementos comuns a ambos os intervalos, que são os números de 3 a 5 inclusive.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Qual o resultado de [1, 5] ∪ [3, 8]?', '[1, 8]. A união contém todos os elementos que pertencem a pelo menos um dos intervalos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'O que é o complementar de um conjunto A em relação a ℝ?', 'É o conjunto de todos os reais que NÃO pertencem a A: Aᶜ = ℝ - A. Exemplo: se A = [0, 5], então Aᶜ = (-∞, 0) ∪ (5, +∞).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual a diferença entre A - B e B - A?', 'A - B são os elementos de A que não estão em B. B - A são os elementos de B que não estão em A. Em geral, A - B ≠ B - A.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'O que significa ℤ* (Z estrela)?', 'São os inteiros não-nulos: ℤ* = {..., -2, -1, 1, 2, ...} = ℤ - {0}. O asterisco indica exclusão do zero.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'O que significa ℤ₊ (Z positivo)?', 'São os inteiros não-negativos: ℤ₊ = {0, 1, 2, 3, ...} = ℕ. O subscrito indica apenas elementos positivos ou zero.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'O que é ℚ₊*?', 'São os racionais positivos diferentes de zero. Combina as notações: positivo (₊) e não-nulo (*). Exemplo: 1/2, 3, 0.5 ∈ ℚ₊*, mas 0 e -1/3 não pertencem.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Por que √2 é irracional?', 'Prova por contradição: se √2 = p/q (fração irredutível), então 2q² = p², logo p é par. Se p = 2k, então 2q² = 4k², logo q² = 2k², então q é par. Contradição: p/q não seria irredutível.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'A soma de dois irracionais é sempre irracional?', 'NÃO! Contraexemplo: √2 + (-√2) = 0, que é racional. Mas a soma de um racional com um irracional é sempre irracional.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'O produto de dois irracionais é sempre irracional?', 'NÃO! Contraexemplo: √2 × √2 = 2, que é racional. Porém, o produto de um racional não-nulo por um irracional é sempre irracional.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', '0,999... é igual a 1?', 'SIM! Prova: seja x = 0,999..., então 10x = 9,999... Subtraindo: 9x = 9, logo x = 1. Isso demonstra que 0,999... e 1 são representações do mesmo número.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Entre quaisquer dois números racionais existe um irracional?', 'SIM! Entre quaisquer dois números reais distintos existem infinitos racionais E infinitos irracionais. Isso é a propriedade da densidade dos reais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'O que é o módulo de um número real?', '|x| é a distância de x até a origem. |x| = x se x ≥ 0, e |x| = -x se x < 0. Exemplo: |5| = 5, |-3| = 3. Sempre não-negativo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Qual o conjunto solução de |x - 2| < 3?', '-3 < x - 2 < 3 → -1 < x < 5. Resposta: intervalo (-1, 5). Módulo menor que k gera dupla desigualdade.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - FUNÇÕES DO 1º E 2º GRAU
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Funções: 1º Grau (Afim) e 2º Grau (Quadrática)',
    'Estudo completo das funções afim e quadrática: gráficos, raízes, vértice, concavidade e aplicações.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'funções', 'enem', 'vestibular', 'parábola'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a forma geral de uma função do 1º grau?', 'f(x) = ax + b, onde a ≠ 0 é o coeficiente angular (taxa de variação) e b é o coeficiente linear (ordenada na origem). O gráfico é sempre uma reta.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que representa o coeficiente angular "a" na função f(x) = ax + b?', 'Representa a inclinação da reta e a taxa de variação. Se a > 0, a função é crescente. Se a < 0, a função é decrescente. |a| indica quão "íngreme" é a reta.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Como encontrar a raiz (zero) de f(x) = 3x - 6?', 'Fazendo f(x) = 0: 3x - 6 = 0 → 3x = 6 → x = 2. A raiz é o ponto onde o gráfico corta o eixo x, ou seja, (2, 0).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Qual a forma geral de uma função do 2º grau?', 'f(x) = ax² + bx + c, onde a ≠ 0. O gráfico é uma parábola. "a" determina a concavidade, "c" é o ponto onde corta o eixo y.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que indica o sinal do coeficiente "a" em f(x) = ax² + bx + c?', 'Se a > 0: parábola com concavidade para CIMA (∪), ponto de mínimo. Se a < 0: concavidade para BAIXO (∩), ponto de máximo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Qual a fórmula de Bhaskara para encontrar as raízes?', 'x = (-b ± √Δ) / 2a, onde Δ = b² - 4ac é o discriminante. Esta fórmula fornece as raízes (zeros) da função quadrática.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'O que o discriminante Δ = b² - 4ac indica sobre as raízes?', 'Δ > 0: duas raízes reais distintas. Δ = 0: duas raízes reais iguais (raiz dupla). Δ < 0: nenhuma raiz real (raízes complexas conjugadas).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'Quais são as coordenadas do vértice de uma parábola?', 'V = (xᵥ, yᵥ), onde xᵥ = -b/2a e yᵥ = -Δ/4a (ou calcule f(xᵥ)). O vértice é o ponto de máximo ou mínimo da parábola.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'Qual o vértice de f(x) = x² - 4x + 3?', 'xᵥ = -(-4)/2(1) = 2. yᵥ = f(2) = 4 - 8 + 3 = -1. V = (2, -1). Como a > 0, é ponto de mínimo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Encontre as raízes de f(x) = x² - 5x + 6.', 'Δ = 25 - 24 = 1. x = (5 ± 1)/2. x₁ = 3, x₂ = 2. Ou por soma e produto: x₁ + x₂ = 5 e x₁ · x₂ = 6.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'O que são as relações de Girard (soma e produto das raízes)?', 'Para ax² + bx + c = 0: x₁ + x₂ = -b/a (soma) e x₁ · x₂ = c/a (produto). Útil para construir ou verificar equações.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Qual a equação do 2º grau com raízes 3 e -2?', 'Soma: 3 + (-2) = 1 = -b/a → b = -1 (se a = 1). Produto: 3 × (-2) = -6 = c/a → c = -6. Equação: x² - x - 6 = 0.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Como é o gráfico de f(x) = -x² + 4?', 'Parábola com concavidade para baixo (a = -1 < 0). Vértice em V(0, 4) - ponto de máximo. Raízes em x = ±2. Corta eixo y em (0, 4).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'O que é o eixo de simetria de uma parábola?', 'É a reta vertical x = xᵥ = -b/2a que divide a parábola em duas partes simétricas. Passa pelo vértice.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Quando f(x) = x² - 6x + 5 é positiva?', 'Raízes: x = 1 e x = 5. Como a > 0, a parábola é positiva fora das raízes: x < 1 ou x > 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Qual o valor máximo de f(x) = -2x² + 8x - 3?', 'Como a < 0, existe máximo no vértice. xᵥ = -8/(-4) = 2. yᵥ = f(2) = -8 + 16 - 3 = 5. Valor máximo = 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Um projétil segue h(t) = -5t² + 20t. Qual a altura máxima?', 'tᵥ = -20/(-10) = 2s. h(2) = -20 + 40 = 20m. A altura máxima é 20 metros, atingida em t = 2 segundos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'O que é a forma fatorada de uma função quadrática?', 'f(x) = a(x - x₁)(x - x₂), onde x₁ e x₂ são as raízes. Exemplo: x² - 5x + 6 = (x - 2)(x - 3).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'O que é a forma canônica de uma função quadrática?', 'f(x) = a(x - xᵥ)² + yᵥ, onde (xᵥ, yᵥ) é o vértice. Útil para identificar translações da parábola básica y = x².', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'O coeficiente "c" em f(x) = ax² + bx + c representa o quê?', 'É o valor de f(0), ou seja, onde a parábola intercepta o eixo y. O ponto (0, c) sempre pertence ao gráfico.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'Como determinar se uma função é crescente ou decrescente?', 'Função do 1º grau: crescente se a > 0, decrescente se a < 0. Função do 2º grau: crescente em parte do domínio e decrescente em outra (muda no vértice).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Qual o domínio e a imagem de f(x) = x² - 4?', 'Domínio: ℝ (todos os reais). Imagem: [-4, +∞), pois o mínimo é yᵥ = -4 (vértice em (0, -4)) e a parábola abre para cima.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Para quais valores de k a equação x² + 4x + k = 0 tem raízes reais?', 'Raízes reais quando Δ ≥ 0. Δ = 16 - 4k ≥ 0 → k ≤ 4. Para k > 4, não há raízes reais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Se f(x) = 2x + 3, calcule f(f(2)).', 'f(2) = 2(2) + 3 = 7. f(f(2)) = f(7) = 2(7) + 3 = 17. Isso é composição da função consigo mesma.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Qual a diferença entre função afim e função linear?', 'Função linear: f(x) = ax (b = 0), passa pela origem. Função afim: f(x) = ax + b (caso geral). Toda linear é afim, mas nem toda afim é linear.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'A reta passa por (1, 3) e (3, 7). Qual sua equação?', 'a = (7-3)/(3-1) = 2. Usando y - 3 = 2(x - 1): y = 2x + 1. Verificação: f(1) = 3 ✓, f(3) = 7 ✓.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'O que é taxa de variação média?', 'TVM = [f(b) - f(a)] / (b - a). Para função do 1º grau, TVM é constante e igual a "a". Para 2º grau, depende do intervalo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Quando duas retas são paralelas?', 'Quando têm o mesmo coeficiente angular. Se y = a₁x + b₁ e y = a₂x + b₂, são paralelas ⟺ a₁ = a₂ (e b₁ ≠ b₂).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Quando duas retas são perpendiculares?', 'Quando o produto dos coeficientes angulares é -1. Se y = a₁x + b₁ e y = a₂x + b₂, são perpendiculares ⟺ a₁ · a₂ = -1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Um retângulo tem perímetro 20cm. Qual a função área em termos do lado x?', 'Se 2x + 2y = 20, então y = 10 - x. Área A(x) = x(10-x) = -x² + 10x. Máximo em x = 5: quadrado de lado 5, área 25cm².', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - FUNÇÃO EXPONENCIAL E LOGARÍTMICA
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Funções Exponencial e Logarítmica',
    'Domínio das funções exponenciais e logarítmicas: propriedades, gráficos, equações e inequações.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'exponencial', 'logaritmo', 'enem', 'vestibular'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a forma geral da função exponencial?', 'f(x) = aˣ, onde a > 0 e a ≠ 1 é a base. Se a > 1, a função é crescente. Se 0 < a < 1, é decrescente.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'Por que a base "a" não pode ser 1 nem negativa?', 'Se a = 1: f(x) = 1ˣ = 1 (constante, não exponencial). Se a < 0: aˣ não está definida para todo x real (ex: (-2)^(1/2) = √(-2) ∉ ℝ).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Qual é sempre o ponto que toda exponencial f(x) = aˣ passa?', 'O ponto (0, 1), pois a⁰ = 1 para qualquer a > 0. É o intercepto no eixo y.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'O que é o número de Euler "e"?', 'e ≈ 2,71828... É a base do logaritmo natural. Definido como limite: e = lim(1 + 1/n)ⁿ quando n → ∞. Fundamental em cálculo e crescimento contínuo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'Qual a propriedade de aᵐ × aⁿ?', 'aᵐ × aⁿ = aᵐ⁺ⁿ. Na multiplicação de potências de mesma base, somam-se os expoentes. Ex: 2³ × 2⁴ = 2⁷ = 128.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Qual a propriedade de aᵐ ÷ aⁿ?', 'aᵐ ÷ aⁿ = aᵐ⁻ⁿ. Na divisão de potências de mesma base, subtraem-se os expoentes. Ex: 5⁶ ÷ 5² = 5⁴.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Qual a propriedade de (aᵐ)ⁿ?', '(aᵐ)ⁿ = aᵐ×ⁿ. Potência de potência: multiplicam-se os expoentes. Ex: (2³)² = 2⁶ = 64.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'O que é a⁻ⁿ?', 'a⁻ⁿ = 1/aⁿ. Expoente negativo indica inverso. Ex: 2⁻³ = 1/2³ = 1/8.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'O que é a^(m/n)?', 'a^(m/n) = ⁿ√(aᵐ) = (ⁿ√a)ᵐ. Expoente fracionário é raiz. Ex: 8^(2/3) = ³√(8²) = ³√64 = 4.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Resolva: 2ˣ = 32.', '32 = 2⁵, então 2ˣ = 2⁵ → x = 5. Quando as bases são iguais, os expoentes são iguais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Resolva: 3^(2x-1) = 27.', '27 = 3³, então 3^(2x-1) = 3³ → 2x - 1 = 3 → 2x = 4 → x = 2.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'O que é logaritmo?', 'log_a(b) = x significa aˣ = b. É a operação inversa da exponenciação. "Qual expoente devo dar a `a` para obter `b`?"', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Quais as condições de existência do log_a(b)?', 'a > 0, a ≠ 1 (base positiva e diferente de 1), e b > 0 (logaritmando positivo). log_2(-4) não existe em ℝ.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Calcule log₂(8).', 'log₂(8) = x → 2ˣ = 8 = 2³ → x = 3. Resposta: 3.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Calcule log₃(1/9).', 'log₃(1/9) = log₃(3⁻²) = -2. Ou: 3ˣ = 1/9 = 3⁻² → x = -2.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'O que é log_a(1)?', 'log_a(1) = 0 para qualquer base a válida, pois a⁰ = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'O que é log_a(a)?', 'log_a(a) = 1 para qualquer base a válida, pois a¹ = a.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Qual a propriedade do log do produto?', 'log_a(m × n) = log_a(m) + log_a(n). Logaritmo do produto é soma dos logaritmos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'Qual a propriedade do log do quociente?', 'log_a(m/n) = log_a(m) - log_a(n). Logaritmo do quociente é diferença dos logaritmos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual a propriedade do log da potência?', 'log_a(mⁿ) = n × log_a(m). O expoente "desce" multiplicando. Ex: log(x³) = 3log(x).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'O que é a fórmula de mudança de base?', 'log_a(b) = log_c(b) / log_c(a). Permite calcular qualquer log usando base conveniente (geralmente 10 ou e).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Simplifique log₂(8) + log₂(4).', 'log₂(8) + log₂(4) = log₂(8×4) = log₂(32) = log₂(2⁵) = 5. Ou: 3 + 2 = 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Resolva log(x) + log(x-3) = 1 (base 10).', 'log(x(x-3)) = 1 → x² - 3x = 10 → x² - 3x - 10 = 0 → x = 5 ou x = -2. Como x > 3 (condição), x = 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'O que é logaritmo decimal (log)?', 'log(x) = log₁₀(x). Base 10, muito usado em ciências. Calculadoras científicas têm tecla "log" para esta base.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'O que é logaritmo natural (ln)?', 'ln(x) = logₑ(x). Base e ≈ 2,718. Fundamental em cálculo e fenômenos naturais. d/dx(ln x) = 1/x.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'Qual a relação entre f(x) = aˣ e g(x) = log_a(x)?', 'São funções inversas! Seus gráficos são simétricos em relação à reta y = x. f(g(x)) = x e g(f(x)) = x.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'A população cresce segundo P(t) = P₀ × 2^(t/10). Quanto tempo para dobrar?', 'Dobrar: P(t) = 2P₀. Então 2^(t/10) = 2 → t/10 = 1 → t = 10 unidades de tempo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Resolva a inequação 2ˣ > 16.', '2ˣ > 2⁴. Como base 2 > 1, mantém o sentido: x > 4. Solução: x ∈ (4, +∞).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Resolva a inequação (1/2)ˣ > 8.', '(1/2)ˣ > 8 = (1/2)⁻³. Como 0 < 1/2 < 1, inverte: x < -3. Solução: x ∈ (-∞, -3).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Calcule log₂(log₃(27)).', 'log₃(27) = log₃(3³) = 3. Então log₂(3) ≈ 1,585. (Se fosse log₂(log₃(81)) = log₂(4) = 2)', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - MATEMÁTICA FINANCEIRA
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Matemática Financeira: Porcentagem e Juros',
    'Porcentagem, juros simples e compostos, descontos e aplicações práticas do dia a dia.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'financeira', 'juros', 'enem', 'porcentagem'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que significa porcentagem?', 'Porcentagem (%) significa "por cento", ou seja, uma fração com denominador 100. 25% = 25/100 = 0,25.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 2, 'basic', 'Como calcular 15% de 200?', '15% de 200 = 0,15 × 200 = 30. Transforme a porcentagem em decimal (divide por 100) e multiplique.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 3, 'basic', 'Um produto custava R$80 e agora custa R$100. Qual foi o aumento percentual?', 'Aumento = 100 - 80 = 20. Aumento% = (20/80) × 100 = 25%. O preço aumentou 25%.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 4, 'basic', 'Um produto de R$120 teve 30% de desconto. Qual o preço final?', 'Desconto = 0,30 × 120 = 36. Preço final = 120 - 36 = R$84. Ou diretamente: 0,70 × 120 = R$84.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 5, 'basic', 'O que é fator de multiplicação para aumento de p%?', 'Fator = 1 + p/100. Para aumento de 20%: fator = 1,20. Multiplica-se o valor original pelo fator.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 6, 'basic', 'O que é fator de multiplicação para desconto de p%?', 'Fator = 1 - p/100. Para desconto de 15%: fator = 0,85. Multiplica-se o valor original pelo fator.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 7, 'basic', 'Um produto aumentou 20% e depois diminuiu 20%. Voltou ao preço original?', 'NÃO! 100 × 1,20 = 120. Depois: 120 × 0,80 = 96. Ficou 4% menor que o original. Aumentos e reduções não se cancelam!', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 8, 'basic', 'Dois aumentos sucessivos de 10% equivalem a um aumento de quanto?', '1,10 × 1,10 = 1,21 = aumento de 21%. Aumentos sucessivos: multiplica-se os fatores.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 9, 'basic', 'O que é Capital (C) em matemática financeira?', 'Capital (C) ou Principal (P) é o valor inicial aplicado ou emprestado. É a "semente" do investimento.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 10, 'basic', 'O que é Juro (J)?', 'Juro é a remuneração pelo uso do capital durante determinado tempo. É a diferença entre o montante final e o capital inicial: J = M - C.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 11, 'basic', 'O que é Montante (M)?', 'Montante é o valor final: capital mais juros. M = C + J. Também chamado de valor futuro.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 12, 'basic', 'Qual a fórmula dos Juros Simples?', 'J = C × i × t, onde C = capital, i = taxa (em decimal), t = tempo. Montante: M = C(1 + i×t).', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 13, 'basic', 'Calcule os juros simples de R$1000 a 2% ao mês por 6 meses.', 'J = 1000 × 0,02 × 6 = R$120. Montante: M = 1000 + 120 = R$1120.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 14, 'basic', 'Qual a característica principal dos Juros Simples?', 'Os juros são calculados sempre sobre o capital inicial. O juro é constante a cada período: J₁ = J₂ = J₃ = ... = C × i.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 15, 'basic', 'Qual a fórmula dos Juros Compostos?', 'M = C × (1 + i)ᵗ. Os juros de cada período são incorporados ao capital para o cálculo do próximo período.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 16, 'basic', 'Calcule o montante de R$1000 a 10% a.a. por 3 anos (juros compostos).', 'M = 1000 × (1,10)³ = 1000 × 1,331 = R$1331,00. Juros = 1331 - 1000 = R$331.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 17, 'basic', 'Qual a diferença entre juros simples e compostos para longo prazo?', 'Juros compostos crescem exponencialmente (muito mais rápido). No longo prazo, a diferença é enorme. "Juros sobre juros" faz o montante crescer cada vez mais rápido.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 18, 'basic', 'Em quanto tempo R$2000 viram R$4000 a 10% a.a. (juros compostos)?', '4000 = 2000 × (1,10)ᵗ → 2 = 1,10ᵗ → t = log(2)/log(1,10) ≈ 7,27 anos.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 19, 'basic', 'O que é taxa nominal e taxa efetiva?', 'Taxa nominal é a taxa anunciada (ex: 12% a.a. com capitalização mensal). Taxa efetiva é a taxa real aplicada por período de capitalização (ex: 1% a.m.).', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 20, 'basic', 'Converta 12% a.a. nominal com capitalização mensal para taxa efetiva anual.', 'Taxa mensal: 12%/12 = 1% a.m. Taxa efetiva anual: (1,01)¹² - 1 ≈ 12,68% a.a.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 21, 'basic', 'O que é desconto comercial (por fora)?', 'D = N × i × t, onde N = valor nominal (valor futuro). Valor presente: V = N - D = N(1 - i×t). Usado em duplicatas e títulos.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 22, 'basic', 'O que é desconto racional (por dentro)?', 'D = V × i × t, onde V = valor presente. N = V(1 + i×t). É matematicamente mais correto, equivalente a juros simples "ao contrário".', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 23, 'basic', 'Uma duplicata de R$1000 é descontada 2 meses antes a 5% a.m. (desconto comercial). Qual o valor recebido?', 'D = 1000 × 0,05 × 2 = R$100. V = 1000 - 100 = R$900.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 24, 'basic', 'O que significa "taxas equivalentes"?', 'Taxas que, aplicadas a um mesmo capital pelo mesmo prazo, produzem o mesmo montante. Ex: 1% a.m. é equivalente a (1,01)¹² - 1 ≈ 12,68% a.a. em juros compostos.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 25, 'basic', 'Como converter taxa mensal para diária (juros compostos)?', 'Se i_m é a taxa mensal: i_d = (1 + i_m)^(1/30) - 1. Ex: 3% a.m. → i_d = 1,03^(1/30) - 1 ≈ 0,0986% a.d.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 26, 'basic', 'O que é a "Regra dos 72"?', 'Estimativa: tempo para dobrar capital ≈ 72 / taxa%. Para 6% a.a.: 72/6 = 12 anos para dobrar. Funciona bem para juros compostos.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 27, 'basic', 'O que é taxa real de juros?', 'Taxa real = taxa descontando a inflação. (1 + i_real) = (1 + i_nominal) / (1 + inflação). Se nominal = 10% e inflação = 4%: real ≈ 5,77%.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 28, 'basic', 'Um investimento rendeu 15% no ano, mas a inflação foi 10%. Qual o ganho real?', '(1,15)/(1,10) - 1 = 0,0455 = 4,55% de ganho real. O poder de compra aumentou 4,55%.', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 29, 'basic', 'O que é amortização?', 'É o pagamento gradual de uma dívida em parcelas. Cada parcela contém uma parte de juros e uma parte de amortização (abatimento do principal).', 'Matemática Comercial e Financeira - Assaf Neto'),
  (v_deck_id, 30, 'basic', 'Qual a diferença entre SAC e Price?', 'SAC: amortização constante, parcelas decrescentes. Price: parcelas iguais, amortização crescente. No SAC, paga-se menos juros no total.', 'Matemática Comercial e Financeira - Assaf Neto');

  RAISE NOTICE 'Decks de Matemática (parte 1) inseridos com sucesso!';
END $$;
