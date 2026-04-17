---
name: git-wf
description: Git branch, commit, push, and PR workflow. Use before making code changes in a git repo, on branch switch, or when the user says `push` or `pr`.
compatibility: Requires git, gh, and git-wt.
---

# Git Workflow

## Intent Expansion

- Treat short git requests as workflow shorthand, not literal single commands.
  - `push` means: inspect repo, create coherent commits if needed, then push.
  - `pr` means: inspect repo, move off default branch if needed, commit, push, and open the PR.
- Ask only when the intended change scope is unclear enough that you might include unrelated work.

## Branch

- Do not keep feature work on the default branch.
- Use `git wt` for all worktree operations. It has no subcommands — any argument is treated as a branch name.
  - `git wt` (no args) → list worktrees
  - `git wt <branch>` → switch/create worktree
  - `git wt <branch> --copymodified --copyuntracked` → switch/create while copying files
  - `git wt -h` → help
- Worktree basedir is `../{gitroot}.wt/`, outside the repo.

## Commit

- Use English for commit messages if the working directory is a public repo; otherwise, use the language the user is currently using.
- Use `cxg` skill for commit message format.

## Pull Request

- Draft the title and body in English if the working directory is a public repo; otherwise, use the language the user is currently using.
- PR body structure: `## Summary`, optional `## Background`, `## Changes`, optional `## Impact`.
- ALWAYS create as draft PR.
