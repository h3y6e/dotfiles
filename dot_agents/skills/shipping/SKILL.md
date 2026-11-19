---
compatibility: Requires git, gh, cxg, and the orchestrating, no-comments, code-review, and security-review skills.
description: Ships code changes from branch to merge — branch, commit, push, PR, checks, merge. Use whenever asked to `commit`, `push`, `pr`/`ship`/`open a PR`/`merge this`, or manage branches, and whenever about to make code changes in a git repo, to confirm the branch is right before implementation starts — even if the user only described the change and never said the word "git".
license: MIT
metadata:
    author: h3y6e
    github-path: skills/shipping
    github-ref: refs/tags/v2026.11.4
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: af3b7c847444c7b75cef8ef8c8977f31bd313aad
    version: 2026.11.4
name: shipping
---
# Shipping

Code changes flow through: branch → commit → push → PR → merge.

## Intent Expansion

Treat short git requests as workflow shorthand.

| User says | What it means |
|-----------|---------------|
| `commit` | Inspect, stage coherent chunks, commit |
| `push` | Inspect, create commits if needed, push |
| `pr` | Inspect, move off default branch if needed, commit, push, open PR |

Ask only when the intended change scope is unclear enough that you might include unrelated work.

## Branch

In a bare repository, follow the `orchestrating` skill instead.
In a worktree, keep working there. Do not move already-started work into a new worktree; create or switch to the appropriate branch in place when safe.

Give each change its own PR against the default branch; stacks delay merging. Stack only when the upper PR cannot work until the lower merges, and manage the stack with `gh stack`.

## Commit

Do not change an agreed API or design just to pass tests; if it must change, ask first with the reason.

Before committing, run the `no-comments` skill on the touched files.

Use the `cxg-commit` skill for the commit message format, and pipe the message through `cxg lint` before committing.

On a PR branch, keep history as meaningful units, not a log of attempts. Rewrite it with `git history` (see `git history -h`; `reword` opens `GIT_EDITOR`), and push with `--force-with-lease`.

## Pull Request

- PR titles use Conventional Commit subject format: `type(scope): subject`.
- Read [the PR body format](references/pr-body.md) before writing the body, even with a repository PR template.
- Create the PR with `gh pr create --draft --body-file <file>`, adding `--attach <image>` for each image the body references by that same path.
- Leave an existing PR's draft/ready state alone unless asked.
- After each push to a branch with an open PR, reread the title and body against the diff and `gh pr edit` what no longer matches.

## Review Loop

After opening a PR, read [the review loop](references/review-loop.md) and run it before reporting back.

## Monitor

An open PR is not done. After each push, wait on its required checks with `gh pr checks <branch> --watch` and fix failures before reporting; checks you chose to run locally do not replace them. Settle new reviews with `receiving-code-review`. Report its CI, review, and merge state from `gh pr view --json state,mergeStateStatus,statusCheckRollup,reviewDecision`.

## Merge

When strict required checks leave the PR `BEHIND`, rebase it onto the default branch before merging, or use the merge queue if the repository has one. After a behavior-changing PR deploys to staging, verify the behavior there and comment the result on the PR.
