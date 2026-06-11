---
compatibility: Requires git, gh, cxg, and git-wt. Do not use raw git worktree.
description: Use when making code changes in a git repo, switching branches, or when asked to `push`, `commit`, `pr`, or manage branches. Use before starting implementation to confirm you're on the right branch.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/git-shipping
    github-ref: refs/tags/v2026.6.2
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 4d9978775c08af640ded8e5db545b0fcce0df5fb
    version: 2026.6.2
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

Start new feature work in a clean feature-branch worktree, not on the default branch.
When creating a worktree, check `git wt -h` before choosing flags and use `git wt`.
Do not call raw `git worktree` directly.

Do not move already-started work into a new worktree just to satisfy this workflow. If files are already being edited in the current checkout, keep working there and create or switch to the appropriate branch in place when safe.

## Commit

**REQUIRED SUB-SKILL:** Use `cxg` skill for commit message format.

## Pull Request

- Prefer a repository PR template when one applies.
- When no template applies, use only these sections, in this order: `## Summary`, `## Background`, `## Changes`, optional `## Impact`.
- Use `## Impact` only for behavior changed by merging the PR. Omit it when there is no behavior change; do not list unchanged behavior, non-goals, or work not done.
- Do not add ad hoc `Testing`, `Verification`, `Checklist`, `Related issues`, or `Screenshots` sections. Never dump every local verification command into the PR body.
- New PRs default to draft (`gh pr create --draft`); preserve existing PR draft/ready state unless asked.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Starting new work directly on the default branch | Create a clean feature-branch worktree first |
| Moving already-started work just to satisfy the workflow | Keep working in the current checkout; branch in place when safe, and ask before relocating changes |
| Copying modified or untracked files into new worktrees by default | Create clean worktrees; transfer in-progress changes only on explicit request |
| Treating `push` / `commit` as a single git command | Follow Intent Expansion above |
| Using raw `git worktree` | Use `git wt`; run `git wt -h` before choosing flags |
| Skipping `cxg lint` | Always pipe through `cxg lint` before committing |
