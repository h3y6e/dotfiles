---
status: draft
summary: Execution plan for [FEATURE_NAME]
---

Place this file at `specs/{feature}/plan.md`.

## Summary

- [EXECUTION_SUMMARY]

## Execution Context

- Runtime/Platform: [RUNTIME_OR_PLATFORM]
- Implementation Dependencies: [PRIMARY_IMPLEMENTATION_DEPENDENCIES]
- Constraints: [EXECUTION_CONSTRAINTS]
- Validation: [VALIDATION_STRATEGY]

## Key Decisions

- [DECISION]

## Format

- `- [ ] Txxx (P) [USn] [DESCRIPTION] ([PATH])`
- `(P)` marks a parallelizable task
- `[USn]` links the task to a user story

## Phase 1: Setup

- [ ] T001 [SETUP_TASK]
- [ ] T002 (P) [SETUP_TASK]
- [ ] T003 [SPIKE_OR_RESEARCH_TASK_IF_NEEDED]

<!-- Use a spike/research task when uncertainty could change the spec, task order, or validation approach. -->

### DoD

- [ ] [DOD_CHECK]
- [ ] [DOD_CHECK]

## Phase 2: Foundational

- [ ] T004 [FOUNDATIONAL_TASK]
- [ ] T005 (P) [FOUNDATIONAL_TASK]

### DoD

- [ ] [DOD_CHECK]
- [ ] [DOD_CHECK]

## Phase [N]: User Story [N] (Priority: P[N])

- [ ] T0xx [USn] [IMPLEMENTATION_TASK]
- [ ] T0xx (P) [USn] [IMPLEMENTATION_TASK]

### DoD

- [ ] [DOD_CHECK]
- [ ] [DOD_CHECK]

[Add as many user story phases as needed]

## Phase N: Polish

- [ ] T0xx [POLISH_TASK]

### DoD

- [ ] [DOD_CHECK]
- [ ] [DOD_CHECK]

## Progress Log

- Task: [TASK_ID]
  Change: [CHANGE_SUMMARY]
  Doc Impact: [local-only | plan-impacting | spec-impacting]
  Validation: [PASS_FAIL_AND_EVIDENCE]
  Next: [NEXT_TASK]

<!-- If impact is `plan-impacting` or `spec-impacting`, stop and realign the documents before continuing implementation. -->
