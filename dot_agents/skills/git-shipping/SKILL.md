---
compatibility: Requires git, gh, cxg, and git-wt. Do not use raw git worktree.
description: Guides the git workflow for shipping code changes — branch, commit, push, PR. Use whenever asked to `commit`, `push`, `pr`/`ship`/`open a PR`/`merge this`, or manage branches, and whenever about to make code changes in a git repo, to confirm the branch is right before implementation starts — even if the user only described the change and never said the word "git".
license: MIT
metadata:
    author: h3y6e
    github-path: skills/git-shipping
    github-ref: refs/tags/v2026.9.16
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: b47fbeb5cde51b21ec6d8d43ceff93411d89299a
    version: 2026.9.16
name: git-shipping
---
# Git Shipping

Code changes flow through: branch → commit → push → PR.

## Intent Expansion

Treat short git requests as workflow shorthand.

| User says | What it means |
|-----------|---------------|
| `commit` | Inspect, stage coherent chunks, commit |
| `push` | Inspect, create commits if needed, push |
| `pr` | Inspect, move off default branch if needed, commit, push, open PR |

Ask only when the intended change scope is unclear enough that you might include unrelated work.

## Language Rule

Check visibility with `gh repo view --json visibility -q '.visibility'`.

- **PUBLIC**: Use English for commit messages, PR titles, and PR bodies.
- **PRIVATE / INTERNAL**: Use the language the user is currently using.

## Branch

Start new feature work in a clean worktree from the remote default branch, not in the default-branch checkout.
Before creating it, check `git wt -h`, then use `git wt <branch> origin/<default-branch> --nocd`.
Never call raw `git worktree`.

New worktrees start clean; transfer in-progress changes only on request.

Do not move already-started work into a new worktree just to satisfy this workflow. If files are already being edited in the current checkout, keep working there and create or switch to the appropriate branch in place when safe.

## Commit

**REQUIRED SUB-SKILL:** Use `cxg` skill for commit message format. Pipe the message through `cxg lint` before committing.

## Pull Request

- PR titles use Conventional Commit subject format: `type(scope): subject`.
- Prefer a repository PR template when one applies.
- Without a template, use only: `## Summary`, `## Background`, `## Changes`, optional `## Impact`.
- Use `## Impact` only for merge behavior changes. Omit unchanged behavior, non-goals, and work not done.
- Do not add ad hoc `Testing`, `Verification`, `Checklist`, `Related issues`, or `Screenshots`. Never dump local verification commands into the PR body.
- Write the body to a `mktemp` file under `$TMPDIR`, never a fixed path — `gh pr create`/`gh pr edit` can reuse stale content, and plain `mktemp` can fail in a sandboxed shell.
- New PRs default to draft (`gh pr create --draft`); preserve existing PR draft/ready state unless asked.
- After pushing to a branch with an open PR, reread the title and body against the new diff and edit whatever no longer matches (`gh pr edit`).
