# Tools

- Use `trash` instead of `rm`.
- Prefer installed tools: `rg`, `jq`, `yq`, `actionlint`, `pinact`, `ghalint`, `zizmor`, `hadolint`, `shfmt`, `shellcheck`, `gh`.
  - Avoid throwaway Python/Ruby/Node scripts.
- Prefer single quotes for shell arguments to avoid backtick command substitution.

# Workflow

- For creative/feature work, explore the problem space before implementing. Understand purpose, constraints, and success criteria first.
- Use **tdd** skill when implementing any feature or bugfix, before writing implementation code.
- If something goes wrong, stop and re-plan before pushing forward.
- Never mark a task done without relevant validation. Prefer tool-specific lint, format, test, or execution checks that match the files you changed.
  - Skip validation when the change is trivially correct (e.g. typo fix, comment edit).

# Task Management

- Use **tracking-tasks** skill.
- On session start: read tasks relevant to the current work.

# Language

- Conversation with the user: Japanese.
- Agent-facing guidance (`AGENTS.md`, Agent Skills): English.
- Other written artifacts (docs, commit messages, issue/PR titles and bodies, etc.):
  - Run `gh repo view --json visibility -q '.visibility'` to determine.
  - PUBLIC → English.
  - PRIVATE / INTERNAL / unknown → natural Japanese.
    - Write prose for Japanese readers, not literal translations of English source terms.
    - Use natural Japanese; leave English only for identifiers, product/library names, API names, and established terms when clearer.

# Writing Artifacts

- In docs, issues, PR bodies, and review comments, keep only non-obvious rationale, constraints, trade-offs, impact, and risks.
- Omit source/diff-obvious facts, restatements, and duplicate summaries.

# Principles

- Always use the latest or near-latest versions for dependencies.
- Simplicity first. Refactor boldly, delete freely, no backward compatibility unless asked.
- No hacky fixes: find root causes, maintain senior-level standards.
- For non-trivial changes, pause and ask "is there a more elegant way?"
- Act autonomously. Resolve ambiguity yourself; only ask when a real trade-off needs user judgment.
- Never extract trivial expressions into named helper functions. Inline them at the call site.
  - A helper is justified only when it is called 3+ times AND encapsulates non-obvious logic.
- Avoid one-off variables that merely rename an expression without adding clarity.
