-- disable treesitter highlight for rust and c
return {
{
  "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        disable = {"rust", "c"},
      }
    }
  },
}
