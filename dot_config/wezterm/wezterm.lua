local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local conf = {}
if wezterm.config_builder then
  conf = wezterm.config_builder()
end

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window, _)
  local cells = {}
  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  local colors = {
    '#3c1361',
    '#52307c',
  }
  local elements = {}
  local num_cells = 0

  local function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = '#c0c0c0' } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = utf8.char(0xe0b2) })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)

-- theme
conf.color_scheme = 'Catppuccin Latte'
conf.font = wezterm.font_with_fallback {
  { family = 'UDEV Gothic 35NFLG' },
}
conf.font_size = 13.0
conf.line_height = 1.1
conf.unicode_version = 14
conf.scrollback_lines = 10000
conf.use_ime = true

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
  { key = "d",     mods = "SUPER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "D",     mods = "SUPER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "h",     mods = "SUPER", action = act({ ActivatePaneDirection = "Left" }) },
  { key = "l",     mods = "SUPER", action = act({ ActivatePaneDirection = "Right" }) },
  { key = "k",     mods = "SUPER", action = act({ ActivatePaneDirection = "Up" }) },
  { key = "j",     mods = "SUPER", action = act({ ActivatePaneDirection = "Down" }) },
  { key = "/",     mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "Enter", mods = "SUPER", action = act.ToggleFullScreen },
}

return conf
