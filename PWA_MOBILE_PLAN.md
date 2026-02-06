# Plano Completo: Adaptacao PWA Mobile/Tablet

## Indice

1. [Visao Geral e Estrategia](#1-visao-geral-e-estrategia)
2. [Auditoria do Estado Atual](#2-auditoria-do-estado-atual)
3. [Arquitetura da Solucao](#3-arquitetura-da-solucao)
4. [Detalhamento Tecnico por Componente](#4-detalhamento-tecnico-por-componente)
5. [Fluxos de Usuario](#5-fluxos-de-usuario)
6. [Matriz de Comportamento](#6-matriz-de-comportamento)
7. [Riscos e Mitigacoes](#7-riscos-e-mitigacoes)
8. [Criterios de Aceite](#8-criterios-de-aceite)

---

## 1. Visao Geral e Estrategia

### Problema
O site precisa funcionar bem em mobile/tablet sem quebrar a experiencia desktop. Tentativas anteriores de usar User-Agent para detectar dispositivos causaram problemas graves (MobileShell engolindo o desktop, falsos positivos em iPads/MacBooks, etc.).

### Solucao: PWA com Display Mode Detection
Em vez de detectar o DISPOSITIVO, detectamos o CONTEXTO:

| Contexto | Como detectar | Experiencia |
|----------|---------------|-------------|
| Desktop web (browser) | `!standalone && !isTauri && md:` | Navbar topo + layout responsivo normal |
| Mobile/tablet web (browser) | `!standalone && !isTauri && <md` | Navbar topo (hamburger) + layout responsivo normal |
| PWA instalada (standalone) | `display-mode: standalone` | Bottom nav + sem navbar topo = experiencia de app |
| Tauri desktop | `__TAURI__` + isDesktop | Sidebar esquerda (ja funciona) |

### Principio Fundamental
> **O browser (desktop ou mobile) usa SEMPRE a mesma navegacao: Navbar no topo.**
> **Apenas quando o usuario INSTALA o PWA (adiciona na tela inicial), a experiencia muda para app-like com bottom bar.**

Isso evita completamente os problemas anteriores porque:
- Nao depende de User-Agent (sem falsos positivos)
- `display-mode: standalone` e 100% confiavel
- O usuario ESCOLHE quando quer a experiencia de app
- Zero risco de quebrar o desktop

---

## 2. Auditoria do Estado Atual

### Infraestrutura PWA ja existente
| Item | Status | Arquivo |
|------|--------|---------|
| manifest.json | OK | `public/manifest.json` - display: standalone, icons, shortcuts |
| Service Worker (Workbox) | OK | `next.config.ts` - @ducanh2912/next-pwa com caching |
| Offline page | OK | `app/offline/page.tsx` |
| OfflineIndicator | OK | `components/OfflineIndicator.tsx` |
| InstallPrompt (popup) | PARCIAL | `components/InstallPrompt.tsx` - ja detecta standalone e beforeinstallprompt |
| Pagina de download | OK | `app/download/page.tsx` - cards por plataforma |

### Componentes de Navegacao
| Componente | Estado Atual | Precisa Mudar? |
|------------|-------------|----------------|
| Navbar.tsx | Visivel em tudo exceto Tauri desktop | SIM - esconder tambem em PWA standalone |
| BottomNav.tsx | Visivel em `<md` (todos mobile) | SIM - visivel APENAS em PWA standalone |
| DesktopSidebar.tsx | Visivel apenas em Tauri desktop | NAO |
| TauriMainWrapper.tsx | Margem para sidebar Tauri | SIM - precisa de padding para standalone |

### Arquivos que NAO serao alterados
| Arquivo | Motivo |
|---------|--------|
| `lib/tauri.tsx` | Funciona perfeitamente para Tauri |
| `DesktopSidebar.tsx` | Funciona perfeitamente para Tauri desktop |
| `next.config.ts` | PWA ja configurado corretamente |
| `public/manifest.json` | Ja tem display: standalone |
| `OfflineIndicator.tsx` | Funciona independentemente |
| `app/globals.css` | Apenas adicoes opcionais de CSS |

---

## 3. Arquitetura da Solucao

### 3.1 Novo Hook: `usePWA()`

**Arquivo:** `lib/pwa.tsx`

**Responsabilidades:**
1. Detectar se esta rodando em `display-mode: standalone` (PWA instalada)
2. Capturar e armazenar o evento `beforeinstallprompt`
3. Expor funcao `promptInstall()` para botao de instalacao
4. Detectar plataforma (iOS vs Android/Chrome) para instrucoes corretas
5. Monitorar mudancas de display mode em tempo real

**Interface:**
```typescript
interface PWAContextType {
    isStandalone: boolean;       // true = PWA instalada, rodando fullscreen
    isInstallable: boolean;      // true = browser suporta instalacao (beforeinstallprompt disparou)
    isIOS: boolean;              // true = precisa de instrucoes manuais
    promptInstall: () => Promise<'accepted' | 'dismissed' | 'unavailable'>;
}
```

**Deteccao de standalone (3 metodos, cobrem todos os browsers):**
```typescript
// 1. CSS media query (Chrome, Edge, Firefox, Samsung)
window.matchMedia('(display-mode: standalone)').matches

// 2. navigator.standalone (Safari iOS)
(navigator as any).standalone === true

// 3. Listener de mudanca (caso mude durante sessao)
window.matchMedia('(display-mode: standalone)').addEventListener('change', ...)
```

**Diagrama de fluxo:**
```
App carrega
    |
    v
usePWA() inicializa
    |
    +---> Checa display-mode: standalone?
    |     |
    |     +-- SIM --> isStandalone = true (experiencia de app)
    |     |
    |     +-- NAO --> isStandalone = false (experiencia de browser)
    |
    +---> Escuta evento 'beforeinstallprompt'
    |     |
    |     +-- Disparou --> isInstallable = true, guarda deferredPrompt
    |     |
    |     +-- Nao disparou --> isInstallable = false
    |
    +---> Checa plataforma iOS
          |
          +-- iOS --> isIOS = true (instrucoes manuais)
          |
          +-- Outro --> isIOS = false
```

### 3.2 Provider PWA

**Arquivo:** `lib/pwa.tsx` (mesmo arquivo do hook)

O `PWAProvider` sera adicionado ao `app/layout.tsx` DENTRO do `TauriProvider`, para que ambos os contextos estejam disponiveis.

**Hierarquia de providers:**
```
<TauriProvider>
    <PWAProvider>
        <Navbar />           // usa usePWA() para se esconder
        <DesktopSidebar />   // usa useTauri() apenas
        <TauriMainWrapper>   // usa ambos
            {children}
        </TauriMainWrapper>
        <BottomNav />        // usa usePWA() para se mostrar
    </PWAProvider>
</TauriProvider>
```

### 3.3 Logica Condicional dos Componentes

```
Navbar.tsx:
  if (isTauri && isDesktop) return null;    // Tauri desktop -> sidebar
  if (isStandalone) return null;            // PWA instalada -> bottom nav
  return <nav>...</nav>;                    // Browser (qualquer tamanho) -> navbar

BottomNav.tsx:
  if (!isStandalone) return null;           // Browser -> sem bottom nav
  if (pathname em /auth/*) return null;     // Auth pages -> sem bottom nav
  return <nav>...</nav>;                    // PWA standalone -> bottom nav

TauriMainWrapper.tsx:
  // Margem esquerda para Tauri sidebar (ja existe)
  // Padding bottom para PWA bottom nav (NOVO)
  // Padding top para browser navbar (ja existe via body class)

app/layout.tsx <body>:
  // pt-16 -> espaço para navbar fixa (browser)
  // pb-20 md:pb-0 -> MUDAR para pb-0 sempre no browser
  // PWA standalone: pt-0, pb-[env(safe-area)] + bottom nav height
```

---

## 4. Detalhamento Tecnico por Componente

### 4.1 `lib/pwa.tsx` (NOVO)

```typescript
// === ESTRUTURA COMPLETA ===

'use client';

import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';

// Tipagem do evento beforeinstallprompt
interface BeforeInstallPromptEvent extends Event {
    readonly platforms: string[];
    readonly userChoice: Promise<{ outcome: 'accepted' | 'dismissed'; platform: string }>;
    prompt(): Promise<void>;
}

// Interface do contexto
interface PWAContextType {
    isStandalone: boolean;
    isInstallable: boolean;
    isIOS: boolean;
    promptInstall: () => Promise<'accepted' | 'dismissed' | 'unavailable'>;
}

// Contexto com defaults seguros
const PWAContext = createContext<PWAContextType>({
    isStandalone: false,
    isInstallable: false,
    isIOS: false,
    promptInstall: async () => 'unavailable',
});

// Provider
export function PWAProvider({ children }: { children: ReactNode }) {
    const [isStandalone, setIsStandalone] = useState(false);
    const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null);
    const [isIOS, setIsIOS] = useState(false);

    useEffect(() => {
        // --- Detectar standalone ---
        const mqStandalone = window.matchMedia('(display-mode: standalone)');
        const navStandalone = (navigator as any).standalone === true;
        setIsStandalone(mqStandalone.matches || navStandalone);

        // Listener para mudancas (raro, mas cobre edge cases)
        const handleChange = (e: MediaQueryListEvent) => setIsStandalone(e.matches);
        mqStandalone.addEventListener('change', handleChange);

        // --- Detectar iOS ---
        const ua = navigator.userAgent;
        setIsIOS(/iPad|iPhone|iPod/.test(ua) && !(window as any).MSStream);

        // --- Capturar beforeinstallprompt ---
        const handleBIP = (e: Event) => {
            e.preventDefault();
            setDeferredPrompt(e as BeforeInstallPromptEvent);
        };
        window.addEventListener('beforeinstallprompt', handleBIP);

        return () => {
            mqStandalone.removeEventListener('change', handleChange);
            window.removeEventListener('beforeinstallprompt', handleBIP);
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

// Hook
export function usePWA() {
    return useContext(PWAContext);
}
```

**Pontos criticos:**
- `useState(false)` para `isStandalone`: evita flash de conteudo no SSR/hydration
- `e.preventDefault()` no `beforeinstallprompt`: OBRIGATORIO para poder chamar `.prompt()` depois
- `useCallback` no `promptInstall`: evita re-renders desnecessarios nos consumers
- Cleanup nos listeners: evita memory leaks

---

### 4.2 `components/Navbar.tsx` (MODIFICAR)

**Mudanca:** Adicionar uma unica linha de condicao.

```typescript
// ANTES (linha 20):
const { isTauri, isDesktop } = useTauri();

// DEPOIS:
const { isTauri, isDesktop } = useTauri();
const { isStandalone } = usePWA();

// ANTES (linhas 122-125):
if (isTauri && isDesktop) {
    return null;
}

// DEPOIS:
if ((isTauri && isDesktop) || isStandalone) {
    return null;
}
```

**Import adicional:**
```typescript
import { usePWA } from '@/lib/pwa';
```

**Impacto:** ZERO no desktop. A Navbar so desaparece quando `isStandalone === true`, que so acontece dentro de PWA instalada.

---

### 4.3 `components/BottomNav.tsx` (MODIFICAR)

**Mudanca:** Trocar `md:hidden` por condicional baseada em `isStandalone`.

```typescript
// ANTES:
export default function BottomNav() {
    const pathname = usePathname();

    if (pathname?.startsWith('/auth')) {
        return null;
    }

    return (
        <nav className="fixed bottom-0 left-0 right-0 z-50 md:hidden">
            ...
        </nav>
    );
}

// DEPOIS:
import { usePWA } from '@/lib/pwa';

export default function BottomNav() {
    const pathname = usePathname();
    const { isStandalone } = usePWA();

    // Apenas mostrar em PWA standalone
    if (!isStandalone) return null;
    if (pathname?.startsWith('/auth')) return null;

    return (
        <nav className="fixed bottom-0 left-0 right-0 z-50">
            ...
        </nav>
    );
}
```

**Mudancas detalhadas:**
1. Remover `md:hidden` da classe do `<nav>` (nao precisa mais — o JS ja controla)
2. Adicionar `if (!isStandalone) return null;` como primeira condicao
3. Importar `usePWA`

**Impacto:** BottomNav NUNCA aparece no browser (desktop ou mobile). So aparece quando o usuario instala o PWA.

---

### 4.4 `app/layout.tsx` (MODIFICAR)

**Mudanca 1:** Adicionar `PWAProvider` na hierarquia

```typescript
// ANTES:
import { TauriProvider } from "@/lib/tauri";

// DEPOIS:
import { TauriProvider } from "@/lib/tauri";
import { PWAProvider } from "@/lib/pwa";

// ANTES (hierarquia):
<TauriProvider>
    <Navbar />
    ...
    <BottomNav />
</TauriProvider>

// DEPOIS:
<TauriProvider>
    <PWAProvider>
        <Navbar />
        ...
        <BottomNav />
    </PWAProvider>
</TauriProvider>
```

**Mudanca 2:** Ajustar body padding

```typescript
// ANTES:
className={`... pt-16 pb-20 md:pb-0`}

// DEPOIS:
className={`... pt-16 pb-0`}
```

**Explicacao:** `pb-20` era para dar espaco ao BottomNav em mobile browser. Agora o BottomNav so aparece em PWA standalone, e o padding sera gerenciado pelo `TauriMainWrapper`. No browser (desktop ou mobile), `pb-0` e correto.

---

### 4.5 `components/TauriMainWrapper.tsx` (MODIFICAR)

**Mudanca:** Adicionar padding condicional para PWA standalone.

```typescript
// ANTES:
import { useTauri } from '@/lib/tauri';

export default function TauriMainWrapper({ children }: TauriMainWrapperProps) {
    const { isTauri, isDesktop, sidebarCollapsed } = useTauri();
    const needsMargin = isTauri && isDesktop && !isOnboardingPage;

    return (
        <main className={`min-h-screen transition-[margin-left] ... ${
            needsMargin ? sidebarCollapsed ? 'ml-16' : 'ml-64' : ''
        } ${isTauri ? 'desktop-density' : ''}`}>
            {children}
        </main>
    );
}

// DEPOIS:
import { useTauri } from '@/lib/tauri';
import { usePWA } from '@/lib/pwa';

export default function TauriMainWrapper({ children }: TauriMainWrapperProps) {
    const { isTauri, isDesktop, sidebarCollapsed } = useTauri();
    const { isStandalone } = usePWA();
    const needsMargin = isTauri && isDesktop && !isOnboardingPage;

    return (
        <main className={`min-h-screen transition-[margin-left] ... ${
            needsMargin ? sidebarCollapsed ? 'ml-16' : 'ml-64' : ''
        } ${isTauri ? 'desktop-density' : ''} ${
            isStandalone ? 'pt-0 pb-20' : ''
        }`}>
            {children}
        </main>
    );
}
```

**Explicacao:**
- `pt-0`: Em PWA standalone, nao tem Navbar, entao remove o top padding (o `pt-16` do body fica sobrescrito)
- `pb-20`: Em PWA standalone, o BottomNav ocupa ~80px na parte inferior, entao precisa de padding

**Nota:** A classe `pt-0` funciona porque tem especificidade maior quando aplicada ao `<main>` vs a classe `pt-16` do `<body>`. Mas para evitar conflitos, vamos usar uma abordagem alternativa no body — ver secao de CSS.

---

### 4.6 `app/globals.css` (ADICIONAR)

Adicionar regras CSS para PWA standalone, usando `@media (display-mode: standalone)`:

```css
/* === PWA Standalone Mode === */
@media (display-mode: standalone) {
    body {
        padding-top: env(safe-area-inset-top, 0px) !important;
        padding-bottom: 0 !important;
    }
}
```

**Vantagem do CSS:** Aplica ANTES do JavaScript hidratar, evitando flash. O JS (usePWA) cuida da logica dos componentes React, mas o CSS cuida do layout basico instantaneamente.

---

### 4.7 `app/download/page.tsx` (MODIFICAR)

**Mudanca:** Adicionar card "Instalar como App" na secao de plataformas.

**Novo card PWA (inserido ANTES dos cards existentes quando em mobile):**

```typescript
import { usePWA } from '@/lib/pwa';

// Dentro do componente:
const { isStandalone, isInstallable, isIOS, promptInstall } = usePWA();

// Nova secao entre o hero e os cards de download:
{!isStandalone && (
    <div className="mb-8 p-6 rounded-xl border-2 border-brand bg-brand/5">
        <div className="flex flex-col items-center text-center">
            <div className="w-14 h-14 bg-brand text-white rounded-2xl flex items-center justify-center mb-4">
                <Smartphone className="w-7 h-7" />
            </div>
            <h3 className="text-xl font-bold text-foreground mb-2">
                Instalar como App
            </h3>
            <p className="text-sm text-[var(--color-text-secondary)] mb-4 max-w-md">
                Adicione o Flashcards Generator na sua tela inicial.
                Acesse offline, carregamento instantaneo, sem ocupar espaco.
            </p>

            {isInstallable ? (
                // Android/Chrome: botao nativo
                <button
                    onClick={async () => {
                        const result = await promptInstall();
                        trackEvent('pwa_install_download_page', { result });
                    }}
                    className="inline-flex items-center gap-2 px-6 py-3 bg-brand text-white font-bold rounded-lg hover:bg-brand/90 transition-colors shadow-lg shadow-brand/20"
                >
                    <Download className="w-5 h-5" />
                    Instalar Agora
                </button>
            ) : isIOS ? (
                // iOS: instrucoes
                <div className="space-y-3 text-left max-w-sm">
                    <p className="text-sm font-medium text-foreground/70">
                        No Safari, siga estes passos:
                    </p>
                    <ol className="text-sm text-foreground/60 space-y-2">
                        <li>1. Toque no icone de compartilhar (quadrado com seta)</li>
                        <li>2. Role e toque em "Adicionar a Tela de Inicio"</li>
                        <li>3. Toque em "Adicionar"</li>
                    </ol>
                </div>
            ) : (
                // Fallback: link para abrir no Chrome
                <p className="text-sm text-foreground/50">
                    Abra no Chrome ou Safari para instalar como app.
                </p>
            )}

            <div className="flex gap-4 mt-4 text-xs text-foreground/40">
                <span>Sem download pesado</span>
                <span>Funciona offline</span>
                <span>Sempre atualizado</span>
            </div>
        </div>
    </div>
)}
```

**Posicionamento:** Este card aparece ACIMA dos cards de plataforma (Windows, macOS, etc.), destacado com borda brand e fundo brand/5.

**Logica:**
- Se ja esta em standalone -> nao mostra (ja instalou)
- Se `isInstallable` (Chrome/Edge/Samsung) -> botao que chama `promptInstall()`
- Se iOS -> instrucoes visuais
- Se nenhum dos dois -> mensagem para abrir em Chrome/Safari

---

### 4.8 `components/InstallPrompt.tsx` (MODIFICAR)

**Mudanca:** Refatorar para usar `usePWA()` em vez de logica propria.

```typescript
// ANTES: toda a logica de deteccao estava duplicada aqui
// DEPOIS: usa usePWA() e fica muito mais simples

import { usePWA } from '@/lib/pwa';

export default function InstallPrompt() {
    const { isStandalone, isInstallable, isIOS, promptInstall } = usePWA();
    const [showPrompt, setShowPrompt] = useState(false);
    const [isWindows, setIsWindows] = useState(false);

    useEffect(() => {
        if (isStandalone) return; // Ja instalado

        const ua = navigator.userAgent.toLowerCase();
        const windows = ua.includes('windows');
        setIsWindows(windows);

        const dismissed = localStorage.getItem('pwa-prompt-dismissed');
        const dismissedAt = dismissed ? parseInt(dismissed, 10) : 0;
        const daysSinceDismissed = (Date.now() - dismissedAt) / (1000 * 60 * 60 * 24);
        if (dismissed && daysSinceDismissed < 7) return;

        // Temporizador para mostrar prompt
        const delay = windows ? 15000 : isIOS ? 60000 : 30000;
        const timer = setTimeout(() => setShowPrompt(true), delay);

        return () => clearTimeout(timer);
    }, [isStandalone, isIOS]);

    // ... resto do JSX permanece similar, mas usa promptInstall() do hook
}
```

**Beneficio:** Remove 40+ linhas de logica duplicada. A deteccao fica centralizada no `usePWA()`.

---

## 5. Fluxos de Usuario

### 5.1 Usuario acessa pelo celular (browser)
```
1. Abre flashcardsgenerator.com.br no Chrome/Safari
2. Ve a Navbar no topo (igual desktop, mas com hamburger menu)
3. Navega normalmente pelo site
4. Apos 30s, ve o InstallPrompt sugerindo instalar
5. Se clicar "Instalar" -> prompt nativo do Chrome
6. Se ignorar -> continua usando normalmente no browser
```

### 5.2 Usuario instala PWA (Android)
```
1. Clica "Instalar" no InstallPrompt ou na pagina de Download
2. Chrome mostra dialog nativo "Adicionar a tela inicial"
3. Confirma -> icone aparece na home screen
4. Abre o app pela home screen
5. display-mode: standalone ativado
6. Navbar desaparece, BottomNav aparece
7. Experiencia de app nativo
```

### 5.3 Usuario instala PWA (iOS)
```
1. Ve instrucoes no InstallPrompt ou na pagina de Download
2. Toca Compartilhar > "Adicionar a Tela de Inicio"
3. Confirma -> icone aparece na home screen
4. Abre o app pela home screen
5. navigator.standalone === true
6. Navbar desaparece, BottomNav aparece
7. Experiencia de app nativo
```

### 5.4 Usuario acessa pelo desktop (browser)
```
1. Abre flashcardsgenerator.com.br no Chrome
2. Ve a Navbar no topo (experiencia completa)
3. Nenhum BottomNav visivel (nem em tela pequena!)
4. InstallPrompt pode mostrar sugestao de download .exe (Windows)
5. Tudo funciona exatamente como antes
```

### 5.5 Usuario usa Tauri desktop
```
1. Abre o app Tauri
2. __TAURI__ detectado, isDesktop = true
3. Navbar escondida, DesktopSidebar visivel
4. usePWA().isStandalone = false (nao e PWA)
5. BottomNav escondido
6. Tudo funciona exatamente como antes
```

---

## 6. Matriz de Comportamento

| Componente | Desktop Browser | Mobile Browser | PWA Standalone | Tauri Desktop |
|------------|----------------|----------------|----------------|---------------|
| Navbar | VISIVEL | VISIVEL (hamburger) | ESCONDIDA | ESCONDIDA |
| BottomNav | ESCONDIDO | ESCONDIDO | VISIVEL | ESCONDIDO |
| DesktopSidebar | ESCONDIDO | ESCONDIDO | ESCONDIDO | VISIVEL |
| body pt-16 | SIM (Navbar) | SIM (Navbar) | NAO (sem Navbar) | NAO (sidebar) |
| body pb-20 | NAO | NAO | SIM (BottomNav) | NAO |
| Safe area top | NAO | NAO | SIM (notch iOS) | NAO |
| Safe area bottom | NAO | NAO | SIM (home indicator) | NAO |
| InstallPrompt popup | Download .exe | PWA install | NAO (ja instalou) | NAO |
| Download page PWA card | VISIVEL | VISIVEL | ESCONDIDO | ESCONDIDO |

---

## 7. Riscos e Mitigacoes

### Risco 1: Flash de layout no PWA (FOUC)
**Problema:** React hidrata com `isStandalone = false`, depois atualiza para `true`. Pode causar flash da Navbar por ~100ms.
**Mitigacao:** Usar CSS `@media (display-mode: standalone)` para esconder a Navbar instantaneamente, ANTES do JS:
```css
@media (display-mode: standalone) {
    /* Esconde navbar antes do React hidratar */
    [data-navbar] { display: none !important; }
    /* Mostra bottom nav antes do React hidratar */
    [data-bottomnav] { display: flex !important; }
}
```
Isso e aplicado pelo browser instantaneamente, sem esperar JavaScript.

### Risco 2: iOS Safari nao suporta beforeinstallprompt
**Problema:** Safari nunca dispara `beforeinstallprompt`. O usuario precisa de instrucoes manuais.
**Mitigacao:** `usePWA().isIOS` detecta isso e mostra instrucoes visuais (ja implementado no InstallPrompt.tsx).

### Risco 3: Quebrar o desktop web
**Problema:** Historico de bugs ao mexer em navegacao.
**Mitigacao:**
- `usePWA().isStandalone` e `false` por padrao -> NADA muda ate que o usuario instale PWA
- Desktop web nao e afetado por NENHUMA das mudancas
- Nenhum arquivo critico (Navbar, BottomNav) muda comportamento no desktop

### Risco 4: Service Worker cacheando versao antiga
**Problema:** Apos deploy, o SW pode servir HTML/JS antigo.
**Mitigacao:** Ja configurado `skipWaiting: true` e `clientsClaim: true` no next.config.ts. O SW se atualiza automaticamente.

### Risco 5: PWA em tablet landscape
**Problema:** BottomNav pode parecer estranho em tablet landscape (tela larga).
**Mitigacao:** O BottomNav ja tem design responsivo. Em landscape, os icones ficam mais espacados. Aceitavel para MVP. Pode ser refinado depois.

---

## 8. Criterios de Aceite

### Desktop Web
- [ ] Navbar visivel e funcional
- [ ] BottomNav NUNCA aparece
- [ ] Layout identico ao commit df839c4
- [ ] Pagina de download mostra card "Instalar como App"
- [ ] `npm run build` sem erros

### Mobile Web (Browser)
- [ ] Navbar visivel com hamburger menu
- [ ] BottomNav NUNCA aparece
- [ ] Layout responsivo funcional
- [ ] InstallPrompt aparece apos delay
- [ ] Pagina de download mostra instrucoes iOS ou botao Android

### PWA Standalone
- [ ] Navbar NUNCA aparece
- [ ] BottomNav visivel com 5 itens
- [ ] Safe area respeitada (notch, home indicator)
- [ ] Navegacao funcional entre todas as paginas
- [ ] Sem flash de Navbar ao abrir

### Tauri Desktop
- [ ] Sidebar visivel (sem mudancas)
- [ ] Navbar escondida (sem mudancas)
- [ ] BottomNav escondido (sem mudancas)
- [ ] Zero impacto das mudancas PWA

---

*Documento criado em 2026-02-06*
*Base: commit df839c4b19a8f2367b7f4d60fcb472b8c973d48f*
