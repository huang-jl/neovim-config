-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize Window
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<c-/>")
vim.keymap.del("n", "<c-_>")

vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })

-- move text up and down
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { silent = true, noremap = true })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { silent = true, noremap = true })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { silent = true, noremap = true })

-- terminal
local last_used_term = nil
vim.keymap.set("n", [[<c-\>]], function()
  local id = vim.v.count
  if id == 0 and last_used_term ~= nil and last_used_term:buf_valid() then
    last_used_term:toggle()
  else
    last_used_term = Snacks.terminal()
  end
end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Terminal (cwd)" })

-- add a picker for terminal
local terminal_picker = function()
  Snacks.picker.pick({
    source = "terminals",
    finder = function()
      local terms = Snacks.terminal.list()
      if vim.tbl_isempty(terms) then
        return {}
      end
      return vim.tbl_map(function(win)
        local cmd = type(win.cmd) == "table" and table.concat(win.cmd, " ") or (win.cmd or "")
        local name = vim.fn.fnamemodify(cmd, ":t")
        local title = vim.fn.getbufvar(win.buf, "term_title", "")
        local text = vim.tbl_get(win, "opts", "wo", "winbar")
        if text == nil or text == "" then
          text = string.format("[%d]: %s %s", win.id, cmd, name ~= "" and name or "term")
        else
          local id_str = text:match("^(%d+):")
          if id_str ~= nil then
            text = "[" .. id_str .. "] " .. title
          end
        end
        return {
          id = win.id,
          win = win,
          buf = win.buf,
          text = text,
        }
      end, terms)
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        item.win:toggle()
      end
    end,
    format = function(item)
      return { { item.text, "Normal" } }
    end,
    preview = function(ctx)
      if ctx.item.buf then
        Snacks.picker.preview.file(ctx)
      else
        ctx.preview:reset()
        ctx.preview:set_title("No preview")
      end
    end,
  })
end

vim.keymap.set("n", "<leader>ft", terminal_picker, {
  desc = "List Snack Terminal",
})
