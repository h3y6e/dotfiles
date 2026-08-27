---
description: Compresses documents, prompts, or knowledge sources into fewer tokens while verifying that every answerable fact survives, using a test-question harness graded by a fresh, source-blind agent. Use when asked to shrink a doc, README, or prompt losslessly, cut token or context-window footprint without losing information, or confirm a compression keeps every fact intact.
license: MIT
metadata:
    author: h3y6e
    github-path: skills/compressing-knowledge
    github-ref: refs/tags/v2026.8.4
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: bcacd42485347a2a1e5c430f2a04736462bc47fb
    version: 2026.8.4
name: compressing-knowledge
---
# Compressing Knowledge

Compression is trustworthy only if something that never saw the original can still pass a test on it. Treat every draft as unverified until a source-blind agent proves otherwise.

## When Not To Use

- Some information loss is acceptable — just summarize; the harness is overkill.
- The task is prose style or code tightening, not fact preservation — use a style or simplification pass instead.
- No subagent can run with a genuinely empty context (see Verification) — say so; offer only an unverified summary if still wanted.

## Workflow

1. **Baseline.** Record the source's token count with a consistent proxy (`wc -w` is enough — exact tokenizer accuracy doesn't matter, only consistency across iterations).

2. **Extract test questions.** Before drafting, pull out question/answer pairs, each grounded in one distinct fact and traceable to a specific passage. Scale count to length: roughly one per 40 source tokens, minimum 5, or the user's stated count. Done when no two questions share a fact and every answer is written down.

3. **Verify the harness.** Spawn a fresh, non-fork subagent (`Agent`, e.g. `general-purpose`) with *only* the original source and the bare questions (no answers). Grade its answers against the recorded ones yourself. A failure means the question is ambiguous or ungrounded — fix or drop it and re-run until the source passes every question. This is the ground truth later drafts are measured against.

4. **Cut, then test.** Cut redundancy, restatement, and filler into a candidate draft — cutting content, not whitespace or formatting, which doesn't reduce real footprint. Spawn a fresh subagent with *only the candidate draft* (never the original) and the bare questions; grade its answers.
   - All pass → new safe anchor. Return here and cut further.
   - Any fail → floor found; go to step 5.

5. **Repair.** Patch the failing draft with the minimum addition that restores the missing fact(s) — don't revert wholesale to the last anchor. Re-test with another fresh subagent until it passes every question, then retry step 4 from the repaired draft.

6. **Stop.** Finish when two consecutive repair-then-shrink attempts fail to beat the last safe anchor's size, or a user-given budget is exhausted. Never hand back a draft that hasn't itself passed a fresh, source-blind test at 100%.

7. **Report.** Deliver the final text plus: baseline and final token counts and reduction %, the full question/answer set (for re-verifying future edits), and an iteration log (draft tokens → pass/fail → what failed → repair made).

## Verification

The grading subagent must never have seen the original and must never be a fork — forks inherit your context, including the source, which defeats the test. Use a fresh, non-fork `Agent` call every time. If the environment can't spawn one, verification is unavailable: say so plainly and never claim the result is lossless without it.

Grade strictly: a hedge ("not stated"), a partial answer, or a wrong fact all count as failure — the method depends on treating "probably fine" as failure.
