-- Marketplace Seed: Decks de Matemática (Parte 2)
-- Análise Combinatória, Probabilidade, Geometria Plana

DO $$
DECLARE
  v_author_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_author_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_author_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/estatistica';

  -- ============================================================================
  -- MATEMÁTICA - ANÁLISE COMBINATÓRIA
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Análise Combinatória: Arranjos, Combinações e Permutações',
    'Fatorial, princípios de contagem, arranjos, combinações e permutações. Essencial para probabilidade e ENEM.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'combinatória', 'enem', 'vestibular', 'contagem'],
    true, true, 4.8
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é o fatorial de um número n (n!)?', 'n! = n × (n-1) × (n-2) × ... × 2 × 1. Exemplo: 5! = 5×4×3×2×1 = 120. Por definição, 0! = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'Qual o valor de 6!?', '6! = 6×5×4×3×2×1 = 720. Dica: 6! = 6 × 5! = 6 × 120 = 720.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Por que 0! = 1?', 'Por convenção, para que fórmulas funcionem. Ex: C(n,0) = n!/(0!×n!) = 1 (há 1 modo de escolher 0 elementos). Também: n! = n × (n-1)! → 1! = 1 × 0! → 0! = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Simplifique 10!/8!', '10!/8! = (10×9×8!)/8! = 10×9 = 90. Fatoriais se simplificam cancelando termos comuns.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que é o Princípio Fundamental da Contagem (PFC)?', 'Se um evento pode ocorrer de m maneiras e outro de n maneiras, então ambos podem ocorrer de m × n maneiras. Multiplica-se as possibilidades de cada etapa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Quantas placas de 3 letras e 4 números são possíveis?', '26³ × 10⁴ = 17.576 × 10.000 = 175.760.000 placas. (26 letras, 10 dígitos, com repetição)', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'O que é Permutação Simples?', 'Pₙ = n! É o número de maneiras de ordenar n elementos distintos. Exemplo: anagramas de "AMOR" = 4! = 24.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'Quantos anagramas tem a palavra "PROVA"?', 'PROVA tem 5 letras distintas. P₅ = 5! = 120 anagramas.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'O que é Permutação com Repetição?', 'Pₙ^(a,b,c,...) = n!/(a!×b!×c!×...), onde a, b, c são as quantidades de elementos repetidos. Para "BANANA": 6!/(3!×2!) = 60.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'Quantos anagramas tem "MATEMATICA"?', '10 letras: M(2), A(3), T(2), E(1), I(1), C(1). P = 10!/(2!×3!×2!) = 3.628.800/24 = 151.200.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'O que é Arranjo Simples?', 'A(n,p) = n!/(n-p)! É o número de sequências ordenadas de p elementos escolhidos de n elementos. A ordem IMPORTA.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'De quantas formas podemos formar uma comissão de presidente, vice e secretário com 10 candidatos?', 'Arranjo: A(10,3) = 10!/(10-3)! = 10×9×8 = 720. Ordem importa pois os cargos são diferentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'O que é Combinação Simples?', 'C(n,p) = n!/(p!×(n-p)!) É o número de subconjuntos de p elementos escolhidos de n. A ordem NÃO importa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'De quantas formas podemos escolher 3 pessoas de um grupo de 10?', 'Combinação: C(10,3) = 10!/(3!×7!) = (10×9×8)/(3×2×1) = 120. Ordem não importa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual a diferença entre Arranjo e Combinação?', 'Arranjo: ordem importa (1º, 2º, 3º são diferentes). Combinação: ordem não importa (ABC = ACB = BAC). A = C × P, ou seja, A(n,p) = C(n,p) × p!', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Calcule C(8,2).', 'C(8,2) = 8!/(2!×6!) = (8×7)/(2×1) = 56/2 = 28.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Por que C(n,p) = C(n,n-p)?', 'Escolher p elementos para incluir é equivalente a escolher n-p elementos para excluir. Ex: C(10,3) = C(10,7) = 120.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'O que é o Triângulo de Pascal?', 'Tabela onde cada número é a soma dos dois acima. A linha n contém os C(n,k) para k = 0,1,...,n. Linha 4: 1 4 6 4 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'Qual a relação de Stifel no Triângulo de Pascal?', 'C(n,k) + C(n,k+1) = C(n+1,k+1). Cada número é soma dos dois de cima. Exemplo: C(4,1)+C(4,2) = 4+6 = 10 = C(5,2).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'O que é Permutação Circular?', 'PCₙ = (n-1)! Número de formas de dispor n elementos em círculo. Um elemento é fixado como referência. PC₅ = 4! = 24.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'De quantas maneiras 6 pessoas podem sentar em uma mesa redonda?', 'Permutação circular: PC₆ = 5! = 120. Fixa-se uma pessoa e permutam-se as outras 5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Numa comissão de 5 homens e 4 mulheres, quantas subcomissões de 3 homens e 2 mulheres são possíveis?', 'C(5,3) × C(4,2) = 10 × 6 = 60 subcomissões. Multiplica-se pois as escolhas são independentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Quantos números de 4 algarismos distintos existem?', 'Primeiro algarismo: 9 opções (1-9). Depois: 9, 8, 7. Total: 9 × 9 × 8 × 7 = 4.536 números.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'O que é Combinação com Repetição?', 'CR(n,p) = C(n+p-1,p). Escolher p elementos de n tipos, podendo repetir. Ex: 3 frutas de 4 tipos = C(6,3) = 20.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'De quantos modos 4 bolas idênticas podem ser distribuídas em 3 urnas?', 'Combinação com repetição: CR(3,4) = C(3+4-1,4) = C(6,4) = 15 modos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'Quantas diagonais tem um polígono de n lados?', 'D = n(n-3)/2. Ou: C(n,2) - n = n(n-1)/2 - n = n(n-3)/2. Hexágono: 6×3/2 = 9 diagonais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'Quantos triângulos podem ser formados com 8 pontos (sem 3 colineares)?', 'C(8,3) = 8!/(3!×5!) = (8×7×6)/(3×2×1) = 336/6 = 56 triângulos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'Em uma prova com 10 questões V ou F, quantas combinações de respostas são possíveis?', '2¹⁰ = 1.024 combinações. Cada questão tem 2 opções, são eventos independentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'Quantos anagramas de "ESCOLA" começam com vogal?', 'Vogais: E, O, A (3 opções para 1ª letra). Restam 5 letras para 5 posições: 5! = 120. Total: 3 × 120 = 360.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Quantos números pares de 3 algarismos distintos existem?', 'Último: 0,2,4,6,8. Se último=0: 9×8=72. Se último≠0 (4 opções): 8×8=64 cada → 4×64=256. Total: 72+256=328.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - PROBABILIDADE
  -- ============================================================================
  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Probabilidade: Eventos, Espaço Amostral e Probabilidade Condicional',
    'Conceitos fundamentais de probabilidade: experimentos, eventos, cálculos básicos e probabilidade condicional.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'probabilidade', 'enem', 'vestibular', 'estatística'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é Espaço Amostral (Ω ou S)?', 'É o conjunto de todos os resultados possíveis de um experimento aleatório. Ex: lançar dado → Ω = {1,2,3,4,5,6}.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que é um Evento?', 'É qualquer subconjunto do espaço amostral. Evento A = "sair par" no dado → A = {2,4,6}. Evento certo: Ω. Evento impossível: ∅.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Qual a fórmula clássica da probabilidade?', 'P(A) = n(A)/n(Ω) = casos favoráveis / casos possíveis. Válida quando todos os resultados são equiprováveis.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'Qual a probabilidade de sair 5 em um dado honesto?', 'P(5) = 1/6 ≈ 0,167 = 16,7%. Um resultado favorável em 6 possíveis.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'Qual a probabilidade de sair número par em um dado?', 'Evento A = {2,4,6}, n(A) = 3. P(A) = 3/6 = 1/2 = 50%.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'Quais são os limites da probabilidade?', '0 ≤ P(A) ≤ 1 para qualquer evento A. P(impossível) = 0. P(certo) = 1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'O que é o evento complementar?', 'Ā (ou A^c) é o evento "não A". P(Ā) = 1 - P(A). Ex: P(não tirar 6) = 1 - 1/6 = 5/6.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'Qual a probabilidade de NÃO sair cara em uma moeda?', 'P(não cara) = 1 - P(cara) = 1 - 1/2 = 1/2 = P(coroa). Complementar.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'O que é a união de eventos (A ∪ B)?', 'Evento "A ou B" (pelo menos um). P(A∪B) = P(A) + P(B) - P(A∩B). Subtrai a interseção para não contar duas vezes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'O que são eventos mutuamente exclusivos?', 'Eventos que não podem ocorrer simultaneamente: A ∩ B = ∅. Neste caso, P(A∪B) = P(A) + P(B).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Qual a probabilidade de tirar ás ou rei de um baralho de 52 cartas?', 'Eventos mutuamente exclusivos: P(ás ∪ rei) = 4/52 + 4/52 = 8/52 = 2/13.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Qual a prob. de tirar carta de copas ou figura de um baralho?', 'P(copas) = 13/52, P(figura) = 12/52, P(copas∩figura) = 3/52. P(C∪F) = 13/52 + 12/52 - 3/52 = 22/52 = 11/26.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'O que são eventos independentes?', 'Eventos onde a ocorrência de um não afeta a probabilidade do outro. P(A∩B) = P(A) × P(B).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Qual a prob. de sair cara em 2 lançamentos de moeda?', 'Eventos independentes: P(cara e cara) = 1/2 × 1/2 = 1/4 = 25%.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual a prob. de sair 6 em dois dados lançados juntos?', 'P(6 e 6) = 1/6 × 1/6 = 1/36 ≈ 2,8%. Eventos independentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'O que é Probabilidade Condicional?', 'P(A|B) = P(A∩B)/P(B). Probabilidade de A sabendo que B ocorreu. Reduz o espaço amostral para B.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'Dado que saiu número par, qual a prob. de ser maior que 3?', 'B = {2,4,6}, A = {4,5,6}. A∩B = {4,6}. P(A|B) = 2/3. Espaço amostral reduzido a {2,4,6}.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Uma urna tem 3 bolas brancas e 2 pretas. Retirando 2 sem reposição, qual a prob. de ambas brancas?', 'P(1ª branca) = 3/5. P(2ª branca|1ª branca) = 2/4. P = 3/5 × 2/4 = 6/20 = 3/10 = 30%.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'O que muda quando há reposição?', 'Com reposição, eventos são independentes (prob. não muda). Sem reposição, são dependentes (prob. muda após cada retirada).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual a prob. de acertar 4 questões V/F no chute?', 'Cada questão: P = 1/2. P(4 certas) = (1/2)⁴ = 1/16 = 6,25%. Eventos independentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'O que é Distribuição Binomial?', 'P(X=k) = C(n,k) × p^k × (1-p)^(n-k). Prob. de k sucessos em n tentativas independentes com prob. p de sucesso.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Lançando uma moeda 5 vezes, qual a prob. de exatamente 3 caras?', 'P(X=3) = C(5,3) × (1/2)³ × (1/2)² = 10 × 1/8 × 1/4 = 10/32 = 5/16 ≈ 31,25%.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'O que é Esperança (Valor Esperado)?', 'E(X) = Σ xᵢ × P(xᵢ). Média ponderada dos valores pela probabilidade. No dado: E = (1+2+3+4+5+6)/6 = 3,5.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'O Teorema de Bayes serve para quê?', 'Atualizar probabilidades com nova informação: P(A|B) = P(B|A)×P(A)/P(B). Inversão de condicionais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Em um teste médico com 95% de acerto, se 1% da população tem a doença, qual a prob. de ter a doença dado teste positivo?', 'Bayes: P(D|+) = P(+|D)P(D)/P(+) = 0,95×0,01/(0,95×0,01 + 0,05×0,99) ≈ 16%. Surpreendentemente baixo!', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'O que é o Paradoxo do Aniversário?', 'Com apenas 23 pessoas, há >50% de chance de duas fazerem aniversário no mesmo dia. Com 50 pessoas, >97%. Contraintuitivo!', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'Qual a prob. de tirar pelo menos uma bola vermelha em 3 retiradas (5 vermelhas, 3 azuis, com reposição)?', 'P(pelo menos 1) = 1 - P(nenhuma) = 1 - (3/8)³ = 1 - 27/512 = 485/512 ≈ 94,7%.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'O que é a Lei dos Grandes Números?', 'Quanto mais vezes repetimos um experimento, mais a frequência relativa se aproxima da probabilidade teórica.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'A Falácia do Jogador é...?', 'Achar que resultados passados afetam futuros em eventos independentes. Se saiu cara 10 vezes, a próxima ainda é 50% cara!', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Em um jogo, você paga R$2 e ganha R$5 se sair 6. Vale a pena?', 'E(ganho) = 5×(1/6) - 2 = 5/6 - 2 = -7/6 ≈ -R$1,17. Esperança negativa = não vale a pena em média.', 'Fundamentos de Matemática Elementar - Iezzi');

  -- ============================================================================
  -- MATEMÁTICA - GEOMETRIA PLANA
  -- ============================================================================
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/matematica/geometria';

  INSERT INTO decks (title, description, price, author_id, category_id, tags, is_public, is_verified, rating)
  VALUES (
    'Geometria Plana: Ângulos, Triângulos, Polígonos e Círculos',
    'Estudo completo da geometria plana: ângulos, triângulos, semelhança, Pitágoras, polígonos, áreas e circunferência.',
    0, v_author_id, v_cat_id,
    ARRAY['matemática', 'geometria', 'enem', 'vestibular', 'triângulos'],
    true, true, 4.9
  ) RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Qual a soma dos ângulos internos de um triângulo?', '180°. Isso vale para qualquer triângulo (equilátero, isósceles, escaleno, retângulo, etc.).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 2, 'basic', 'O que é um ângulo reto?', 'Ângulo de 90° (1/4 de volta). Representado por um pequeno quadrado no vértice. Presente em triângulos retângulos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 3, 'basic', 'Classifique os ângulos: agudo, reto, obtuso.', 'Agudo: 0° < α < 90°. Reto: α = 90°. Obtuso: 90° < α < 180°. Raso: α = 180°.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 4, 'basic', 'O que são ângulos complementares?', 'Dois ângulos cuja soma é 90°. Exemplo: 30° e 60° são complementares.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 5, 'basic', 'O que são ângulos suplementares?', 'Dois ângulos cuja soma é 180°. Exemplo: 120° e 60° são suplementares.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 6, 'basic', 'O que são ângulos opostos pelo vértice?', 'Ângulos formados por duas retas que se cruzam, situados em lados opostos do vértice. São sempre iguais (congruentes).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 7, 'basic', 'Qual a soma dos ângulos internos de um polígono de n lados?', 'S = (n-2) × 180°. Triângulo (n=3): 180°. Quadrilátero (n=4): 360°. Pentágono: 540°.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 8, 'basic', 'Qual o ângulo interno de um hexágono regular?', 'S = (6-2)×180° = 720°. Cada ângulo = 720°/6 = 120°.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 9, 'basic', 'O que é um triângulo equilátero?', 'Triângulo com os 3 lados iguais (e 3 ângulos iguais de 60°). Tem 3 eixos de simetria.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 10, 'basic', 'O que é um triângulo isósceles?', 'Triângulo com 2 lados iguais. Os ângulos da base (opostos aos lados iguais) também são iguais.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 11, 'basic', 'Enuncie o Teorema de Pitágoras.', 'Em um triângulo retângulo: a² = b² + c², onde "a" é a hipotenusa (maior lado, oposto ao ângulo reto) e b, c são os catetos.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 12, 'basic', 'Se os catetos medem 3 e 4, qual a hipotenusa?', 'a² = 3² + 4² = 9 + 16 = 25 → a = 5. Essa é a terna pitagórica mais conhecida: (3, 4, 5).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 13, 'basic', 'Quais são outras ternas pitagóricas famosas?', '(5, 12, 13), (8, 15, 17), (7, 24, 25). Múltiplos também funcionam: (6, 8, 10) = 2×(3,4,5).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 14, 'basic', 'Qual a altura de um triângulo equilátero de lado L?', 'h = L√3/2. Deriva de Pitágoras aplicado à metade do triângulo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 15, 'basic', 'Qual a área de um triângulo?', 'A = (base × altura)/2 = bh/2. Também: A = (1/2)ab×sen(C), onde C é o ângulo entre os lados a e b.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 16, 'basic', 'Qual a área de um triângulo equilátero de lado L?', 'A = L²√3/4. Exemplo: L = 4 → A = 16√3/4 = 4√3.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 17, 'basic', 'O que são triângulos semelhantes?', 'Triângulos com ângulos correspondentes iguais e lados proporcionais. Razão k entre lados correspondentes.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 18, 'basic', 'Se dois triângulos são semelhantes com razão k, qual a razão das áreas?', 'Razão das áreas = k². Se lados estão na razão 3:1, áreas estão na razão 9:1.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 19, 'basic', 'O que é o Teorema de Tales?', 'Feixes de retas paralelas cortadas por transversais determinam segmentos proporcionais. a/a'' = b/b'' = c/c''.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 20, 'basic', 'Qual a área de um retângulo?', 'A = base × altura = b × h. O retângulo é o caso base para cálculo de outras áreas.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 21, 'basic', 'Qual a área de um paralelogramo?', 'A = base × altura = b × h, onde h é a altura perpendicular à base (não o lado inclinado).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 22, 'basic', 'Qual a área de um trapézio?', 'A = (B + b) × h / 2, onde B é a base maior, b a base menor, e h a altura.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 23, 'basic', 'Qual a área de um losango?', 'A = (D × d) / 2, onde D e d são as diagonais. As diagonais do losango são perpendiculares.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 24, 'basic', 'Qual a área de um polígono regular?', 'A = (perímetro × apótema) / 2 = (p × a) / 2. Apótema: distância do centro ao lado.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 25, 'basic', 'Qual o comprimento da circunferência?', 'C = 2πr = πd, onde r é o raio e d o diâmetro. π ≈ 3,14159...', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 26, 'basic', 'Qual a área do círculo?', 'A = πr². Exemplo: r = 3 → A = 9π ≈ 28,27 unidades².', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 27, 'basic', 'Qual a área de um setor circular de ângulo θ (em radianos)?', 'A = (θ/2) × r² = (θ/2π) × πr². Fração da área total proporcional ao ângulo.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 28, 'basic', 'O que é ângulo inscrito e ângulo central?', 'Central: vértice no centro do círculo. Inscrito: vértice na circunferência. Inscrito = Central/2 (mesmo arco).', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 29, 'basic', 'O que é a relação métrica no triângulo retângulo para a altura?', 'h² = m × n, onde h é a altura relativa à hipotenusa, m e n são as projeções dos catetos na hipotenusa.', 'Fundamentos de Matemática Elementar - Iezzi'),
  (v_deck_id, 30, 'basic', 'Qual a área de uma coroa circular (anel)?', 'A = π(R² - r²), onde R é o raio maior e r o raio menor. Diferença das áreas dos círculos.', 'Fundamentos de Matemática Elementar - Iezzi');

  RAISE NOTICE 'Decks de Matemática (parte 2) inseridos com sucesso!';
END $$;
