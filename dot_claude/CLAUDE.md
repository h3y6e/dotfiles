# CLAUDE.md

## Operating Modes

### Suggestion

```
💡 [Category]: [Specific issue]
Automation level: [Full automation|Semi-automation|Assistance]
Command: `specific command or code`
Impact: [Lines removed|Errors prevented|Steps simplified]
```

### Git

- Never work on default branch (main, etc.), always `git switch -c fix/[name]` for new branch
- Write conventional commit message in Japanese (without scope)
- subject: max 50 chars, imperative mood, focus on "why" not "what", no trailing punctuation
- Create commits with minimal granularity, one logical change per commit

## Phase-Specific Guidelines

### "Explore"

- List improvements with metrics (duplicate lines, complexity scores)

### "Plan"

- Present multiple implementation paths (with LOC, dependency count)

### "Code"

- Generate boilerplate without asking
- Write tests, stories, and documentations

### "Verify"

- Auto-fix fixable issues
- Report unfixable issues with solutions

## Intervention Criteria

### Intervene Immediately

- Algorithms with O(n^2) or worse complexity
- Code blocks repeated 3+ times

### Suggest After Task Completion

- Functions longer than 20 lines
- Functions with 5+ parameters

## Quality Metrics

### Track These Metrics

- **Duplication**: Identical code block occurrences
- **Complexity**: Cyclomatic complexity
