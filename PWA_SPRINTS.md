# Sprints de Execucao: PWA Mobile/Tablet

## Indice de Sprints

| Sprint | Nome | Arquivos | Risco | Dependencias |
|--------|------|----------|-------|--------------|
| 1 | Hook usePWA + Provider | 2 arquivos novos/modificados | BAIXO | Nenhuma |
| 2 | Navbar + BottomNav condicionais | 2 arquivos modificados | MEDIO | Sprint 1 |
| 3 | Layout + TauriMainWrapper padding | 2 arquivos modificados | MEDIO | Sprint 1 |
| 4 | CSS anti-flash (FOUC prevention) | 1 arquivo modificado | BAIXO | Sprint 2 |
| 5 | Pagina de Download + botao instalar | 1 arquivo modificado | BAIXO | Sprint 1 |
| 6 | Refatorar InstallPrompt | 1 arquivo modificado | BAIXO | Sprint 1 |
| 7 | Testes e validacao | 0 arquivos | - | Sprints 1-6 |

---

## Sprint 1: Hook usePWA + Provider

**Objetivo:** Criar a infraestrutura central de deteccao PWA.
**Risco:** BAIXO — arquivo novo, zero impacto em codigo existente.
**Tempo estimado:** ~15 min

### Arquivo: `lib/pwa.tsx` (CRIAR)

**Prompt de execucao:**
```
Criar o arquivo lib/pwa.tsx com:

1. Interface BeforeInstallPromptEvent (tipagem do evento)
2. Interface PWAContextType com: isStandalone, isInstallable, isIOS, promptInstall
3. PWAContext com createContext e defaults seguros (tudo false)
4. PWAProvider component que:
   - Detecta standalone via matchMedia('(display-mode: standalone)') E navigator.standalone
   - Escuta mudancas no matchMedia com addEventListener('change')
   - Captura beforeinstallprompt event com preventDefault()
   - Detecta iOS via /iPad|iPhone|iPod/.test(navigator.userAgent)
   - Expoe promptInstall() via useCallback que chama deferredPrompt.prompt()
   - Faz cleanup de todos os listeners no return do useEffect
5. Hook usePWA() que retorna useContext(PWAContext)
6. Funcao utilitaria isStandaloneMode() para checagem estatica sem contexto
```

**Codigo completo a ser criado:**

```typescript
'use client';

import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';

interface BeforeInstallPromptEvent extends Event {
    readonly platforms: string[];
    readonly userChoice: Promise<{
        outcome: 'accepted' | 'dismissed';
        platform: string;
    }>;
    prompt(): Promise<void>;
}

declare global {
    interface WindowEventMap {
        beforeinstallprompt: BeforeInstallPromptEvent;
    }
}

interface PWAContextType {
    isStandalone: boolean;
    isInstallable: boolean;
    isIOS: boolean;
    promptInstall: () => Promise<'accepted' | 'dismissed' | 'unavailable'>;
}

const PWAContext = createContext<PWAContextType>({
    isStandalone: false,
    isInstallable: false,
    isIOS: false,
    promptInstall: async () => 'unavailable',
});

export function PWAProvider({ children }: { children: ReactNode }) {
    const [isStandalone, setIsStandalone] = useState(false);
    const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null);
    const [isIOS, setIsIOS] = useState(false);

    useEffect(() => {
        // Detectar standalone mode
        const mqStandalone = window.matchMedia('(display-mode: standalone)');
        const safariStandalone = (navigator as Navigator & { standalone?: boolean }).standalone === true;
        setIsStandalone(mqStandalone.matches || safariStandalone);

        const handleDisplayChange = (e: MediaQueryListEvent) => {
            setIsStandalone(e.matches);
        };
        mqStandalone.addEventListener('change', handleDisplayChange);

        // Detectar iOS
        const ua = navigator.userAgent;
        setIsIOS(/iPad|iPhone|iPod/.test(ua) && !('MSStream' in window));

        // Capturar beforeinstallprompt
        const handleBeforeInstall = (e: BeforeInstallPromptEvent) => {
            e.preventDefault();
            setDeferredPrompt(e);
        };
        window.addEventListener('beforeinstallprompt', handleBeforeInstall);

        return () => {
            mqStandalone.removeEventListener('change', handleDisplayChange);
            window.removeEventListener('beforeinstallprompt', handleBeforeInstall);
        };
    }, []);

    const promptInstall = useCallback(async (): Promise<'accepted' | 'dismissed' | 'unavailable'> => {
        if (!deferredPrompt) return 'unavailable';
        await deferredPrompt.prompt();
        const { outcome } = await deferredPrompt.userChoice;
        setDeferredPrompt(null);
        return outcome;
    }, [deferredPrompt]);

    return (
        <PWAContext.Provider value={{
            isStandalone,
            isInstallable: !!deferredPrompt,
            isIOS,
            promptInstall,
        }}>
            {children}
        </PWAContext.Provider>
    );
}

export function usePWA() {
    return useContext(PWAContext);
}

export function isStandaloneMode(): boolean {
    if (typeof window === 'undefined') return false;
    return window.matchMedia('(display-mode: standalone)').matches
        || (navigator as Navigator & { standalone?: boolean }).standalone === true;
}
```

