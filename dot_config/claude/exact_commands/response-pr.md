---
description: Handle GitHub PR review comments by implementing fixes or providing explanations in Japanese
argument-hint: <github-pr-comment-url>
allowed-tools: Bash(gh:*), Bash(git:*), Read, Edit
---

# PR Review Responder

Handle GitHub PR review comments by either implementing fixes or providing concise explanations in Japanese.

## Task

Analyze PR review comments from GitHub URLs and respond appropriately - fix issues that need fixing, or explain why no changes are needed.

## Input

`$ARGUMENTS` - GitHub PR comment URL

## Context

Current branch: !`git branch --show-current`
Repository info: !`gh repo view --json nameWithOwner --jq .nameWithOwner`

## Process

1. **Comment Retrieval**
   - Extract PR number and comment ID from URL
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
   - General comments on the PR
2. **Review Comments**: `https://github.com/{owner}/{repo}/pull/{pr}#discussion_r{id}`
   - Comments on specific lines of code
3. **Review Comments (file)**: `https://github.com/{owner}/{repo}/pull/{pr}/files#r{id}`
   - Comments linked from file view

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

> [レビュー3]

[簡潔な返信内容]
```

## Constraints

- Keep responses brief and technical
- Focus on the specific concern raised
- Avoid defensive language
- Provide code references when relevant
- Complete one comment at a time
- Respond in Japanese

Process the URL: $ARGUMENTS
