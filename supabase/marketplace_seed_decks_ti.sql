-- Marketplace Seed: Decks de Tecnologia da Informação

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  -- ALGORITMOS E ESTRUTURAS DE DADOS
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/tecnologia-da-informacao/fundamentos';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Algoritmos e Estruturas de Dados', 'Lógica, estruturas lineares e não-lineares, ordenação e busca. Fundamentos de programação.', 0, v_user_id, v_cat_id, ARRAY['programação', 'algoritmos', 'estruturas de dados', 'ti'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é complexidade de tempo (Big O)?', 'Medida de como o tempo de execução cresce com o tamanho da entrada. O(1) < O(log n) < O(n) < O(n log n) < O(n²) < O(2ⁿ).', 'CLRS Algorithms'),
  (v_deck_id, 2, 'basic', 'O que é O(1) - tempo constante?', 'Tempo não depende do tamanho da entrada. Ex: acesso a índice de array, operações hash perfeitas.', 'CLRS Algorithms'),
  (v_deck_id, 3, 'basic', 'O que é O(n) - tempo linear?', 'Tempo proporcional à entrada. Dobra entrada, dobra tempo. Ex: percorrer array, busca linear.', 'CLRS Algorithms'),
  (v_deck_id, 4, 'basic', 'O que é O(log n) - tempo logarítmico?', 'Divide problema pela metade a cada passo. Ex: busca binária, operações em árvores balanceadas.', 'CLRS Algorithms'),
  (v_deck_id, 5, 'basic', 'O que é O(n²) - tempo quadrático?', 'Loops aninhados. Dobra entrada, quadruplica tempo. Ex: bubble sort, selection sort, comparar todos pares.', 'CLRS Algorithms'),
  (v_deck_id, 6, 'basic', 'O que é um Array (vetor)?', 'Coleção de elementos em posições contíguas. Acesso O(1) por índice. Inserção/remoção O(n) no meio. Tamanho fixo ou dinâmico.', 'CLRS Algorithms'),
  (v_deck_id, 7, 'basic', 'O que é uma Lista Encadeada?', 'Nós com valor + ponteiro para próximo. Inserção/remoção O(1) com referência. Acesso O(n). Simples ou duplamente encadeada.', 'CLRS Algorithms'),
  (v_deck_id, 8, 'basic', 'O que é uma Pilha (Stack)?', 'LIFO: Last In, First Out. Operações: push (adiciona topo), pop (remove topo), peek (vê topo). Ex: chamadas de função, undo.', 'CLRS Algorithms'),
  (v_deck_id, 9, 'basic', 'O que é uma Fila (Queue)?', 'FIFO: First In, First Out. Operações: enqueue (adiciona final), dequeue (remove início). Ex: impressão, BFS.', 'CLRS Algorithms'),
  (v_deck_id, 10, 'basic', 'O que é uma Árvore Binária?', 'Cada nó tem até 2 filhos (esquerdo, direito). Raiz, folhas, altura. Cheia, completa, degenerada.', 'CLRS Algorithms'),
  (v_deck_id, 11, 'basic', 'O que é uma Árvore Binária de Busca (BST)?', 'Esquerda < raiz < direita. Busca, inserção, remoção: O(log n) médio, O(n) pior caso (degenerada).', 'CLRS Algorithms'),
  (v_deck_id, 12, 'basic', 'O que são travessias em árvore?', 'Pré-ordem: raiz-esq-dir. Em-ordem: esq-raiz-dir (BST: ordenado). Pós-ordem: esq-dir-raiz. Por nível (BFS).', 'CLRS Algorithms'),
  (v_deck_id, 13, 'basic', 'O que é uma Árvore AVL?', 'BST auto-balanceada. Diferença de altura entre subárvores ≤ 1. Rotações para balancear. Todas operações O(log n).', 'CLRS Algorithms'),
  (v_deck_id, 14, 'basic', 'O que é uma Hash Table?', 'Mapeia chaves para valores via função hash. Acesso O(1) médio. Colisões: chaining ou probing. Load factor.', 'CLRS Algorithms'),
  (v_deck_id, 15, 'basic', 'O que é um Grafo?', 'Vértices (nós) + arestas (conexões). Dirigido/não-dirigido. Ponderado/não-ponderado. Matriz de adjacência ou lista.', 'CLRS Algorithms'),
  (v_deck_id, 16, 'basic', 'O que é BFS (Busca em Largura)?', 'Explora vizinhos antes de ir mais fundo. Usa fila. Encontra menor caminho em grafos não-ponderados. O(V+E).', 'CLRS Algorithms'),
  (v_deck_id, 17, 'basic', 'O que é DFS (Busca em Profundidade)?', 'Explora o mais fundo possível antes de voltar. Usa pilha (ou recursão). Detecta ciclos, ordenação topológica. O(V+E).', 'CLRS Algorithms'),
  (v_deck_id, 18, 'basic', 'O que é Bubble Sort?', 'Compara pares adjacentes, troca se fora de ordem. Repete até ordenado. O(n²). Estável. Simples mas ineficiente.', 'CLRS Algorithms'),
  (v_deck_id, 19, 'basic', 'O que é Quick Sort?', 'Divide e conquista: pivô, particiona em menores e maiores, ordena recursivamente. O(n log n) médio, O(n²) pior.', 'CLRS Algorithms'),
  (v_deck_id, 20, 'basic', 'O que é Merge Sort?', 'Divide e conquista: divide ao meio, ordena recursivamente, intercala. O(n log n) sempre. Estável. Usa O(n) espaço.', 'CLRS Algorithms'),
  (v_deck_id, 21, 'basic', 'O que é Busca Binária?', 'Em array ordenado: compara com meio, descarta metade. O(log n). Requer acesso aleatório.', 'CLRS Algorithms'),
  (v_deck_id, 22, 'basic', 'O que é Recursão?', 'Função que chama a si mesma. Caso base (para) + caso recursivo (reduz problema). Usa pilha de chamadas.', 'CLRS Algorithms'),
  (v_deck_id, 23, 'basic', 'O que é Programação Dinâmica?', 'Resolve subproblemas e armazena resultados (memoização). Evita recálculo. Bottom-up ou top-down. Ex: Fibonacci, mochila.', 'CLRS Algorithms'),
  (v_deck_id, 24, 'basic', 'O que é um Heap?', 'Árvore binária quase completa. Max-heap: pai ≥ filhos. Min-heap: pai ≤ filhos. Inserção/remoção O(log n). Heapsort.', 'CLRS Algorithms'),
  (v_deck_id, 25, 'basic', 'O que é o algoritmo de Dijkstra?', 'Menor caminho de origem para todos. Grafos ponderados não-negativos. Greedy + heap. O((V+E) log V).', 'CLRS Algorithms'),
  (v_deck_id, 26, 'basic', 'O que é algoritmo Greedy (guloso)?', 'Escolhe o melhor local esperando ótimo global. Nem sempre funciona. Ex: troco de moedas, Huffman, Dijkstra.', 'CLRS Algorithms'),
  (v_deck_id, 27, 'basic', 'O que é backtracking?', 'Tenta soluções, volta atrás se inválida. Explora espaço de busca. Ex: N-rainhas, sudoku, permutações.', 'CLRS Algorithms'),
  (v_deck_id, 28, 'basic', 'O que é Two Pointers?', 'Dois ponteiros percorrem array (mesma direção ou opostas). Evita loops aninhados. Ex: soma de pares, palíndromo.', 'CLRS Algorithms'),
  (v_deck_id, 29, 'basic', 'O que é Sliding Window?', 'Janela de tamanho fixo/variável desliza pelo array. Evita recálculo. Ex: soma máxima de subarray, substring sem repetição.', 'CLRS Algorithms'),
  (v_deck_id, 30, 'basic', 'Qual a diferença entre estável e instável em ordenação?', 'Estável: mantém ordem relativa de elementos iguais. Merge sort, insertion sort estáveis. Quick sort, heap sort instáveis.', 'CLRS Algorithms');

  -- BANCO DE DADOS
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/tecnologia-da-informacao/banco-de-dados';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Banco de Dados: Modelagem e SQL', 'Modelagem ER, modelo relacional, SQL e normalização. Fundamentos de bancos de dados.', 0, v_user_id, v_cat_id, ARRAY['banco de dados', 'sql', 'modelagem', 'ti'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que é o modelo Entidade-Relacionamento?', 'Modelo conceitual: Entidades (retângulos), Atributos (elipses), Relacionamentos (losangos). Base para projeto de BD.', 'Elmasri & Navathe'),
  (v_deck_id, 2, 'basic', 'O que é cardinalidade em relacionamentos?', '1:1 (um para um), 1:N (um para muitos), N:M (muitos para muitos). Define quantas instâncias podem se relacionar.', 'Elmasri & Navathe'),
  (v_deck_id, 3, 'basic', 'O que é chave primária (PK)?', 'Atributo(s) que identifica(m) unicamente cada registro. Não nula, única. Pode ser natural ou surrogate (auto-incremento).', 'Elmasri & Navathe'),
  (v_deck_id, 4, 'basic', 'O que é chave estrangeira (FK)?', 'Atributo que referencia PK de outra tabela. Cria relacionamento. Integridade referencial. ON DELETE CASCADE/SET NULL.', 'Elmasri & Navathe'),
  (v_deck_id, 5, 'basic', 'O que são os comandos DDL?', 'Data Definition Language: CREATE, ALTER, DROP, TRUNCATE. Definem estrutura do banco.', 'Elmasri & Navathe'),
  (v_deck_id, 6, 'basic', 'O que são os comandos DML?', 'Data Manipulation Language: INSERT, UPDATE, DELETE, SELECT. Manipulam dados.', 'Elmasri & Navathe'),
  (v_deck_id, 7, 'basic', 'Qual a sintaxe do SELECT básico?', 'SELECT colunas FROM tabela WHERE condição ORDER BY coluna GROUP BY coluna HAVING condição LIMIT n.', 'Elmasri & Navathe'),
  (v_deck_id, 8, 'basic', 'Quais os tipos de JOIN?', 'INNER (só correspondências), LEFT (todos da esq + match), RIGHT (todos da dir + match), FULL (todos), CROSS (produto cartesiano).', 'Elmasri & Navathe'),
  (v_deck_id, 9, 'basic', 'O que são funções de agregação?', 'COUNT (conta), SUM (soma), AVG (média), MAX (máximo), MIN (mínimo). Usadas com GROUP BY.', 'Elmasri & Navathe'),
  (v_deck_id, 10, 'basic', 'Qual a diferença entre WHERE e HAVING?', 'WHERE: filtra antes do GROUP BY, não usa agregação. HAVING: filtra após GROUP BY, pode usar agregação.', 'Elmasri & Navathe'),
  (v_deck_id, 11, 'basic', 'O que é uma subquery?', 'SELECT dentro de outro SELECT. No WHERE (EXISTS, IN, comparações), no FROM (tabela derivada), no SELECT (escalar).', 'Elmasri & Navathe'),
  (v_deck_id, 12, 'basic', 'O que é normalização?', 'Processo de organizar dados para reduzir redundância e dependências. Formas normais: 1FN, 2FN, 3FN, BCNF.', 'Elmasri & Navathe'),
  (v_deck_id, 13, 'basic', 'O que é a Primeira Forma Normal (1FN)?', 'Valores atômicos (não multivalorados). Cada célula tem um único valor. Elimina grupos repetitivos.', 'Elmasri & Navathe'),
  (v_deck_id, 14, 'basic', 'O que é a Segunda Forma Normal (2FN)?', '1FN + sem dependências parciais. Atributos não-chave dependem de toda a PK (relevante para PKs compostas).', 'Elmasri & Navathe'),
  (v_deck_id, 15, 'basic', 'O que é a Terceira Forma Normal (3FN)?', '2FN + sem dependências transitivas. Atributos não-chave dependem apenas da PK, não de outros não-chave.', 'Elmasri & Navathe'),
  (v_deck_id, 16, 'basic', 'O que é um índice?', 'Estrutura que acelera buscas. B-tree (ordenado), Hash (igualdade). Trade-off: leitura rápida, escrita lenta, espaço.', 'Elmasri & Navathe'),
  (v_deck_id, 17, 'basic', 'O que são propriedades ACID?', 'Atomicidade (tudo ou nada), Consistência (estado válido), Isolamento (transações independentes), Durabilidade (commit permanente).', 'Elmasri & Navathe'),
  (v_deck_id, 18, 'basic', 'O que é uma transação?', 'Unidade lógica de trabalho. BEGIN → operações → COMMIT (confirma) ou ROLLBACK (desfaz). Garante ACID.', 'Elmasri & Navathe'),
  (v_deck_id, 19, 'basic', 'O que é deadlock?', 'Duas transações esperando recursos uma da outra. BD detecta e aborta uma. Prevenção: ordenar locks, timeout.', 'Elmasri & Navathe'),
  (v_deck_id, 20, 'basic', 'O que é uma View?', 'Tabela virtual baseada em SELECT. Simplifica queries complexas, segurança (esconde colunas), abstração.', 'Elmasri & Navathe'),
  (v_deck_id, 21, 'basic', 'O que é uma Stored Procedure?', 'Código SQL armazenado no BD. Parâmetros de entrada/saída. Reutilização, segurança, performance.', 'Elmasri & Navathe'),
  (v_deck_id, 22, 'basic', 'O que é um Trigger?', 'Código executado automaticamente em resposta a INSERT, UPDATE ou DELETE. BEFORE ou AFTER. Auditoria, validação.', 'Elmasri & Navathe'),
  (v_deck_id, 23, 'basic', 'O que é SQL Injection?', 'Ataque: inserir SQL malicioso via input. Prevenção: prepared statements, parametrização, validação.', 'Elmasri & Navathe'),
  (v_deck_id, 24, 'basic', 'O que são bancos NoSQL?', 'Not Only SQL: documentos (MongoDB), chave-valor (Redis), colunas (Cassandra), grafos (Neo4j). Flexíveis, escaláveis.', 'Elmasri & Navathe'),
  (v_deck_id, 25, 'basic', 'O que é sharding?', 'Distribuir dados horizontalmente em múltiplos servidores. Escala leitura/escrita. Chave de partição.', 'Elmasri & Navathe'),
  (v_deck_id, 26, 'basic', 'O que é replicação?', 'Cópias dos dados em múltiplos servidores. Alta disponibilidade, leitura distribuída. Master-slave, multi-master.', 'Elmasri & Navathe'),
  (v_deck_id, 27, 'basic', 'O que é um ORM?', 'Object-Relational Mapping: mapeia objetos de código para tabelas. Ex: Hibernate, Entity Framework, Prisma. Abstrai SQL.', 'Elmasri & Navathe'),
  (v_deck_id, 28, 'basic', 'O que é EXPLAIN em SQL?', 'Mostra plano de execução da query. Identifica table scans, uso de índices, custos. Otimização de performance.', 'Elmasri & Navathe'),
  (v_deck_id, 29, 'basic', 'O que é CASCADE em FK?', 'ON DELETE CASCADE: deleta filhos quando pai é deletado. ON UPDATE CASCADE: atualiza FK quando PK muda. Alternativas: SET NULL, RESTRICT.', 'Elmasri & Navathe'),
  (v_deck_id, 30, 'basic', 'O que é data warehouse vs OLTP?', 'OLTP: transacional, normalizado, escritas frequentes. DW: analítico, desnormalizado, leituras complexas, histórico.', 'Elmasri & Navathe');

  -- REDES DE COMPUTADORES
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-superior/tecnologia-da-informacao/redes';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Redes de Computadores: Modelos e Protocolos', 'Modelo OSI, TCP/IP, protocolos de aplicação, transporte e rede.', 0, v_user_id, v_cat_id, ARRAY['redes', 'tcp/ip', 'protocolos', 'ti'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'Quais as camadas do modelo OSI?', '7-Aplicação, 6-Apresentação, 5-Sessão, 4-Transporte, 3-Rede, 2-Enlace, 1-Física. "Please Do Not Throw Sausage Pizza Away."', 'Kurose & Ross'),
  (v_deck_id, 2, 'basic', 'Quais as camadas do modelo TCP/IP?', '4-Aplicação, 3-Transporte, 2-Internet (Rede), 1-Acesso à Rede (Enlace+Física). Modelo prático usado na Internet.', 'Kurose & Ross'),
  (v_deck_id, 3, 'basic', 'O que é IP (Internet Protocol)?', 'Protocolo de rede: endereçamento e roteamento. IPv4: 32 bits (4 octetos). IPv6: 128 bits. Best-effort, sem conexão.', 'Kurose & Ross'),
  (v_deck_id, 4, 'basic', 'O que é TCP?', 'Transmission Control Protocol: confiável, orientado a conexão, controle de fluxo/congestionamento. 3-way handshake. Portas.', 'Kurose & Ross'),
  (v_deck_id, 5, 'basic', 'O que é UDP?', 'User Datagram Protocol: não-confiável, sem conexão, rápido. Sem garantias de entrega. DNS, streaming, games.', 'Kurose & Ross'),
  (v_deck_id, 6, 'basic', 'O que é o 3-way handshake do TCP?', 'Estabelece conexão: SYN → SYN-ACK → ACK. Sincroniza números de sequência. Encerramento: FIN → ACK → FIN → ACK.', 'Kurose & Ross'),
  (v_deck_id, 7, 'basic', 'O que é DNS?', 'Domain Name System: traduz nomes (google.com) para IPs. Hierárquico: root → TLD → autoritativo. Cache.', 'Kurose & Ross'),
  (v_deck_id, 8, 'basic', 'O que é HTTP/HTTPS?', 'HyperText Transfer Protocol. Requisição-resposta. Métodos: GET, POST, PUT, DELETE. HTTPS: criptografado com TLS.', 'Kurose & Ross'),
  (v_deck_id, 9, 'basic', 'O que são códigos de status HTTP?', '1xx: informacional. 2xx: sucesso (200 OK). 3xx: redirecionamento (301, 302). 4xx: erro cliente (404). 5xx: erro servidor (500).', 'Kurose & Ross'),
  (v_deck_id, 10, 'basic', 'O que é NAT?', 'Network Address Translation: traduz IPs privados para públicos. Conserva endereços IPv4. Router faz mapeamento de portas.', 'Kurose & Ross'),
  (v_deck_id, 11, 'basic', 'O que é DHCP?', 'Dynamic Host Configuration Protocol: atribui IPs automaticamente. Discover → Offer → Request → Acknowledge.', 'Kurose & Ross'),
  (v_deck_id, 12, 'basic', 'O que é ARP?', 'Address Resolution Protocol: mapeia IP para MAC address. Broadcast na rede local. Tabela ARP cache.', 'Kurose & Ross'),
  (v_deck_id, 13, 'basic', 'O que é MAC address?', 'Media Access Control: identificador único de 48 bits da placa de rede. Camada de enlace. Formato: XX:XX:XX:XX:XX:XX.', 'Kurose & Ross'),
  (v_deck_id, 14, 'basic', 'O que é um switch vs router?', 'Switch: camada 2, usa MAC, rede local. Router: camada 3, usa IP, conecta redes diferentes. Firewall: filtra tráfego.', 'Kurose & Ross'),
  (v_deck_id, 15, 'basic', 'O que é subnet (sub-rede)?', 'Divisão de rede IP em partes menores. CIDR: /24 = 256 IPs, /16 = 65536. Máscara define parte rede/host.', 'Kurose & Ross'),
  (v_deck_id, 16, 'basic', 'O que é roteamento?', 'Encaminhar pacotes entre redes. Tabelas de roteamento. Protocolos: RIP (distância), OSPF (estado de enlace), BGP (entre ASs).', 'Kurose & Ross'),
  (v_deck_id, 17, 'basic', 'O que é TLS/SSL?', 'Transport Layer Security: criptografia de comunicação. Handshake, certificados, chaves simétricas e assimétricas. HTTPS.', 'Kurose & Ross'),
  (v_deck_id, 18, 'basic', 'O que é um firewall?', 'Filtra tráfego por regras. Stateless: por pacote. Stateful: por conexão. WAF: aplicação web. Zonas: DMZ.', 'Kurose & Ross'),
  (v_deck_id, 19, 'basic', 'O que é VPN?', 'Virtual Private Network: túnel criptografado sobre Internet pública. Acesso remoto seguro. Protocolos: IPSec, OpenVPN, WireGuard.', 'Kurose & Ross'),
  (v_deck_id, 20, 'basic', 'O que é load balancer?', 'Distribui tráfego entre servidores. Round-robin, least connections, IP hash. Alta disponibilidade, escalabilidade.', 'Kurose & Ross'),
  (v_deck_id, 21, 'basic', 'O que é CDN?', 'Content Delivery Network: servidores distribuídos que cacheiam conteúdo perto dos usuários. Reduz latência. Cloudflare, Akamai.', 'Kurose & Ross'),
  (v_deck_id, 22, 'basic', 'O que é WebSocket?', 'Protocolo full-duplex sobre TCP. Conexão persistente, comunicação bidirecional em tempo real. Chat, games, live updates.', 'Kurose & Ross'),
  (v_deck_id, 23, 'basic', 'O que é REST API?', 'Representational State Transfer: arquitetura web stateless. Recursos, verbos HTTP, JSON/XML. CRUD: GET, POST, PUT, DELETE.', 'Kurose & Ross'),
  (v_deck_id, 24, 'basic', 'O que é GraphQL?', 'Query language para APIs: cliente especifica exatamente os dados. Evita over/under-fetching. Esquema tipado. Facebook.', 'Kurose & Ross'),
  (v_deck_id, 25, 'basic', 'O que é SMTP, POP3, IMAP?', 'SMTP: envio de emails. POP3: download, remove do servidor. IMAP: sincronização, mantém no servidor. Portas: 25, 110, 143.', 'Kurose & Ross'),
  (v_deck_id, 26, 'basic', 'O que é MTU?', 'Maximum Transmission Unit: maior tamanho de pacote. Ethernet: 1500 bytes. Fragmentação se exceder. Path MTU Discovery.', 'Kurose & Ross'),
  (v_deck_id, 27, 'basic', 'O que é latência vs bandwidth?', 'Latência: tempo de viagem (ms). Bandwidth: capacidade do canal (Mbps). Baixa latência para interativo; alta banda para bulk.', 'Kurose & Ross'),
  (v_deck_id, 28, 'basic', 'O que é QoS?', 'Quality of Service: priorização de tráfego. VoIP, vídeo precisam baixa latência. Classificação, enfileiramento, shaping.', 'Kurose & Ross'),
  (v_deck_id, 29, 'basic', 'O que é VLAN?', 'Virtual LAN: segmentação lógica de rede física. Isolamento, segurança, broadcast domains. Tags 802.1Q.', 'Kurose & Ross'),
  (v_deck_id, 30, 'basic', 'O que é ping e traceroute?', 'Ping: testa conectividade via ICMP echo. Traceroute: mostra caminho (roteadores) até destino. TTL decrementado.', 'Kurose & Ross');

  RAISE NOTICE 'Decks de TI inseridos com sucesso!';
END $$;
