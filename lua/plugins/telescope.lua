return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { 
          "nvim-telescope/telescope-live-grep-args.nvim",
          -- This will not install any breaking changes.
          -- For major updates, this must be adjusted manually.
          version = "^1.0.0",
      },
    },
  },
  {
    'LukasPietzschmann/telescope-tabs',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
}
