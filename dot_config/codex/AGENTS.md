# AGENTS.md

## File Management

- Never use `rm` to delete files
- When removing files: use `trash` on macOS
- Never execute python scripts

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

## Markdown

- Avoid overuse of bold text and emojis
- Use `: ` instead of `：` even in Japanese text

## Git

- Branch: `fix/[name]`
- conventional commit message (no scope), imperative, "why" focused, no punctuation
- Minimal granularity

## Context7

- Always use context7 when I need code generation, setup or configuration steps, or library/API documentation.
- This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.
