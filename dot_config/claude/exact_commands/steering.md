---
description: Project-specific context management for consistent code generation
argument-hint: <action: create|update|list|review> [domain: product|tech|structure|custom]
---

# Steering

Project-specific context management for consistent code generation.

## Task

Create and manage project-specific context files to ensure consistent code generation and architectural alignment across all Claude interactions.

## Context

Steering files provide persistent, project-specific guidance that Claude automatically references, similar to Kiro's steering concept. These files capture conventions, standards, and architectural decisions to ensure consistency across the codebase.

## Input

- `$1` - Action: create|update|list|review (required)
- `$2` - Domain: product|tech|structure|custom (optional)
- `$3` - Custom domain name (if domain=custom)

## Process

### Create steering files

1. Analyze project structure and existing code
2. Generate appropriate steering files:
   - `product.md`: Product purpose, objectives, user personas
   - `tech.md`: Technology stack, constraints, dependencies
   - `structure.md`: File organization, architectural patterns
   - Custom domains as needed

### Update steering files

1. Review current steering content
2. Identify gaps or outdated information
3. Update with current project state
4. Ensure consistency across all steering files

### Review effectiveness

1. Analyze recent code generation
2. Check adherence to steering guidelines
3. Identify areas for improvement
4. Update steering files as needed

## Implementation

### File structure

```
/.claude/steering/
├── product.md      # Product objectives and requirements
├── tech.md         # Technology decisions and constraints
├── structure.md    # Architecture and file organization
└── [custom].md     # Domain-specific guidance
```

### Product steering template

```markdown
# Product Steering

## Purpose

[Clear product mission statement]

## Target Users

- Primary: [User persona and needs]
- Secondary: [Additional user groups]

## Core Features

1. [Feature]: [Purpose and value]
2. [Feature]: [Purpose and value]

## Success Metrics

- [Metric]: [Target and rationale]

## Constraints

- [Business/regulatory constraints]
```

### Tech steering template

```markdown
# Technology Steering

## Stack

- Language: [Primary language and version]
- Framework: [Framework and version]
- Database: [Database choice and rationale]
- Infrastructure: [Deployment environment]

## Conventions

- Code style: [Style guide reference]
- Testing: [Testing approach and tools]
- State management: [Patterns used]

## Dependencies

- [Package]: [Purpose and version constraints]

## Performance Requirements

- [Requirement]: [Target and measurement]

## Security Considerations

- [Security requirement or practice]
```

### Structure steering template

```markdown
# Structure Steering

## Directory Organization

project/
├── src/
│ ├── components/ # [Purpose]
│ ├── services/ # [Purpose]
│ └── utils/ # [Purpose]
└── tests/ # [Testing structure]

## Architectural Patterns

- Pattern: [Description and usage]
- Data flow: [How data moves through the system]

## Naming Conventions

- Files: [Convention with examples]
- Components: [Convention with examples]
- Functions: [Convention with examples]

## Module Boundaries

- [Module]: [Responsibilities and interfaces]
```

## Status updates

Update task with:

- Files created/updated
- Key decisions captured
- Consistency improvements identified

## References

- `.claude/CLAUDE.md`: Global project instructions
- `.claude/commands/`: Other command patterns
- Existing code patterns and conventions

## Human review

Before finalizing:

- Are steering files comprehensive yet focused?
- Do they capture actual project patterns?
- Are examples concrete and relevant?
- Is sensitive information excluded?
- Will they improve code consistency?

Execute: /steering $1 $2 $3
