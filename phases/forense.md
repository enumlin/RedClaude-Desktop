# FASE: FORENSE / DFIR (módulo sob demanda)

Carregado quando: dump de memória/disco, logs, ou resposta a incidente.

## Gates
```
host Linux vivo    → adquirir memória (LiME) → volatility3
dump Windows       → volatility3 triagem (windows.pslist)
já no Volatility   → plugin específico direcionado
imagem de disco    → autopsy/bulk-extractor
criar imagem       → dd/dcfldd + hash de verificação
ransomware ativo   → pipeline IR
logs               → grep/jq/chainsaw → timeline
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| Host Linux vivo, adquirir memória | `cybersecurity-skills:analyzing-memory-forensics-with-lime-and-volatility` |
| Dump Windows, triagem inicial | `cybersecurity-skills:performing-memory-forensics-with-volatility3` |
| No Volatility, plugin específico | `cybersecurity-skills:performing-memory-forensics-with-volatility3-plugins` |
| Imagem de disco, análise completa | `cybersecurity-skills:performing-disk-forensics-investigation` |
| Criar imagem forense | `cybersecurity-skills:acquiring-disk-image-with-dd-and-dcfldd` |
| Incidente de ransomware | `cybersecurity-skills:performing-ransomware-response` |
| Logs p/ timeline | `cybersecurity-skills:performing-log-analysis-for-forensic-investigation` |

## F1 — Dedup Volatility (3 fases sequenciais, não redundantes)
1. `lime-and-volatility` → aquisição em host vivo
2. `volatility3` → triagem inicial do dump
3. `volatility3-plugins` → análise profunda com plugin específico
Dump já existe? pular p/ 2. Já em análise? pular p/ 3.
