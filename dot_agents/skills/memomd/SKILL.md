---
name: memomd
description: >
  Record work as Markdown memos. One topic = one file.
  Autonomously append entries without asking. Use proactively at task completion.
---

# MemoMD Skill

Capture everything. Ask nothing. Write it down.

## Directory

`~/ghq/github.com/h3y6e/log/memo`

## File Naming

`YYYY-MM-DD-<slug>.md` — slug is short kebab-case (e.g. `fix-auth-bug`, `api-design`).
Same date-slug → append, don't create a new file.

## Frontmatter

| Field     | Required | Notes                             |
| --------- | -------- | --------------------------------- |
| `date`    | Yes      | `YYYY-MM-DD`                      |
| `summary` | Yes      | One-line description from context |
| `tags`    | Yes      | `[]` by default                   |

## Template

```markdown
---
date: YYYY-MM-DD
summary: <one-line description>
tags: []
---

# <title>
```

## Entry Format

`## HH:MM` or `## <label>` (e.g. Setup, Investigation, Decision) followed by free-form Markdown.

## Operations

### Append

1. Infer date and slug from context — do not ask
2. Path: `~/ghq/github.com/h3y6e/log/memo/YYYY-MM-DD-<slug>.md`
3. Create with template if new; append `## HH:MM` or `## <label>` entry
4. Do not report the write unless asked

### Summary

Append `## Summary` at session end: what was done, key decisions, next steps.

### Search

- Recent: 10 most recently modified files
- Keyword: grep across `*.md`
- Date: match `YYYY-MM-DD-*.md`

## Autonomy

- Never ask before writing. Infer slug and title.
- Never ask for time. Use current time or omit.
- Always append to existing same-day same-slug file.
- Proactively log at natural breakpoints.

## What to Record

- Commands and output (especially errors/fixes)
- Decisions and reasoning
- Files changed
- Links consulted
- TODO items (note only; don't manage here)

## Principles

- **Write first, organize never** — present beats polished
- **Break at context shifts** — one entry per topic change
- **No noise** — log what happened, not intent
