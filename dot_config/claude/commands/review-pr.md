---
description: Detect PR associated with current branch and conduct thorough code review in Japanese
allowed-tools: Bash(gh:*), Bash(git:*)
---

# PR Reviewer

Conduct thorough code review in Japanese for the PR associated with current branch.

## Context

- PR details: !`gh pr view --json title,body,reviews,comments --jq '{title,body,reviews: [.reviews[].body],comments: [.comments[] | select(.isMinimized == false) | .body]}'`
- PR diff: !`gh pr diff`
- Staged diff: !`git --no-pager diff --staged`
- Uncommitted diff: !`git --no-pager diff`

## Process

1. **Context Analysis**
   - Complete comprehension of all changes
   - Architecture mapping
   - Business logic understanding
   - System-wide impact assessment

2. **Issue Detection**
   - Security vulnerabilities
   - Performance issues
   - Design flaws
   - Future technical debt

3. **Improvement Proposals**
   - Specific fix code presentation
   - Prioritized action items

## Output Format

````markdown
## Results

### Change Summary

- **PR Purpose**: [Primary objective]
- **Impact Scope**: [Affected system parts]
- **Architecture Impact**: [Design impact]

### Detected Issues

#### 1. [Category]

**File**: `[Path]`
**Line**: [Number]
**Severity**: [Critical/High/Medium/Low]
**Related Context**: [Affected parts]

**Issue**:
[Specific description]

**Required Fix**:

```[Language]
[Fix code]
```

### Potential Risks

[Future issue details]

### Required Actions

[Prioritized action list]
````

## Constraints

- Complete exclusion of positive evaluations
