# Spec Review

Iteratively refine and update specifications based on implementation progress.

## Task

Review and update existing specifications, mark completed tasks, refine requirements based on learnings, and ensure spec documents remain accurate throughout the development lifecycle.

## Context

Specifications evolve during implementation. This command facilitates the iterative refinement of specs, tracking task completion, updating designs based on discoveries, and maintaining alignment between documentation and implementation.

## Arguments

- `feature`: Feature name to review (required)
- `aspect`: requirements|design|tasks|all (default: all)
- `update-type`: refine|complete|add|remove (optional)

## Process

### Review current state

1. Load existing spec documents
2. Analyze implementation progress
3. Identify:
   - Completed tasks
   - Outdated requirements
   - Design changes needed
   - New discoveries

### Update specifications

1. **Requirements updates**:
   - Refine based on user feedback
   - Add discovered edge cases
   - Update acceptance criteria
   - Mark deprecated requirements

2. **Design updates**:
   - Document architecture changes
   - Update data models
   - Revise component interactions
   - Add implementation learnings

3. **Task updates**:
   - Mark completed tasks
   - Add new tasks discovered
   - Update task dependencies
   - Revise estimates

### Generate reports

1. Progress summary
2. Changes made
3. Remaining work
4. Recommendations

## Implementation

### Review workflow
```
1. Analyze current specs
   ↓
2. Check implementation status
   ↓
3. Identify gaps/changes
   ↓
4. Update documents
   ↓
5. Generate summary
```

### Progress tracking
```markdown
# Task Completion Status

## Completed ✓
- [x] Task 1: [Description] - [Date]
- [x] Task 2: [Description] - [Date]

## In Progress 🔄
- [ ] Task 3: [Description] - 70% complete

## Blocked 🚫
- [ ] Task 4: [Description] - Waiting on [dependency]

## New Tasks 🆕
- [ ] Task 5: [Description] - Discovered during Task 2
```

### Requirements evolution
```markdown
# Requirements Changelog

## Added
- **R10**: WHEN [new scenario] THE SYSTEM SHALL [behavior]
  - Reason: Discovered during user testing

## Modified
- **R3**: Updated to include [edge case]
  - Original: [old requirement]
  - Updated: [new requirement]
  - Reason: [justification]

## Deprecated
- ~~**R5**: No longer applicable~~
  - Reason: [architecture change]
```

### Design refinements
```markdown
# Design Updates

## Architecture Changes
- Component X now directly communicates with Y
- Removed intermediate service Z
- Reason: [Performance improvement]

## Data Model Updates
```diff
interface User {
  id: string;
  email: string;
+ lastLogin: Date;
+ preferences: UserPreferences;
- legacyField: any;
}
```

## New Patterns Discovered
- [Pattern]: [Description and usage]
```

## Status updates

Update task with:
- Specs reviewed and updated
- Completion percentage
- Major changes documented
- Next steps identified

## References

- `.claude/specs/`: Specification documents
- `.claude/steering/`: Project context
- Implementation files referenced in tasks

## Examples

```bash
# Review all aspects of a feature
/spec-review "user-authentication"

# Update only task completion
/spec-review "shopping-cart" --aspect tasks --update-type complete

# Refine requirements based on feedback
/spec-review "payment-processing" --aspect requirements --update-type refine

# Add new discovered tasks
/spec-review "search-feature" --aspect tasks --update-type add
```

## Human review

Before finalizing updates:
- Are all changes justified and documented?
- Do updates maintain consistency?
- Are new discoveries properly captured?
- Is the progression logical?
- Are stakeholders informed of major changes?