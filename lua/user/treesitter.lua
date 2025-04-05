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
    -- disable = { "c", "cpp" }, -- list of language that will be disabled
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false, disable = { "yaml" } },
}

ts_ctx_cs.setup({
  enable_autocmd = false,
})

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

-- setup fold expr
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--
local status_ok, ts_ctx = pcall(require, "treesitter-context")
if not status_ok then
  return
end
ts_ctx.setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 5, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})
