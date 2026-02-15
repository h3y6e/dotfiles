# PR Staged Files

Create a GitHub Pull Request from staged files.

## 🚨 Absolute Constraints

- **Working directly on default branch (main/master) is prohibited**
- **Only process staged files**
- **Never execute `git add` or `git restore` automatically**
- **Never include unstaged/untracked changes in PR**

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

### Step 1: Analysis

Run the following commands to check branch and staging status:
```bash
git branch --show-current
git status --short
git diff --cached --stat
git diff --cached
```

### Step 2: Commit

Commit staged changes with conventional commit message (no scope, imperative, no punctuation).
Focus on "why" in the message.

Push to remote after committing.

### Step 3: Create PR & Review

Check if English option is specified:

- If `--en` flag is provided, use English PR template
- Otherwise, use Japanese PR template (default)

#### Japanese PR Template (Default)

Create PR with:
- Title: conventional commit format
- Body sections:
  - 概要: なぜこの変更が必要なのかを1-3つの箇条書きで説明
  - 背景 (optional): なぜこの決定を行う必要があったか
  - 変更内容: 変更の理由と意図を中心に説明
  - 影響 (optional): システムやコードへの影響

#### English PR Template (with --en flag)

Create PR with:
- Title: conventional commit format
- Body sections:
  - Summary: Why these changes are needed in 1-3 bullet points
  - Background (optional): Why this change was necessary
  - Changes: Reasoning and intent behind changes
  - Impact (optional): Impact on system/code

### Step 4: Code Review

Based on the diff from Step 1, perform a quick code review:

- Check for code quality issues
- Verify no unintended changes were included
- Ensure changes align with commit message
- Look for potential bugs or improvements

## Usage

```
/staged-pr        # Default (Japanese PR)
/staged-pr --en   # English PR
```

Check staged files with `git status` before execution.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Project convention: `fix/[name]` branch naming format
