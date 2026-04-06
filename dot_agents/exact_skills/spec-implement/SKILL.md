---
name: spec-implement
description: Execute open tasks from specs/{feature}/plan.md using an implement → self-validate → fix loop, updating plan.md progress after each completed task. Use this skill whenever someone wants to start or continue feature implementation guided by plan.md, run a self-validating coding loop, continue from a specific task ID, or work through phased tasks with built-in quality checks. This is the execution phase after spec-plan in the spec-driven workflow. Don't use for ad-hoc bug fixes, code review, or implementation tasks not defined in plan.md.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.0"
---

# Implement Skill

## Purpose

Implement using `specs/{feature}/plan.md` as the single progress source.

## Input

- Existing `specs/constitution.md` when present
- `specs/{feature}/spec.md`
- `specs/{feature}/plan.md`

## Output

- Implemented code
- `specs/{feature}/plan.md` when implementation findings change execution design
- `specs/{feature}/spec.md` when implementation findings change requirements
- Progress updates in `specs/{feature}/plan.md`

## Steps

1. Resolve `language` and shared rules from `specs/constitution.md` when present; otherwise infer from the available workflow documents and the user's own message. Ask only if still unclear, then conduct all subsequent interaction in this language.
2. Confirm spec/plan approval state.
   - Require `spec.md` and `plan.md` to be `approved` before implementation begins
3. Process open tasks from top to bottom.
   - Set `plan.md` to `in-progress` when implementation work starts
4. Run an implementation loop for each task.
   - Implement the smallest coherent slice
   - Classify new findings immediately:
     - `local-only`: stays within approved task intent; continue in the current loop
     - `plan-impacting`: changes sequencing, technical approach, dependencies, or validation strategy; update `plan.md`, then resume only after it is aligned
     - `spec-impacting`: changes user-visible behavior, scope, acceptance scenarios, or requirements; stop implementation and return to upstream phases
   - When external platform, library, API, or framework findings need deeper investigation, delegate to `spec-research` instead of recording them inline
   - Self-validate (tests, type checks, static checks, security checks)
   - Fix
5. Update `plan.md` after each successful task.
   - Mark the task as complete
   - Keep `status: in-progress` until all tasks and phase DoD items are complete, then set `status: done`
   - Append evidence under `## Progress Log` (create the section if missing)
   - Record progress in this format:
     - Task: [TASK_ID]
     - Change: [CHANGE_SUMMARY]
     - Doc Impact: [local-only | plan-impacting | spec-impacting]
     - Validation: [PASS_FAIL_AND_EVIDENCE]
     - Next: [NEXT_TASK]
6. Escalate only exception cases.
   - Conflicting requirements
   - High-risk changes
   - Validation failures that cannot be resolved in-loop
7. Run stop-the-line backflow when implementation findings change approved documents.
   - For `plan-impacting`, update `plan.md`, then resume only after it is realigned with the approved spec
   - For `spec-impacting`, update `spec.md`, reset `spec.md` status to `draft`, and stop implementation until upstream documents are approved again
   - Never let implementation continue ahead of approved spec/plan documents after a `plan-impacting` or `spec-impacting` discovery
8. Confirm DoD completion and place outputs in the repository structure.
   - Check each phase DoD when that phase's tasks are complete
   - Set `plan.md` to `done` when all tasks and phase DoD items are complete
9. If documents are updated, perform final review and keep them within 150 lines.
   - Remove repetition
   - Simplify wording
   - Resolve contradictions
10. In the completion message, suggest the next step.
   - If open tasks remain: continue `spec-implement`
   - If all tasks are complete: final completion report

## Success Criteria

- `plan.md` progress matches actual implementation state.
- Findings that affect the plan or spec trigger document realignment before implementation continues.
- Phase DoD items are satisfied.
- Non-exception issues are resolved inside the self-validation loop.

## Completion Guidance

- Next recommended step: continue `spec-implement` or close implementation
- Include completed tasks, remaining tasks, and the next task in the response