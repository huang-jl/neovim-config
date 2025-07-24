return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "<c-p>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" }
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, mode = "n", desc = "Line Diagnostics" }
      keys[#keys + 1] = { "K", false, mode = { "n" } }
      keys[#keys + 1] = { "<c-k>", false, mode = { "i" } }
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        hover = {
          border = {
            style = "rounded",
            padding = { 0, 0 },
          },
        },
        popup = {
          border = {
            style = "rounded",
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- disable inline diagnostics
        virtual_text = false,
        float = {
          border = "rounded",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-p>"] = { "fallback" },
        ["<C-n>"] = { "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          root_dir = function(_)
            return vim.fn.getcwd()
          end,
        },
        ruff_lsp = {
          mason = false,
        },
        ruff = {
          mason = false,
        },
      },
    },
  },
}
