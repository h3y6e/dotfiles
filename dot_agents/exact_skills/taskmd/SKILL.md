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
- Every state transition must touch the task note.
- Fill Goal and the initial DoD before doing substantial work, then move the task to `in-progress`.
- If note text includes backticks, shell substitutions, or other shell-sensitive characters, do not pass it via `obsidian append ... content="..."` or `obsidian daily:append ... content="..."` in zsh. Edit the markdown file directly, or only use shell-safe quoting when the content is simple enough to verify.
- If an `obsidian` subcommand or flag is uncertain, check `obsidian --help` or `obsidian help <command>` before guessing.
- Run a task-note sync checkpoint after the initial plan, after each meaningful implementation/inspection batch, when blocked or changing direction, and immediately before the final response.
- Never send the final answer or treat the work as complete until the task note reflects the current status, completed DoD items, key verification commands/results, and any remaining follow-up. Evidence before claims — if you haven't run the verification, you can't mark it done.
- If something goes wrong mid-task, update the task note with what you know before attempting fixes. The note is the source of truth, not your memory.
- Log universal insights (not task-specific) to today's daily note. Use `obsidian daily:append` only for simple plain text; if the note includes backticks or other shell-sensitive characters, edit the daily note directly instead.

## Workflow

1. `obsidian daily:path vault=log` → `daily/YYYY-MM-DD.md` (use this date, not `date` command)
2. Search for an existing relevant task; if one exists, resume it, otherwise `obsidian create vault=log path="task/YYYY-MM-DD-slug.md" template=task`
3. Edit the file directly — title, Goal, DoD checklist, Research, and Notes seed entries
4. `obsidian property:set vault=log path="task/..." name=status value=in-progress`
5. After each work batch, update Notes with findings, decisions, blockers, and verification. Prefer direct file edits for multi-line or shell-sensitive text; use `obsidian append` only for simple plain text that is safe to quote.
6. `obsidian task vault=log path="task/..." line=N toggle`
7. Before the final response, run one last sync checkpoint so the note matches reality
8. `obsidian property:set vault=log path="task/..." name=status value=done`
