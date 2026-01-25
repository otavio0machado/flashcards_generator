
import fetch from 'node-fetch';

const BASE_URL = 'http://localhost:3000';

async function runTests() {
    console.log('🚀 Iniciando Testes Automatizados da API Demo...\n');
    let passed = 0;
    let failed = 0;

    // --- Helper ---
    async function test(name, fn) {
        try {
            process.stdout.write(`Testing ${name}... `);
            await fn();
            console.log('✅ PASSOU');
            passed++;
        } catch (e) {
            console.log('❌ FALHOU');
            console.error(`   -> ${e.message}`);
            failed++;
        }
    }

    // --- Tests ---

    // 1. Geração Válida
    await test('DEMO-01: Geração válida (>200 chars)', async () => {
        const text = "A Revolução Industrial foi um período de grande desenvolvimento tecnológico que teve início na Inglaterra a partir da segunda metade do século XVIII e que se espalhou pelo mundo, causando grandes transformações. Ela garantiu o surgimento da indústria e consolidou o processo de formação do capitalismo.";

        // O backend exige > 200 chars. O texto acima tem ~270.
        const res = await fetch(`${BASE_URL}/api/demo/generate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ text, language: 'Português' })
        });

        if (res.status !== 200) {
            const data = await res.json().catch(() => ({}));
            throw new Error(`Status ${res.status} !== 200. Error: ${JSON.stringify(data)}`);
        }

        const data = await res.json();
        if (!data.cards || !Array.isArray(data.cards) || data.cards.length === 0) {
            throw new Error('Nenhum flashcard retornado.');
        }
    });

    // 2. Limite Mínimo de Caracteres
    await test('DEMO-02: Texto muito curto (<200 chars)', async () => {
        const res = await fetch(`${BASE_URL}/api/demo/generate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ text: "Texto muito curto.", language: 'Português' })
        });

        if (res.status !== 400) {
            throw new Error(`Deveria falhar com 400, mas retornou ${res.status}`);
        }

        const data = await res.json();
        if (!data.error || !data.error.includes('conteúdo maior')) {
            throw new Error(`Mensagem de erro inesperada: ${JSON.stringify(data)}`);
        }
    });

    // 3. Teste de Segurança (XSS / Prompt Injection)
    await test('DEMO-03: Tentativa de XSS (<script>)', async () => {
        // Texto válido + tentativa de XSS
        const padding = "A segurança da informação é vital para empresas modernas. ".repeat(10); // Garantir > 200 chars
        const malicious = `<script>alert('XSS')</script>`;
        const text = padding + malicious;

        const res = await fetch(`${BASE_URL}/api/demo/generate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ text, language: 'Português' })
        });

        // Pode ser 200 (se sanitizou e gerou) ou 400 (se rejeitou).
        // O importante é o output NÃO conter a tag script executável no JSON.
        const data = await res.json();
        const jsonString = JSON.stringify(data);

        if (jsonString.includes("<script>alert")) {
            throw new Error("🚨 FALHA CRÍTICA: O script injetado foi retornado na resposta da API!");
        }
    });

    // 4. Rate Limiting (Cookie/IP Based)
    await test('DEMO-04: Rate Limiting (2ª requisição imediata)', async () => {
        // Tenta gerar de novo imediatamente
        const text = "A fotossíntese é o processo pelo qual as plantas convertem luz em energia. ".repeat(5);
        const res = await fetch(`${BASE_URL}/api/demo/generate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ text, language: 'Português' })
        });

        // Esperamos 429 Too Many Requests
        if (res.status !== 429) {
            // Nota: Se rodar muito rápido após o teste 1, pode ser que o teste 1 já tenha consumido a cota ou gravado o cookie.
            // O teste 1 pode ter setado o cookie. Como não estamos reenviando o cookie aqui, talvez conte como "novo usuário" se for baseado SÓ em cookie?
            // O código usa 'x-forwarded-for' ou IP real. E cookies.
            // Se o IP for o mesmo (localhost), deve bloquear.
            throw new Error(`Esperado 429, recebeu ${res.status}`);
        }
    });


    console.log('\n------------------------------------------------');
    console.log(`Resumo: ${passed} passaram, ${failed} falharam.`);
    if (failed > 0) process.exit(1);
}

runTests();
