---
name: taskmd
description: >
  Manage tasks as Markdown files. One task = one file.
  Handles registration, status transitions, listing, review date inspection, and triage.
---

# TaskMD Skill

Keep everything on the shelf; pull only what you need onto your desk.

## Directory

`~/ghq/github.com/h3y6e/log/tasks`

## Status Definitions

| Status        | Meaning   | review_date  |
| ------------- | --------- | ------------ |
| `backlog`     | Idea      | Optional     |
| `todo`        | Committed | **Required** |
| `in-progress` | Active    | Not needed   |
| `on-hold`     | Paused    | **Required** |
| `done`        | Complete  | Not needed   |
| `canceled`    | Dropped   | Not needed   |

## Frontmatter

```yaml
status: backlog # Required
review_date: # Required when todo or on-hold (YYYY-MM-DD)
due_date: # Recommended (YYYY-MM-DD)
tags: [] # Optional
# waiting_for:        # Recommended when on-hold
# estimate: 2h        # Optional
# priority: 0         # Optional (avoid unless necessary)
```

## Template

```markdown
---
status: backlog
review_date:
due_date:
tags: []
---

# Overview / Idea

# Goal

# Definition of Done

# TODO

# Links / Resources

# Notes / Journals
```

## Operations

### Register

1. Default status: `backlog`. Filename: kebab-case (non-ASCII OK)
2. `todo` → review_date required (confirm or propose). `in-progress` → due_date recommended.
3. Report file path and settings.

### Update Status

- `backlog` → `todo`: set review_date
- `todo` → `in-progress`: clear review_date, recommend due_date
- `in-progress` → `on-hold`: set review_date, recommend waiting_for
- `on-hold` → `in-progress`: clear review_date
- any → `done`/`canceled`: clear review_date

### List

Group by status. Show due/review dates. `done`/`canceled`: count only.

### Review Date Inspection

Surface tasks where `review_date <= today`. For each: start, defer (new date), or cancel.

### Triage

Review `backlog` and stale `on-hold` tasks. Promote, keep, or cancel.

## WIP Limit

Max 5 `in-progress` tasks. Warn if exceeded. `"project"` tagged tasks counted separately.

## Effort Log

Append to Notes/Journals:

```
LOG: 2025-01-15 9:00-12:15 3h15m requirements -> implementation
LOG: 14:30-16:00 review feedback
LOG: 45m bug fix
```

## Principles

- **Proactive shelving** — `on-hold` + review_date is a positive action, not failure
- **review_date as snooze** — ignore until it arrives, then decide
- **Capture everything** — register first, decide later
- **Avoid priority numbers** — dates are usually enough
