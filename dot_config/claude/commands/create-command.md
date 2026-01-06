---
description: Generate commands following established patterns
argument-hint: [command-name]
---

# Command Creator

## Task

Command creation specialist. Generate commands following established patterns.

## Context

Process: Understand purpose → Determine category → Choose location → Generate command → Create resources → Update docs

## Categories

1. **Planning**: Feature ideation/PRDs, stages, interactive, artifact
2. **Implementation**: Technical tasks, mode-based, patterns, state updates
3. **Analysis**: Review/audit, reports, recommendations
4. **Workflow**: Multi-step orchestration, dependencies, progress
5. **Utility**: Tools/helpers, simple ops

## Pattern research

Before creating:

1. List existing: `ls -la /.claude/commands/` or `$XDG_CONFIG_HOME/claude/commands/`
2. Study patterns: task structure, MCP tools, arguments, references

## Interview process

1. **Purpose**: Check similar commands → Problem/users/output/interactive?
2. **Classification**: Match to existing patterns
3. **Pattern**: Study similar command's task/args/MCP/docs/review sections
4. **Location**: Project (/.claude/commands/) vs User ($XDG_CONFIG_HOME/claude/commands/)
5. **Resources**: Check existing templates/guides

## Generation patterns

Copy from similar commands:

- Task updates: status/logs/checklist/decisions
- Human review: assumptions/technical/patterns flags

## Frontmatter Options

When generating commands, include appropriate frontmatter:

- `description`: Brief description of the command (shown in /help)
- `argument-hint`: Arguments expected (shown during auto-complete)
- `allowed-tools`: List of tools the command can use (e.g., `Bash(git:*)`, `Read`, `Edit`)
- `model`: Specific model string (optional)
- `disable-model-invocation`: Prevent SlashCommand tool from calling this command (optional)

## Bash Execution

Use `!` prefix for bash commands that execute before the command runs:

```
## Context

Current branch: !`git branch --show-current`
Git status: !`git status --short`
```

Note: Must include `allowed-tools` with `Bash` tool when using bash execution.

## File References

Use `@` prefix to include file contents:

```
Review the implementation in @src/utils/helpers.js
```

## Arguments

- `$ARGUMENTS`: Captures all arguments passed to the command
- `$1`, `$2`, etc.: Individual positional arguments

## Checklist

- [ ] Studied similar commands
- [ ] Naming convention (numeric prefix for workflows)
- [ ] Task/context structure
- [ ] References organizational guide
- [ ] Appropriate frontmatter (description, argument-hint, allowed-tools)
- [ ] Human review sections
- [ ] Clear examples
- [ ] Task state updates
- [ ] Documentation
- [ ] Correct prefix (project:/user:)

## Output

1. Command: {location/name/category/pattern}
2. Resources: {templates/docs}
3. Usage: `/{name}` with example
4. Next: Test → Refine → Document

Create command: $ARGUMENTS
