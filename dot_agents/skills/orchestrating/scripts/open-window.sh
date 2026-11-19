#!/bin/sh
name=$1
dir=$2
shift 2
window=$(rex run -s "$REX_SESSION" --focus=false --cwd "$dir" --label "$name" --json -- "$@" | jq -r .window_id)
rex window rename -s "$REX_SESSION" "$window" "$name"
