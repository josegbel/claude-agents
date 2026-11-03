---
name: spec-task
description: Scaffold a spec-driven feature workflow — creates tasks/<slug>.md (Research / Plan / Open Questions) and features/<slug>.checkpoint.md following the 103 Module 1 lifecycle. Use when starting any non-trivial mobile feature, refactor, or bugfix. Trigger on user requests like "start a spec for X", "scaffold a task for X", "/spec-task <slug>".
---

# spec-task — scaffold a spec-driven feature

This skill creates the two files that the spec-driven mobile lifecycle revolves around: a **task file** (the shared state between agents) and a **checkpoint file** (resumable session state).

## When to use this skill

Use it whenever the user says any of:
- "Start a new feature for X"
- "Set up a spec / task for X"
- "/spec-task <slug>"
- "Plan the work for X" (before any code is written)

Skip it for trivial fixes (typo, one-line bug). Use it as soon as work involves more than one file, more than one platform, or any architectural decision.

## What the skill produces

Two files in the **target repo** (the repo where the feature will land), under directories that the repo's `.gitignore` may already exclude:

- `tasks/<slug>.md` — populated with the schema below, all sections empty and ready for `mobile-researcher` and `mobile-planner` to fill in.
- `features/<slug>.checkpoint.md` — initial checkpoint stamped with today's date and `IN PROGRESS — research`.

## How to invoke this skill

1. Ask the user (if not already given):
   - **Target repo** (one of the workspace directories under `~/ClaudeEnvironment/`)
   - **Slug** (kebab-case, short — e.g. `add-payment-leaderboard`, `refactor-onboarding-nav`)
   - **One-line description** of what the feature is

2. Verify the target repo exists at `~/ClaudeEnvironment/<repo>`.

3. Create the directories if missing:
   ```bash
   mkdir -p ~/ClaudeEnvironment/<repo>/tasks
   mkdir -p ~/ClaudeEnvironment/<repo>/features
   ```

4. Read the templates from this skill's `templates/` directory:
   - `~/.claude/skills/spec-task/templates/task.md`
   - `~/.claude/skills/spec-task/templates/checkpoint.md`

5. Substitute placeholders in both templates:
   - `{{SLUG}}` → the slug
   - `{{DESCRIPTION}}` → the one-line description
   - `{{DATE}}` → today's date in `YYYY-MM-DD`
   - `{{REPO}}` → the target repo name

6. Write the substituted templates to:
   - `~/ClaudeEnvironment/<repo>/tasks/<slug>.md`
   - `~/ClaudeEnvironment/<repo>/features/<slug>.checkpoint.md`

7. Tell the user:
   - The two file paths created
   - The next agent to invoke: `mobile-researcher` (with the slug and target repo as input)
   - Optionally remind them of the lifecycle: research → plan → red-team plan → implement → review → red-team implementation

## Operating notes

- **Do not** add `tasks/` or `features/` to the repo's `.gitignore` automatically. The user decides whether spec files are committed (PR documentation) or local-only (personal scratch).
- **Do not** start the researcher yourself. This skill is scaffolding only; the user invokes the next agent when they're ready.
- If a task file with the same slug already exists, ask the user whether to overwrite, append, or pick a different slug. Default: pick a different slug.
- For features that span both Android and iOS, the slug should not encode the platform — one task file covers both. The Plan section will declare per-platform Steps.
