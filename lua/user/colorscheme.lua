-- kanagawa
-- local status_ok, kanagawa = pcall(require, "kanagawa")
-- if not status_ok then
--   return
-- end
-- kanagawa.setup({
--   overrides = function(colors) -- add/modify highlights
--     return {
--       ["@lsp.type.comment"] = { link = "Comment" },
--     }
--   end,
-- })
--
-- vim.cmd [[
-- try
--   colorscheme kanagawa-wave
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
  return
end

tokyonight.setup({
  style = "moon",
  on_highlights = function(hl, c)
    hl.WinSeparator = {
      fg = "#636da6",
    }
  end,
})
vim.cmd[[colorscheme tokyonight-moon]]
