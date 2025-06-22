return {
  {
    "ggandor/leap.nvim",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "F", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap)")
      vim.keymap.set("n", "F", "<Plug>(leap-backward)")

      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
      -- setup highlight
      local links = {
        LeapBackdrop = "Comment",
        LeapMatch = "Search",
        LeapLabel = "Substitute",
      }

      for hl_group, link in pairs(links) do
        vim.api.nvim_set_hl(0, hl_group, { link = link })
      end
    end,
  },
}
