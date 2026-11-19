#!/bin/sh
rex events -s "$REX_SESSION" --json |
  jq --unbuffered -r '.payload.event? | select(.type == "block_event" and .payload.name == "program_status_changed" and .payload.block_id != env.REX_BLOCK and (.payload.payload.record.state | IN("done", "blocked", "error"))) | "\(.payload.block_id) \(.payload.payload.record.state)"' |
  while read -r block state; do
    rex block list -s "$REX_SESSION" --short=false | awk -v b="$block" -v s="$state" '$2 == b { print $4, s }'
  done
