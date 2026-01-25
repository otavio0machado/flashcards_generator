# Flashcards Generator

![Flashcards Generator](https://placehold.co/1200x400/2563eb/ffffff?text=Flashcards+Generator)

**Flashcards Generator** é uma plataforma inteligente que utiliza Inteligência Artificial (Google Gemini) para transformar textos, resumos e anotações em flashcards de estudo otimizados. Ideal para estudantes, concurseiros e qualquer pessoa que deseje acelerar seu aprendizado através da repetição espaçada.

## 🚀 Visão Geral

O projeto foi construído com foco em performance, modernidade e experiência do usuário.

### Stack Tecnológica
- **Framework Web**: [Next.js 16](https://nextjs.org/) (App Router)
- **UI & Estilização**: [React 19](https://react.dev/), [Tailwind CSS v4](https://tailwindcss.com/), [Framer Motion](https://www.framer.com/motion/)
- **Backend & Database**: [Supabase](https://supabase.com/) (Auth, DB), [Upstash Redis](https://upstash.com/) (Rate Limiting)
- **IA Generativa**: [Google Gemini API](https://ai.google.dev/)
- **Pagamentos**: [Stripe](https://stripe.com/)
- **Monitoramento**: [PostHog](https://posthog.com/), [Sentry](https://sentry.io/)

### Requisitos de Sistema
- Node.js 20+
- Python 3.10+ (para scripts de verificação)
- Conta no Supabase, Upstash, Google AI (Gemini) e Stripe.

---

## 🛠️ Instalação e Configuração

Siga os passos abaixo para rodar o projeto localmente.

### 1. Clonar o Repositório

```bash
git clone https://github.com/otavio0machado/flashcards_generator.git
cd flashcards_generator
```

### 2. Instalar Dependências

Utilize o `npm` para instalar as dependências do projeto:

```bash
npm install
```

### 3. Configurar Variáveis de Ambiente

Crie um arquivo `.env.local` na raiz do projeto e configure as seguintes variáveis. **Nunca comite suas chaves secretas!**

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=seu_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua_anon_key
SUPABASE_SERVICE_ROLE_KEY=sua_service_role_key

# Upstash Redis
UPSTASH_REDIS_REST_URL=seu_upstash_url
UPSTASH_REDIS_REST_TOKEN=seu_upstash_token

# Google AI (Gemini)
GEMINI_API_KEY=sua_gemini_key

# Stripe (Opcional para dev, necessário para pagamentos)
STRIPE_SECRET_KEY=sua_stripe_secret
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=sua_stripe_public_key

# Monitoramento (Opcional)
NEXT_PUBLIC_POSTHOG_KEY=sua_posthog_key
NEXT_PUBLIC_POSTHOG_HOST=https://app.posthog.com
SENTRY_DSN=seu_sentry_dsn

# Segurança e Outros
DEMO_IP_SALT=gere_um_hash_aleatorio
```

### 4. Executar a Aplicação

Para rodar o servidor de desenvolvimento:

```bash
npm run dev
```

Acesse [http://localhost:3000](http://localhost:3000).

Para build de produção:

```bash
npm run build
npm start
```

---

## 💡 Uso do Aplicativo

### Gerador de Flashcards (Demo vs. Pago)

O sistema permite gerar flashcards a partir de texto colado ou arquivos (dependendo do plano).

#### Modo Demo (Sem Login)
Ideais para testar a ferramenta.
- **Caracteres Máx:** 2.000 caracteres.
- **Cartões:** Limite de 5 cartões por geração.
- **Rate Limit:** 1 geração a cada 24h por IP/Fingerprint.
- **Recursos:** Apenas texto.

#### Criação de Conta
Ao criar uma conta gratuita, os limites de uso diário são renovados.

### Planos e Limites (Referências)

| Recurso | Grátis | Pro (R$ 9,90/mês) | Ultimate (R$ 19,90/mês) |
| :--- | :--- | :--- | :--- |
| **Gerações Diárias** | 3 | 10 | 20 |
| **Geração por Arquivo** | ❌ | ✅ | ✅ |
| **OCR (Imagem p/ Texto)** | ❌ | ❌ | ✅ |
| **Geração de Imagens** | ❌ | ❌ | ✅ |
| **Histórico Salvo** | ❌ | ✅ | ✅ |

> *Nota: Os planos podem sofrer alterações conforme definido em `constants/pricing.ts`.*

---

## 🤝 Contribuição

Contribuições são bem-vindas! Siga estas diretrizes para manter a qualidade do código.

### Processo de Pull Request
1. Faça um Fork do projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças seguindo o padrão [Conventional Commits](https://www.conventionalcommits.org/). Ex: `feat: adiciona suporte a PDF`.
4. Rode os testes e verificação (`npm run lint` e scripts python) antes de enviar.
5. Abra um Pull Request.

### Padrões de Código
- **S.O.L.I.D. e Clean Code**: Mantenha funções pequenas e com responsabilidade única.
- **Tipagem**: Use TypeScript estrito. Evite `any`.
- **Estilo**: O projeto usa ESLint e Prettier configurados.
- **CSS**: Use Tailwind CSS utilitários. Evite CSS global customizado.

---

## 🧪 Testes e Scripts de Verificação

Utilizamos um conjunto robusto de scripts Python (Antigravity Kit) para garantir a integridade do código.

### Scripts Principais

Os scripts estão localizados em `.agent/scripts/`. Documentação detalhada em `documents/TESTING.md` (se houver) ou verifique o cabeçalho dos arquivos.

#### 1. Checklist Rápido (`checklist.py`)
Executa verificações essenciais (segurança, lint, tipos). Use antes de cada commit.

```bash
python .agent/scripts/checklist.py .
```

#### 2. Verificação Completa (`verify_all.py`)
Executa **todos** os testes, incluindo auditoria de SEO, acessibilidade, performance (Lighthouse) e E2E. Use antes de deploy ou PR.

```bash
# Requer servidor rodando (ex: localhost:3000)
python .agent/scripts/verify_all.py . --url http://localhost:3000
```

### Testes Automatizados

- **Linting**: `npm run lint`
- **Testes Unitários/Integração**: Configurados via script `.agent/skills/testing-patterns/scripts/test_runner.py`.

---

## ❓ FAQ e Suporte

**P: Onde os dados ficam salvos?**
R: Os dados de usuários e histórico são salvos no Supabase (PostgreSQL). No modo Demo, nada é salvo permanentemente além de logs de uso anônimos para Rate Limit.

**P: Posso exportar para o Anki?**
R: Sim! A funcionalidade de exportação gera arquivos `.apkg` compatíveis com o Anki Desktop e Mobile.

**Scontrou um bug?**
Abra uma [Issue no GitHub](https://github.com/otavio0machado/flashcards_generator/issues) descrevendo o problema, passos para reproduzir e ambiente utilizado.

---

*Documentação gerada automaticamente pelo agente **documentation-writer**.*
