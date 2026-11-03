# claude-agents

Portable copy of my Claude Code agents and the `spec-task` skill, so the same setup can be installed on any laptop.

## Contents

| Path | Installs to | What it is |
|---|---|---|
| `agents/` | `~/.claude/agents/` | Global mobile pipeline: `mobile-researcher` → `mobile-planner` → `mobile-red-team` → `android-developer` / `ios-developer` → `mobile-code-reviewer` |
| `skills/spec-task/` | `~/.claude/skills/spec-task/` | Creates `tasks/<slug>.md` and `features/<slug>.checkpoint.md`, the shared files the agents read and write |
| `project-agents/android-migration/` | `<aepm-labs>/services/android-migration/.claude/agents/` | Project-scoped migration pipeline: `legacy-android-researcher` → `legacy-android-planner` → `legacy-android-red-team` → `android-migration-developer` → `migration-code-reviewer` |

The agents never start each other. Run `spec-task` first, then start each agent yourself in order.

## Install

```bash
git clone https://github.com/josegbel/claude-agents.git ~/ClaudeEnvironment/claude-agents
cd ~/ClaudeEnvironment/claude-agents
./install.sh                      # global agents + spec-task skill
./install.sh --migration <path-to-aepm-labs>   # also install the migration agents
```

`install.sh` creates symlinks, so a `git pull` here updates every installed copy. If a real file is already in the way, the script moves it to `*.bak` first.

## Known gaps

- TODO: `android-migration-developer` calls a `kotlin-j2k-style` skill that is not in this repo yet.
