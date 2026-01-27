# Build do Aplicativo Desktop - Flashcards Generator

## Pré-requisitos

### Windows
- Node.js 18+
- Rust (via rustup)
- Microsoft Visual Studio C++ Build Tools
- WebView2 (já incluso no Windows 11)

### macOS
- Node.js 18+
- Rust (via rustup)
- Xcode Command Line Tools

## Scripts Disponíveis

```bash
# Desenvolvimento local (usa localhost:3000)
npm run tauri:dev

# Build de produção (todas as plataformas)
npm run tauri:build:prod

# Build específico para Windows
npm run tauri:build:windows

# Build específico para macOS
npm run tauri:build:mac
```

## Arquivos de Saída

Após o build, os instaladores estarão em:

- **Windows**: `src-tauri/target/release/bundle/msi/` e `src-tauri/target/release/bundle/nsis/`
- **macOS**: `src-tauri/target/release/bundle/dmg/` e `src-tauri/target/release/bundle/macos/`
- **Linux**: `src-tauri/target/release/bundle/appimage/` e `src-tauri/target/release/bundle/deb/`

## Fluxo de Build para Produção

1. **Certifique-se que o site está online** em `www.flashcards-generator.com`

2. **Gere os ícones** (se necessário):
   ```bash
   npm run tauri:icons
   ```

3. **Execute o build de produção**:
   ```bash
   npm run tauri:build:prod
   ```

4. **Colete os instaladores** da pasta `src-tauri/target/release/bundle/`

## Configuração

### Desenvolvimento (tauri.conf.json)
- `devUrl`: Aponta para `http://localhost:3000/desktop/welcome`
- Usado com `npm run tauri:dev`

### Produção (tauri.conf.prod.json)
- `frontendDist`: Aponta para `https://www.flashcards-generator.com/desktop/welcome`
- O app carrega diretamente do site em produção
- Usado com `npm run tauri:build:prod`

## Fluxo do Aplicativo

1. **Primeira execução**: Usuário vê o onboarding (welcome → features → plans → login)
2. **Após login**: Flag `desktop_onboarding_complete` é salva no localStorage
3. **Próximas execuções**: Se logado e onboarding completo, vai direto para `/app`

## Testando Localmente

```bash
# Terminal 1 - Inicie o servidor Next.js
npm run dev

# Terminal 2 - Inicie o Tauri
npm run tauri:dev
```

## Assinatura de Código

### Windows
Para assinar o instalador Windows, configure no `tauri.conf.prod.json`:
```json
"windows": {
  "certificateThumbprint": "SEU_THUMBPRINT",
  "digestAlgorithm": "sha256",
  "timestampUrl": "http://timestamp.digicert.com"
}
```

### macOS
Para assinar o app macOS, configure:
```json
"macOS": {
  "signingIdentity": "Developer ID Application: Seu Nome (TEAM_ID)"
}
```

## Versão Atual

- **Versão**: 1.0.0
- **Identifier**: com.flashcards-generator.app
- **Categoria**: Education
