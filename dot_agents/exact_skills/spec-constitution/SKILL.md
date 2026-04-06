---
name: spec-constitution
description: Use when a team wants to create or update specs/constitution.md to define durable principles that govern spec-skills runs, especially when starting a new workflow, revising shared governance for the spec-driven phases, or deciding what belongs in constitutional rules versus lower-level docs.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.0"
---

# Constitution Skill

## Purpose

Create or update `specs/constitution.md` when the team wants shared rules that spec-skills should apply during their own workflow.

## Input

- User-provided project rules (via prompt or conversation)
- Existing `specs/constitution.md` when present

## Output

- `specs/constitution.md`

## Steps

1. Determine `language`.
   - Use the existing `specs/constitution.md` frontmatter value if present
   - Otherwise infer from the user's own message (never from this SKILL.md or system instructions)
   - If still unknown, ask the user before proceeding
   - Conduct all subsequent interaction in this language
2. Read `specs/constitution.md`; if missing, initialize from `references/constitution-template.md`.
3. Keep the document structure aligned with `references/constitution-template.md`.
   - Do not invent additional top-level sections unless the user explicitly requests them
4. Update Core Principles based on user-provided rules.
    - Ask the user if no rules were provided
    - Keep only stable, project-wide principles here when they are meant to guide spec-skills phases
    - Prefer durable decision principles over implementation details
    - Do not copy concrete coding conventions, framework APIs, directory names, commands, or tool-specific rules into the constitution unless the user explicitly wants to elevate them into permanent governance
    - Even when the user requests elevation, include such a rule only if it is intended to remain valid across features and over time; otherwise keep it in lower-level docs
    - The constitution should govern spec-skills behavior and outputs, not become a general repository policy file by default
5. Add variable project rules only when the user specifies them.
    - Fold them into existing principles when possible
    - If a rule belongs more naturally in `AGENTS.md`, contribution docs, or feature documents, keep it out of the constitution and preserve that separation
6. Update frontmatter.
   - Required keys: `language`, `summary`
7. If updating an existing constitution, verify consistency with existing feature documents.
    - Check `specs/{feature}/spec.md` and `plan.md`
    - Preserve consistency by removing contradictions, not by copying feature-level implementation detail into the constitution
    - Skip this step when no feature documents exist
8. Perform final review and keep the file within 150 lines.
   - Remove repetition
   - Simplify wording
   - Resolve contradictions
9. In the completion message, suggest the next step.
   - New feature: `spec-specify`
   - Existing feature update: `spec-specify` for the target `spec.md`

## Success Criteria

- Constitution reflects the shared rules that spec-skills should use during the workflow.
- Constitution stays at the level of durable governing principles rather than duplicating lower-level implementation guidance.
- Frontmatter values are valid and complete.
- Related feature documents stay consistent.

## Completion Guidance

- Next recommended step: `spec-specify`
- Include the target feature and next file path in the response
