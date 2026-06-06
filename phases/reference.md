# Referência — exemplos completos (L3, sob demanda)

Carregado só se o formato de hipótese/reflexão/improvisação precisar de exemplo completo.

## Hipóteses — exemplos
```
H1 @ 10.0.0.5/web: SQLi no parâmetro ?id= de /user
     CONFIRMADA · 100% · CRÍTICA
     evidência: erro de banco + delay com sleep(5)
     ação pendente: sqlmap --os-shell -p id

H2 @ dc01/ad: AS-REP roasting em svc_backup
     CONFIRMADA · 100% · ALTA
     evidência: hash via GetNPUsers
     ação pendente: hashcat -m 18200

H3 @ 10.0.0.8/post: credencial do git reutilizada no PostgreSQL
     SUSPEITA · 55% · ALTA
     evidência: mesmo padrão de senha em config.py (correlação cruzada-branch)
     ação pendente: psql -h 10.0.0.8 -U dbuser
```

## Reflexão — exemplos
```
L1: contexto: host 10.0.0.5, WAF Cloudflare bloqueou SQLi simples
    causa:   inspeção de assinatura em UNION/SELECT
    ajuste:  começar com tamper=space2comment,charencode
    escopo:  todos os hosts atrás do mesmo CDN (10.0.0.5, 10.0.0.6)

L2: contexto: brute SSH em 10.0.0.9 disparou fail2ban
    causa:   >5 tentativas em 60s
    ajuste:  throttle 1/30s ou pular vetor
    escopo:  todo o range 10.0.0.0/24

L3: contexto: linpeas em www-data sem SUID/sudo
    causa:   host hardenizado
    ajuste:  ir direto p/ capabilities + cron + creds em config
    escopo:  hosts da mesma imagem/baseline
```

## Improvisação — exemplo completo
```
Output inesperado: nmap retorna 4848/tcp open
[I1] vejo porta 4848
[I2] sugere GlassFish Admin Console
[I3] porque 4848 é a porta padrão, histórico de auth bypass e deploy arbitrário
[I4] portanto: curl http://alvo:4848/management/domain/applications/
[I5] enxertar H[n] @ alvo/web: RCE via GlassFish deploy · SUSPEITA · 65% · ALTA
```
