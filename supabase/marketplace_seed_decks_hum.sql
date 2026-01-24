-- Marketplace Seed: Decks de Humanas (História e Geografia)

DO $$
DECLARE
  v_user_id UUID;
  v_deck_id UUID;
  v_cat_id UUID;
BEGIN
  SELECT id INTO v_user_id FROM auth.users WHERE email = 'otavio100206@gmail.com';
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não encontrado'; END IF;

  -- HISTÓRIA GERAL
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-humanas/historia';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('História Geral: Da Antiguidade à Contemporaneidade', 'Antiguidade, Idade Média, Moderna e Contemporânea. Principais eventos e transformações históricas.', 0, v_user_id, v_cat_id, ARRAY['história', 'história geral', 'enem', 'vestibular'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que caracterizou a democracia ateniense?', 'Democracia direta: cidadãos votavam nas assembleias. Excluía mulheres, escravos e estrangeiros. Péricles foi líder importante.', 'História Geral - Boris Fausto'),
  (v_deck_id, 2, 'basic', 'Quais as principais contribuições de Roma?', 'Direito romano (base do direito ocidental), latim (origem das línguas românicas), república, engenharia (aquedutos, estradas).', 'História Geral - Boris Fausto'),
  (v_deck_id, 3, 'basic', 'O que foi o feudalismo?', 'Sistema medieval: relação suserania/vassalagem, economia agrária, sociedade estamental (clero, nobreza, servos), descentralização política.', 'História Geral - Boris Fausto'),
  (v_deck_id, 4, 'basic', 'O que foram as Cruzadas?', 'Expedições militares cristãs (séc. XI-XIII) para recuperar Jerusalém. Intensificaram comércio com Oriente. 8 cruzadas principais.', 'História Geral - Boris Fausto'),
  (v_deck_id, 5, 'basic', 'O que foi o Renascimento?', 'Movimento cultural (séc. XIV-XVI) que valorizou arte greco-romana, humanismo, racionalismo. Leonardo da Vinci, Michelangelo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 6, 'basic', 'O que foi a Reforma Protestante?', 'Movimento de Lutero (1517) contra práticas católicas. 95 teses. Surgem luteranos, calvinistas, anglicanos. Contrarreforma católica.', 'História Geral - Boris Fausto'),
  (v_deck_id, 7, 'basic', 'O que caracterizou o Absolutismo?', 'Concentração de poder no rei. Luís XIV: "O Estado sou eu". Teoria do direito divino. Mercantilismo como política econômica.', 'História Geral - Boris Fausto'),
  (v_deck_id, 8, 'basic', 'O que foi o Iluminismo?', 'Movimento intelectual (séc. XVIII) que defendia razão, liberdade, igualdade. Voltaire, Rousseau, Montesquieu. Influenciou revoluções.', 'História Geral - Boris Fausto'),
  (v_deck_id, 9, 'basic', 'Quais as causas da Revolução Francesa (1789)?', 'Crise financeira, desigualdade social (3 estados), ideais iluministas, fome. Queda da Bastilha. Fim do absolutismo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 10, 'basic', 'Quais as fases da Revolução Francesa?', 'Assembleia Nacional (1789-92), Convenção/Terror (1792-94), Diretório (1795-99), Consulado/Napoleão (1799+).', 'História Geral - Boris Fausto'),
  (v_deck_id, 11, 'basic', 'O que foi a Revolução Industrial?', 'Transformação produtiva (séc. XVIII-XIX). Máquinas, fábricas, êxodo rural. Iniciou na Inglaterra. Carvão e ferro. Classe operária.', 'História Geral - Boris Fausto'),
  (v_deck_id, 12, 'basic', 'O que foi o Imperialismo/Neocolonialismo?', 'Expansão europeia na África e Ásia (séc. XIX). Partilha da África (1884). Exploração de recursos, mercados e mão de obra.', 'História Geral - Boris Fausto'),
  (v_deck_id, 13, 'basic', 'Quais as causas da Primeira Guerra Mundial?', 'Imperialismo, nacionalismo, alianças (Tríplice Entente × Tríplice Aliança), corrida armamentista. Estopim: assassinato de Francisco Ferdinando.', 'História Geral - Boris Fausto'),
  (v_deck_id, 14, 'basic', 'O que foi a Revolução Russa (1917)?', 'Queda do czarismo, ascensão dos bolcheviques (Lenin). Primeiro Estado socialista. Sovietes. Saída da WWI.', 'História Geral - Boris Fausto'),
  (v_deck_id, 15, 'basic', 'O que foi a Crise de 1929?', 'Quebra da bolsa de NY, superprodução, especulação. Grande Depressão mundial. New Deal de Roosevelt. Abriu caminho para fascismo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 16, 'basic', 'O que caracterizou o Nazifascismo?', 'Regimes totalitários: Hitler (Alemanha), Mussolini (Itália). Nacionalismo extremo, partido único, antissemitismo, expansionismo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 17, 'basic', 'Quais as causas da Segunda Guerra Mundial?', 'Tratado de Versalhes humilhante, expansionismo nazista, invasão da Polônia (1939). Eixo × Aliados.', 'História Geral - Boris Fausto'),
  (v_deck_id, 18, 'basic', 'O que foi o Holocausto?', 'Genocídio de ~6 milhões de judeus pelos nazistas. Campos de concentração. Também perseguiu ciganos, homossexuais, deficientes.', 'História Geral - Boris Fausto'),
  (v_deck_id, 19, 'basic', 'O que foi a Guerra Fria?', 'Tensão EUA × URSS (1947-1991) sem conflito direto. Corrida armamentista e espacial. Muro de Berlim. Proxy wars.', 'História Geral - Boris Fausto'),
  (v_deck_id, 20, 'basic', 'O que foi a descolonização afro-asiática?', 'Independência de colônias após WWII. Índia (1947), Argélia (1962), África portuguesa (1970s). Muitas vezes violenta.', 'História Geral - Boris Fausto'),
  (v_deck_id, 21, 'basic', 'O que foi a queda do Muro de Berlim?', '1989: abertura do muro que dividia Alemanha. Símbolo do fim da Guerra Fria. Reunificação alemã em 1990.', 'História Geral - Boris Fausto'),
  (v_deck_id, 22, 'basic', 'O que foi o fim da URSS?', '1991: dissolução da União Soviética. Formação de 15 repúblicas. Fim do socialismo real. Vitória do capitalismo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 23, 'basic', 'O que foi o 11 de setembro?', '2001: ataques terroristas nos EUA (Torres Gêmeas). Al-Qaeda. Guerra ao Terror: Afeganistão, Iraque.', 'História Geral - Boris Fausto'),
  (v_deck_id, 24, 'basic', 'O que é globalização?', 'Integração econômica, cultural e política mundial. Fluxo de capitais, informação, pessoas. Internet. Desigualdades.', 'História Geral - Boris Fausto'),
  (v_deck_id, 25, 'basic', 'O que foi a Primavera Árabe?', '2010-2012: protestos no Oriente Médio e Norte da África. Queda de ditadores (Tunísia, Egito, Líbia). Guerra na Síria.', 'História Geral - Boris Fausto'),
  (v_deck_id, 26, 'basic', 'O que foi o Tratado de Versalhes?', '1919: encerrou WWI. Culpou Alemanha, impôs reparações pesadas. Humilhação alemã contribuiu para nazismo.', 'História Geral - Boris Fausto'),
  (v_deck_id, 27, 'basic', 'O que foi a ONU?', 'Organização das Nações Unidas (1945). Substituiu Liga das Nações. Promove paz e cooperação. Conselho de Segurança com 5 permanentes.', 'História Geral - Boris Fausto'),
  (v_deck_id, 28, 'basic', 'O que foi a Declaração dos Direitos do Homem?', '1789 (Revolução Francesa): liberdade, igualdade, propriedade. 1948 (ONU): Declaração Universal dos Direitos Humanos.', 'História Geral - Boris Fausto'),
  (v_deck_id, 29, 'basic', 'O que foi a Doutrina Monroe?', '1823: "América para os americanos". EUA contra intervenção europeia nas Américas. Base do imperialismo americano.', 'História Geral - Boris Fausto'),
  (v_deck_id, 30, 'basic', 'O que foi o Plano Marshall?', '1947: ajuda americana para reconstrução da Europa pós-WWII. Visava conter comunismo. ~13 bilhões de dólares.', 'História Geral - Boris Fausto');

  -- HISTÓRIA DO BRASIL
  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('História do Brasil: Da Colônia à República', 'Período colonial, Império, República Velha, Era Vargas, Ditadura e Redemocratização.', 0, v_user_id, v_cat_id, ARRAY['história', 'brasil', 'enem', 'vestibular'], true, true, 4.9)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que foi o período pré-colonial (1500-1530)?', 'Exploração do pau-brasil. Feitorias. Pouco interesse de Portugal. Trocas com indígenas (escambo).', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 2, 'basic', 'O que foram as Capitanias Hereditárias?', '1534: divisão do Brasil em 15 faixas. Donatários tinham poderes amplos. Maioria fracassou. São Vicente e Pernambuco prosperaram.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 3, 'basic', 'O que foi o Governo-Geral?', '1549: centralização administrativa. Tomé de Sousa, 1º governador. Salvador, capital. Jesuítas catequizam.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 4, 'basic', 'O que foi o ciclo do açúcar?', 'Séc. XVI-XVII, Nordeste. Plantation: latifúndio, monocultura, exportação, escravidão. Engenhos. Sociedade patriarcal.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 5, 'basic', 'O que foi a União Ibérica?', '1580-1640: Portugal unido à Espanha. Brasil vulnerável a ataques holandeses. Invasões no Nordeste.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 6, 'basic', 'O que foi a invasão holandesa no Brasil?', '1630-1654: Holanda no Nordeste. Maurício de Nassau: tolerância religiosa, urbanização. Expulsos na Insurreição Pernambucana.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 7, 'basic', 'O que foi o ciclo do ouro?', 'Séc. XVIII, Minas Gerais. Migração interna, urbanização, interiorização. Derrama, revoltas (Inconfidência).', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 8, 'basic', 'O que foi a Inconfidência Mineira (1789)?', 'Revolta contra impostos e domínio português. Tiradentes, líder. Influência iluminista. Delatada e reprimida.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 9, 'basic', 'O que foi a vinda da família real (1808)?', 'D. João foge de Napoleão. Rio vira capital. Abertura dos portos. Tratados com Inglaterra. Impulso modernizador.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 10, 'basic', 'Como foi a Independência do Brasil (1822)?', 'D. Pedro I proclamou às margens do Ipiranga. Processo relativamente pacífico. Manteve monarquia e escravidão.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 11, 'basic', 'O que caracterizou o Primeiro Reinado?', 'D. Pedro I (1822-1831). Constituição de 1824 (poder moderador). Confederação do Equador. Abdicação em favor de Pedro II.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 12, 'basic', 'O que foi o Período Regencial (1831-1840)?', 'Regentes governam até maioridade de Pedro II. Revoltas: Cabanagem, Balaiada, Farroupilha, Sabinada. Instabilidade.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 13, 'basic', 'O que caracterizou o Segundo Reinado?', 'D. Pedro II (1840-1889). Café como base econômica. Parlamentarismo às avessas. Guerra do Paraguai. Abolição. Queda da monarquia.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 14, 'basic', 'Quais as etapas da abolição da escravidão?', 'Lei Eusébio de Queirós (1850): fim tráfico. Ventre Livre (1871). Sexagenários (1885). Lei Áurea (1888): abolição.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 15, 'basic', 'Como foi proclamada a República (1889)?', 'Golpe militar de Deodoro da Fonseca. Queda de D. Pedro II. Sem participação popular. "O povo assistiu bestializado."', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 16, 'basic', 'O que foi a República Velha (1889-1930)?', 'Política do café-com-leite (SP e MG). Coronelismo, voto de cabresto. Revoltas: Canudos, Contestado, Tenentismo.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 17, 'basic', 'O que foi a Revolução de 1930?', 'Getúlio Vargas assume após golpe. Fim da República Velha. Aliança Liberal. Centralização, modernização.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 18, 'basic', 'O que foi o Estado Novo (1937-1945)?', 'Ditadura de Vargas. Constituição outorgada. DIP (propaganda). Trabalhismo, CLT. Industrialização. Entrada na WWII.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 19, 'basic', 'O que caracterizou o período 1945-1964?', 'Democracia populista. Dutra, Vargas (suicídio 1954), JK (50 anos em 5, Brasília), Jânio, Jango. Crise e golpe.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 20, 'basic', 'O que foi o Plano de Metas de JK?', 'Desenvolvimento industrial: energia, transportes, indústria de base, alimentação, educação. Brasília, meta-síntese.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 21, 'basic', 'O que foi o Golpe de 1964?', 'Militares depõem João Goulart. Guerra Fria influenciou. Apoio civil (classe média, UDN). 21 anos de ditadura.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 22, 'basic', 'O que foi o AI-5 (1968)?', 'Ato Institucional nº 5: endurecimento da ditadura. Fechou Congresso, censurou, cassou, torturou. "Anos de chumbo."', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 23, 'basic', 'O que foi o "Milagre Econômico"?', '1968-1973: crescimento de ~10% ao ano. Industrialização, dívida externa, concentração de renda. "Cresceu o bolo."', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 24, 'basic', 'Como foi a redemocratização?', 'Abertura lenta e gradual. Anistia (1979), Diretas Já (1984), Tancredo/Sarney (1985), Constituição (1988).', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 25, 'basic', 'O que foi o movimento Diretas Já?', '1983-84: mobilização por eleições diretas. Milhões nas ruas. Emenda Dante de Oliveira rejeitada. Eleição indireta.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 26, 'basic', 'O que foi a Constituição de 1988?', '"Constituição Cidadã": direitos sociais, SUS, educação, meio ambiente. Combina liberalismo e estado social.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 27, 'basic', 'O que foi o impeachment de Collor (1992)?', 'Primeiro presidente eleito diretamente pós-ditadura. Esquema PC Farias. "Caras-pintadas". Renunciou antes da votação.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 28, 'basic', 'O que foi o Plano Real (1994)?', 'Estabilização econômica. URV → Real. Fim da hiperinflação. Fernando Henrique Cardoso, ministro e depois presidente.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 29, 'basic', 'O que caracterizou os governos Lula (2003-2010)?', 'PT no poder. Bolsa Família, redução da pobreza, crescimento econômico. Mensalão. Pré-sal.', 'História do Brasil - Boris Fausto'),
  (v_deck_id, 30, 'basic', 'O que foram as manifestações de junho de 2013?', 'Protestos que começaram contra aumento de tarifa. Ampliaram-se: corrupção, serviços públicos. Polarização política.', 'História do Brasil - Boris Fausto');

  -- GEOGRAFIA
  SELECT id INTO v_cat_id FROM categories WHERE slug = 'ensino-medio/ciencias-humanas/geografia';

  INSERT INTO decks (title, description, price, user_id, category_id, tags, is_public, is_verified, rating)
  VALUES ('Geografia: Física, Humana e Geopolítica', 'Cartografia, geologia, climatologia, população, urbanização, economia e geopolítica mundial.', 0, v_user_id, v_cat_id, ARRAY['geografia', 'geopolítica', 'enem', 'vestibular'], true, true, 4.8)
  RETURNING id INTO v_deck_id;

  INSERT INTO cards (deck_id, "order", type, front_content, back_content, source_citation) VALUES
  (v_deck_id, 1, 'basic', 'O que são coordenadas geográficas?', 'Latitude: distância ao Equador (0° a 90° N/S). Longitude: distância ao Meridiano de Greenwich (0° a 180° L/O).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 2, 'basic', 'O que são projeções cartográficas?', 'Representações da Terra esférica em plano. Cilíndricas (Mercator), cônicas, azimutais. Todas têm distorções.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 3, 'basic', 'O que é escala cartográfica?', 'Relação mapa/realidade. 1:100.000 = 1cm no mapa = 1km real. Escala grande: mais detalhes, área menor.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 4, 'basic', 'O que é a Teoria da Tectônica de Placas?', 'Litosfera dividida em placas que se movem. Convergência (montanhas, vulcões), divergência (dorsais), transformante (falhas).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 5, 'basic', 'Quais os agentes de formação do relevo?', 'Endógenos: tectonismo, vulcanismo. Exógenos: intemperismo, erosão (água, vento, gelo). Modelam a superfície.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 6, 'basic', 'Quais as formas de relevo brasileiras?', 'Planaltos (maioria, erosão), planícies (deposição), depressões (entre planaltos). Escudos cristalinos e bacias sedimentares.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 7, 'basic', 'Quais os fatores climáticos?', 'Latitude, altitude, maritimidade, continentalidade, massas de ar, correntes marítimas, relevo.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 8, 'basic', 'Quais os principais climas do Brasil?', 'Equatorial (Amazônia), Tropical (maior parte), Semiárido (Nordeste), Subtropical (Sul), Tropical de Altitude.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 9, 'basic', 'O que são massas de ar?', 'Grandes porções de ar com características de temperatura e umidade. No Brasil: mEc, mEa, mTa, mTc, mPa.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 10, 'basic', 'Quais as principais bacias hidrográficas do Brasil?', 'Amazônica (maior), Tocantins-Araguaia, São Francisco, Paraná (hidrelétricas), Paraguai (Pantanal).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 11, 'basic', 'O que é transição demográfica?', 'Mudança de altas taxas de natalidade/mortalidade para baixas. Fases: pré-transição, transição, pós-transição.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 12, 'basic', 'O que é pirâmide etária?', 'Gráfico de distribuição por idade e sexo. Jovem: base larga. Adulta: centro largo. Envelhecida: topo largo.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 13, 'basic', 'O que é urbanização?', 'Crescimento das cidades e da população urbana. Brasil: 85% urbano. Êxodo rural. Metrópoles. Problemas urbanos.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 14, 'basic', 'O que são megalópoles?', 'Conurbação de metrópoles. Ex: BosWash (Boston-Washington), Tokaido (Tóquio-Osaka), Rio-SP.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 15, 'basic', 'O que é segregação socioespacial?', 'Separação espacial de grupos sociais na cidade. Periferização, favelas, condomínios fechados.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 16, 'basic', 'O que é agronegócio?', 'Agricultura empresarial integrada à indústria. Monocultura, mecanização, exportação. Soja, milho, carne.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 17, 'basic', 'O que são commodities?', 'Produtos primários padronizados, cotados em bolsa. Agrícolas (soja, café), minerais (ferro, petróleo).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 18, 'basic', 'Quais os tipos de indústria?', 'Base (siderurgia, petroquímica), bens de capital (máquinas), bens de consumo (duráveis e não-duráveis).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 19, 'basic', 'O que é a matriz energética brasileira?', 'Predomina energia renovável (hidrelétricas ~60%). Petróleo, gás, biomassa, eólica e solar em crescimento.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 20, 'basic', 'O que é globalização econômica?', 'Integração de mercados mundiais. Multinacionais, fluxo de capitais, livre comércio. Interdependência e desigualdades.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 21, 'basic', 'O que são blocos econômicos?', 'Acordos regionais: zona de livre comércio, união aduaneira, mercado comum. UE, Mercosul, NAFTA/USMCA.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 22, 'basic', 'O que é o Mercosul?', 'Bloco sul-americano (1991). Brasil, Argentina, Uruguai, Paraguai. Tarifa externa comum. Venezuela suspensa.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 23, 'basic', 'O que são os BRICS?', 'Brasil, Rússia, Índia, China, África do Sul. Economias emergentes. Banco do BRICS. Contrapeso ao G7.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 24, 'basic', 'O que é IDH?', 'Índice de Desenvolvimento Humano: saúde (expectativa de vida), educação (escolaridade), renda (PIB per capita). 0 a 1.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 25, 'basic', 'O que é aquecimento global?', 'Aumento da temperatura média por intensificação do efeito estufa (CO₂, CH₄). Mudanças climáticas, derretimento, eventos extremos.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 26, 'basic', 'O que foi o Acordo de Paris?', '2015: limitar aquecimento a 1,5-2°C. NDCs (contribuições nacionais). EUA saiu (Trump) e voltou (Biden).', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 27, 'basic', 'O que é desertificação?', 'Degradação de terras áridas/semiáridas. Causas: desmatamento, uso inadequado do solo, mudanças climáticas.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 28, 'basic', 'Quais os conflitos geopolíticos atuais?', 'Oriente Médio (Israel-Palestina), Ucrânia-Rússia, Mar da China, Coreia do Norte. Tensões EUA-China.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 29, 'basic', 'O que são refugiados?', 'Pessoas que fogem de perseguição, guerra ou violência. Crise: Síria, Afeganistão, Venezuela. ACNUR.', 'Geografia Geral e do Brasil - Melhem Adas'),
  (v_deck_id, 30, 'basic', 'Qual a posição geopolítica do Brasil?', 'Potência regional. Amazônia, pré-sal, agronegócio. BRICS, G20. Diplomacia multilateral. Desafios de desenvolvimento.', 'Geografia Geral e do Brasil - Melhem Adas');

  RAISE NOTICE 'Decks de Humanas inseridos com sucesso!';
END $$;
