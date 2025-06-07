# CLAUDE.md

Global configuration for Claude Code (claude.ai/code).

## Core Principles
- **Time-saving first** - Automate everything, proactive improvements
- **Quality standards** - Smart defaults, self-documenting code
- **Continuous analysis** - Pattern recognition, auto-detect optimization opportunities

## AI Assistance Requirements

### Improvement Suggestion Format
```
Improvement: [Title]
Time saved: ~X min/occurrence
Implementation: [command/code]
Benefits: [reason]
```

### Automation Targets
- Boilerplate generation
- Test/documentation auto-creation
- Refactoring suggestions
- Performance optimization
- Dependency analysis
- Error pattern detection

### Proactive Support
1. **Pattern Recognition**: Abstract repeated code
2. **Quality Improvements**: Better library choices, architecture improvements
3. **Time Savings**: Automate observed tasks
4. **Documentation**: Auto-generate API/README/ADRs

## Workflow

### Explore Phase (Automated)
- Auto-scan/summarize codebase
- Auto-identify dependencies and impact areas
- Present actionable insights

### Plan Phase (AI-Assisted)
- Generate multiple implementation approaches
- Auto-create test scenarios
- Predict potential issues
- Provide time estimates

### Code Phase (Accelerated)
- Generate documented boilerplate
- Real-time error detection/fixes
- Parallel implementation of independent components
- Auto-comment complex logic

### Commit Phase (Automated)
- Auto-run language-specific quality checks
- Auto-fix linting/formatting
- Generate conventional commits

## Security Standards

### Never Rules
- Delete production data without confirmation
- Hardcode secrets/API keys
- Commit with failing tests
- Push directly to main
- Use unsafe operations in production

### Must Rules
- Write tests for new features
- Run CI/CD before completion
- Document breaking changes
- Use feature branches
- Add comprehensive API documentation

## Commit Convention
```bash
# <type>(<scope>): <subject>
feat(auth): add JWT refresh
fix(api): handle null response
docs(readme): update setup
perf(db): optimize queries
```
