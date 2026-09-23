local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local conf = {}
if wezterm.config_builder then
  conf = wezterm.config_builder()
end

-- `wezterm connect` does not emit gui-startup.
wezterm.on('gui-attached', function()
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

wezterm.on('update-right-status', function(window, _)
  local cells = {}
  table.insert(cells, window:active_workspace())

  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  local colors = {
    '#3c1361',
    '#52307c',
    '#6f2c91',
  }

  local elements = {}
  for i, text in ipairs(cells) do
    table.insert(elements, { Foreground = { Color = '#c0c0c0' } })
    table.insert(elements, { Background = { Color = colors[((i - 1) % #colors) + 1] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })

    if i < #cells then
      table.insert(elements, { Foreground = { Color = colors[(i % #colors) + 1] } })
      table.insert(elements, { Text = utf8.char(0xe0b2) })
    end
  end

  window:set_right_status(wezterm.format(elements))
end)

-- theme
conf.color_scheme = 'Catppuccin Frappe'
conf.font = wezterm.font 'UDEV Gothic 35NF'
conf.font_size = 13.0
conf.line_height = 1.1
conf.scrollback_lines = 10000
conf.use_ime = true
conf.enable_kitty_keyboard = true
conf.audible_bell = "Disabled"
conf.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-- mux
conf.unix_domains = {
  {
    name = 'unix',
  },
}
conf.default_gui_startup_args = { 'connect', 'unix' }
conf.window_close_confirmation = 'NeverPrompt'

-- window
conf.adjust_window_size_when_changing_font_size = false
conf.window_background_opacity = 0.9
conf.window_decorations = "RESIZE"
conf.enable_scroll_bar = true
conf.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

-- tab
conf.tab_bar_at_bottom = true
conf.use_fancy_tab_bar = false
conf.tab_max_width = 100

-- key bindings
conf.keys = {
  -- Cmd-Q kills panes. On the unix domain, match the window close button and detach.
  {
    key = "q",
    mods = "SUPER",
    action = wezterm.action_callback(function(window, pane)
      if pane:get_domain_name() == 'unix' then
        window:perform_action(act.DetachDomain 'CurrentPaneDomain', pane)
      else
        window:perform_action(act.QuitApplication, pane)
      end
    end),
  },
  { key = "d",     mods = "SUPER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "D",     mods = "SUPER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "h",     mods = "SUPER", action = act({ ActivatePaneDirection = "Left" }) },
  { key = "l",     mods = "SUPER", action = act({ ActivatePaneDirection = "Right" }) },
  { key = "k",     mods = "SUPER", action = act({ ActivatePaneDirection = "Up" }) },
  { key = "j",     mods = "SUPER", action = act({ ActivatePaneDirection = "Down" }) },
  { key = "[",     mods = "SUPER", action = act({ ActivatePaneDirection = "Prev" }) },
  { key = "]",     mods = "SUPER", action = act({ ActivatePaneDirection = "Next" }) },
  { key = "/",     mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "Enter", mods = "SUPER", action = act.ToggleFullScreen },
}

return conf
