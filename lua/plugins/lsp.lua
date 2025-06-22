return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<c-k>", false }
      keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "<c-p>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" }
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
      },
    },
  },
}
