---
description: Stands in for the complaint user would otherwise have written in anger, and finds what it was about.
disable-model-invocation: true
license: MIT
metadata:
    author: h3y6e
    github-path: skills/fuck
    github-ref: refs/tags/v2026.8.2
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 8f96d825e4f7b1b92e1023cbbe42d6724afdea85
    version: 2026.8.2
name: fuck
---
# fuck

Something in the last output was wrong enough to provoke this. The complaint itself was never typed, so work out what it was.

## 1. Locate it

What you handed back last is in scope: the previous reply, the diff you just made, the comment you just wrote. Not the whole session, not inherited code.

Any argument passed with the invocation narrows that scope to what it names.

## 2. Diagnose

Read that artifact and answer, concretely:

- Which prose is padding? Which sentence states what the code, the diff, or a file listing already shows?
- Did you read a question as a rejection and start changing things? A question wants an answer, not a diff.
- Which claim did you make without reading the file, running the command, or pointing at a source?
- Which written rule did you skip — in `AGENTS.md`, or in an Agent Skill you never loaded?
- Which choice did you make for yourself where a neighbouring file, a sibling PR, an existing name, or the tool you are imitating had already made it?
- Which Japanese sentence reads unnaturally, or leaves an English word standing where a Japanese one exists?

Every question that lands is a cause. Questions that do not apply get no answer — this is a diagnosis, not a report.

## 3. Repair

Fix every cause you found. Delete rather than rephrase. Revert rather than justify. Retract rather than hedge.

Stay inside the scope from step 1. A provoked moment is the worst time to start improving untouched code, and the same rigor still applies: read the file, verify the claim, stay inside the request.

## 4. Report

One line: what most likely provoked it, what changed, what you left alone. No apology, no plan, no options — `/fuck` was typed instead of a paragraph because the fix is wanted, not a discussion.
