# What to Write per Issue Type

For each heading, this specifies what to write, only for the applicable type.
Don't guess to fill a heading that doesn't apply.

## Bug

- **Sources and rationale**: Record reproduction steps, logs, tests, and impact scope. Record cause and fix as hypotheses, separate from observed facts.
- **Problem**: Record the expected behavior versus the actually observed behavior, and whether the post-failure state and external side effects are known or remain unknown.
- **Acceptance criteria**: Include a regression test and judgment criteria for confirming non-recurrence.

## Research

- **Problem** / **Outcome**: Put the question to answer in Problem, and the decision to make in Outcome. Don't write implementation work.
- **Verification**: Record the evidence needed, how to obtain it, and the deliverable.
- **Decision gate**: Record the stop condition and which outcomes require a follow-up issue.
- Don't guess the scope or acceptance criteria of downstream implementation before a conclusion is reached.

## Migration / Architecture Change

- **Problem** / **Outcome**: Record the current state in Problem, and the target state in Outcome.
- **Scope**: Record contracts that must not change, and whichever of deploy ordering, compatibility window, backfill, dual read/write, and consistency checks apply.
- **Decision gate**: For the migration as a whole, record the observation period, exit condition, stop condition, point of no return, required approvals, and rollback or roll-forward.
- **Decision gate**: For each flag, adapter, dual write, copy, and old path introduced, record how it's observed, its removal condition, and its removal phase.
- **Verification**: Include zero usage of the old path as the pre-removal judgment criterion.
