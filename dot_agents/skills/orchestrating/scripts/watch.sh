#!/bin/sh
set -eu
seen=$(mktemp -d "${TMPDIR:-/tmp}/watch.XXXXXX")
trap 'trap - EXIT HUP INT TERM; rm -r "$seen"; kill 0' EXIT HUP INT TERM

workers() { rex window list --json | jq -r --arg b "${1-}" '.windows[] | .label as $w | .layers[].blocks[] | select(.label == $w and .block_id != env.REX_BLOCK and ($b == "" or .block_id == $b)) | "\(.block_id) \($w)"'; }

status() {
  pr=$(gh pr view "$2" --json number,state,mergeStateStatus,reviewDecision --jq '"#\(.number) \(.state) \(.mergeStateStatus) \(.reviewDecision)"' 2>/dev/null) || {
    echo "$1 cannot read $2"
    return 1
  }
  echo "$1 pr $pr"
  case $pr in *" MERGED "* | *" CLOSED "*) return 1 ;; esac
}

listen() {
  trap 'rm "$3"' EXIT
  while :; do
    gh event listen --resource "$2" --follow --event com.github.pull_request.state.changed.v1,com.github.pull_request.review.submitted.v1,com.github.pull_request.merge_conflict.v1 >"$3" 2>&1 &
    pid=$!
    status "$1" "$2" || {
      kill "$pid"
      return
    }
    while IFS= read -r line; do
      case $line in
        '{'*) status "$1" "$2" || {
          kill "$pid"
          return
        } ;;
        "Listening for events." | "Changes made before this point"* | hint:* | " "*) ;;
        *) echo "$1 $line" ;;
      esac
    done <"$3"
    wait "$pid" || return 0
  done
}

current() { rex block call -b "$1" program_status | jq -r '.records[] | select(.id == null) | .state'; }

pr() {
  cwd=$(rex block call -b "$1" process 2>/dev/null | jq -r '.child.cwd // empty')
  [ -n "$cwd" ] || return 0
  url=$(cd "$cwd" && gh pr view "$2" --json url --jq .url 2>/dev/null) || return 0
  fifo="$seen/$(echo "$url" | tr / _)"
  [ -p "$fifo" ] && return 0
  mkfifo "$fifo"
  listen "$2" "$url" "$fifo" 2>/dev/null &
}

workers | while read -r block branch; do pr "$block" "$branch"; done

rex events -s "$REX_BLOCK" --json |
  jq --unbuffered -nr 'foreach (inputs | .payload.event? | select(.type == "block_event" and (.payload.name == "child_exited" or (.payload.name == "program_status_changed" and .payload.payload.record.id == null))) | .payload) as $e ({}; .prev = .[$e.block_id] | .[$e.block_id] = (if $e.name == "child_exited" then "exited" else ($e.payload.record | if .state == "blocked" and .kind then "blocked \(.kind)" else .state end) end); .[$e.block_id] as $s | select($s != .prev and ($s | test("^(done|blocked|error|exited)"))) | "\($e.block_id) \($s)")' |
  while read -r block state; do
    branch=$(workers "$block" | cut -d " " -f 2)
    [ -n "$branch" ] || continue
    case $state in
      done)
        n=$((${n:-0} + 1))
        echo "$n" >"$seen/${block#block:}"
        {
          sleep 5
          [ "$(cat "$seen/${block#block:}")" = "$n" ] && [ "$(current "$block")" = "done" ] || exit 0
          echo "$branch done"
          pr "$block" "$branch"
        } &
        ;;
      *) echo "$branch $state" ;;
    esac
  done &
wait
