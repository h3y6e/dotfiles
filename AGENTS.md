# Tools

- Use `context7` mcp to search docs.
- Use `gh_grep` mcp to search code from GitHub.
- Use `trash` instead of `rm`.
- Prefer installed tools: `rg`, `jq`, `yq`, `actionlint`, `shfmt`, `shellcheck`.
  - Avoid throwaway Python/Ruby scripts.
- Prefer single quotes for shell arguments to avoid backtick command substitution.

# Workflow

- Enter plan mode for non-trivial tasks. If something goes wrong, stop and re-plan.
- Use subagents liberally: one task per subagent, keep main context clean.
- Never mark a task done without relevant validation. Prefer tool-specific lint, format, test, or execution checks that match the files you changed.
- For creative/feature work, explore the problem space before implementing. Understand purpose, constraints, and success criteria first.

# Task Management

- Use **taskmd** skill.
- On session start: read tasks relevant to the current work.

# Principles

- Simplicity first. Refactor boldly, delete freely, no backward compatibility unless asked.
- No hacky fixes: find root causes, maintain senior-level standards.
- For non-trivial changes, pause and ask "is there a more elegant way?"
- Fix bugs autonomously—don't ask for hand-holding.
- Evidence before claims: no completion without running verification.
