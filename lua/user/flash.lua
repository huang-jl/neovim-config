local status_ok, flash = pcall(require, "flash")
if not status_ok then
	return
end

flash.setup({
})

vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({ "n" }, "<cr>", function() flash.jump({ continue = true }) end, { desc = "Continue Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set({ "x", "o" }, "r", function() flash.remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "r", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash" })
