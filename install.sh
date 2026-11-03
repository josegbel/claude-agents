#!/usr/bin/env bash
# Symlink these agents and skills into Claude Code's config folders.
# Usage: ./install.sh [--migration <path-to-aepm-labs>]
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bak"
    echo "backed up $dest -> $dest.bak"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest"
}

for f in "$REPO"/agents/*.md; do
  link "$f" "$CLAUDE_DIR/agents/$(basename "$f")"
done

link "$REPO/skills/spec-task" "$CLAUDE_DIR/skills/spec-task"

if [ "${1:-}" = "--migration" ]; then
  target="${2:?usage: ./install.sh --migration <path-to-aepm-labs>}"
  for f in "$REPO"/project-agents/android-migration/*.md; do
    link "$f" "$target/services/android-migration/.claude/agents/$(basename "$f")"
  done
fi
