---
name: cxg
description: Use when creating a git commit.
compatibility: Requires git and cxg.
license: MIT
metadata:
  author: h3y6e
  version: "2026.4.2"
---

# cxg

Route all commit messages through `cxg`. Never bypass it.

## Flow

1. If unsure of commit scope, run `git diff --cached --stat`
2. Write subject + action lines you can support
3. Commit:

```sh
cxg lint --fix \
  -m 'type(scope): subject' \
  -m 'action-type(scope): description' \
  | git commit -F -
```

If validation fails, fix the message and rerun.

## Commit Format

```text
type(scope): subject line

action-type(scope): description
```

Subject types: `feat` `fix` `refactor` `perf` `test` `docs` `style` `build` `ci` `chore` `revert`

Action types (most commits need 1-3 lines — never pad with noise):

- `intent(scope)` — what the user wanted and why. Capture their voice, not a restatement of the diff.
- `decision(scope)` — which approach was chosen when alternatives existed, with brief reasoning.
- `rejected(scope)` — what was considered and discarded. Always include the reason.
- `constraint(scope)` — hard limits or dependencies that shaped the implementation.
- `learned(scope)` — API quirks, undocumented behavior, things you wish you'd known earlier.

Scope is a human-readable concept label (e.g. `auth`, `payment-flow`, `session-store`). Keep scopes consistent across commits.

- Conventional Commits, max 72 chars
- Body lines must be valid action lines (no free-form text)
- Trivial commits can stay subject-only
- Do not fabricate context you do not have — a clean subject with no action lines is better than invented reasoning

## Options

```sh
# trailer
cxg lint --fix -m '...' --trailer 'Co-authored-by: Alice <alice@example.com>' | git commit -F -

# JSON errors
cxg lint --json -m 'bad message'

# file (for hooks)
cxg lint .git/COMMIT_EDITMSG
```

## Examples

```
fix(button): correct alignment on mobile viewport
```

```
feat(notifications): add email digest for weekly summaries

intent(notifications): users want batch notifications instead of per-event emails
decision(digest-schedule): weekly on Monday 9am — matches user research feedback
constraint(email-provider): SendGrid batch API limited to 1000 recipients per call
```

```
refactor(payments): migrate from single to multi-currency support

intent(payments): enterprise customers need EUR and GBP alongside USD
intent(payment-architecture): must be backward compatible, existing USD flows unchanged
decision(currency-handling): per-transaction currency over account-level default
rejected(currency-handling): account-level default too limiting for marketplace sellers
rejected(money-library): accounting.js — lacks sub-unit arithmetic, using currency.js instead
constraint(stripe-integration): Stripe requires currency at PaymentIntent creation, cannot change after
constraint(database-migration): existing amount columns need companion currency columns, not replacement
learned(stripe-multicurrency): presentment currency vs settlement currency are different Stripe concepts
learned(exchange-rates): Stripe handles conversion, we should NOT store our own rates
```
