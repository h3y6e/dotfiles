# CLAUDE.md

## Orchestrator

Use ultrathink for complex task decomposition with parallel reads and sequential writes

### Process

1. Explore & Plan:
   - Scope analysis
   - Parallel: `WebSearch`, `WebFetch`, or context7
   - Iterative strategy refinement based on findings
2. Implement:
   - Sequential: `Write`, `Edit`, `MultiEdit`
   - Dependency-ordered execution
3. Verify:
   - Mandatory: format, lint, test
   - Parallel: read results
   - Sequential: fix errors
   - Repeat until pass

### Implementation

- `TodoWrite` for task classification
- Subagent tasks: information gathering, analysis
- Sequential tasks: all write operations
- Essential findings only between steps
- Brief summaries per step

## File Management

- Never use `rm` to delete files
- When removing files: use `mv` to `.trash.local/` folder in project root

## Naming Conventions

- Prohibit meaningless words (`common`, `util`, `result`) in all names
- Use descriptive names indicating purpose (exception: actual Result types)
- Prefer singular forms for modules/types
- Variables: descriptive names over simple plurals (`userList` not `users`)

## Error Handling

- Utilize error data when handling locally
- Log warnings with error details for non-fatal errors
- Never discard errors to `_`

## Comments

- Document top-level functions/types
- Skip obvious implementation details

## Verification

- Work is complete only when builds/tests pass and warnings resolved
- Report failures if unable to complete

## Testing

### Never modify tests

- Tests are specs: fix implementation when tests fail
- Exceptions: explicit request, syntax errors, contradictions (ask first)

### No test data dependencies

- Don't special-case test values (names, IDs)
- Causes: fragility, hidden specs, lack of generality

## Task Clarification

- When task requirements are unclear or ambiguous, ASK the user for clarification
- Do NOT make assumptions about implementation details
- It's better to ask questions than to guess wrong
- Feel free to ask without hesitation - clarification saves time

## Thinking

- ALWAYS think in English, regardless of the user's language
- Internal reasoning and analysis must be in English
- Only use other languages when communicating with the user

## Shell

- Default: `zsh`

## Markdown

- Avoid overuse of bold text and emojis
- Use `: ` instead of `：` even in Japanese text

## Git

- Branch: `fix/[name]`
- conventional commit message (no scope), imperative, "why" focused, no punctuation
- Minimal granularity
