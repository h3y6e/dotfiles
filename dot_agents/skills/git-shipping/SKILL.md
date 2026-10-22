---
compatibility: Requires git, gh, cxg, and git-wt.
description: Guides the git workflow for shipping code changes — branch, commit, push, PR. Use whenever asked to `commit`, `push`, `pr`/`ship`/`open a PR`/`merge this`, or manage branches, and whenever about to make code changes in a git repo, to confirm the branch is right before implementation starts — even if the user only described the change and never said the word "git".
license: MIT
metadata:
    author: h3y6e
    github-path: skills/git-shipping
    github-ref: refs/tags/v2026.10.5
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 38bfd10d15e4c0af12bbec8cd28d2281f00bc4cd
    version: 2026.10.5
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

Write commit messages, PR titles, and PR bodies in the language the repository's recent commits and PRs already use. With no precedent, English if `gh repo view --json visibility -q '.visibility'` is `PUBLIC`, else the user's language.

## Branch

Start new feature work in a clean worktree from the remote default branch, not in the default-branch checkout.
Before creating it, check `git wt -h`, then use `git wt <branch> origin/<default-branch> --nocd`.
Use `git wt` rather than raw `git worktree` so worktrees follow the repository's configured layout.

New worktrees start clean; transfer in-progress changes only on request.

Do not move already-started work into a new worktree just to satisfy this workflow. If files are already being edited in the current checkout, keep working there and create or switch to the appropriate branch in place when safe.

## Commit

Use the `cxg` skill for the commit message format, and pipe the message through `cxg lint` before committing.

## Pull Request

- PR titles use Conventional Commit subject format: `type(scope): subject`.
- Prefer a repository PR template when one applies; otherwise read [the PR body format](references/pr-body.md) before writing the body.
- Create the PR with `gh pr create --draft --body-file <file>`, adding `--attach <image>` for each image the body references by that same path.
- Leave an existing PR's draft/ready state alone unless asked.
- After each push to a branch with an open PR, reread the title and body against the diff and `gh pr edit` what no longer matches.

## Review Loop

After opening a PR, read [the review loop](references/review-loop.md) and run it before reporting back.
