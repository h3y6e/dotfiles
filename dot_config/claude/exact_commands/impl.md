---
description: Sequentially implement tasks from specification documents with proper git commits and PR creation
argument-hint: <spec-name>
allowed-tools: Bash(git:*), Bash(gh:*), Bash(mise:*), Bash(pnpm:*), Read, Edit
---

# Impl Command

Sequentially implement tasks from specification documents with proper git commits and PR creation.

## Input

`$ARGUMENTS` - Specification name (corresponds to directory under `docs/spec/`)

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`
- Recent commits: !`git log --oneline -5`

## Overview

This command automates the implementation of tasks defined in specification documents created by `/spec`. It implements each task as a separate git commit, ensuring clean version history and enabling easy review. Upon completion, it creates a GitHub pull request.

## Process

### 1. Task Analysis

- Load specification documents from `docs/spec/$ARGUMENTS/`:
  - `1-requirements.md` - Understand user stories and acceptance criteria
  - `2-design.md` - Review technical architecture and implementation details
  - `3-tasks.md` - Get task list and dependencies
- Identify incomplete tasks
- Analyze dependencies between tasks
- Create implementation plan based on requirements and design

### 2. Sequential Implementation

For each incomplete task:

- Mark task as in-progress `- [-]` in `3-tasks.md`
- Check task dependencies
- Implement the task following specifications
- Run tests and linting
- Update task status to completed `- [x]` in `3-tasks.md`
- Create atomic git commit with conventional commit message (including both implementation and 3-tasks.md update)

### 3. Quality Assurance

- Run full test suite after each commit
- Ensure linting passes
- Check for breaking changes
- Validate against acceptance criteria

### 4. Pull Request Creation

- Create feature branch if needed
- Push all commits
- Generate comprehensive PR description
- Include task completion checklist

## Implementation Strategy

### Branch Management

```bash
# Create feature branch from spec name
git checkout -b feat/$ARGUMENTS

# Commit spec documents to track progress
git add docs/spec/$ARGUMENTS/
git commit -m "docs: add $ARGUMENTS specification documents"

# Or continue on existing branch
git branch --show-current
```

### Commit Convention

Each task gets one commit with format:

```
feat: [task description]

- Implement [specific functionality]
- Add [tests/documentation]
- Update [related files]
```

### Task Selection

1. Start with tasks marked as high priority
2. Respect dependency order
3. Skip blocked tasks
4. Group related small tasks when appropriate

### Error Handling

- If tests fail, fix before committing
- If linting fails, auto-fix when possible
- If task is blocked, skip and document reason
- If critical error, rollback and report

## Task Tracking

### Status Updates

During implementation:

- Edit `3-tasks.md` directly
- Use `- [-]` for task currently in progress
- Change to `- [x]` when task is completed
- Keep original file structure intact

Example progression:

```markdown
# Before starting

- [ ] **Task 6**: ページネーション機能の実装

# During implementation

- [-] **Task 6**: ページネーション機能の実装

# After completion

- [x] **Task 6**: ページネーション機能の実装
```

### Progress Reporting

- Update task status in-place in `3-tasks.md`
- Log implementation decisions in git commits
- Document any deviations in PR description

## Git Workflow

### Pre-implementation Checks

```bash
# Ensure clean working directory
git status

# Pull latest changes
git pull origin main

# Create/switch to feature branch
git switch -c feat/$ARGUMENTS

# Run initial checks to ensure environment is ready
mise x -- pnpm check
mise x -- pnpm test run
```

### Per-Task Flow

```bash
# 1. Mark task as in-progress in 3-tasks.md
# Edit 3-tasks.md: change "- [ ]" to "- [-]"

# 2. Implement task
# [implementation steps]

# 3. Stage changes
git add [files]

# 4. Commit with message
git commit -m "feat: [task description]"
```

### PR Creation

```bash
# Push branch
git push -u origin feat/$ARGUMENTS

# Create PR via GitHub CLI
gh pr create \
  --title "feat: $ARGUMENTS" \
  --body "[generated description]" \
  --web
```

## Task Implementation Guidelines

### Code Quality Standards

- Follow existing patterns in codebase
- Maintain consistent code style
- Add appropriate comments for complex logic
- Ensure proper error handling

### Testing Requirements

- Write tests for new functionality
- Update existing tests if needed
- Maintain test coverage
- Run full test suite before commit

### Documentation

- Update relevant documentation
- Add JSDoc comments for new functions
- Update README if needed
- Create Storybook stories when applicable

## Progress Tracking

The command maintains progress in:

- Git commit history
- Task status in original `3-tasks.md` (edited in-place)
- PR description with checklist

## Human Review Points

Before starting:

- Is the working directory clean?
- Are all dependencies installed?
- Is the feature branch appropriate?

During implementation:

- Are the changes following the spec?
- Is the code quality acceptable?
- Are tests comprehensive?

Before PR:

- Are all tasks complete?
- Is the PR description clear?
- Are there any breaking changes?

## Error Recovery

If implementation fails:

1. Check error logs
2. Rollback incomplete changes
3. Document blockers
4. Skip to next viable task

## Completion Criteria

Implementation is complete when:

- [ ] All high-priority tasks are implemented
- [ ] All tests pass
- [ ] Linting passes
- [ ] Code review ready
- [ ] PR created with proper documentation

## References

- Spec documents: `docs/spec/$ARGUMENTS/`
  - `1-requirements.md` - User stories and acceptance criteria
  - `2-design.md` - Technical architecture and design decisions
  - `3-tasks.md` - Implementation tasks (edited in-place)
- Git conventions: Conventional Commits

Implement the spec: $ARGUMENTS
