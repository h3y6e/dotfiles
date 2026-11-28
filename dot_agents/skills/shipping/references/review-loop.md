# Review Loop

After opening a PR, review it and settle the findings without waiting for the user:

1. Run your harness's `/review` on the PR and its security review on the branch.
2. Settle every finding with the `receiving-code-review` skill, running unattended.
3. Commit accepted fixes as in [Commit](../SKILL.md#commit), then push. If there were any and fewer than three rounds have run, return to step 1; otherwise stop and report, naming fixes no review has seen.
