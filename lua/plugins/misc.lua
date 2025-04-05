return {
  -- symbols-outline
  { 'hedyhli/outline.nvim' },

  -- which-key
  { "folke/which-key.nvim" },

  -- none-ls
  { "nvimtools/none-ls.nvim" },

  -- navic for statusline and winbar
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  },

  -- lualine: statusline + winbar
  { 'nvim-lualine/lualine.nvim' },

  -- toggleterm: float terminal
  { "akinsho/toggleterm.nvim" },

  { "lukas-reineke/indent-blankline.nvim" },

  { "stevearc/profile.nvim" },

  -- we choose leap instead of flash
  -- as flash is slow when opening large files (e.g., over 30 MBs)
  { "ggandor/leap.nvim" },
}
