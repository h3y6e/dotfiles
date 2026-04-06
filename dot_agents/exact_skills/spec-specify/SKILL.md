---
name: spec-specify
description: Create or update specs/{feature}/spec.md from user requirements — writing user stories, functional requirements, acceptance criteria, and resolving ambiguity through focused questions. Use this skill whenever someone wants to document feature requirements, write a specification, turn ideas or user research into a formal spec, update spec.md, or says "create a spec for [feature]". This is the first required step in the spec-driven workflow and typically follows spec-constitution when a team uses shared constitutional rules. Don't use for execution design, task decomposition, bug fixes, or implementation.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.0"
---

# Specify Skill

## Purpose

Create or update `specs/{feature}/spec.md` from user requirements.
Resolve ambiguity within this skill before handing off to downstream phases.

## Input

- User requirements
- Existing `specs/constitution.md` when present
- Existing `specs/{feature}/spec.md` when present

## Output

- `specs/{feature}/spec.md`

## Steps

1. Resolve `language` and shared rules from `specs/constitution.md` when present; otherwise infer from the available workflow documents and the user's own message. Ask only if still unclear, then conduct all subsequent interaction in this language.
2. Decide the feature slug and target `specs/{feature}/`.
3. Create the spec from `references/spec-template.md`.
   - Keep the spec focused on user needs, behavior, business rules, and constraints
   - Avoid locking in technical design choices unless the user explicitly requires them
   - If optional or secondary capabilities can stand alone, prefer splitting them into separate specs instead of expanding the current one
   - Write acceptance scenarios as natural sentences that still make context, action, and outcome explicit; avoid forcing literal `Given/When/Then` wording when it hurts readability
4. Run a specification self-review.
   - Scope
   - Data
   - UX
   - Non-Functional
   - Integration
   - Edge
   - Terminology
   - Ambiguity
   - Completion
5. Ask only high-impact clarification questions.
   - Actively look for ambiguity that would materially change scope, behavior, data, UX, or downstream execution design
   - Resolve high-impact ambiguity before recommending the next phase
   - Delegate low-impact open points to `spec-research` for investigation
6. Integrate answers directly into the spec.
7. Update frontmatter.
   - Required keys: `status`, `summary`
   - Initial `status`: `draft`
   - Set `status: approved` when no unresolved high-impact ambiguity remains and the spec is ready for execution design and tasking
8. Perform final review and keep the file within 150 lines.
   - Remove repetition
   - Simplify wording
   - Resolve contradictions
9. In the completion message, suggest the next step.
   - If review-ready: `spec-plan`
   - If open points need investigation: `spec-research`
   - If more refinement is needed: continue `spec-specify`

## Success Criteria

- Prioritized user stories include at least one P1 story.
- Acceptance scenarios are testable.
- Functional requirements align with success criteria.
- No unresolved high-impact ambiguity remains before handoff.

## Completion Guidance

- Next recommended step: `spec-plan` (or `spec-research` if open points remain)
- Include the target feature and generated `spec.md` path in the response