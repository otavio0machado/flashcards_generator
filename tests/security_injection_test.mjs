
const BASE_URL = 'http://localhost:3000';

async function runInjectionTest() {
    console.log('🧪 Iniciando Teste de Injeção de Código (XSS)\n');

    const fingerprint = 'test-security-' + Date.now();

    // Payload > 200 chars
    const longText = "A Revolução Industrial foi um período de grande avanço tecnológico que começou na Grã-Bretanha em meados do século XVIII e se espalhou para outras partes do mundo. Durante esse tempo, a sociedade rural e agrária tornou-se industrial e urbana. " +
        "Mas o que acontece se eu inserir isto: <script>alert('XSS_PAYLOAD')</script> e também <img src=x onerror=alert(1)>? Será que a IA ignora? " +
        "Vamos adicionar mais texto para garantir que passamos do limite de 200 caracteres exigido pela API de demonstração. " +
        "Isso é um teste de segurança autorizado para verificar a robustez do sistema contra injeção de código.";

    const payload = {
        text: longText,
        language: "Português",
        difficulty: "Intermediário",
        studyLevel: "ENEM",
        studyGoal: "Memorizar",
        templateType: "resumo"
    };

    console.log('Sending payload with HTML tags (Length: ' + longText.length + ')...');
    try {
        const randomIp = Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255);

        const res = await fetch(`${BASE_URL}/api/demo/generate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-demo-fingerprint': fingerprint,
                'X-Forwarded-For': randomIp // Bypass IP Rate Limit
            },
            body: JSON.stringify(payload)
        });

        if (res.status === 200) {
            const data = await res.json();
            console.log('Response received.');
            const strData = JSON.stringify(data);

            if (strData.includes("XSS_PAYLOAD") || strData.includes("onerror")) {
                console.log('⚠️  VULNERABILITY FOUND: Payload returned unsanitized in JSON response.');
                console.log('   (This is risky if the frontend renders this JSON improperly)');
                console.log('   Snippet:', strData.substring(0, 300));
            } else {
                console.log('✅ Payload check: Input seems sanitized or safely handled by IA.');
                console.log('   Response does NOT contain the script tags verbatim.');
            }
        } else {
            console.error(`❌ Request failed: Status ${res.status}`);
            console.log(await res.text());
        }
    } catch (e) {
        console.error('❌ Erro de conexão:', e.message);
    }
}

runInjectionTest();
