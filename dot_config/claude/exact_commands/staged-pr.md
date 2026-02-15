---
description: Create a GitHub Pull Request from staged files
argument-hint: [--en]
allowed-tools: Bash(git:*), Bash(gh:*)
---

# PR Staged Files

Create a GitHub Pull Request from staged files.

## 🚨 Absolute Constraints

- **Working directly on default branch (main/master) is prohibited**
- **Only process staged files**
- **Never execute `git add` or `git restore` automatically**
- **Never include unstaged/untracked changes in PR**

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`
- Staged changes summary: !`git diff --cached --stat`

## Process

1. **Branch & Staged Changes Analysis**
   - Check if on default branch (main/master)
   - If on default branch, create and switch to a new branch based on staged changes
   - Analyze only staged files
   - Completely ignore unstaged changes

2. **Commit Preparation**
   - Conventional commit (no scope, imperative, no punctuation)
   - Focus on "why" in the message
   - Default: Japanese, Option: English with `--en` flag

3. **Create Pull Request**
   - Push branch to remote
   - Create PR (Japanese by default, English with `--en` flag)
   - Automatically open PR in web browser for review

4. **Code Review**
   - Review the staged changes from Step 1
   - Check for any issues or improvements

## Workflow Steps

### Step 1: Get Full Diff

```bash
git diff --cached
```

### Step 2: Commit

```bash
# Commit staged changes
git commit -m "[conventional commit message]"

# Push to remote
git push -u origin "$(git branch --show-current)"
```

### Step 3: Create PR & Review

Check if English option is specified in $ARGUMENTS:

- If `--en` flag is present, use English PR template
- Otherwise, use Japanese PR template (default)

#### Japanese PR Template (Default)

```bash
gh pr create --title "[PRタイトル - conventional commit形式で記述]" --body "## 概要
[なぜこの変更が必要なのかを1-3つの箇条書きで説明 - whatではなくwhyに集中]

## 背景 (optional)
[なぜこの決定を行う必要があったか、背景情報や制約]

## 変更内容
[変更の理由と意図を中心に説明 - 実装の詳細よりも、なぜこのアプローチを選択したかを重視]

## 影響 (optional)
[システムやコードへの影響、発生するメリット・デメリット、既存コードへのマイグレーション方法など]" --web
```

#### English PR Template (with --en flag)

```bash
gh pr create --title "[PR Title - use conventional commit format]" --body "## Summary
[Explain why these changes are needed in 1-3 bullet points - focus on why, not what]

## Background (optional)
[Why this change was necessary, background information, or constraints]

## Changes
[Explain the reasoning and intent behind changes - emphasize why this approach was chosen over implementation details]

## Impact (optional)
[Impact on system/code, benefits/drawbacks, migration approach for existing code]" --web
```

### Step 4: Code Review

Based on the diff from Step 1, perform a quick code review:

- Check for code quality issues
- Verify no unintended changes were included
- Ensure changes align with commit message
- Look for potential bugs or improvements

## Usage

```bash
# Default (Japanese PR)
/staged-pr

# English PR
/staged-pr --en
```

Check staged files with `git status` before execution.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Project convention: `fix/[name]` branch naming format

Arguments: $ARGUMENTS
