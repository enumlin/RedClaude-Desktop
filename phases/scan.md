# FASE: SCANNING + REDE/INFRA (módulo sob demanda)

Carregado quando: IP/range, portas desconhecidas, ou serviço de rede exposto.

## Gates — FASE 2 (por porta/serviço)
```
80/443            → Read phases/web.md
445/139 Windows   → enum4linux-ng + MS17-010 + SMB signing  (§rede abaixo)
135 RPC           → impacket-rpcdump · DCOM lateral potencial
88 + 389/636      → Read phases/ad.md (AD enum sem credenciais)
3306              → mysql -u root sem senha → hydra se falhar
5432              → psql -U postgres → hydra se falhar
1433              → impacket-mssqlclient + xp_cmdshell
22 < 7.4          → CVEs OpenSSH + user enumeration
21                → ftp anonymous
2375/2376         → Read phases/cloud.md (Docker daemon → RCE)
6443/8443         → Read phases/cloud.md (Kubernetes API)
9200/9300         → Elasticsearch sem auth → dump de índices
27017             → MongoDB sem auth → dump direto
6379              → Redis sem auth → info + config get *
5985/5986         → WinRM → evil-winrm com credenciais

ANÔMALO:
  só 443, 403 massivo → WAF → wafw00f → Read phases/web.md §WAF
  host sem resposta   → -Pn → masscan -p1-65535 --rate=1000 fallback
```

## §rede — exploração de serviço de rede
```
SMBv1 + sem patch       → EternalBlue (skill abaixo)
SMB shares/auth         → smbclient -L · netexec smb
DC + Netlogon           → Zerologon (skill abaixo)
sem AD mapeado, pivot   → internal-network-penetration-test
```

## F2 — Flags adaptativas nmap
```
sem info  → nmap -sV --top-ports 1000 -T4 <alvo>
portas+   → nmap -sV -sC -p<abertas> -T3 <alvo>
escopo ok → nmap -sV -sC -p- --min-rate 1000 <alvo>
ICMP block→ +-Pn (lição típica do Buffer de Reflexão)
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Host sem info de portas | `cybersecurity-skills:scanning-network-with-nmap-advanced` |
| Portas abertas, vulns web | `cybersecurity-skills:performing-web-application-scanning-with-nikto` |
| URL conhecida, enumerar diretórios | `cybersecurity-skills:performing-web-application-penetration-test` |
| Credenciais válidas, scan autenticado | `cybersecurity-skills:performing-authenticated-vulnerability-scan` |
| SMBv1, Windows sem MS17-010 | `cybersecurity-skills:exploiting-ms17-010-eternalblue-vulnerability` |
| SMB exposto, shares e auth | `cybersecurity-skills:exploiting-smb-vulnerabilities-with-metasploit` |
| DC, Netlogon exposto | `cybersecurity-skills:exploiting-zerologon-vulnerability-cve-2020-1472` |
| Rede interna sem AD mapeado | `cybersecurity-skills:conducting-internal-network-penetration-test` |
