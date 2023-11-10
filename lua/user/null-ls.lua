local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  vim.notify("null-ls plugin not ok")
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
  formatting.black.with({ extra_args = { "--fast", "-l", "130" } }),
  formatting.stylua,
  formatting.clang_format.with({
    extra_args = { "--style", "file" },
  }),
}

null_ls.setup({
  debug = true,
  sources = sources,
  root_dir = function()
    return nil
  end
})
