---
compatibility: Requires git, gh, git-wt, and cxg.
description: Use when making code changes in a git repo, switching branches, or when asked to `push`, `commit`, `pr`, or manage branches. Use before starting implementation to confirm you're on the right branch.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/git-shipping
    github-ref: refs/tags/v2026.5.3
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 17d06fce4863bfcdfdc644325e51d449e1c6aa71
    version: 2026.5.3
name: git-shipping
---
# Git Shipping

Every code change flows through: branch → commit → push → PR. This skill ensures each step follows project conventions.

## Intent Expansion

Treat short git requests as workflow shorthand, not literal single commands.

| User says | What it means |
|-----------|---------------|
| `commit` | Inspect repo, stage coherent chunks, commit with proper message |
| `push` | Inspect repo, create coherent commits if needed, then push |
| `pr` | Inspect repo, move off default branch if needed, commit, push, open PR |

Ask only when the intended change scope is unclear enough that you might include unrelated work.

## Language Rule

Check repo visibility with `gh repo view --json visibility -q '.visibility'`.

- **PUBLIC**: Use English for commit messages, PR titles, and PR bodies.
- **PRIVATE / INTERNAL**: Use the language the user is currently using.

## Branch

Feature work belongs on a feature branch, not the default branch. Use `git wt` for all worktree operations.

When creating a new worktree, consider whether to carry over uncommitted work:

- **Moving in-progress work** (e.g., started on main, moving to a feature branch): `git wt <branch> --copymodified --copyuntracked`
- **Starting fresh** (e.g., separate, unrelated work): `git wt <branch>`

## Commit

**REQUIRED SUB-SKILL:** Use `cxg` skill for commit message format.

## Pull Request

- Prefer a repository PR template when one applies (`pull_request_template.*` or `PULL_REQUEST_TEMPLATE/`; use `gh pr create --template <file>` when useful).
- Fallback body structure only: `## Summary`, optional `## Background`, `## Changes`, optional `## Impact`.
- Default to draft PR (`gh pr create --draft`). Only create a ready PR when the user explicitly requests it.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Working directly on the default branch | `git wt <branch>` first |
| Treating `push` / `commit` as a single git command | Follow Intent Expansion above |
| Using `git worktree` directly | Use `git wt` — run `git wt -h` for help |
| Skipping `cxg lint` | Always pipe through `cxg lint` before committing |
