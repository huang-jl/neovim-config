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
              ["<M-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<M-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
        },
        list = {
          keys = {
            ["<M-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<M-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<M-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
            ["<M-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
