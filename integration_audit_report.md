# Relatório de Auditoria de Integrações e Resiliência

**Data:** 25/01/2026
**Responsável:** Agente `debugger` / `explorer-agent`
**Contexto:** Análise de robustez das integrações com IA (Gemini/OpenAI), Autenticação (Supabase) e Pagamentos.

---

## 🗺️ 1. Mapeamento de Integrações

A aplicação depende de 3 serviços externos críticos para seu funcionamento. Uma falha em qualquer um deles degrada significativamente a experiência.

| Serviço | Uso Principal | Localização no Código | Criticidade |
| :--- | :--- | :--- | :--- |
| **Google Gemini** | Motor de Geração de Flashcards | `services/aiService.ts` | **Alta (Core)**. Sem isso, o app não funciona. |
| **OpenAI (DALL-E 3)** | Geração de Imagens para Cards | `services/imageService.ts` | **Média**. Feature Premium/Pro. |
| **Pollinations.ai** | Refinamento de Prompts de Imagem | `services/imageService.ts` | **Média**. Usado como passo intermediário gratuito. |
| **Supabase Auth** | Identidade, Login e Sessão | `middleware.ts`, `api/generate` | **Alta**. Bloqueia acesso ao app. |
| **Upstash (Redis)** | Rate Limiting e Controle de Demo | `api/generate`, `api/demo` | **Média**. Protege contra abuso. |

---

## 🛡️ 2. Tratamento de Erros e Resiliência

Analisei como a aplicação lida com falhas nestes serviços.

### ✅ Pontos Positivos:
1.  **Retry Pattern (Backoff Exponencial):**
    *   Implementado em `aiService.ts` (método `fetchWithRetry`).
    *   A aplicação tenta reconectar até 5 vezes em casos de erro 429 (Rate Limit) ou 503 (Serviço Indisponível), com espera progressiva (2s, 4s, 8s...). **Excelente prática.**
2.  **Degradação Graciosa na Geração de Imagens:**
    *   Em `imageService.ts`, a geração de imagens roda em paralelo (`Promise.all`). Se uma imagem falhar, ela é logada (`stats.failed++`) mas **não derruba** a requisição inteira. O usuário recebe os cards de texto normalmente.
3.  **Sanitização de Input:**
    *   O `sanitizedText` e o uso de tags `<user_content>` no prompt do sistema (`promptService.ts`) ajudam a prevenir que o modelo de IA seja "hackeado" por instruções maliciosas no texto do usuário.

### ⚠️ Pontos de Falha (Vulnerabilidades):
1.  **Dependência Forte da Pollinations.ai:**
    *   O `imageService` usa `pollinations.ai` (serviço gratuito) para converter texto em prompts visuais *antes* de chamar o DALL-E. Não há fallback se este serviço cair ou ficar lento. Isso pode gargalar toda a geração de imagens paga.
2.  **Timeouts não Configurados Explicitamente:**
    *   As chamadas `fetch` padrão do Node têm timeouts longos. Se o Gemini travar (hang), a requisição do usuário pode ficar pendente até o limite da Vercel (10s no plano Hobby / 60s no Pro), causando Timeout 504 sem feedback rápido.

---

## 🚦 3. Limites e Controle de Uso

1.  **Rate Limiting Global:**
    *   Implementado via **Upstash Redis** (`api/generate/route.ts`).
    *   Limite deslizante de 10 requisições/minuto por usuário. Isso protege a carteira do dono do projeto contra scripts de loop.
2.  **Limites de Negócio (Planos):**
    *   Verificação rigorosa de `dailyGens`, `maxChars` e permissões de feature (`allowImageGeneration`) antes de chamar qualquer IA. Isso economiza custos de token.

---

## 📊 4. Monitoramento e Logs

1.  **Sentry Configurado:**
    *   O arquivo `sentry.client.config.ts` está presente e ativo. Isso capturará exceções não tratadas no front.
2.  **Logs de Backend:**
    *   Existem `console.error` e `console.warn` nos catch blocks dos serviços.
    *   **Sugestão:** Em produção, `console.log` pode se perder ou ser ruidoso. Logs estruturados (JSON) com métricas de "Tempo de Geração" e "Custo de Token" seriam valiosos para análise de custos.

---

## 💡 Recomendações de Melhoria

### Curto Prazo (Correções Rápidas)
1.  **Timeout no Fetch:** Adicionar `AbortSignal` com timeout de 30s nas chamadas ao Gemini/OpenAI para evitar processos zumbis.
2.  **Fallback de Prompt:** Se a Pollinations.ai falhar, usar o texto original do card como prompt para o DALL-E (mesmo que menos otimizado), garantindo a entrega da imagem paga.

### Médio Prazo (Arquitetura)
3.  **Fila de Processamento (Jobs):**
    *   Mover a geração de imagens (que é lenta) para um **Background Job** (Inngest ou fila do Supabase).
    *   O usuário receberia os cards de texto na hora, e as imagens apareceriam via WebSocket/Polling assim que estivessem prontas. Isso melhora drasticamente a percepção de velocidade.
