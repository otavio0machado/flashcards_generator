-- Seed categories for Ensino Medio (BNCC) and Ensino Superior (Graduacao).

INSERT INTO categories (name, slug, parent_id) VALUES
  ('Ensino Médio (BNCC)', 'ensino-medio', NULL),
  ('Ensino Superior (Graduação)', 'ensino-superior', NULL)
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-medio'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Linguagens', 'ensino-medio/linguagens'),
  ('Matemática', 'ensino-medio/matematica'),
  ('Ciências da Natureza', 'ensino-medio/ciencias-da-natureza'),
  ('Ciências Humanas', 'ensino-medio/ciencias-humanas')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-medio/linguagens'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Português', 'ensino-medio/linguagens/portugues'),
  ('Literatura', 'ensino-medio/linguagens/literatura'),
  ('Inglês', 'ensino-medio/linguagens/ingles'),
  ('Espanhol', 'ensino-medio/linguagens/espanhol'),
  ('Artes', 'ensino-medio/linguagens/artes')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-medio/matematica'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Álgebra', 'ensino-medio/matematica/algebra'),
  ('Geometria', 'ensino-medio/matematica/geometria'),
  ('Estatística', 'ensino-medio/matematica/estatistica')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-medio/ciencias-da-natureza'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Biologia', 'ensino-medio/ciencias-da-natureza/biologia'),
  ('Química', 'ensino-medio/ciencias-da-natureza/quimica'),
  ('Física', 'ensino-medio/ciencias-da-natureza/fisica')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-medio/ciencias-humanas'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('História', 'ensino-medio/ciencias-humanas/historia'),
  ('Geografia', 'ensino-medio/ciencias-humanas/geografia'),
  ('Filosofia', 'ensino-medio/ciencias-humanas/filosofia'),
  ('Sociologia', 'ensino-medio/ciencias-humanas/sociologia')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Ciências da Saúde', 'ensino-superior/ciencias-da-saude'),
  ('Ciências Jurídicas/Direito', 'ensino-superior/direito'),
  ('Engenharias e Exatas', 'ensino-superior/engenharias-e-exatas'),
  ('Tecnologia da Informação', 'ensino-superior/tecnologia-da-informacao'),
  ('Negócios', 'ensino-superior/negocios')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Medicina', 'ensino-superior/ciencias-da-saude/medicina'),
  ('Enfermagem', 'ensino-superior/ciencias-da-saude/enfermagem'),
  ('Odontologia', 'ensino-superior/ciencias-da-saude/odontologia'),
  ('Psicologia', 'ensino-superior/ciencias-da-saude/psicologia')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Ciclo Básico', 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico'),
  ('Ciclo Clínico', 'ensino-superior/ciencias-da-saude/medicina/ciclo-clinico'),
  ('Internato', 'ensino-superior/ciencias-da-saude/medicina/internato'),
  ('Residência', 'ensino-superior/ciencias-da-saude/medicina/residencia')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Anatomia', 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico/anatomia'),
  ('Fisiologia', 'ensino-superior/ciencias-da-saude/medicina/ciclo-basico/fisiologia')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/direito'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('OAB', 'ensino-superior/direito/oab'),
  ('Concursos', 'ensino-superior/direito/concursos'),
  ('Civil', 'ensino-superior/direito/civil'),
  ('Penal', 'ensino-superior/direito/penal'),
  ('Constitucional', 'ensino-superior/direito/constitucional'),
  ('Administrativo', 'ensino-superior/direito/administrativo'),
  ('Processual', 'ensino-superior/direito/processual')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/engenharias-e-exatas'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Cálculo', 'ensino-superior/engenharias-e-exatas/calculo'),
  ('Física Universitária', 'ensino-superior/engenharias-e-exatas/fisica-universitaria'),
  ('Química Geral', 'ensino-superior/engenharias-e-exatas/quimica-geral'),
  ('Resistência dos Materiais', 'ensino-superior/engenharias-e-exatas/resistencia-dos-materiais'),
  ('Fenômenos de Transporte', 'ensino-superior/engenharias-e-exatas/fenomenos-de-transporte')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/tecnologia-da-informacao'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Fundamentos', 'ensino-superior/tecnologia-da-informacao/fundamentos'),
  ('Linguagens de Programação', 'ensino-superior/tecnologia-da-informacao/linguagens-de-programacao'),
  ('Banco de Dados', 'ensino-superior/tecnologia-da-informacao/banco-de-dados'),
  ('Redes', 'ensino-superior/tecnologia-da-informacao/redes'),
  ('Cloud/DevOps', 'ensino-superior/tecnologia-da-informacao/cloud-devops')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;

WITH parent AS (
  SELECT id FROM categories WHERE slug = 'ensino-superior/negocios'
)
INSERT INTO categories (name, slug, parent_id)
SELECT v.name, v.slug, parent.id
FROM (VALUES
  ('Administração', 'ensino-superior/negocios/administracao'),
  ('Economia', 'ensino-superior/negocios/economia'),
  ('Contabilidade', 'ensino-superior/negocios/contabilidade'),
  ('Marketing', 'ensino-superior/negocios/marketing')
) AS v(name, slug)
CROSS JOIN parent
ON CONFLICT (slug) DO NOTHING;
