# Issue Sets

Read this when there are multiple independent outcomes, or a broad mechanical change that can't stay green all at once.

## Graph rules

- Default to a **tracer bullet** (the smallest vertical slice that verifies a requirement end to end); don't create layer-based nodes like schema, backend, frontend, and tests.
- Size each node so it completes in one fresh context and can land, demo, and verify on its own.
- Fold setup, configuration, and documentation into the first outcome that needs them.
- Add an edge only for a condition that blocks the downstream node from starting, not for "nice to have first."
- Assign each source requirement to one node, and record the reason for any intentional overlap.
- Don't turn an area you can't precisely question into a node by guessing.
  For an unknown that would change a downstream boundary, create only a research node whose question and needed evidence are explicit.

## Broad mechanical changes

Use only when one change breaks many call sites at once, so a vertical slice can't stay green on its own.

1. **Expand:** Let old and new coexist, preserving existing behavior.
2. **Migrate:** Move call sites unit by unit — package, directory, or similar blast-radius boundary.
3. **Contract:** Confirm every call site has migrated, then remove the old path.

Give each phase preconditions, verification, a stop condition, rollback or roll-forward, and completion criteria.
Each migrate node is blocked by Expand; Contract is blocked by every migrate node.

## Presenting the draft

```markdown
## Issue graph

1. <title>
   - Readiness: ready | blocked
   - Blocked by: none | <node title>
   - Covers: <source requirement>

## Source coverage

| Source item | Issue | Acceptance | Verification |
| --- | --- | --- | --- |
```

Confirm the graph is acyclic, has at least one frontier (a startable leading node), and can be published in blocker-first order.
