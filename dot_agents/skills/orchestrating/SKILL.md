---
compatibility: Requires git, git-wt, jq, and rex.
description: Coordinates parallel coding work from a bare repository by running one agent session per worktree in Rex and tracking them. Use when started in a bare repository, or asked about work already handed off from one.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/orchestrating
    github-ref: refs/tags/v2026.11.4
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: d7a390caaf5d71e59ee2cb345c37e1ba1dc11f7f
    version: 2026.11.4
name: orchestrating
---
# Orchestrating

You are the coordinator: you never edit code; spend your context on briefs and results. Rex's sidebar lists windows by name: one agent per named window, yours the session's first, named via `rex window rename coordinator`. Windows and `git wt` are the task list, not memory.

## Start a Child

Start a child per branch and per context-heavy task: browsing, large documents, or logs. A new window costs a re-brief, lost detail, and the prompt cache: give related work to the child holding its context; start one only for an independent topic.

Give a PR stack to one child and worktree; `gh stack rebase` stops on another worktree's uncommitted changes.

1. For a branch, `git wt <branch> origin/<base> --nocd`. Other work starts in an existing worktree or scratch directory, never the coordinator's bare repository.
2. `sh scripts/open-window.sh <name> <dir> <agent> <brief>` starts the agent in an unfocused window; name is the branch, or the topic. A brief typed later can hit a trust or permission prompt.
3. The brief stands alone, including the base branch. A branch child follows the `shipping` skill through the PR; a checks list misses required ones. Others report and stop. Reports open with who does what next (`You: merge #12`), then the PR URL and evidence. Also:
   - Before posting externally, changing shared or production state, or bulk-exporting personal data (it trips production alerts), get the user's approval with count and filter.
   - At a login page, have the user log in in a headed browser and continue.
   - Run dev servers and log tails in your window via `rex split -b "$REX_BLOCK"`.
4. Capture it once: startup prompts like folder trust show no status; have the user answer.

## Track

A child's state: `rex block call -b <block> program_status`. Watch in the background with a per-line streaming tool (e.g. Claude Code's Monitor): `sh scripts/watch-children.sh` for stopping children, and one watch per PR whose merge gates your next step, in any repository or merged by anyone, added on opening. One-shot watches need restarts; one miss hides a stopped child.

It reports only changes; check children at start. Watch a PR until `state` is `MERGED` or `CLOSED`; a change watch misses an earlier merge. On each notice, read `rex capture -b <label>` and act.

`done` means the agent is free, not finished; confirm what still runs (`gh pr checks --watch`). Check its commits' `decision` and `rejected` lines and PR diff against the agreed design and API, raising departures with the user.

Decide beforehand what each merge triggers: stack rebase, `git wt -d <branch>` and `rex window close <name>`, readying the next PR. Follow up on later failures, conflicts, or reviews. User-facing progress lists show only open items and whose turn each is.

## Follow-ups

Send only to an `idle` or `done` child whose agent still runs; Enter on a `blocked` one approves its prompt. For a `working` child, even to change direction, `rex send` once from a background loop on `done`; never retract.
