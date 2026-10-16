# Review Loop

After opening a PR, get it reviewed by Copilot code review and settle the result without waiting for the user:

1. Request a review from `@copilot`. Each review costs AI credits, so request once per push.
2. Wait until `copilot-pull-request-reviewer[bot]` has reviewed the head commit; this usually takes a few minutes. After 10 minutes, stop and report.
3. Settle every unresolved thread with the `receiving-code-review` skill, running unattended. Read the review body too: Copilot lists findings on unchanged code there without opening a thread.
4. Commit and push accepted fixes. If there were any and fewer than three reviews have run, return to step 1; otherwise stop and report, naming fixes no review has seen.
