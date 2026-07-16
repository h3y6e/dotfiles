---
description: Creates draft content for new issues as a single issue or dependency-aware issue set. Use when the user explicitly asks to turn a conversation or source material into a new issue/ticket draft or decompose work into multiple issue drafts. Do not use for implementing or reviewing existing issues, publishing an already-approved draft, or authoring issue templates.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/creating-issues
    github-ref: refs/tags/v2026.7.1
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 7a5507a41b20be505102f26e6b75927edd1493fd
    version: 2026.7.1
name: creating-issues
---
# Creating Issues

Build an approvable issue graph from source material — a conversation, existing issue, spec, plan, audit, research, or feedback.
A **node** is one issue; an **edge** is a dependency between nodes.
A single issue is just a one-node graph — skip the singular-vs-plural choice.

## Boundaries

- Scope is creating new issues or improving existing ones, not implementation, triage, or status review.
- If you can't state the problem or an observable outcome, stop and ask the user to confirm it.
- Write for an implementer with no context, but repository access.
- File paths and code snippets go stale as implementation proceeds; write abstractly, and pin down specifics only when required.

## Process

### 1. Check sources and existing issues

Read all source material — comments and links too, for an existing issue — plus any needed repository context.
Check the issue template, language, labels, and issue type.
Judge duplicates by shared problem or decision, not wording.

**Completion criteria:** Sources and duplicates are listed; include/exclude/merge is reasoned.

### 2. Determine readiness

Each node's `readiness` is `ready` or `blocked`.
Extract requirements, decisions, constraints, and risks, and classify each as explicit, inferred/assumed, unknown, or contradicted.
Handle unknowns and contradictions by what they affect:

| Affects | Next action |
| --- | --- |
| The problem/outcome itself | Stop and ask the user to confirm it |
| The answer/feasibility (outcome is clear) | Mark `ready` as a research issue |
| Implementation details only | Mark `ready` as a normal issue |
| Scope, acceptance criteria, or an irreversible decision | Add a **decision gate**; mark dependents `blocked` |

**Completion criteria:** No outcome-changing unknown or contradiction is hidden in an inference or assumption.

### 3. Decide the issue graph

Use one node if it completes in one fresh context, with no intermediate result or rollback boundary that lands independently.
For multiple independently approvable, implementable, and verifiable outcomes, or a broad mechanical change, read [issue set rules](references/issue-sets.md).
When the work doesn't fit one fresh context and independent outcomes aren't identifiable yet, create only a research node that determines the boundary.

**Completion criteria:** Each node has one coherent outcome; edges reflect only real start conditions.

### 4. Write each node

Put the title, readiness, and dependency edges in the node's metadata; body follows the template below.
Don't leave empty sections.
Keep the body to durable intent, constraints, acceptance criteria, and judgment criteria; add implementation steps only when their order is itself a contract.

```markdown
## Sources and rationale

- Facts stated explicitly in the sources, with their references
- Claims filled in by inference or assumption where not stated explicitly, with their rationale and how to confirm them
- Anything that remains unknown
- Any contradictions within the sources

## Problem

- The observable problem today (what is wrong, and why it matters)

## Outcome

- The observable state after completion (what changes, and how)

## Scope

- In scope:
- Preserve:
- Out of scope:

## Acceptance criteria

- [ ] Observable expected result
- [ ] Absence of a prohibited result

## Verification

- Verification method, judgment criteria, and expected evidence a third party can use to decide pass/fail

## Decision gate

- Open question that branches the outcome, and the evidence needed
```

For a bug, research, migration, or architecture-change node only, read [issue type rules](references/issue-types.md) and follow the applicable heading.
A research node can be `ready` with unknowns remaining, as long as its question, needed evidence, and stop condition are clear.
Don't write planned verification as already-obtained evidence.

### 5. Inspect the whole graph

- Map each requirement, decision, constraint, and risk to one node's acceptance criteria and verification, or to a justified out-of-scope item.
- Resolve scope overlap, missing requirements, cyclic edges, `TBD`/`TODO`, and unjudgeable acceptance criteria.
- Confirm each node can start from its body and repository information alone, and its pass/fail can be judged independently.
- Confirm the graph has at least one node that isn't `blocked`.

### 6. Separate approval from publishing

Present the final draft, source coverage, duplicate candidates, and dependency edges, then get approval for the title, body, node granularity, and edges.
Only when publishing is requested, the target tracker is known, every node to publish is `ready`, and the graph is approved, read [publishing an issue](references/publishing.md).
Stop at the draft stage when the tracker is unknown or any node to publish is `blocked`.
