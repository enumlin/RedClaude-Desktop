# FASE: EXPLORAÇÃO WEB + API (módulo sob demanda)

Carregado quando: 80/443, app HTTP, URL, ou superfície de API.

## Gates — pós-WEB (sinal no endpoint)
```
input refletido   → XSS (dalfox)
ID numérico        → IDOR
parâmetro de path  → path traversal
XML no body        → XXE
template render    → SSTI ({{7*7}})
URL externa        → SSRF (interactsh)
JSON de objeto     → mass assignment
JWT no header/cookie → §API JWT
```

## §SQLi
```
erro com '   → skill manual (confirmar)
delay sleep(5) → sqlmap --technique=T -u <url> -p <param>
sqlmap confirma → --dbs → --tables → --dump
DBA/root     → --os-shell → RCE
```

## §XSS
```
stored + sem HttpOnly → session hijack (CRÍTICA)
reflected + sem CSP   → exfil de cookie direto
CSP ativa             → bypass (JSONP, CDN, unsafe-eval)
```

## §SSRF (cross-phase!)
```
169.254.169.254 acessível → Read phases/cloud.md (IAM AWS imediato)
metadata GCP/Azure        → Read phases/cloud.md (token de serviço)
rede interna acessível    → SSRF como proxy de scan interno → enxertar branches
```

## §WAF (gatilho de sensibilidade — recarregar se saiu do contexto)
```
payload bloqueado → wafw00f identificar
→ skill WAF bypass
→ encodings progressivos: URL double → Unicode → HTML entities → case variation
```

## §API
```
JWT none não testado     → none-algorithm
JWT RS256/ES256          → confusion HS256 (jwt_tool -X k)
OAuth redirect/state      → oauth-misconfiguration
GraphQL sem schema       → introspection + graphql-security
REST IDs previsíveis      → BOLA
sem doc, params ocultos   → fuzzing (arjun/ffuf)
```

## Skill → Estado de Entrada — WEB
| Estado de entrada | Skill |
|---|---|
| Suspeita de SQLi, confirmando | `cybersecurity-skills:exploiting-sql-injection-vulnerabilities` |
| SQLi confirmado, extrair | `cybersecurity-skills:exploiting-sql-injection-with-sqlmap` |
| Pontos de reflexão XSS | `cybersecurity-skills:testing-for-xss-vulnerabilities` |
| Tráfego no Burp, explorar XSS | `cybersecurity-skills:testing-for-xss-vulnerabilities-with-burpsuite` |
| Parâmetro requisição externa | `cybersecurity-skills:exploiting-server-side-request-forgery` |
| SSRF sem resposta direta | `cybersecurity-skills:performing-blind-ssrf-exploitation` |
| Objetos por ID | `cybersecurity-skills:exploiting-idor-vulnerabilities` |
| Processa XML do usuário | `cybersecurity-skills:testing-for-xxe-injection-vulnerabilities` |
| Template engine identificada | `cybersecurity-skills:exploiting-template-injection-vulnerabilities` |
| Parsers HTTP diferentes | `cybersecurity-skills:exploiting-http-request-smuggling` |
| Desserializa objetos | `cybersecurity-skills:exploiting-insecure-deserialization` |
| CDN/cache ativo | `cybersecurity-skills:performing-web-cache-poisoning-attack` |
| Parâmetro de arquivo/caminho | `cybersecurity-skills:performing-directory-traversal-testing` |
| CORS com credenciais | `cybersecurity-skills:testing-cors-misconfiguration` |
| Endpoint com limite de uso | `cybersecurity-skills:exploiting-race-condition-vulnerabilities` |
| API campos extras | `cybersecurity-skills:testing-api-for-mass-assignment-vulnerability` |
| WAF bloqueando | `cybersecurity-skills:performing-web-application-firewall-bypass` |

## Skill → Estado de Entrada — API
| Estado de entrada | Skill |
|---|---|
| JWT, `none` não testado | `cybersecurity-skills:performing-jwt-none-algorithm-attack` |
| JWT RS256/ES256, confusão HS256 | `cybersecurity-skills:exploiting-jwt-algorithm-confusion-attack` |
| OAuth redirect_uri/state | `cybersecurity-skills:exploiting-oauth-misconfiguration` |
| GraphQL sem schema | `cybersecurity-skills:performing-graphql-security-assessment` |
| REST IDs previsíveis | `cybersecurity-skills:testing-api-for-broken-object-level-authorization` |
| API sem doc, params ocultos | `cybersecurity-skills:performing-api-fuzzing-with-restler` |

## F1/F3 — Dedup
- **SQLi/XSS:** confirmação manual e automação são fases do MESMO branch. Carregou
  `exploiting-sql-injection-vulnerabilities`? Vá direto p/ sqlmap sem recarregar. Idem XSS→burp.
- **JWT:** uma skill de JWT por branch. `none` testado e token assimétrico → confusion direto.
