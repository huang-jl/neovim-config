local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  -- This color are copy from tokionight moon theme
  -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_moon.lua
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#82aaff" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#86e1fc" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#c3e88d" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ff966c" })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ff757f" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#fca7ea" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ffc777" })
end)
local highlight = {
  "RainbowBlue",
  "RainbowCyan",
  "RainbowGreen",
  "RainbowOrange",
  "RainbowRed",
  "RainbowViolet",
  "RainbowYellow",
}

ibl.setup({
  indent = {
    char = '▏',
    tab_char = '▏',
    highlight = highlight,
  },
  scope = {
    enabled = false,
  }
})
