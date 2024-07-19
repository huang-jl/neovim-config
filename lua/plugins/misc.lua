return {
  -- symbols-outline
  { 'simrat39/symbols-outline.nvim' },

  -- which-key
  { "folke/which-key.nvim" },

  -- null-ls
  { "jose-elias-alvarez/null-ls.nvim" },

  -- grayout for CONFIG_XXX (i.e., kernel config) or MACRO in C/C++
  { "mphe/grayout.vim" },

  -- navic for statusline and winbar
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  },

  -- lualine: statusline + winbar
  { 'nvim-lualine/lualine.nvim'},

  -- toggleterm: float terminal
  { "akinsho/toggleterm.nvim"},
}
