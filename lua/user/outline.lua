local status_ok, outline = pcall(require, "outline")
if not status_ok then
	return
end

local opts = {
  guides = {
    enabled = true,
  },
  outline_window = {
    position = 'right',
    relative_width = true,
    width = 20,
    wrap = false,
    show_relative_numbers = false,
    show_numbers = false,
    auto_close = false,
  },
  outline_items = {
    highlight_hovered_item = true,
    show_symbol_details = true,
  },
  symbol_folding = {
    markers = { '', '' },
  },
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "P",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "H",
    unfold_all = "L",
    fold_reset = "R",
  },
}

outline.setup(opts)

