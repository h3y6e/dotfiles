---
description: Turns review feedback into per-item verdicts backed by evidence from the codebase, before any fix is written. Use when review comments are in hand — fetched from a pull request, pasted into the conversation, or left by an automated reviewer such as Copilot code review, CodeRabbit, or another agent — and before acting on any of them, including when asked to just apply them, and when a suggestion looks unclear, wrong, or larger than the problem it solves.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/receiving-code-review
    github-ref: refs/tags/v2026.9.13
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 6dcaaf1b5fb432192681107ade27874bad25b648
    refs: https://github.com/obra/superpowers/tree/v6.2.0/skills/receiving-code-review
    version: 2026.9.13
name: receiving-code-review
---
# Receiving Code Review

A review comment is a hypothesis about the code, not a fact about it. Settle every item against the codebase first; fixes come after.

## Verdicts

Assign one verdict per item before editing anything. The evidence column is what makes the verdict reportable — without it, the item is still unsettled.

| Verdict | Evidence required | Next action |
| --- | --- | --- |
| accept | The reported behavior reproduced, or the cited code read and confirmed | Fix, then verify the fix |
| clarify | — | Ask what the item means before touching the code |
| push back | Code, test, or constraint that contradicts the suggestion | Reply with that evidence and a question |
| drop | No caller or usage found for the code the suggestion would grow | Propose deleting it instead |
| unverifiable | — | Report what you checked, and what would settle it |

The item is clear but nothing in reach proves or disproves it — a production-only failure, an external system's behavior — so it is unverifiable, not a push back: absence of supporting code is not contradicting evidence. Never quietly accept one either.

A suggestion that contradicts a decision the user already made outranks the table: it goes back to the user, not into the code.

Confidence in a reviewer is not evidence. Bots and agent reviewers report findings about code paths they never read, and a human may be reading an older revision; check either, and accept what holds up.

## Clarify All Items First

Assign verdicts across every item before implementing any of them, and ask about all the unclear ones in a single reply. Hold any item sharing an assumption with an unclear one — fixing item 3 under a wrong reading of item 5 produces work that must be undone. Independent accepted items can proceed while you wait.

## Implement and Verify

Order accepted items: breakage and security first, then mechanical fixes, then the ones that need design. Verify each fix on its own before starting the next, and re-run the wider tests once the batch is done.

## Replying

Report the verdict and what settled it — "Reproduced, fixed in `parser.ts`", "Checked: no caller reaches this branch". Accepting is silent work; pushing back needs the contradicting evidence quoted. If you pushed back and were wrong, say what you checked, what it showed, and that you are fixing it.

On GitHub, answer an inline comment inside its own thread:

```bash
gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies -f body='...'
```
