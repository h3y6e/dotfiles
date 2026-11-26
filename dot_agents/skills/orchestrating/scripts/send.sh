#!/bin/sh
set -eu
branch=$1
text=$(cat)
record() { rex block call -b "$branch" program_status | jq -r '.records[] | select(.id == null) | "\(.state) \(.updated_at)"'; }
state() { record | cut -d ' ' -f 1; }
[ "$(state)" = working ] && printf '\033' | rex send -b "$branch"
while :; do
  s=$(state)
  case $s in
    idle | done) break ;;
    working) sleep 1 ;;
    *)
      echo "$branch: $s, not sent" >&2
      exit 1
      ;;
  esac
done
printf '%s' "$text" | rex send -b "$branch"
sleep 1
before=$(record)
printf '\r' | rex send -b "$branch"
for _ in 1 2 3 4 5; do
  sleep 1
  [ "$(record)" != "$before" ] && exit 0
done
echo "$branch: not submitted" >&2
exit 1
