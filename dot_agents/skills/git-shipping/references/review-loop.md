# Review Loop

After opening a PR, review it with the `code-review` and `security-review` skills and settle the findings without waiting for the user:

1. Run the `code-review` skill on the PR and the `security-review` skill on the branch.
2. Settle every finding with the `receiving-code-review` skill, running unattended.
3. Commit and push accepted fixes. If there were any and fewer than three rounds have run, return to step 1; otherwise stop and report, naming fixes no review has seen.
