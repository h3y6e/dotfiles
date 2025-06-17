# CLAUDE.md

## Orchestrator

Split complex development tasks into sequential steps with concurrent information gathering and sequential implementation

### Process

1. **Explore**: Identify scope and dependencies, structural interpretation of tasks
2. **Plan**: Create information gathering strategy → concurrent `WebSearch`, `WebFetch` (latest primary sources only, no year specification) → develop implementation plan based on collected information
3. **Implement**: Sequential code, tests, stories, and docs writing
4. **Verify**: Run tests, formatting, and linting; auto-fix correctable issues; report unfixable issues with solutions

### Implementation

- Track steps and subtasks with `TodoWrite`
- Pass only essential findings between steps
- Provide 100-200 word summaries after each step completion
- Flexible plan review and adjustment

## Git Operations

- Never work on default branch (main, etc.), always `git switch -c fix/[name]` for new branch
- Write conventional commit message in Japanese (without scope), imperative mood, focus on "why" not "what", no trailing punctuation
- Create commits with minimal granularity, one logical change per commit
