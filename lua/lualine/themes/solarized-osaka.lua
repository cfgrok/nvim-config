local colors = require("solarized-osaka.colors").setup({ transform = true })
local config = require("solarized-osaka.config").options

local solarized_osaka = {}

solarized_osaka.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.base03, fg = colors.blue },
  c = { bg = colors.none, fg = colors.fg },
}

solarized_osaka.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.base03, fg = colors.green },
}

solarized_osaka.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.base03, fg = colors.yellow },
}

solarized_osaka.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.base03, fg = colors.magenta },
}

solarized_osaka.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.base03, fg = colors.red },
}

solarized_osaka.terminal = {
  a = { bg = colors.orange, fg = colors.black },
  b = { bg = colors.base03, fg = colors.orange },
}

solarized_osaka.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
  for _, mode in pairs(solarized_osaka) do
    mode.a.gui = "bold"
  end
end

return solarized_osaka
