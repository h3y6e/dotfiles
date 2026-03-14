---
name: taskmd
description: Plan before starting, track progress during work. One task = one file in the Obsidian vault. Use when starting a new piece of work, resuming an existing task, or updating task status.
compatibility: Requires Obsidian with CLI enabled and vault "log".
allowed-tools: Bash(obsidian:*) Bash(ghq get log) Bash(cat:*) Bash(rg:*) Read Edit
---

# TaskMD

## Vault

`~/ghq/github.com/h3y6e/log` — if missing, `ghq get log`.

## File

`task/YYYY-MM-DD-<slug>.md`

Frontmatter: `title` (human-readable name for the task), `status` (`backlog` → `todo` → `in-progress` → `done`/`canceled`), `tags`.

Sections: Goal, DoD (checklist), Research, Notes (findings, decisions, lessons learned).

## Rules

- Never ask before writing. Infer slug, title, tags, and content from context.
- On session start: `obsidian tasks todo vault=log` or `obsidian search:context vault=log query="keyword" path=task` to find relevant tasks, then read the file directly.
- Keep status and notes updated as work progresses.
- Log universal insights (not task-specific) to today's daily note: `obsidian daily:append vault=log content="..."`.

## Workflow

1. `obsidian daily:path vault=log` → `daily/YYYY-MM-DD.md` (use this date, not `date` command)
2. `obsidian create vault=log path="task/YYYY-MM-DD-slug.md" template=task`
3. Edit file directly — Goal, DoD checklist, etc.
4. `obsidian property:set vault=log path="task/..." name=status value=in-progress`
5. Edit file to append to Notes
6. `obsidian task vault=log path="task/..." line=N toggle`
7. `obsidian property:set vault=log path="task/..." name=status value=done`
