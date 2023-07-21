local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  vim.notify("null-ls plugin not ok")
  return
end

local sources = {
  null_ls.builtins.formatting.clang_format.with({
    extra_args = { "--style", "file" },
  }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