### Validacao Sprint 1:
```bash
# Verificar que o arquivo foi criado corretamente
# Verificar que npm run build passa (o provider ainda nao esta no layout)
npm run build
```

**Criterio de aceite:** Build passa sem erros. Arquivo criado em `lib/pwa.tsx`.

---

## Sprint 2: Navbar + BottomNav condicionais

**Objetivo:** Fazer Navbar se esconder e BottomNav aparecer apenas em PWA standalone.
**Risco:** MEDIO — mexe em navegacao, area sensivel.
**Dependencia:** Sprint 1 (usePWA hook)

### Arquivo 1: `components/Navbar.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Modificar components/Navbar.tsx:

1. Adicionar import: import { usePWA } from '@/lib/pwa';
2. Dentro do componente, apos o useTauri(), adicionar: const { isStandalone } = usePWA();
3. Mudar a condicao de return null (linha ~123):
   ANTES: if (isTauri && isDesktop) { return null; }
   DEPOIS: if ((isTauri && isDesktop) || isStandalone) { return null; }
4. Adicionar data-navbar ao <nav> para CSS anti-flash:
   ANTES: <nav className={`fixed top-0 ...
   DEPOIS: <nav data-navbar className={`fixed top-0 ...
```

**Mudancas especificas (linha por linha):**

```diff
// Linha 15 - adicionar import
+ import { usePWA } from '@/lib/pwa';

// Linha 20 - adicionar hook
  const { isTauri, isDesktop } = useTauri();
+ const { isStandalone } = usePWA();

// Linhas 122-125 - expandir condicao
- if (isTauri && isDesktop) {
+ if ((isTauri && isDesktop) || isStandalone) {
    return null;
  }

// Linha 128 - adicionar data attribute
- <nav className={`fixed top-0 left-0 right-0 z-50 ...
+ <nav data-navbar className={`fixed top-0 left-0 right-0 z-50 ...
```

### Arquivo 2: `components/BottomNav.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Modificar components/BottomNav.tsx:

1. Adicionar import: import { usePWA } from '@/lib/pwa';
2. Dentro do componente, apos usePathname(), adicionar: const { isStandalone } = usePWA();
3. Adicionar condicao ANTES da checagem de auth:
   if (!isStandalone) return null;
4. Remover md:hidden da classe do <nav> (JS agora controla visibilidade)
5. Adicionar data-bottomnav ao <nav> para CSS anti-flash
```

**Mudancas especificas (linha por linha):**

```diff
// Linha 3 (ou apos imports existentes) - adicionar import
+ import { usePWA } from '@/lib/pwa';

// Linha 17 - adicionar hook
  const pathname = usePathname();
+ const { isStandalone } = usePWA();

// Linha 20 - adicionar condicao ANTES da checagem de auth
+ if (!isStandalone) return null;
+
  if (pathname?.startsWith('/auth')) {
      return null;
  }

// Linha 25 - modificar classe do nav
- <nav className="fixed bottom-0 left-0 right-0 z-50 md:hidden">
+ <nav data-bottomnav className="fixed bottom-0 left-0 right-0 z-50">
```

### Validacao Sprint 2:
```bash
npm run build
```

**Testes manuais:**
1. Abrir no browser desktop -> Navbar VISIVEL, BottomNav ESCONDIDO
2. Abrir no browser mobile (DevTools F12) -> Navbar VISIVEL, BottomNav ESCONDIDO
3. Simular standalone no DevTools -> Navbar ESCONDIDA, BottomNav VISIVEL

**Como simular standalone no DevTools:**
1. F12 -> Application -> Manifest
2. Ou: Console -> `window.matchMedia('(display-mode: standalone)')` checar
3. Ou: Rendering tab -> "Emulate CSS media feature display-mode" -> standalone

**Criterio de aceite:** Build passa. Desktop web identico ao commit df839c4. BottomNav nao aparece em browser.

---

## Sprint 3: Layout + TauriMainWrapper padding

**Objetivo:** Ajustar padding do body e do wrapper para cada contexto.
**Risco:** MEDIO — padding errado = conteudo atras da navbar.
**Dependencia:** Sprint 1

### Arquivo 1: `app/layout.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Modificar app/layout.tsx:

1. Adicionar import: import { PWAProvider } from "@/lib/pwa";
2. Envolver todo o conteudo DENTRO do TauriProvider com PWAProvider:
   ANTES:
     <TauriProvider>
         <Navbar />
         ...
     </TauriProvider>
   DEPOIS:
     <TauriProvider>
         <PWAProvider>
             <Navbar />
             ...
         </PWAProvider>
     </TauriProvider>
3. Mudar body className:
   ANTES: pt-16 pb-20 md:pb-0
   DEPOIS: pt-16 pb-0
```

**Mudancas especificas:**

```diff
// Imports
+ import { PWAProvider } from "@/lib/pwa";

// Body className (linha 103)
- className={`${geistSans.variable} ${geistMono.variable} antialiased noise-bg min-h-screen pt-16 pb-20 md:pb-0`}
+ className={`${geistSans.variable} ${geistMono.variable} antialiased noise-bg min-h-screen pt-16 pb-0`}

// Provider hierarchy (linhas 119-129)
  <TauriProvider>
+     <PWAProvider>
          <Navbar />
          <DesktopSidebar />
          <Suspense fallback={null}>
              <AnalyticsPageView />
          </Suspense>
          <TauriMainWrapper>{children}</TauriMainWrapper>
          <BottomNav />
          <TauriConditionalComponents />
          <Toaster />
+     </PWAProvider>
  </TauriProvider>
```

### Arquivo 2: `components/TauriMainWrapper.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Modificar components/TauriMainWrapper.tsx:

1. Adicionar import: import { usePWA } from '@/lib/pwa';
2. Dentro do componente, adicionar: const { isStandalone } = usePWA();
3. Adicionar classes condicionais para PWA standalone:
   - Quando isStandalone: pt-0 pb-20 (sem navbar, com bottom nav)
   - Manter logica existente do Tauri intacta
```

**Mudancas especificas:**

```diff
// Imports
+ import { usePWA } from '@/lib/pwa';

// Dentro do componente (apos useTauri)
+ const { isStandalone } = usePWA();

// Classe do <main>
  <main
      className={`min-h-screen transition-[margin-left] duration-300 ease-in-out ${
          needsMargin ? sidebarCollapsed ? 'ml-16' : 'ml-64' : ''
-     } ${isTauri ? 'desktop-density' : ''}`}
+     } ${isTauri ? 'desktop-density' : ''} ${
+         isStandalone ? '!pt-0 pb-20' : ''
+     }`}
  >
```

**Nota sobre `!pt-0`:** O `!` (important modifier do Tailwind) garante que sobrescreve o `pt-16` do body. Alternativa e usar CSS puro (ver Sprint 4).

### Validacao Sprint 3:
```bash
npm run build
```

**Testes manuais:**
1. Desktop browser: conteudo com padding top correto (abaixo da Navbar)
2. Mobile browser: idem
3. PWA standalone (simulado): conteudo sem padding top, com padding bottom

**Criterio de aceite:** Build passa. Conteudo nunca fica atras da Navbar. Conteudo nunca fica atras do BottomNav.

---

## Sprint 4: CSS anti-flash (FOUC prevention)

**Objetivo:** Evitar flash da Navbar ao abrir PWA standalone.
**Risco:** BAIXO — apenas adicoes CSS.
**Dependencia:** Sprint 2 (data-navbar e data-bottomnav attributes)

### Arquivo: `app/globals.css` (MODIFICAR)

**Prompt de execucao:**
```
Adicionar ao FINAL do arquivo app/globals.css:

Bloco CSS para PWA standalone que:
1. Esconde [data-navbar] imediatamente (antes do JS)
2. Ajusta body padding: pt=0, pb=80px (bottom nav height)
3. Adiciona safe-area-inset para notch iOS e home indicator
```

**Codigo a adicionar (no final do arquivo):**

```css
/* ========================================
   PWA Standalone Mode
   Aplicado ANTES do JavaScript hidratar.
   Evita flash de Navbar ao abrir como app.
   ======================================== */

@media (display-mode: standalone) {
    /* Esconder Navbar instantaneamente */
    [data-navbar] {
        display: none !important;
    }

    /* Ajustar body padding para standalone */
    body {
        padding-top: env(safe-area-inset-top, 0px) !important;
        padding-bottom: 0 !important;
    }
}

/* Safari iOS standalone (navigator.standalone) */
@media (display-mode: standalone), (-webkit-device-pixel-ratio: 0) {
    /* Fallback: Safari iOS pode nao responder a display-mode */
}

/* Safe area para bottom nav em PWA */
@supports (padding-bottom: env(safe-area-inset-bottom)) {
    @media (display-mode: standalone) {
        [data-bottomnav] {
            padding-bottom: env(safe-area-inset-bottom, 0px);
        }
    }
}
```

### Validacao Sprint 4:
```bash
npm run build
```

**Teste manual:**
1. Abrir PWA standalone (simulado) -> SEM flash de Navbar
2. Desktop browser -> CSS nao afeta (media query nao match)

**Criterio de aceite:** Build passa. Zero flash de layout em standalone.

---

## Sprint 5: Pagina de Download + botao instalar

**Objetivo:** Adicionar card "Instalar como App" na pagina de download.
**Risco:** BAIXO — apenas adicao de UI.
**Dependencia:** Sprint 1

### Arquivo: `app/download/page.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Modificar app/download/page.tsx:

1. Adicionar imports: import { usePWA } from '@/lib/pwa'; import { trackEvent } from '@/lib/analytics';
2. Dentro do componente, adicionar: const { isStandalone, isInstallable, isIOS, promptInstall } = usePWA();
3. Adicionar novo card "Instalar como App" ACIMA da grid de plataformas (dentro da section pb-24)
4. O card so aparece quando !isStandalone (nao mostrar se ja instalou)
5. Condicional dentro do card:
   - isInstallable (Android/Chrome): botao que chama promptInstall()
   - isIOS: instrucoes passo a passo
   - fallback: mensagem "Abra no Chrome ou Safari"
6. Card com borda brand, fundo brand/5, destaque visual
7. Adicionar na lista de beneficios do card: "Sem download pesado", "Funciona offline", "Sempre atualizado"
8. Analytics: trackEvent('pwa_install_download_page', { result }) ao clicar
```

**Posicionamento no JSX:**

```
<section className="pb-24 px-4">
    <div className="max-w-4xl mx-auto">

        {/* === NOVO: Card "Instalar como App" === */}
        {!isStandalone && !isDesktopApp && (
            <div className="mb-8 ...">
                ...card PWA...
            </div>
        )}

        {/* Grid de plataformas existente */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
            ...
        </div>
    </div>
</section>
```

### Validacao Sprint 5:
```bash
npm run build
```

**Testes manuais:**
1. Desktop browser: card visivel com instrucoes/botao
2. Mobile browser: card visivel
3. PWA standalone: card ESCONDIDO
4. Tauri desktop: card ESCONDIDO (isDesktopApp check)

**Criterio de aceite:** Build passa. Card aparece acima dos downloads. Botao funciona.

---

## Sprint 6: Refatorar InstallPrompt

**Objetivo:** Simplificar InstallPrompt.tsx usando usePWA() centralizado.
**Risco:** BAIXO — refatoracao, comportamento identico.
**Dependencia:** Sprint 1

### Arquivo: `components/InstallPrompt.tsx` (MODIFICAR)

**Prompt de execucao:**
```
Refatorar components/InstallPrompt.tsx:

1. Substituir a logica manual de deteccao standalone por usePWA()
2. Remover:
   - Estado local deferredPrompt (agora vem do usePWA)
   - Estado local isIOS (agora vem do usePWA)
   - Estado local isStandalone (agora vem do usePWA)
   - Interface BeforeInstallPromptEvent (ja declarada em lib/pwa.tsx)
   - Declare global WindowEventMap (ja declarado em lib/pwa.tsx)
   - Logica de addEventListener('beforeinstallprompt') (ja no provider)
3. Manter:
   - Estado local showPrompt
   - Estado local isWindows (especifico deste componente)
   - Timer de delay para mostrar prompt
   - Logica de dismiss com localStorage
   - Todo o JSX
4. Usar promptInstall() do hook em vez de deferredPrompt.prompt() local
5. Usar isStandalone e isIOS do hook
```

**Resultado esperado:** ~80 linhas removidas, zero mudanca no comportamento visual.

### Validacao Sprint 6:
```bash
npm run build
```

**Criterio de aceite:** Build passa. InstallPrompt funciona identicamente (mesmos delays, mesma UI).

---

## Sprint 7: Testes e Validacao Final

**Objetivo:** Verificar TODOS os cenarios antes de commit.
**Risco:** Nenhum — apenas validacao.

### Script de Validacao:

```bash
# 1. Build completo
npm run build

# 2. Verificar que nao ha erros de TypeScript
# (ignoreBuildErrors: true no next.config, mas bom checar)

# 3. Iniciar servidor de producao
npm run start
# (ou usar o dev: npm run dev)
```

### Checklist de Testes Manuais:

**A. Desktop Browser (Chrome, 1920x1080):**
- [ ] Navbar visivel no topo
- [ ] Logo, links de navegacao, botoes de auth funcionais
- [ ] BottomNav NAO aparece
- [ ] Pagina de download mostra card "Instalar como App"
- [ ] InstallPrompt popup aparece apos delay (se nao dismissado)
- [ ] Todas as paginas carregam com padding correto
- [ ] Dark mode funciona

**B. Mobile Browser (Chrome DevTools, iPhone 14 Pro, 390x844):**
- [ ] Navbar visivel com hamburger menu
- [ ] BottomNav NAO aparece
- [ ] Hamburger menu abre e fecha corretamente
- [ ] Links do menu navegam e fecham o menu
- [ ] Pagina de download mostra card com instrucoes iOS
- [ ] Layout responsivo sem overflow horizontal

**C. PWA Standalone (DevTools > Rendering > display-mode: standalone):**
- [ ] Navbar NAO aparece
- [ ] BottomNav aparece com 5 itens
- [ ] Navegacao entre paginas via BottomNav funciona
- [ ] Pagina de download NAO mostra card "Instalar como App"
- [ ] Conteudo nao fica atras do BottomNav
- [ ] Conteudo comeca no topo da tela (sem espaco da Navbar)

**D. Tauri Desktop (se disponivel):**
- [ ] Sidebar esquerda funciona
- [ ] Navbar escondida
- [ ] BottomNav escondido
- [ ] Zero impacto das mudancas

### Script de Verificacao Automatica:

```bash
# Verificar que nao quebramos nenhum import
grep -r "from '@/lib/pwa'" components/ app/ --include="*.tsx" --include="*.ts"

# Verificar que data-navbar e data-bottomnav estao nos componentes
grep "data-navbar" components/Navbar.tsx
grep "data-bottomnav" components/BottomNav.tsx

# Verificar que PWAProvider esta no layout
grep "PWAProvider" app/layout.tsx

# Verificar que isStandalone esta sendo usado
grep "isStandalone" components/Navbar.tsx components/BottomNav.tsx components/TauriMainWrapper.tsx
```

---

## Ordem de Execucao Recomendada

```
Sprint 1 (lib/pwa.tsx)
    |
    +---> Sprint 2 (Navbar + BottomNav)
    |         |
    |         +---> Sprint 4 (CSS anti-flash)
    |
    +---> Sprint 3 (Layout + TauriMainWrapper)
    |
    +---> Sprint 5 (Download page)
    |
    +---> Sprint 6 (Refatorar InstallPrompt)
    |
    v
Sprint 7 (Testes)
```

**Sprints 2, 3, 5, 6 podem ser executados em paralelo** apos o Sprint 1, pois sao independentes entre si. Porem, para minimizar risco, a ordem sequencial acima e recomendada.

---

## Resumo de Arquivos Modificados

| # | Arquivo | Acao | Sprint |
|---|---------|------|--------|
| 1 | `lib/pwa.tsx` | CRIAR | 1 |
| 2 | `components/Navbar.tsx` | MODIFICAR (4 linhas) | 2 |
| 3 | `components/BottomNav.tsx` | MODIFICAR (5 linhas) | 2 |
| 4 | `app/layout.tsx` | MODIFICAR (5 linhas) | 3 |
| 5 | `components/TauriMainWrapper.tsx` | MODIFICAR (4 linhas) | 3 |
| 6 | `app/globals.css` | ADICIONAR (~20 linhas) | 4 |
| 7 | `app/download/page.tsx` | MODIFICAR (~50 linhas add) | 5 |
| 8 | `components/InstallPrompt.tsx` | REFATORAR (~80 linhas removidas) | 6 |

**Total: 8 arquivos, ~1 novo, ~7 modificados**
**Linhas adicionadas: ~150**
**Linhas removidas: ~80**
**Mudanca liquida: ~70 linhas**

---

## Estrategia de Commit

```bash
# Apos Sprint 1:
git add lib/pwa.tsx
git commit -m "feat(pwa): add usePWA hook and PWAProvider for standalone detection"

# Apos Sprints 2-4:
git add components/Navbar.tsx components/BottomNav.tsx app/layout.tsx components/TauriMainWrapper.tsx app/globals.css
git commit -m "feat(pwa): conditional nav — hide Navbar and show BottomNav in PWA standalone mode"

# Apos Sprints 5-6:
git add app/download/page.tsx components/InstallPrompt.tsx
git commit -m "feat(pwa): add install card on download page and refactor InstallPrompt"

# Push
git push origin master
```

---

## Rollback Plan

Se algo quebrar apos o deploy:

```bash
# Voltar para o commit anterior (df839c4)
git revert HEAD~3..HEAD
git push origin master

# Ou, se necessario, hard reset:
git reset --hard df839c4
git push origin master --force
```

O branch `backup/mobile-work` ainda existe como referencia do trabalho mobile anterior.

---

*Documento criado em 2026-02-06*
*Para ser executado sequencialmente, Sprint por Sprint, com validacao entre cada um.*
