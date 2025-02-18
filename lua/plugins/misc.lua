return {
  -- symbols-outline
  { 'hedyhli/outline.nvim' },

  -- which-key
  { "folke/which-key.nvim" },

  -- null-ls
  { "jose-elias-alvarez/null-ls.nvim" },

  -- navic for statusline and winbar
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  },

  -- lualine: statusline + winbar
  { 'nvim-lualine/lualine.nvim' },

  -- toggleterm: float terminal
  { "akinsho/toggleterm.nvim" },

  { "folke/flash.nvim" },

  { "lukas-reineke/indent-blankline.nvim" },
}
