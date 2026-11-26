#!/bin/sh
set -eu
branch=$1
shift
git fetch --quiet origin
wt=$(git -c branch.autoSetupMerge=false wt "$branch" origin/HEAD --nocd)
dir=$(printf '%s\n' "$wt" | tail -n 1)
brief=$(printf '%s\n\n' "$(cat)" && cat "$(dirname "$0")/../assets/rules.md")
window=$(rex run --focus=false --keep-open --cwd "$dir" --label "$branch" --json -- "$@" "$brief" | jq -r .window_id)
rex window rename "$window" "$branch"
