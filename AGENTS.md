# Tools

- Use `context7` mcp to search docs.
- Use `gh_grep` mcp to search code from GitHub. Never use `gh api`.
- Use `trash` instead of `rm`.
- Prefer installed tools: `rg`, `jq`, `yq`, `actionlint`, `shfmt`, `shellcheck`.
  - Avoid throwaway Python/Ruby scripts.
- Prefer single quotes for shell arguments to avoid backtick command substitution.

# Workflow

- Enter plan mode for non-trivial tasks. If something goes wrong, stop and re-plan.
- Use subagents liberally: one task per subagent, keep main context clean.
- Never mark a task done without relevant validation. Prefer tool-specific lint, format, test, or execution checks that match the files you changed.

# Task Management

- Use **taskmd** skill.
- On session start: read tasks relevant to the current work.

# Principles

- Simplicity first: minimal code, minimal impact. Improve aggressively—no backward compatibility or migration paths unless explicitly asked. This is a personal dotfiles repo, not a public library. Refactor boldly, delete freely, simplify relentlessly.
- No hacky fixes: find root causes, maintain senior-level standards.
- For non-trivial changes, pause and ask "is there a more elegant way?"
- Fix bugs autonomously—don't ask for hand-holding.
