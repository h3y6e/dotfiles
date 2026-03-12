# git-wt Reference

> Source: <https://github.com/k1LoW/git-wt>

A Git subcommand that makes `git worktree` simple.

## Commands

```console
git wt                            # List all worktrees
git wt <branch|worktree|path>     # Switch to worktree (create worktree/branch if needed)
git wt --nocd <branch>            # Create/switch worktree without changing directory (prints path)
git wt --json                     # List all worktrees in JSON format
```

## Target Types

- branch: `git wt feature-branch`
- worktree: directory name relative to basedir
- path: absolute or relative filesystem path to existing worktree
