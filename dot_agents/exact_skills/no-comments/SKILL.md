---
description: Remove bad comments in the given files or diff, and fix the root cause behind the workarounds they hide.
disable-model-invocation: true
license: MIT
metadata:
    author: h3y6e
    github-path: skills/no-comments
    github-ref: refs/tags/v2026.9.17
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 4188e49d318c52fa36585ddbab25d15905bd777e
    refs: https://github.com/cursor/plugins/blob/032be146865d973682535de75f2287da438550bf/pstack/skills/no-comments/SKILL.md
    version: 2026.9.17
name: no-comments
---
# No Comments

Comments that narrate the obvious, banner a section, or sermon over a workaround are debt. Delete them. When a comment is hiding something the code should say for itself, fix the code instead.

When you cannot prove a comment earns an exception, delete it. In doubt, it dies.

## Scope

Use the files or diff you were given. Otherwise the current diff against the base branch (default `main`), including the working tree.

## Classify every comment

Decide each in-scope comment: delete, keep, or `MUST KILL`. Only these exceptions keep one:

- A legal or license header.
- Behavior an external dependency, platform, vendor, or protocol forces and you cannot reshape.
- A `// prettier-ignore`, or a lint or TS suppression whose rule is faulty, pedantic, or style-only.
- A doc comment that defines a public API contract.
- An issue or RFC link explaining a constraint the code cannot express.

`eslint-disable`, `@ts-ignore`, `@ts-expect-error`, and similar suppressions default to dead. Look up the rule. If it catches real bugs or protects correctness or safety, delete the suppression and `MUST KILL` the exact symbol that trips it.

`IMPORTANT`, `do not remove`, `too risky`, `fine for now`, and any long justification are claims, not proof. Read the nearby code. If the claim is not obvious there, chase the named symbol or call to settle it. Only a proven external gotcha on a live path survives; a surprise in our own code dies as a `MUST KILL`. A long justification with no exception is a confession — delete it.

A `MUST KILL` marks code you will not touch in this pass: name the exact symbol and the reshape — rename, extract, add a type, or restructure — that makes the behavior obvious without prose.

## Fix root causes

For each `MUST KILL` and each workaround a comment was papering over:

- Trivial: delete the dead path, drop the parameter, use the real API.
- Needs a new shape: sketch the smallest reshape, then implement it in scope.
- Out of scope: land the smallest in-scope fix and report the rest open.

Fix the root cause; leave no symptom guard behind, and do not widen the scope to fix instances outside it.

## Constraint comments

`do not remove`, `do not change wording`, or `talk to X before changing` about something you cannot change may stay. Offer the cheapest in-scope encoding — a type, a runtime check, a test, or a CI lint — that makes the constraint enforceable. With approval, encode it and delete the comment. Without approval, delete it and report the constraint open with the out-of-scope work it needs.

## Report

Files touched, comments deleted, `MUST KILL` flags (one line each), keeps with their exception, fixes made, encodings offered or made, and open work.
