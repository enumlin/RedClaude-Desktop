# RedClaude Desktop — Claude Desktop para Linux, customizado para pentest

> **Fork de pentest** do excelente [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian).
> A base que empacota o **Claude Desktop para Linux/Kali** é 100% do aaddrick.
> Este fork adiciona o **RedClaude** — um motor cognitivo de pentest (ReAct + árvore de
> tarefas + reflexão) + integração com o servidor MCP **ptai** + 750+ skills de segurança.

---

## ⚠️ Aviso de uso autorizado

Ferramenta **ofensiva autônoma**. Use **exclusivamente** contra alvos com **autorização
explícita e por escrito** (pentest contratado, escopo de bug bounty, ou CTF/lab próprio).
Uso não autorizado é **ilegal**. Você é o único responsável por operar dentro da lei e do escopo.

---

## Crédito à base (aaddrick)

Tudo que faz o **Claude Desktop rodar no Linux** — `build.sh`, `scripts/`, `nix/`, `docs/`,
empacotamento `.deb`/`.rpm`/AppImage — é trabalho do **aaddrick**, sob MIT/Apache 2.0.
A documentação original dele está preservada em
[`README-claude-desktop-debian.md`](README-claude-desktop-debian.md) e o contexto de build em
[`CLAUDE-desktop-build.md`](CLAUDE-desktop-build.md). As licenças dele
([LICENSE-APACHE](LICENSE-APACHE), [LICENSE-MIT](LICENSE-MIT)) permanecem intactas.

**Este fork não é endossado pelo aaddrick nem pela Anthropic.**

---

## O que o RedClaude adiciona (a camada de pentest)

O diferencial não são as ferramentas — é **como o agente raciocina**:

| Mecanismo | O que faz |
|---|---|
| **Árvore de Tarefas** | estado do engajamento como árvore (alvo→fase→vetor→ação) |
| **Loop ReAct** | Thought → Action → Observation, expande o nó de maior prioridade |
| **Buffer de Reflexão** | lições de falha propagam entre alvos (host A ensina host B) |
| **Faculdades Meta M1–M4** | anti-loop · planejamento por dependência · verificar antes de quebrar o alvo · ganho de informação |
| **Núcleo + módulos** | motor sempre carregado; detalhe de fase sob demanda |
| **Estado em disco** | sobrevive à compactação e a novas sessões |

Cérebro: [`CLAUDE.md`](CLAUDE.md) + [`phases/`](phases/). Mãos: **ptai** (200+ tools) + skills.

---

## Instalação (Kali / Debian / Ubuntu)

```bash
# 1. Clonar o fork
git clone https://github.com/enumlin/RedClaude-Desktop.git
cd RedClaude-Desktop

# 2. (Base aaddrick) Construir o Claude Desktop para Linux
#    Veja README-claude-desktop-debian.md para opções (.deb / .rpm / AppImage / Nix)
./build.sh

# 3. (Camada RedClaude) Instalar ptai + skills e gerar a config MCP
chmod +x install.sh
./install.sh

# 4. Abrir o Claude Desktop e carregar o motor cognitivo (CLAUDE.md) como instruções
#    + registrar o ptai como servidor MCP (config/mcp.json.template)
```

> O **login é com a sua conta** Claude — não vai no repositório, por segurança.

---

## Uso

Declare alvo + escopo autorizado e inicie o engajamento. O agente cria
`engagements/<alvo>/` (tree · hypotheses · reflexion · loot), carrega o módulo da fase
certa pelo **Índice de Gatilhos**, e percorre a árvore até o objetivo ou o escopo se esgotar.

---

## Estrutura

```
RedClaude-Desktop/
├── build.sh, scripts/, nix/, docs/   ← BASE DESKTOP (aaddrick) — intacta
├── README-claude-desktop-debian.md   ← README original do aaddrick
├── CLAUDE-desktop-build.md           ← contexto de build do aaddrick
├── LICENSE-APACHE, LICENSE-MIT       ← licenças do aaddrick
│
├── CLAUDE.md                         ← RedClaude: motor cognitivo (núcleo)
├── phases/                           ← RedClaude: módulos de fase
├── engagements/_TEMPLATE/            ← RedClaude: estado persistente
├── config/mcp.json.template          ← RedClaude: config MCP (ptai)
├── install.sh                        ← RedClaude: instalador da camada de pentest
├── LICENSE-REDCLAUDE (MIT) · NOTICE-REDCLAUDE
```

---

## Créditos

- **Base Claude Desktop para Linux:** [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian) (MIT/Apache 2.0)
- **Skills:** [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) (Apache 2.0)
- **ptai:** servidor MCP de pentest autônomo
- **Fundamentos:** ReAct, Reflexion, Tree of Thoughts, CoALA, MemGPT

## Licenças

Camada RedClaude: [LICENSE-REDCLAUDE](LICENSE-REDCLAUDE) (MIT). Base Desktop: LICENSE-APACHE / LICENSE-MIT (aaddrick).
Componentes de terceiros mantêm suas licenças — ver [NOTICE-REDCLAUDE](NOTICE-REDCLAUDE).
