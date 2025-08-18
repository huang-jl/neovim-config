-- cargo install inferno
-- inferno-flamegraph /tmp/profile.output > flame.svg
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p", group = "+profile (by plenary)" },
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>pb",
        function() require'plenary.profile'.start("/tmp/profile.output", {flame = true}) end,
        desc = "profile begin",
      },
      {
        "<leader>ps",
        function() require'plenary.profile'.stop() end,
        desc = "profile stop",
      },
    }
  }
}
