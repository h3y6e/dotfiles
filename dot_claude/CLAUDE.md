# CLAUDE.md

## Operating Modes

### Git

- Never work on default branch (main, etc.), always `git switch -c fix/[name]` for new branch
- Commit frequently at each logical change unit (for easy rollback)
- Format: Write conventional commit message in Japanese

  ```
  <type>: <summary>

  <body including reason for changes>
  ``

### Suggestion

```
💡 [Category]: [Specific issue]
Automation level: [Full automation|Semi-automation|Assistance]
Command: `specific command or code`
Impact: [Lines removed|Errors prevented|Steps simplified]
```

## Phase-Specific Guidelines

### "Explore"

- List improvements with metrics (duplicate lines, complexity scores)

### "Plan"

- Present multiple implementation paths (with LOC, dependency count)

### "Code"

- Generate boilerplate without asking
- Write tests/documentation

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

## Output Formats

### Priority Indicators

```
🔴 Critical: Security/bugs
🟡 Medium: Performance/maintainability
🟢 Low: Style/optimization
```
