---
name: taskmd
description: >
  Manage tasks using the TaskMD method: one task = one Markdown file (TaskMD).
  Handles task registration, status updates, listing, review date inspection, and triage.
  Use this skill whenever the user wants to add a task, change task status, view their task list,
  check tasks with upcoming or overdue review dates, put a task on hold, or manage tasks with
  statuses like backlog/todo/in-progress/on-hold/done/canceled.
  Also use proactively for task triage, weekly review, or any TaskMD workflow.
---

# TaskMD Skill

A task management approach based on the principle: "Keep everything on the shelf; pull only what you need onto your desk."
One task = one Markdown file (TaskMD).

## Task Directory

All TaskMD files are stored in `~/ghq/github.com/h3y6e/log/tasks`.

## Status Definitions

| Status        | Meaning        | review_date  |
| ------------- | -------------- | ------------ |
| `backlog`     | Idea/backlog   | Optional     |
| `todo`        | Committed      | **Required** |
| `in-progress` | Active         | Not needed   |
| `on-hold`     | Paused/waiting | **Required** |
| `done`        | Complete       | Not needed   |
| `canceled`    | Abandoned      | Not needed   |

## Frontmatter Properties

```yaml
status: backlog # Required: backlog|todo|in-progress|on-hold|done|canceled
review_date: # Required when todo or on-hold (YYYY-MM-DD)
due_date: # Recommended (YYYY-MM-DD)
tags: [] # Optional: string or array of strings
# waiting_for:          # Recommended when on-hold: reason/condition for resuming
# estimate: 2h          # Optional: time estimate (2h, 30m, 1h30m format)
# priority: 0           # Optional: numeric priority (avoid using unless necessary)
# task_id:              # Optional: unique identifier
```

## TaskMD Template

Use this template when creating new tasks:

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

### Register a Task

1. Determine the task name, content, and initial status (default: `backlog`)
2. Choose a filename: kebab-case or the task name as-is (non-ASCII characters OK)
3. Create the file in `~/ghq/github.com/h3y6e/log/tasks` using the template above
4. Set frontmatter based on status:
   - `backlog` → review_date not needed
   - `todo` → **review_date required** (confirm with user or propose a reasonable date)
   - `in-progress` → due_date recommended
5. Report the file path and settings to the user

**Choosing the initial status:**

- Not sure whether to do it → `backlog`
- Committed to doing it soon → `todo` (review_date required)
- Starting right now → `in-progress`

### Update Status

Edit the frontmatter of an existing TaskMD. Follow these transition rules:

- `backlog` → `todo`: set review_date
- `todo` → `in-progress`: clear review_date, recommend setting due_date
- `in-progress` → `on-hold`: set review_date, recommend setting waiting_for
- `on-hold` → `in-progress`: clear review_date
- any → `done`/`canceled`: clear review_date

### List Tasks

Scan `~/ghq/github.com/h3y6e/log/tasks`, read frontmatter from each file, and display grouped by status:

```
in-progress (N)
  - Task name  [due: YYYY-MM-DD]

todo (N)
  - Task name  [review: YYYY-MM-DD]

on-hold (N)
  - Task name  [review: YYYY-MM-DD]  -> waiting_for if set

backlog (N)
  - Task name

done / canceled: show count only
```

Apply tag filtering if the user requests it (e.g., "only @work tasks").

### Review Date Inspection

Compare review dates against today and surface tasks where `review_date <= today`.

**Inspection flow for each task:**

1. Present the task to the user
2. Prompt for a decision:
   - **Start/resume** → change to `in-progress`, clear review_date
   - **Defer** → set a new review_date (confirm with user or suggest one)
   - **Cancel** → change to `canceled`

### Triage / Weekly Review

A periodic review of all tasks, especially those not in daily focus.

1. List `backlog` tasks (by creation date or name)
2. Identify tasks with no recent activity
3. Prompt the user for each:
   - Promote to `todo`?
   - Keep in `backlog` (optionally set a review_date)?
   - Move to `canceled`?
4. Also check `on-hold` tasks for overdue review dates

## WIP Limit

Keep `in-progress` tasks to 5 or fewer as a guideline. Warn if exceeded:

> Currently N tasks are in-progress. Consider completing or putting one on-hold before starting another.

Tasks tagged `"project"` can be counted separately from the WIP limit.

## Effort Log Format

When recording work time, append to the Notes/Journals section:

```
LOG: [date] [time range or duration] [description]
```

Examples:

```
LOG: 2025-01-15 9:00-12:15 3h15m requirements -> implementation
LOG: 14:30-16:00 review feedback
LOG: 45m bug fix
```

## Key Principles

- **Proactive shelving**: Moving tasks to `on-hold` is a positive action. Use `review_date` to specify when to reconsider — not when to panic.
- **review_date as snooze**: You don't need to think about a task until its review_date arrives. When it does, decide: change status or defer again.
- **Capture everything in backlog**: Register first, decide later. Keeps your head clear.
- **Avoid priority numbers**: Due dates and review dates are usually enough. Use `priority: 1` only for genuine emergencies, temporarily.
