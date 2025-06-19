# Bug fixer

Systematic bug investigation and resolution with comprehensive testing.

## Task

Investigate, fix, and verify bugs following test-driven approach.

## Process

1. **Bug Analysis**

   - Reproduce the issue
   - Identify root cause through debugging
   - Map affected components and dependencies
   - Review related code and tests

2. **Solution Development**

   - Write failing test cases first (TDD)
   - Implement minimal fix
   - Consider edge cases and side effects
   - Update documentation if needed

3. **Verification**

   - Run all affected tests
   - Verify fix doesn't break existing functionality
   - Check performance impact
   - Ensure code quality (lint, type-check)

4. **Documentation**
   - Update comments and docstrings
   - Document the fix approach
   - Note any breaking changes

## Workflow

```bash
# 1. Understand the bug
git status
git log --oneline -10
gh issue view <issue-number> || echo "No issue linked"

# 2. Create bug branch
git checkout -b fix/bug-description

# 3. Reproduce and debug
# Run tests, use debugger, analyze logs

# 4. Fix and verify
# Implement fix with tests
# Run: test, lint, type-check

# 5. Document and commit
git add -A
git commit -m "fix: <concise description of what was fixed>"
```

## Investigation Tools

- **Error Analysis**: Stack traces, error messages, logs
- **Code Search**: grep/ripgrep for related patterns
- **Git History**: `git blame`, `git log -p` for context
- **Test Coverage**: Identify missing test scenarios
- **Dependency Check**: Verify version compatibility

## Fix Patterns

1. **Null/Undefined Handling**: Add proper guards
2. **Type Mismatches**: Fix type definitions or casting
3. **Race Conditions**: Add proper synchronization
4. **Logic Errors**: Correct conditionals and flow
5. **Edge Cases**: Handle boundary conditions

## Verification Checklist

- [ ] Bug is reproducible before fix
- [ ] Test case fails without fix
- [ ] Test case passes with fix
- [ ] All existing tests still pass
- [ ] No new lint/type errors
- [ ] Performance not degraded
- [ ] Code follows project conventions

## Output Format

```markdown
## Bug Fix Summary

**Issue**: [Brief description]
**Root Cause**: [Technical explanation]
**Solution**: [What was changed and why]

### Changes Made

1. [File:line] - [What was changed]
2. [File:line] - [What was changed]

### Tests Added/Modified

- [Test file] - [Test description]

### Verification

- ✅ Bug no longer reproduces
- ✅ All tests passing
- ✅ No regressions found

### Follow-up Actions

- [ ] [Any additional tasks needed]
```

## Arguments

- `<issue-id>`: GitHub issue number or bug description
- `--quick`: Skip comprehensive testing (use with caution)

## Example

```
/bugfixer 123
/bugfixer "TypeError in user login"
/bugfixer --quick "Fix typo in error message"
```
