---
allowed-tools: Bash(obsidian:*) Bash(ghq get log) Bash(rg:*) Read Edit Write
compatibility: Requires Obsidian with CLI enabled and vault "log".
description: Use when starting multi-step work, resuming an existing task, switching direction mid-task, wrapping up, or capturing cross-session task context in Obsidian.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/tracking-tasks
    github-ref: refs/tags/v2026.6.6
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 7939a5aa2d93bf017c852fab0c3b9658c909c2c8
    version: 2026.6.6
name: tracking-tasks
---
# Tracking Tasks

## Vault

`~/ghq/github.com/h3y6e/log` — if missing, `ghq get log`.

## Task Note

Path: `task/YYYY-MM-DD-<slug>.md`. Frontmatter: `title`, `status` (`backlog`→`todo`→`in-progress`→`done`/`canceled`). Sections: Goal, DoD (checklist), Research, Notes.

- Infer slug and title from context — don't ask.
- On session start: search with `obsidian search:context query=<text> limit=<n>` or direct `rg` under the log vault, then read the file directly.
- Fill Goal and DoD before substantial work, then set status to `in-progress`.
- The note is the source of truth. Sync after initial plan, each work batch, direction changes, and before final response.
- Evidence before claims — don't mark done until verification is recorded.

## Graph

Make the Obsidian graph useful with `[[wikilinks]]`; do not treat notes as isolated logs.

- Link concrete context: active project/repo, related task notes, daily notes, issues/PRs, and ADRs/specs.
- When resuming a task, inspect linked notes/backlinks before broad search; prefer existing pages over new abstract concept nodes.
- When logging a cross-cutting finding in the daily note, link the active task and relevant project/source pages there too.

## Daily Note

Triggers are **session-wide** — even without a task note, even on single-response tasks. Write at the moment of discovery, not batched at the end.

Path: `obsidian daily` → `daily/YYYY-MM-DD.md`. If CLI fails, use `~/ghq/github.com/h3y6e/log/daily/YYYY-MM-DD.md`.

**Triggers** — TIL, workarounds, cross-cutting decisions, env/tooling issues, useful links, recurring patterns.

If a finding is both task-relevant and cross-cutting, log task impact in the task note and the broader concern in the daily note separately.

## Obsidian CLI

The CLI is unstable. If any command errors, **immediately fall back to direct file editing** — do not retry or debug. Prefer direct editing over `obsidian append` for backticks or shell-sensitive content.

## Workflow

1. `obsidian daily` → get today's date (use this, not `date` command)
2. Search for existing task; if none, `obsidian create path="task/YYYY-MM-DD-slug.md" template=task`
3. Edit directly — Goal, DoD, Research, Notes
4. Add/update `[[wikilinks]]` so graph/backlinks connect the task to related work
5. `obsidian property:set path="task/..." name=status value=in-progress`
6. After each batch, update Notes with findings/decisions/verification
7. `obsidian task ref=<path:line> toggle`
8. Final sync checkpoint
9. `obsidian property:set path="task/..." name=status value=done`
