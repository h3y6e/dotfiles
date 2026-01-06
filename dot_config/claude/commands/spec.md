---
description: Generate comprehensive technical specifications following professional standards
argument-hint: <feature-description>
---

# Spec

Generate comprehensive technical specifications following professional standards.

## Input

`$ARGUMENTS` - Feature description to generate specifications for

## Overview

Creates structured technical specifications with requirements, design, and implementation tasks following industry best practices and BDD methodology.

## Process

### 1. Requirements Analysis

- Extract user stories in "As a [role], I want [goal], so that [benefit]" format
- Define acceptance criteria using WHEN/THEN conditions (BDD style)
- Identify functional and non-functional requirements
- Document constraints and business rules
- **Create 1-requirements.md and ask for user feedback**

### 2. Technical Design

- Define comprehensive architecture with rationale
- Detail component hierarchy and interfaces
- Specify data models and API contracts
- Address cross-cutting concerns (security, performance, accessibility, i18n)
- Plan error handling and testing strategies
- **Create 2-design.md and ask for user feedback**

### 3. Implementation Planning

- Break down into traceable, actionable tasks
- Reference requirements for each task
- Define dependencies and execution order
- Include testing, optimization, and validation tasks
- **Create 3-tasks.md and ask for user feedback**

### Interactive Review Process

After creating each document:

1. Present the document to the user
2. Ask: "この[要件定義/技術設計/実装タスク]に修正したい点はありますか？修正が必要であれば指摘してください。問題なければ次のドキュメント作成に進みます。"
3. Apply any requested changes before proceeding
4. Continue to the next phase only after user approval

## File Structure

Creates specifications under `docs/spec/[feature-name]/`:

```
docs/spec/[feature-name]/
├── 1-requirements.md    # User stories and acceptance criteria
├── 2-design.md         # Technical architecture and implementation
└── 3-tasks.md          # Implementation plan with traceability
```

## Templates

### Requirements Template

```markdown
# [Feature Name] Requirements

## Introduction

Brief overview of the feature and its business value.

## User Stories

### Story 1: [Description]

**As a** [user role]  
**I want** [goal]  
**So that** [benefit]

#### Acceptance Criteria

- **When** [condition] **then** [expected behavior]
- **When** [condition] **then** [expected behavior]

## Requirements

### Requirement 1: [Title]

[Detailed requirement description]

### Requirement 2: [Title]

[Detailed requirement description]

## Constraints

- Performance: [Requirements]
- Security: [Requirements]
- Compatibility: [Requirements]

## Business Rules

- [Rule 1]
- [Rule 2]
```

### Design Template

````markdown
# [Feature Name] Technical Design

## Architecture Overview

High-level architecture description with rationale for design decisions.

## URL Structure

```
/path/structure → Description
/path/structure → Description
```

## Component Hierarchy

```
ComponentName
├── SubComponent1
├── SubComponent2
└── SubComponent3
```

## File Structure

```
src/
├── component/
├── screen/
└── domain/
```

## Data Models

```typescript
interface Props {
  property: type;
}
```

## API Integration

Description of API endpoints and data flow.

## Error Handling

- Error Case 1: Handling strategy
- Error Case 2: Handling strategy

## Testing Strategy

- Unit Testing: Approach
- Integration Testing: Approach
- E2E Testing: Scenarios

## Performance Considerations

- Optimization strategies
- Performance metrics

## Security Considerations

- Authentication/Authorization
- Data protection

## Accessibility

- ARIA compliance
- Keyboard navigation
- Screen reader support

## Internationalization

- Translation keys
- Locale-specific considerations

## Migration Strategy

- Backward compatibility
- Rollout plan
````

### Tasks Template

```markdown
# [Feature Name] Implementation Tasks

## Phase 1: Foundation

- [ ] **Task 1**: [Description]
  - Requirements: 1.1, 2.1
  - Implementation: [Specific steps]
  - Files: [File paths]
  - Dependencies: None

- [ ] **Task 2**: [Description]
  - Requirements: 1.2, 3.1
  - Implementation: [Specific steps]
  - Files: [File paths]
  - Dependencies: Task 1

## Phase 2: Core Implementation

[Additional phases...]

## Phase 3: Testing & Validation

[Testing and validation tasks...]

## Dependencies

- Task A → Task B → Task C
- Task D can run in parallel with Task A

## Completion Criteria

- [ ] All requirements implemented
- [ ] All tests passing
- [ ] Performance benchmarks met
- [ ] Security review completed
- [ ] Accessibility audit passed
```

## Quality Standards

### Language

- Use Japanese for all technical documentation
- Professional, clear, and concise writing
- Consistent terminology throughout

### Structure

- Logical information hierarchy
- Cross-references between documents
- Traceability from requirements through implementation

### Content

- Comprehensive coverage of functional and non-functional requirements
- Detailed technical implementation guidance
- Production-ready considerations
- Testable acceptance criteria

### Traceability

- Requirements numbered for reference
- Tasks linked to specific requirements
- Clear dependency mapping

## Workflow Example

```
User: /spec "user authentication system with OAuth2 support"

Claude: [Creates 1-requirements.md]
        この要件定義に修正したい点はありますか？修正が必要であれば指摘してください。問題なければ次のドキュメント作成に進みます。

User: パスワードリセット機能も追加してください

Claude: [Updates 1-requirements.md with password reset feature]
        修正しました。他に修正点はありますか？

User: 問題ありません

Claude: [Creates 2-design.md]
        この技術設計に修正したい点はありますか？...

[Process continues for each document]
```

## Implementation Notes

- Analyze existing codebase patterns before generating specifications
- Reference established architectural patterns in the project
- Consider existing components and utilities for reuse
- Align with project's technology stack and conventions
- Include migration considerations for existing functionality

Generate specifications for: $ARGUMENTS
