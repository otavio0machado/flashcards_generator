# Task: Remodelagem Mobile e Tablet (Android)

Remodelar totalmente a experiência do aplicativo para dispositivos móveis e tablets, focando em ergonomia, navegação nativa e layouts adaptáveis.

## 1. Análise e Objetivos
O aplicativo atual funciona bem em desktop, mas em dispositivos móveis a interface de geração e a navegação lateral não são ideais. O objetivo é criar uma experiência "Mobile-First" premium.

### Decisões de Design (Socratic Approval)
- **Navegação**: Bottom Navigation Bar para celulares (já existente, mas precisa ser refinada).
- **Entrada de Dados**: Focar na facilidade de colar texto e gerir arquivos em telas pequenas.
- **Tablet**: Layout Master-Detail (Dual Pane) para aproveitar o espaço horizontal.
- **Recursos Nativos**: Preparar UI para OCR/Câmera.

## 2. Plano de Implementação

### Fase 1: Refinamento da Navegação
- [x] Atualizar `components/BottomNav.tsx` para garantir que tenha um visual "Premium" (Blur, animações suaves).
- [x] Garantir que a `BottomNav` apareça corretamente no Android (Tauri).
- [x] Verificar breakpoints no `app/layout.tsx` para esconder/mostrar Sidebar e Navbar corretamente.

### Fase 2: Responsividade do Gerador (`app/app/generator-client.tsx`)
- [x] Criar uma version "Mobile" das configurações de geração (Idioma, Dificuldade, Estilo de Card).
- [x] Usar "Bottom Sheets" ou Modais de tela cheia para configurações em celulares.
- [x] Otimizar o editor de cards para touch (aumentar touch targets).

### Fase 3: Layout para Tablets
- [ ] Implementar breakpoint para tablets (ex: `lg:`) que utiliza layout de duas colunas.
- [ ] Coluna 1: Lista de cards gerados / Configurações.
- [ ] Coluna 2: Preview do card selecionado / Editor.

### Fase 4: Recursos Mobile
- [ ] Adicionar botão de "Câmera/OCR" na interface mobile (Placeholder funcional).
- [ ] Implementar feedbacks táteis (vibração via plugin Tauri OS/Notification se possível).

## 3. Critérios de Aceitação
- [ ] O app funciona perfeitamente no emulador Android com navegação inferior.
- [ ] Em telas de tablet (horizontal), o layout muda para dual-pane.
- [ ] Não há "overflow" horizontal em telas pequenas.
- [ ] A navegação é fluida e segue padrões de UX mobile.

## 4. Verificação
- [ ] Executar `npm run tauri:android:dev` e validar no emulador.
- [ ] Testar em diferentes tamanhos de tela no Chrome DevTools (Responsive mode).
- [ ] Validar se as configurações de geração são acessíveis via bottom sheet em telas pequenas.
