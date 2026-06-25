---
compatibility: Requires git, gh, cxg, and git-wt. Do not use raw git worktree.
description: Use when making code changes in a git repo, switching branches, or when asked to `push`, `commit`, `pr`, or manage branches. Use before starting implementation to confirm you're on the right branch.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/git-shipping
    github-ref: refs/tags/v2026.6.7
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 875bfe7cc09d6d33a3238412bc462b01115f05db
    version: 2026.6.7
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

Do not move already-started work into a new worktree just to satisfy this workflow. If files are already being edited in the current checkout, keep working there and create or switch to the appropriate branch in place when safe.

## Commit

**REQUIRED SUB-SKILL:** Use `cxg` skill for commit message format.

## Pull Request

- PR titles use Conventional Commit subject format: `type(scope): subject`.
- Prefer a repository PR template when one applies.
- Without a template, use only: `## Summary`, `## Background`, `## Changes`, optional `## Impact`.
- Use `## Impact` only for merge behavior changes. Omit unchanged behavior, non-goals, and work not done.
- Do not add ad hoc `Testing`, `Verification`, `Checklist`, `Related issues`, or `Screenshots`. Never dump local verification commands into the PR body.
- New PRs default to draft (`gh pr create --draft`); preserve existing PR draft/ready state unless asked.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Starting new work on the default branch | Create a clean feature worktree |
| Moving already-started work just to satisfy this workflow | Keep the current checkout; branch in place when safe |
| Copying modified or untracked files into new worktrees by default | Create clean worktrees; transfer in-progress changes only on request |
| Treating `push` / `commit` as one git command | Follow Intent Expansion |
| Using a prose PR title | Use Conventional Commit subject format: `type(scope): subject` |
| Using raw `git worktree` | Use `git wt <branch> origin/<default-branch> --nocd`; check `git wt -h` first |
| Skipping `cxg lint` | Pipe through `cxg lint` before committing |
