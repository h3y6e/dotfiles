# PR Body

Write only what a reviewer needs to judge the change, so they grasp it without reading the diff. Start from the purpose; later work follows from it. Leave out local environment details and promises such as "CI will verify".

A repository template's headings are a guide: add nothing just to fill one, and put no parenthetical notes in headings. Without a template, use only these sections, skipping what reviewers already know:

- `## Summary`: 1–3 sentences: the purpose and the outcome once merged, then why it is needed now. Link the issue.
- `## Evidence`: before and after, above the level of the diff. Never copy diff lines or list changes by file. Omit when the diff reads at a glance.
  - Behavior: screenshots for UI; otherwise output or a test that fails before and passes after, pasted verbatim.
  - Structure: file or call trees in `diff` or `text` blocks, tables, pseudocode, Mermaid diagrams, or SVGs (e.g. from D2).
  - Draw from `git diff` and the code, not memory, and check the rendered result, on the PR page if not locally.
- `## Impact` (optional): one-way or two-way door, blast radius, and up to 3 things reviewers must know. Omit unchanged behavior and work not done.
