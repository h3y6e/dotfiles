---
name: spec-research
description: Investigate a specific topic and record findings in specs/{feature}/research/{topic}.md — covering technical options, library comparisons, API constraints, architecture trade-offs, or any open question that needs evidence before a decision can be made. Use this skill whenever someone wants to research a topic independently of spec/plan/implement phases, compare technical alternatives, investigate an API or platform constraint, run a proof of concept and document results, or says "research [topic]". This is a utility skill that can be invoked from any point in the spec-driven workflow or standalone. Don't use for writing specs, creating plans, or implementing code.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.0"
---

# Research Skill

## Purpose

Investigate a focused topic and produce `specs/{feature}/research/{topic}.md` with findings, a decision, and impact assessment.
This skill can be invoked independently or from any other skill when deeper investigation is needed.

## Input

- Research question or topic from the user
- Existing `specs/constitution.md` when present
- Existing `specs/{feature}/spec.md` when present
- Existing `specs/{feature}/plan.md` when present
- Existing `specs/{feature}/research/*.md` when present

## Output

- `specs/{feature}/research/{topic}.md`
- Updated `specs/{feature}/spec.md` when findings change requirements
- Updated `specs/{feature}/plan.md` when findings change execution design

## Steps

1. Resolve `language` and shared rules from `specs/constitution.md` when present; otherwise infer from the available workflow documents and the user's own message. Ask only if still unclear, then conduct all subsequent interaction in this language.
2. Clarify the research scope.
   - Identify the feature slug and research topic
   - Frame a clear research question
   - Determine whether existing `spec.md` or `plan.md` context is relevant
3. Gather information.
   - Read existing project context (`spec.md`, `plan.md`, other `research/*.md`)
   - Investigate external sources: documentation, APIs, library comparisons, platform constraints
   - Run a proof of concept when hands-on validation is needed to answer the question
4. Create the research file from `references/research-template.md`.
   - Research Question: one clear question the research answers
   - Context: feature, topic, and scope of investigation
   - Sources: all references consulted
   - Findings: factual observations with evidence
   - Decision: selected option with rationale and alternatives considered
   - Impact: assessed effect on spec, plan, and tasks
   - Follow-ups: remaining open items, if any
5. Assess impact on existing documents.
   - If findings change requirements or user-visible behavior: flag spec impact
   - If findings change execution design, dependencies, or validation strategy: flag plan impact
   - If no upstream documents exist yet, record impact as guidance for future phases
6. Apply backflow when existing approved documents are affected.
   - Update `spec.md` and reset its status to `draft` when findings are spec-impacting
   - Update `plan.md` and reset its status to `draft` when findings are plan-impacting
   - Do not apply backflow when upstream documents do not yet exist
7. Perform final review and keep the file within 150 lines.
   - Remove repetition
   - Simplify wording
   - Ensure the decision is clearly stated with rationale
8. In the completion message, suggest the next step.
   - If a spec does not yet exist: `spec-specify`
   - If a spec exists but no plan: `spec-plan`
   - If a plan exists and is approved: `spec-implement`
   - If more research is needed: continue `spec-research`

## Success Criteria

- The research question is clearly stated and answered.
- Findings are backed by evidence or direct observation.
- A decision is recorded with rationale and alternatives.
- Impact on existing spec and plan documents is assessed.
- Backflow is applied when approved documents are affected.

## Completion Guidance

- This is a utility skill; the next step depends on workflow context
- Include the research topic, decision summary, and generated file path in the response