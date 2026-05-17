---
name: tracking-tasks
description: Use when starting any multi-step work, resuming an existing task, switching direction mid-task, or wrapping up. Use proactively when a request spans more than one response — open or create a task note before diving in.
compatibility: Requires Obsidian with CLI enabled and vault "log".
allowed-tools: Bash(obsidian:*) Bash(ghq get log) Bash(rg:*) Read Edit Write
license: MIT
metadata:
  author: h3y6e
  version: 2026.5.1
  github-path: skills/tracking-tasks
  github-ref: refs/tags/v2026.5.1
  github-repo: https://github.com/h3y6e/agent-skills
  github-tree-sha: af2f4f0079fc6bce9cc7db37467b0169f7875d6f
---
# Tracking Tasks

## Vault

`~/ghq/github.com/h3y6e/log` — if missing, `ghq get log`.

## Task Note

Path: `task/YYYY-MM-DD-<slug>.md`. Frontmatter: `title`, `status` (`backlog`→`todo`→`in-progress`→`done`/`canceled`), `tags`. Sections: Goal, DoD (checklist), Research, Notes.

- Infer slug, title, tags from context — don't ask.
- On session start: search with `obsidian search:context` or direct `rg` under the log vault, then read the file directly.
- Fill Goal and DoD before substantial work, then set status to `in-progress`.
- The note is the source of truth. Sync after initial plan, each work batch, direction changes, and before final response.
- Evidence before claims — don't mark done until verification is recorded.

## Daily Note

Triggers are **session-wide** — even without a task note, even on single-response tasks. Write at the moment of discovery, not batched at the end.

Path: `obsidian daily:path vault=log` → `daily/YYYY-MM-DD.md`. If CLI fails, use `~/ghq/github.com/h3y6e/log/daily/YYYY-MM-DD.md`.

**Triggers** — TIL, workarounds, cross-cutting decisions, env/tooling issues, useful links, recurring patterns.

If a finding is both task-relevant and cross-cutting, log task impact in the task note and the broader concern in the daily note separately.

## Obsidian CLI

The CLI is unstable. If any command errors, **immediately fall back to direct file editing** — do not retry or debug. Prefer direct editing over `obsidian append` for backticks or shell-sensitive content.

## Workflow

1. `obsidian daily:path vault=log` → get today's date (use this, not `date` command)
2. Search for existing task; if none, `obsidian create vault=log path="task/YYYY-MM-DD-slug.md" template=task`
3. Edit directly — Goal, DoD, Research, Notes
4. `obsidian property:set vault=log path="task/..." name=status value=in-progress`
5. After each batch, update Notes with findings/decisions/verification
6. `obsidian task vault=log path="task/..." line=N toggle`
7. Final sync checkpoint
8. `obsidian property:set vault=log path="task/..." name=status value=done`
