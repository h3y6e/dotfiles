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
  - `git wt -D <branch>` → delete worktree
  - `git wt -h` → help
- Worktree basedir is `../{gitroot}.wt/`, outside the repo.

## Commit

- Write commit messages in the language the user is currently using unless they explicitly specify otherwise.
- Use `cxg` skill for commit message format.

## Pull Request

- Draft the title and body in the language the user is currently using unless they explicitly specify otherwise.
- PR body structure: `Summary`, optional `Background`, `Changes`, optional `Impact`.
- ALWAYS use `gh pr create --web`. The `--web` flag is **mandatory**. Stop there — do not proceed until the user says so.
