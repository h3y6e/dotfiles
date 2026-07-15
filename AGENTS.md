# Tools

- Use `trash` instead of `rm`.
- Prefer single quotes for shell arguments to avoid backtick command substitution.

# Workflow

- Use TDD skills before writing implementation code.
  - Tests are specifications: test code expresses the specification of the implementation.
  - In test code, explicitly mark each section with comments: `// Assert`, `// Act`, `// Arrange`.
  - Name tests with a sentence stating the situation, operation, and expected result in that order, e.g. "when a valid token is provided, retrieving user information succeeds".
- Act autonomously. Ask only for real trade-offs.
- For non-trivial changes, ask: "is there a more elegant way?"
- Validate before marking done. Prefer tool-specific checks. Skip trivial fixes.

# Task Management

- Use **tracking-tasks** skill for every task.
- Before starting any work: read tasks relevant to the current work.

# Language

- Conversation with the user: Japanese. Agent-facing guidance (`AGENTS.md`, Agent Skills): English.
- Other written artifacts (docs, descriptions, test names, commit messages, issue/PR titles and bodies, etc.):
  - Run `gh repo view --json visibility -q '.visibility'` to determine.
  - PUBLIC → English.
  - PRIVATE / INTERNAL / unknown → Japanese.
    - Use natural Japanese, not awkward mixed Japanese-English phrasing; leave English only for identifiers, product/library names, API names, and established terms when clearer.
    - Do not end Japanese description fields or similar prose with the Japanese full stop `。`.

# Writing Artifacts

- In docs, issues, PR bodies, and review comments, keep only non-obvious rationale, constraints, trade-offs, impact, and risks.
- Omit source/diff-obvious facts, restatements, and duplicate summaries.

# Principles

- Always use near-latest versions for dependencies.
- Simplicity first. Refactor boldly. No backward compatibility unless asked.
- Find root causes. No hacky fixes.
- Shorter is better. Brevity is beauty; beauty is read; read code has fewer bugs.
- Inline trivial expressions; avoid one-off variables.
- Prefer co-location: keep related code close together.
- Extract helpers only when called 3+ times and non-obvious.
- Never chase minimal diffs. Patchwork follows.
- Never add fallback logic "just in case". Let edge cases surface.
