rex.bind("cmd+e", function(ctx)
  local p = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
  return assert(rex.exec { "/opt/homebrew/bin/zed", "--existing", p.foreground.cwd }).ok
end)
