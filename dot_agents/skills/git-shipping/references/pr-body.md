# PR Body

Use only these sections, written so a reviewer grasps the change without reading the diff, and skip what they already know:

- `## Summary`: 1–3 sentences: the outcome once merged, then why it is needed now. Link the issue.
- `## Evidence`: before and after, above the level of the diff. Never copy diff lines or list changes by file. Omit when the diff reads at a glance.
  - Behavior: screenshots for UI; otherwise output or a test that fails before and passes after, pasted verbatim.
  - Structure: a `diff` or `text` block of a file tree, call tree, or pseudocode you write (`retry: caller → HTTP client`, not the code). Mermaid only for what text cannot show, such as sequences between parties; SVG (e.g. from D2) only when Mermaid lays it out badly.
  - Draw from `git diff` and the code, not memory, and check the rendered result, on the PR page if not locally.
- `## Impact` (optional): one-way or two-way door, blast radius, and up to 3 things reviewers must know. Omit unchanged behavior and work not done.
