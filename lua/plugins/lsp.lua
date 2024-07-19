return {
  { "neovim/nvim-lspconfig" }, -- enable LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  { "williamboman/mason-lspconfig.nvim" },
  { 'simrat39/rust-tools.nvim' }, -- for rust
}
