# Relatório de Análise de Banco de Dados e Segurança

**Data:** 25/01/2026
**Responsável:** Agente `database-architect`
**Stack:** PostgreSQL (Supabase), Next.js 16 (App Router)

---

## 🏗️ 1. Modelagem e Normalização

A modelagem atual é robusta e bem estruturada para o domínio de Flashcards + Marketplace.
As tabelas principais (`profiles`, `decks`, `cards`) estão normalizadas (3NF) e possuem as chaves estrangeiras corretas (`ON DELETE CASCADE`).

### Pontos Fortes:
- **Integridade Referencial:** O uso de `ON DELETE CASCADE` em `cards` e `decks` garante que não fiquem dados órfãos ao deletar um usuário ou baralho.
- **Tipagem de Cards:** O uso de `CHECK (type IN (...))` no SQL (visto em `marketplace_schema.sql`) é excelente para garantir consistência de dados a nível de banco.
- **Indexação:** Os índices essenciais (`decks_public_published_idx`, `cards_deck_idx`) foram criados, o que é crucial para a performance de listagens públicas.

### ⚠️ Pontos de Atenção (Duplicidade):
Notei a existência de dois arquivos de schema principais: `schema.sql` (App Core) e `marketplace_schema.sql` (Marketplace).
- O `schema.sql` cria `decks` com campos como `user_id`.
- O `marketplace_schema.sql` cria `decks` com campos como `author_id` e `price`.
**Risco:** Se ambos forem executados no mesmo banco, haverá conflito de nomes ou tabelas híbridas não planejadas. Recomenda-se unificar a definição da tabela `decks` para suportar tanto o uso pessoal (`user_id`) quanto o marketplace (`price`, `is_verified`).

---

## 🔒 2. Segurança (RLS & Acesso)

O projeto faz uso extensivo e correto de **Row Level Security (RLS)** do Supabase.

### Análise das Políticas:
- **Profiles:** Usuários só editam o próprio perfil (`auth.uid() = id`). ✅
- **Decks Privados:** Apenas o dono vê e edita (`auth.uid() = user_id`). ✅
- **Decks Públicos:** Qualquer um vê (`is_public = true`). ✅
- **Cards:** A política usa `EXISTS (SELECT 1 FROM decks ...)` para verificar permissão baseada no pai (Deck). Isso é seguro, mas pode ter impacto de performance em grandes volumes (joins implícitos em cada linha).

### Proteção de Credenciais:
O cliente Supabase é inicializado via variáveis de ambiente (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`).
- **Server-Side:** O uso de `createServerClient` (visto no `route.ts` da API) é correto para contextos de servidor.
- **Client-Side:** O uso de `createBrowserClient` (visto em `lib/supabase.ts`) está correto.

---

## 🚀 3. Padrões de Acesso e Performance

A aplicação usa o padrão `Service` (`deckService.ts`) para centralizar a lógica de banco, o que é bom.

### Otimizações Observadas:
- **RPC (Remote Procedure Call):** O uso da função `increment_daily_usage` e `update_card_progress` move a lógica de negócio (e updates atômicos) para dentro do banco. Isso previne *race conditions* no contador de uso diário e cálculo de SRS. **Excelente prática.**
- **Batch Inserts:** O método `saveDeck` realiza inserts em lote (`cardsToInsert`), reduzindo round-trips ao banco.

### Recomendação de Server Components:
- Atualmente, o `deckService.ts` usa o cliente padrão (provavelmente client-side se importado no front).
- **Melhoria:** Para páginas de listagem e detalhes (Marketplace), use **Server Components** que chamam o Supabase diretamente, evitando expor lógica no cliente e reduzindo o JS enviado ao navegador.

---

## ✅ 4. Recomendações Finais

### Alta Prioridade (Segurança/Integridade):
1.  **Unificar Schemas:** Consolidar `schema.sql` e `marketplace_schema.sql` em uma definição única e coerente para a tabela `decks`, evitando colunas duplicadas ou conflitantes (`user_id` vs `author_id`).
2.  **Validação Zod:** Implementar schemas Zod no `deckService.ts` ou nas API Routes para validar os dados *antes* de tentar enviar ao Supabase. Isso poupa recursos do banco.

### Média Prioridade (Escalabilidade):
3.  **Índice em Cards:** Adicionar índice composto em `cards(deck_id, order)` se a ordenação for frequente na visualização de estudo.
4.  **Cache de Marketplace:** Implementar ISR (Incremental Static Regeneration) ou cache com `unstable_cache` do Next.js para as páginas públicas do Marketplace, já que esses dados mudam pouco.

### Baixa Prioridade:
5.  **Soft Delete:** Considerar adicionar coluna `deleted_at` em `decks` ao invés de `DELETE CASCADE` imediato, permitindo recuperação de dados acidentais.
