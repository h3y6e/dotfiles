# CLAUDE.md

## Orchestrator

Ultrathink complex task decomposition with parallel reads and sequential writes

### Process

1. Explore & Plan:
   - Scope analysis
   - Parallel: `WebSearch`, `WebFetch`, or context7
   - Iterative strategy refinement based on findings
2. Implement:
   - Sequential: `Write`, `Edit`, `MultiEdit`
   - Dependency-ordered execution
   - Never delete files
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

## Shell

- Default: `zsh`

## Markdown

- Avoid overuse of bold text and emojis
- Use `: ` instead of `：` even in Japanese text

## Git

- Branch: `fix/[name]`
- conventional commit message (no scope), imperative, "why" focused, no punctuation
- Minimal granularity
