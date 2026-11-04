local shell = "com.superlogical.terminal.shell"

rex.action{
  name = "open_in_zed",
  title = "Open in Zed",
  run = function(ctx)
    local p = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
    local r = assert(rex.exec{ "/opt/homebrew/bin/zed", "--existing", p.foreground.cwd })
    assert(r.ok, r.stderr)
  end,
}
rex.bind("cmd+e", "open_in_zed")

rex.action{
  name = "open_repo",
  title = "Open Repository…",
  args = { block = "string?", root = "string?", repo = "string?" },
  run = function(ctx, args)
    if args.repo == nil then
      local pick = ('rex do -C %s open_repo block=%s repo="$(ghq list | peco)" root="$(ghq root)"'):format(ctx.client_id, ctx.block_id)
      assert(rex.session.new_layer{
        bounds = { 0.2, 0.2, 0.6, 0.6 },
        focus = true,
        layout = rex.layout.block{ flavor = shell, options = { command = { "sh", "-c", pick } } },
      })
      return
    end
    assert(rex.session.focus_block{ block_id = args.block })
    if args.repo == "" then return end
    local s = assert(rex.call("session.create", {
      label = args.repo:match("[^/]+$"),
      initial_windows = { { layout = rex.layout.block{ flavor = shell, options = { cwd = args.root .. "/" .. args.repo } } } },
    }))
    rex.client.queue("session.select", { session_id = s.session_id })
  end,
}
rex.bind("cmd+n", "open_repo")
