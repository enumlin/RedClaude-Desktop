# FASE: RECONHECIMENTO (módulo sob demanda)

Carregado quando: alvo = domínio/empresa, ou expansão de superfície.

## Gates — FASE 0 (entrada)
```
domínio/empresa  → RECON: osint → subfinder → dnsrecon → shodan
IP/range         → Read phases/scan.md
URL web          → Read phases/web.md
credenciais      → scan autenticado + Read phases/ad.md (simultâneo)
```

## Gates — FASE 1 (pós-recon)
```
HOSTNAME → classificar e enxertar branch:
  vpn|ras|remote|citrix    → branch REDE (Read phases/scan.md §rede)
  dev|staging|test|qa      → branch WEB, prioridade ALTA (creds default)
  api|graphql|rest|swagger → branch API (Read phases/web.md §API)
  git|gitlab|bitbucket     → SECRETS imediato (gitleaks/trufflehog)
  admin|panel|dashboard    → branch WEB, prioridade CRÍTICA
  mail|smtp|mx             → branch EMAIL (Read phases/redteam.md)

DNS:
  zone transfer ok → lista axfr substitui subfinder
  SPF ausente/+all → vetor phishing (Read phases/redteam.md)
  CNAME cloud      → dangling takeover
  TXT com secrets  → finding crítico

SHODAN:
  CVE crítico + exploit → exploração direta (módulo da superfície)
  tecnologia detectada  → ajustar wordlist ao stack
```

## Resolver superfície
```
httpx -l subdomains.txt -status-code -title -tech-detect
hosts vivos → executar fila por prioridade · mortos → descartar
```

## Falha
```
subfinder/amass vazio → amass -brute -d <dom> · resolvers 8.8.8.8,1.1.1.1,9.9.9.9 · crt.sh JSON
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Só nome da empresa / domínio raiz | `cybersecurity-skills:conducting-external-reconnaissance-with-osint` |
| Domínio raiz, expandir subdomínios | `cybersecurity-skills:performing-subdomain-enumeration-with-subfinder` |
| Lista de domínios, DNS / zone transfer | `cybersecurity-skills:performing-dns-enumeration-and-zone-transfer` |
| IP/range, serviços e reputação | `cybersecurity-skills:performing-ip-reputation-analysis-with-shodan` |
| Credenciais vazadas em pastes/repos | `cybersecurity-skills:performing-paste-site-monitoring-for-credentials` |

## F2 — Flags adaptativas
- `amass`: ajustar `-timeout` e `-max-dns-queries` ao escopo
- `subfinder`: `-sources` só com fontes sem API key disponível
- `dnsrecon`: não usar `std,axfr` sem verificar se zone transfer é permitido
