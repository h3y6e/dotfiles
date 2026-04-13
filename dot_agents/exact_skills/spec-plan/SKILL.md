---
name: spec-plan
description: Create or update specs/{feature}/plan.md by turning an approved spec into one execution-ready document with key technical decisions, phased tasks, IDs (T001...), parallel candidates (P), story linkage, TDD-oriented bite-sized steps, and Definition of Done per phase. Use this skill whenever someone wants to translate a spec into concrete implementation work without maintaining a separate execution-design file, create a structured task checklist for a feature, add DoD to task phases, or create/update plan.md. This follows spec-specify and precedes spec-implement in the spec-driven workflow. Don't use for general to-do lists or project management outside the spec workflow.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.1"
---

# Plan Skill

## Purpose

**Core principle:** Write plans assuming the engineer has zero codebase context. Document everything they need: which files, what code, how to test, how to verify. No guessing.

Create or update `specs/{feature}/plan.md` as the execution source of truth, including technical context, key decisions, phased tasks, and completion conditions.

## Input

- Existing `specs/constitution.md` when present
- `specs/{feature}/spec.md`

## Output

- `specs/{feature}/plan.md`
- `specs/{feature}/spec.md` when backflow is required

## Steps

1. Resolve `language` and shared rules from `specs/constitution.md` when present; otherwise infer from the available workflow documents and the user's own message. Ask only if still unclear, then conduct all subsequent interaction in this language.
2. Read `spec.md`, extract user stories and constraints, and confirm spec approval state.
   - Require `spec.md` to be `approved` before generating the execution plan
3. Create the plan from `references/plan-template.md`.
   - Summary
   - Execution Context
   - Key Decisions
   - Phases: Setup, Foundational, User Story (P1, P2, ...), Polish
   - When uncertainty could change the spec or plan structure, delegate to `spec-research` instead of investigating inline
4. Map out the file structure before defining tasks.
   - List which files will be created or modified and what each one is responsible for
   - Prefer smaller, focused files over large ones that do too much; files that change together should live together
   - In existing codebases, follow established patterns; if a file has grown unwieldy, include a split in the plan
5. Capture only execution-facing detail that must stay aligned during implementation.
   - Record technical context, constraints, validation strategy, and key decisions here instead of splitting them into another document
   - Reference the spec for user-facing intent rather than repeating full story prose
6. Standardize the task format.
   - `- [ ] Txxx ...`
   - Use `(P)` for parallel candidates
   - Use `[USn]` for story linkage
   - Assume the implementer is skilled but has little codebase or domain context; each task should be a single action that can be completed quickly and independently
   - When testing is required, make the expected test change, verification command, and expected outcome explicit instead of assuming the implementer will fill them in
   - Every task must contain the concrete content needed to execute it; do not use placeholders such as "TBD", "TODO", "implement later", "fill in details", or references like "Similar to Task N"
   - Do not defer critical details behind vague instructions such as "Add appropriate error handling" or "Write tests for the above"; spell out the required work directly
7. Add `DoD` under each phase.
   - Include checks for testing, observability, and rollback readiness
   - Write DoD as proof that the phase itself is complete
8. Express dependencies through phase order and task descriptions.
   - Place high-uncertainty discovery work before irreversible implementation tasks
9. Run backflow if requirement gaps or contradictions are discovered.
    - Update `spec.md`
    - Reset `spec.md` status to `draft`
10. Update frontmatter.
    - Required keys: `status`, `summary`
    - Initial `status`: `draft`
    - Set `status: approved` when the plan is ready for implementation
11. Perform final review and keep the file within 150 lines.
    - Remove repetition
    - Simplify wording
    - Resolve contradictions
12. In the completion message, suggest the next step.
     - After approval: `spec-implement`
     - If requirement changes are needed: `spec-specify`
     - If technical investigation is needed: `spec-research`

## Success Criteria

- The plan combines execution design and delivery sequencing without requiring another execution document.
- The plan supports independent delivery by story.
- Each phase has a clear DoD.
- `(P)` marks valid parallel work.
- Every task contains concrete code, commands, and expected output — no placeholders.
- High-uncertainty work is front-loaded as spike or research tasks when needed.
- Backflow handling is explicit.

## Completion Guidance

- Next recommended step: `spec-implement`
- If technical investigation is needed before proceeding: `spec-research`
- Include the target feature and generated `plan.md` path in the response
