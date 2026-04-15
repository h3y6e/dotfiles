# Tools

- Use `context7` mcp to search docs.
- Use `gh_grep` mcp to search code from GitHub.
- Use `trash` instead of `rm`.
- Prefer installed tools: `rg`, `jq`, `yq`, `actionlint`, `pinact`, `shfmt`, `shellcheck`, `gh`.
  - Avoid throwaway Python/Ruby/Node scripts.
- Prefer single quotes for shell arguments to avoid backtick command substitution.

# Workflow

- Never mark a task done without relevant validation. Prefer tool-specific lint, format, test, or execution checks that match the files you changed.
- For creative/feature work, explore the problem space before implementing. Understand purpose, constraints, and success criteria first.
- If something goes wrong, stop and re-plan before pushing forward.

# Task Management

- Use **taskmd** skill.
- On session start: read tasks relevant to the current work.

# Principles

- Always use the latest or near-latest versions for dependencies.
- Simplicity first. Refactor boldly, delete freely, no backward compatibility unless asked.
- No hacky fixes: find root causes, maintain senior-level standards.
- For non-trivial changes, pause and ask "is there a more elegant way?"
- Act autonomously. Resolve ambiguity yourself; only ask when a real trade-off needs user judgment.
- Prefer inline code; avoid one-off variables and non-reused helpers.
- Evidence before claims: no completion without running verification.
