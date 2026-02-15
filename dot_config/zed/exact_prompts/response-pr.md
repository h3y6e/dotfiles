# PR Review Responder

Handle GitHub PR review comments by either implementing fixes or providing concise explanations in Japanese.

## Task

Analyze PR review comments from the provided GitHub URL and respond appropriately - fix issues that need fixing, or explain why no changes are needed.

## Process

1. **Comment Retrieval**
   - Extract PR number and comment ID from the provided URL
   - Fetch specific comment content via GitHub API
   - Get associated code context and diff
   - Identify comment type (review comment vs issue comment)

2. **Comment Analysis**
   - Parse review comment content
   - Identify specific concerns or suggestions
   - Determine if code changes are needed
   - Prioritize based on severity/importance

3. **Action Decision**
   - **Fix Required**: Implement changes immediately
   - **No Fix Needed**: Provide brief, technical explanation

4. **Implementation** (if fixes needed)
   - Make minimal, focused changes
   - Ensure changes address the specific concern
   - Verify no regressions introduced
   - Update tests if necessary

5. **Response Generation**
   - Concise explanation of actions taken
   - Technical justification if no changes made
   - Reference specific code/commits if relevant

## URL Patterns

The command handles these GitHub PR comment URL types:

1. **Issue Comments**: `https://github.com/{owner}/{repo}/pull/{pr}#issuecomment-{id}`
2. **Review Comments**: `https://github.com/{owner}/{repo}/pull/{pr}#discussion_r{id}`
3. **Review Comments (file)**: `https://github.com/{owner}/{repo}/pull/{pr}/files#r{id}`

## Shell Commands Reference

```bash
# Fetch specific issue comment
gh api repos/{owner}/{repo}/issues/comments/{comment_id}

# Fetch review comments
gh api repos/{owner}/{repo}/pulls/{pr_number}/comments

# Get PR context
gh pr view {pr_number} --json files,diff

# After fixes
git add -A
git commit -m "fix: address review feedback"
```

## Response Patterns

### When Fix Applied

```
> [レビューコメント]

修正しました。[具体的な変更内容]
```

### When No Fix Needed

```
> [レビューコメント]

現在の実装で問題ありません。[技術的な理由]
```

## Output Format

```markdown
> [レビュー1]

[簡潔な返信内容]

> [レビュー2]

[簡潔な返信内容]
```

## Constraints

- Keep responses brief and technical
- Focus on the specific concern raised
- Avoid defensive language
- Provide code references when relevant
- Respond in Japanese

---

**Please provide the GitHub PR comment URL to process.**
