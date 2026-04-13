---
name: spec-implement
description: Execute open tasks from specs/{feature}/plan.md using an implement → self-validate → fix loop, updating plan.md progress after each completed task. Use this skill whenever someone wants to start or continue feature implementation guided by plan.md, run a self-validating coding loop, continue from a specific task ID, or work through phased tasks with built-in quality checks. This is the execution phase after spec-plan in the spec-driven workflow. Don't use for ad-hoc bug fixes, code review, or implementation tasks not defined in plan.md.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.1"
---

# Implement Skill

## Purpose

Implement using `specs/{feature}/plan.md` as the single progress source.

**Iron Law:** No completion claims without fresh verification evidence. If you haven't run the command in this step, you cannot claim it passes.

## Input

- Existing `specs/constitution.md` when present
- `specs/{feature}/spec.md` and `specs/{feature}/plan.md`

## Output

- Implemented code with passing tests
- Updated `specs/{feature}/plan.md` (and `spec.md` if findings require it)
- Progress log entries with verification evidence

## Steps

1. Resolve `language` and shared rules from `specs/constitution.md` when present; otherwise infer from workflow documents and the user's message. Ask only if still unclear.
2. Confirm spec/plan approval state — both must be `approved` before work begins.
3. Process open tasks from top to bottom. Set `plan.md` to `in-progress` when work starts.
4. **Implementation loop** for each task:
   - Implement the smallest coherent slice
   - When testing is required to prove the task is complete, make the test change, verification command, and expected outcome explicit before claiming success
   - Classify findings: `local-only` (continue), `plan-impacting` (update plan, realign), `spec-impacting` (stop, return upstream)
   - Delegate deep investigation to `spec-research` when needed
   - Self-validate (tests, type checks, static analysis, security checks)
   - Fix until green
   - Run the actual verification command and read the output before claiming pass; never trust "should pass" or stale results
5. **Update `plan.md`** after each successful task:
   - Mark task complete, keep `status: in-progress` until all tasks and phase DoD items finish
   - Append under `## Progress Log` (create if missing):
     - Task: [TASK_ID] | Change: [SUMMARY] | Doc Impact: [local-only|plan-impacting|spec-impacting]
     - Validation: [PASS/FAIL + evidence] | Next: [NEXT_TASK]
6. Escalate exception cases: conflicting requirements, high-risk changes, unresolvable validation failures.
7. **Stop-the-line backflow** when findings change approved documents:
   - `plan-impacting`: update `plan.md`, realign before resuming
   - `spec-impacting`: update `spec.md`, reset to `draft`, stop until re-approved
8. Confirm DoD completion per phase. Set `plan.md` to `done` when all tasks and DoD items pass.
9. If documents are updated, review and keep within 150 lines.
10. Suggest next step: continue `spec-implement` or final completion report.

## Success Criteria

- `plan.md` progress matches actual implementation state
- Every task has fresh verification evidence (not stale or assumed)
- Findings that affect plan/spec trigger document realignment before continuing
- Phase DoD items are satisfied
- Non-exception issues resolved inside the self-validation loop

## Completion Guidance

- Next recommended step: continue `spec-implement` or close implementation
- Include completed tasks, remaining tasks, and the next task in the response
