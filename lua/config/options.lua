-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- clipboard overrides is needed as Alacritty does not support runtime OSC 52 detection.
-- We need to customize the clipboard depending on whether in tmux, in SSH_TTY or not.
--  In Tmux, there are 2 clipboard providers
--  1. Tmux
--  2. OSC52 should also work by default.
--  In SSH_TTY, OSC 52 should work, but needs to be overridden as I use Alacritty.
--  In local (not SSH session), LazyVim default clipboard providers can be used.
--   Sample references -
--   https://github.com/folke/which-key.nvim/issues/584 - Has references to when clipboard is modified
--   Some more info here - https://www.reddit.com/r/neovim/comments/17rbbec/neovim_nightly_now_you_can_copy_via_ssh_with/
--
--
--  You can test OSC 52 in terminal by using following in your terminal -
--  printf $'\e]52;c;%s\a' "$(base64 <<<'hello world')"
vim.opt.clipboard = "unnamedplus"
local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.
-- TMUX documentation about its clipboard - https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard
if vim.env.SSH_TTY and not is_tmux_session then
  vim.notify("setup clipboard", vim.log.levels.INFO)
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
