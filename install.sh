#!/usr/bin/env bash
#
# RedClaude — instalador idempotente
# Instala ptai (MCP) + skills de segurança e parametriza a config para esta máquina.
# NÃO automatiza o login do Claude (cada usuário usa a própria conta).
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PTAI_VERSION="0.17.1"
SKILLS_MARKETPLACE="mukul975/Anthropic-Cybersecurity-Skills"
SKILLS_PLUGIN="cybersecurity-skills@anthropic-cybersecurity-skills"

say()  { printf "\033[1;36m[RedClaude]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[aviso]\033[0m %s\n" "$*"; }
die()  { printf "\033[1;31m[erro]\033[0m %s\n" "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
say "1/5 — Verificando pré-requisitos"
command -v git    >/dev/null || die "git não encontrado (sudo apt install -y git)"
command -v python3>/dev/null || die "python3 não encontrado (sudo apt install -y python3)"
if ! command -v pipx >/dev/null; then
  warn "pipx não encontrado — instalando"
  python3 -m pip install --user pipx >/dev/null 2>&1 || sudo apt install -y pipx
  python3 -m pipx ensurepath >/dev/null 2>&1 || true
fi
if ! command -v claude >/dev/null; then
  warn "Claude Code (CLI) não encontrado."
  warn "Instale antes de usar:  npm install -g @anthropic-ai/claude-code"
fi

# ---------------------------------------------------------------------------
say "2/5 — Instalando ptai==${PTAI_VERSION}"
if command -v ptai >/dev/null && ptai --version 2>/dev/null | grep -q "$PTAI_VERSION"; then
  say "    ptai ${PTAI_VERSION} já instalado"
else
  pipx install "ptai==${PTAI_VERSION}" 2>/dev/null || pipx install --force "ptai==${PTAI_VERSION}"
fi
PTAI_PATH="$(command -v ptai || echo "$HOME/.local/bin/ptai")"
say "    ptai em: $PTAI_PATH"

# ---------------------------------------------------------------------------
say "3/5 — Instalando skills de segurança (marketplace pinado)"
if command -v claude >/dev/null; then
  # Sintaxe pode variar conforme a versão do Claude Code — verifique 'claude plugin --help'.
  claude plugin marketplace add "$SKILLS_MARKETPLACE" 2>/dev/null || \
    warn "Não foi possível registrar o marketplace automaticamente — registre manualmente:"
  claude plugin install "$SKILLS_PLUGIN" 2>/dev/null || \
    warn "Instale o plugin manualmente: claude plugin install $SKILLS_PLUGIN"
else
  warn "Claude Code ausente — pulei a instalação das skills."
fi

# ---------------------------------------------------------------------------
say "4/5 — Gerando .mcp.json para esta máquina"
sed "s|__PTAI_PATH__|${PTAI_PATH}|g" "$REPO_DIR/config/mcp.json.template" > "$REPO_DIR/.mcp.json"
say "    .mcp.json criado com PTAI_PATH=$PTAI_PATH"

# ---------------------------------------------------------------------------
say "5/5 — Pronto. O núcleo (CLAUDE.md + phases/) já está no diretório do projeto."
cat <<EOF

  Próximos passos:
    1) cd "$REPO_DIR"
    2) claude            # login com a SUA conta Claude
    3) ptai --version    # confirmar 0.17.1
    4) Declare alvo + escopo AUTORIZADO e inicie o engajamento.

  Lembre: só opere contra alvos autorizados. Loot fica em engagements/ (gitignorado).
EOF
