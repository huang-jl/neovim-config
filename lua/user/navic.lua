local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  return
end

navic.setup({})

-- NOTE there is two other piece of configuration related to navic:
-- 1. LSP, we need to attach nvim-navic to lsp server
-- 2. lualine, we need to demonstrate the navic to winbar
