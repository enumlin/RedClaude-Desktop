# FASE: RED TEAM (módulo sob demanda)

Carregado quando: necessidade de C2, phishing, ou captura de sessão AiTM.

## Gates
```
acesso persistente longo prazo  → Sliver (modular)
evasão avançada de EDR          → Havoc
initial access via email        → GoPhish (campanha)
alvo com MFA                    → Evilginx3 (AiTM, captura de sessão/token)
SPF ausente (vindo de recon)    → spoof direto no phishing
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| C2 persistente e modular | `cybersecurity-skills:building-c2-infrastructure-with-sliver-framework` |
| C2 com evasão de EDR | `cybersecurity-skills:building-red-team-c2-infrastructure-with-havoc` |
| Phishing por email | `cybersecurity-skills:performing-red-team-phishing-with-gophish` |
| MFA, captura de sessão AiTM | `cybersecurity-skills:performing-initial-access-with-evilginx3` |
