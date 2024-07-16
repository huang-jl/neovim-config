# Neovim config of huang-jl

This is based on  [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch).

## Dependency

You need install python and pynvim module.

```bash
pip install pynvim
```

The pynvim module is to enable [grayout plugin](https://github.com/mphe/grayout.vim), which can gray out based on `compile_commands.json`.
It is helpful to explore the code of Linux kernel with respect to your `.config`.

Press `<leader>lg` to enable the grayout to current buffer.
