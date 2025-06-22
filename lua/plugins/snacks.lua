return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          -- input window
          input = {
            keys = {
              ["<M-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<M-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            },
          },
        },
        list = {
          keys = {
            ["<M-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<M-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
