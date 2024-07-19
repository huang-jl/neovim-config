local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end


local status_ok, ts_ctx_cs = pcall(require, "ts_context_commentstring")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
    "rust", "python", "bash", "cpp", "go",
    "html", "javascript", "json",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "c", "cpp" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
}

ts_ctx_cs.setup({
  enable_autocmd = false,
})
