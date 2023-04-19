local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  local cells = {}

  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find '/'
    local cwd = ''
    local hostname = ''
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
      local dot = hostname:find '[.]'
      if dot then
        hostname = hostname:sub(1, dot - 1)
      end
      cwd = cwd_uri:sub(slash)

      table.insert(cells, cwd)
      table.insert(cells, hostname)
    end
  end

  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  local LEFT_ARROW = utf8.char(0xe0b3)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local colors = {
    '#3c1361',
    '#52307c',
    '#663a82',
    '#7c5295',
    '#b491c8',
  }

  local text_fg = '#c0c0c0'

  local elements = {}
  local num_cells = 0

  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)

return {
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  color_scheme = 'OneHalfDark',
  font = wezterm.font_with_fallback {
    { family = 'UDEV Gothic 35NFLG', weight = 'Bold' }, -- https://github.com/yuru7/udev-gothic
    { family = 'Source Code Pro', weight = 'DemiBold' },
  },
  font_size = 13.0,
  initial_cols = 80,
  initial_rows = 24,
  leader = { key = "Space", mods = "CTRL|SHIFT" },
  keys = {
    { key = "d", mods = "SUPER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
    { key = "D", mods = "SUPER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "h", mods = "SUPER", action = act({ ActivatePaneDirection = "Left" }) },
    { key = "l", mods = "SUPER", action = act({ ActivatePaneDirection = "Right" }) },
    { key = "k", mods = "SUPER", action = act({ ActivatePaneDirection = "Up" }) },
    { key = "j", mods = "SUPER", action = act({ ActivatePaneDirection = "Down" }) },
    { key = "Enter", mods = "SUPER", action = "QuickSelect" },
    { key = "/", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  },
  line_height = 1.1,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  use_ime = true,
  window_background_opacity = 0.9,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
