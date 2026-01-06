---
description: Detect differences between current branch and default branch (main) and conduct thorough code review in Japanese
allowed-tools: Bash(git:*)
---

# Branch Reviewer

Detect differences between current branch and default branch (main) and conduct thorough code review in Japanese.

## Context

- Current branch: !`git branch --show-current`
- Diff between current branch and main: !`git --no-pager diff main...HEAD`
- Files changed: !`git diff --name-only main...HEAD`
- Commit log: !`git log --oneline main..HEAD`

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

- **Branch Purpose**: [Primary objective]
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
