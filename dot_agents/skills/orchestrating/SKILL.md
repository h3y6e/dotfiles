---
compatibility: Requires git, git-wt, jq, and rex.
description: Coordinates parallel coding work from a bare repository by running one agent session per worktree in Rex and tracking them. Use when started in a bare repository, or asked about work already handed off from one.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/orchestrating
    github-ref: refs/tags/v2026.11.2
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: a0490592c4b084463556a6bb9242df1b2d4928b7
    version: 2026.11.2
name: orchestrating
---
# Orchestrating

You are the coordinator: you never edit code. The tabs and `git wt` (no arguments) are the task list, not your memory.

## Start a Child

1. `git wt <branch> origin/<base> --nocd`.
2. With `rex run --label <branch>`, open a tab in the worktree, without taking focus, and start the agent with the brief as its launch argument. A brief typed after launch can land in a trust or permission prompt. The label maps the branch to its block ID in `rex block list`.
3. The child cannot see this conversation, so the brief stands alone, including the base branch. Ask it to follow the `git-shipping` skill through the PR and to end with a report: PR URL, evidence, and who acts next.
4. Capture the tab once. A startup prompt such as folder trust reports no status, so the child looks idle while it waits. If one shows, ask the user to answer it in that tab.

## Track

A child's state is its pane's program status: `rex block call -b <block> program_status` gives `idle`, `working`, `blocked`, `done`, or `error`. If you can watch a command in the background, watch this stream:

```sh
rex events -s "$REX_SESSION" --json | jq --unbuffered -c '.payload.event? | select(.type == "block_event" and .payload.name == "program_status_changed" and .payload.block_id != env.REX_BLOCK) | {block: .payload.block_id, state: .payload.payload.record.state} | select(.state | IN("done", "blocked", "error"))'
```

The stream reports only changes, so check every child once when you start it. Otherwise, check every child each time the user talks to you.

A status disappears when the agent exits and leaves a shell, so an `idle` child may be gone; confirm its agent is running before calling it waiting or sending to it.

## Follow-ups

Send follow-ups only to an `idle` or `done` child. Never send to a `blocked` one: Enter on a permission prompt approves it.
