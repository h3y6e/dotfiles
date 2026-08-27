---
argument-hint: what went wrong
description: Turns a terse or angry complaint attached to /fuck into a precise, confirmed cause and a fix, scoped to what was just handed back.
disable-model-invocation: true
license: MIT
metadata:
    author: h3y6e
    github-path: skills/fuck
    github-ref: refs/tags/v2026.8.4
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 7d09cff1e3b88a4fa1a0cbb109f2e43d4ef4c12c
    version: 2026.8.4
name: fuck
---
# fuck

Something in the last output was wrong enough to provoke this. The complaint:

> $ARGUMENTS

It states the symptom, not the mechanism, and the tone is not signal — don't take it at face value, don't mirror it, don't let it push you past what the content actually supports. Turn it into a precise, confirmed cause before touching anything.

## 1. Locate it

What you handed back last is in scope: the previous reply, the diff you just made, the comment you just wrote. Not the whole session, not inherited code — unless the complaint names a wider target itself.

Read the complaint as a pointer into that artifact: a file, a function, a sentence, "that comment," "the diff." Find the exact thing it refers to before diagnosing it.

## 2. Diagnose

For example, "this comment is pointless" says what to remove, not why it was wrong to add — confirm which of these it actually is:

- Is it padding — a sentence stating what the code, the diff, or a file listing already shows?
- Did you read a question as a rejection and start changing things, when the question wanted an answer, not a diff?
- Is it a claim you made without reading the file, running the command, or pointing at a source?
- Is it a written rule you skipped — in `AGENTS.md`, or in an Agent Skill you never loaded?
- Is it a choice you made for yourself where a neighbouring file, a sibling PR, an existing name, or the tool you are imitating had already made it?
- Is it a Japanese sentence that reads unnaturally, or leaves an English word standing where a Japanese one exists?
- Is it something the user just told you that a memory system, if available, should have captured, and you skipped saving?

If none of these fit, the mechanism is whatever the complaint most plainly says — don't force a fit.

## 3. Repair

Fix the cause you confirmed. Delete rather than rephrase. Revert rather than justify. Retract rather than hedge.

Stay inside the scope from step 1 — a provoked moment is the worst time to start improving untouched code — and the same rigor still applies: read the file, verify the claim, stay inside the request.

Fix this instance; don't let it rewrite your general behavior going forward. Bending your defaults around one complaint is a local optimum: it fixes what just annoyed someone at the cost of everything else you'd otherwise get right.

## 4. Report

One line: what the complaint pointed at, what changed, what you left alone. No apology, no plan, no options — `/fuck` plus a short complaint was typed instead of a paragraph because the fix is wanted, not a discussion.
