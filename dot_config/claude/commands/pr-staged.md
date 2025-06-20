# PR Staged Files

Create a GitHub Pull Request from staged files.

## 🚨 Absolute Constraints

- **Working directly on default branch (main/master) is prohibited**
- **Only process staged files**
- **Never execute `git add` or `git restore` automatically**
- **Never include unstaged/untracked changes in PR**

## Process

1. **Branch & Staged Changes Analysis**

   - Verify not on default branch
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

### Step 1: Analysis

```zsh
# Check branch and staging status
git branch --show-current
git status --short
git diff --cached --stat
git diff --cached
```

### Step 2: Commit

```zsh
# Commit staged changes
git commit -m "$(cat <<'EOF'
[conventional commit message]
EOF
)"

# Push to remote
git push -u origin "$(git branch --show-current)"
```

### Step 3: Create PR & Review

Check if English option is specified:

- If command includes `--en` flag, use English PR template
- Otherwise, use Japanese PR template (default)

#### Japanese PR Template (Default)

```zsh
# Create PR and automatically open in browser
gh pr create --title "[PRタイトル]" --body "$(cat <<'EOF'
## 概要
[変更内容を1-3つの箇条書きで]

## 背景 (optional)
[なぜこの決定を行う必要があったか、背景情報や制約]

## 変更内容
[詳細な変更内容]

## 影響 (optional)
[システムやコードへの影響、発生するメリット・デメリット、既存コードへのマイグレーション方法など]

## スクリーンショット/実行結果 (optional)
[該当する場合]
EOF
)" --web
```

#### English PR Template (with --en flag)

```zsh
# Create PR and automatically open in browser
gh pr create --title "[PR Title]" --body "$(cat <<'EOF'
## Summary
[List 1-3 bullet points of changes]

## Background (optional)
[Why this change was necessary, background information, or constraints]

## Changes
[Detailed description of changes]

## Impact (optional)
[Impact on system/code, benefits/drawbacks, migration approach for existing code]

## Screenshots/Results (optional)
[If applicable]
EOF
)" --web
```

### Step 4: Code Review

Based on the diff from Step 1, perform a quick code review:

- Check for code quality issues
- Verify no unintended changes were included
- Ensure changes align with commit message
- Look for potential bugs or improvements

## Usage

```zsh
# Default (Japanese PR)
/pr-staged

# English PR
/pr-staged --en
```

Check staged files with `git status` before execution.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Project convention: `fix/[name]` branch naming format
