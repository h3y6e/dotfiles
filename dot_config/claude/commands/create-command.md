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

1. List existing: `ls -la /.claude/commands/` or `~/.claude/commands/`
2. Study patterns: task structure, MCP tools, arguments, references
3. Use MCP tools NOT CLI: ✅ `mcp__scopecraft-cmd__task_create` ❌ `scopecraft task list`

## Interview process

1. **Purpose**: Check similar commands → Problem/users/output/interactive?
2. **Classification**: Match to existing patterns
3. **Pattern**: Study similar command's task/args/MCP/docs/review sections
4. **Location**: Project (/.claude/commands/) vs User (~/.claude/commands/)
5. **Resources**: Check existing templates/guides

## Generation patterns

Copy from similar commands:

- MCP usage: `mcp__scopecraft-cmd__task_create/update/list`
- Task updates: status/logs/checklist/decisions
- Human review: assumptions/technical/patterns flags

## Checklist

- [ ] Studied similar commands
- [ ] Naming convention (numeric prefix for workflows)
- [ ] Task/context structure
- [ ] References organizational guide
- [ ] MCP tools (not CLI)
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
