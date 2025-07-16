# Spec

Generate structured specifications from requirements to implementation.

## Task

Transform feature requests into well-structured specifications with requirements, design, and implementation tasks following EARS notation and systematic design patterns.

## Context

Based on Kiro's spec methodology, this command creates a structured approach to bridge product requirements and technical implementation through three key documents: requirements, design, and tasks.

## Arguments

- `feature`: Feature name or description (required)
- `source`: requirements text or file path (optional)
- `format`: ears|user-story|custom (default: ears)

## Process

### Requirements generation

1. Analyze feature request and context
2. Generate EARS-formatted requirements:
   - WHEN [condition/event] THE SYSTEM SHALL [expected behavior]
   - Focus on clarity, testability, and completeness
3. Organize by user roles and scenarios
4. Include acceptance criteria

### Design documentation

1. Define technical architecture
2. Document:
   - System architecture and components
   - Data flow and interactions
   - Interface definitions
   - Data models and schemas
   - Error handling strategies
   - Testing approach

### Task breakdown

1. Create discrete, implementable tasks
2. Include for each task:
   - Clear description and scope
   - Expected outcomes
   - Dependencies and resources
   - Estimated complexity

## Implementation

### File structure
```
/.claude/specs/
├── [feature-name]/
│   ├── requirements.md   # Product requirements
│   ├── design.md        # Technical design
│   └── tasks.md         # Implementation tasks
```

### Requirements template
```markdown
# [Feature] Requirements

## Overview
[Brief feature description and business value]

## User Stories

### [User Role]
**R1**: WHEN [user initiates action] THE SYSTEM SHALL [respond appropriately]
**R2**: WHEN [system state changes] THE SYSTEM SHALL [update accordingly]

## Acceptance Criteria
- [ ] [Testable criterion]
- [ ] [Testable criterion]

## Constraints
- Performance: [Requirements]
- Security: [Requirements]
- Compatibility: [Requirements]
```

### Design template
```markdown
# [Feature] Technical Design

## Architecture
[High-level architecture diagram or description]

## Components
### [Component Name]
- Purpose: [What it does]
- Interfaces: [How it connects]
- Dependencies: [What it needs]

## Data Flow
1. [Step]: [Description]
2. [Step]: [Description]

## Data Models
```[language]
[Schema or type definitions]
```

## Error Handling
- [Error Case]: [Handling Strategy]

## Testing Strategy
- Unit: [Approach]
- Integration: [Approach]
- E2E: [Scenarios]
```

### Tasks template
```markdown
# [Feature] Implementation Tasks

## Phase 1: Foundation
- [ ] **Task 1**: [Description]
  - Outcome: [What success looks like]
  - Resources: [Files, docs, dependencies]
  
- [ ] **Task 2**: [Description]
  - Outcome: [Expected result]
  - Dependencies: [Task 1]

## Phase 2: Core Implementation
[Additional tasks organized by phase]

## Phase 3: Testing & Polish
[Testing and refinement tasks]
```

## Status updates

Update task with:
- Requirements generated
- Design decisions documented
- Tasks created and organized
- Dependencies identified

## References

- EARS notation: Easy Approach to Requirements Syntax
- Existing project patterns and conventions
- `.claude/steering/`: Project context files

## Examples

```bash
# Generate spec from description
/spec "user authentication with OAuth"

# Import existing requirements
/spec "shopping cart" --source requirements.txt

# Use custom format
/spec "payment processing" --format user-story
```

## Human review

Before finalizing:
- Are requirements clear and testable?
- Is the design aligned with project architecture?
- Are tasks discrete and implementable?
- Have all edge cases been considered?
- Are dependencies clearly identified?