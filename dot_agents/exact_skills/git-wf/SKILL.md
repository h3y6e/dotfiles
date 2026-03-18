---
name: git-wf
description: Git branch, commit, push, and PR workflow using `git-wt`. Use before making code changes in a git repo, on branch switch, or when the user says `push` or `pr`.
compatibility: Requires git, gh, and git-wt.
---

# Git Workflow

## Intent Expansion

- Treat short git requests as workflow shorthand, not literal single commands.
  - `push` means: inspect repo, create coherent commits if needed, then push.
  - `pr` means: inspect repo, move off default branch if needed, commit, push, and open the PR.
- Ask only when the intended change scope is unclear enough that you might include unrelated work.

## Worktree Preference

- Prefer `git wt` (or `git wt --nocd` for non-interactive use) over `git switch` for all branch operations (switching, creating, resuming). 
  - Basedir is `../{gitroot}.wt`, outside the repo. 
  - See [git-wt reference](references/git-wt.md) for details.
- Prefer worktrees over stashing when preserving dirty work.
- Reuse an existing worktree if the target branch already has one.
- Do not keep feature work on the default branch.

## Commit

- Write commit messages in the language the user is currently using unless they explicitly specify otherwise.

## Pull Request

- Draft the title and body in the language the user is currently using unless they explicitly specify otherwise.
- PR body structure: `Summary`, optional `Background`, `Changes`, optional `Impact`.
- ALWAYS use `gh pr create --web`. The `--web` flag is **mandatory**.
