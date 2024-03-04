local status_ok, telescope_tabs = pcall(require, "telescope-tabs")
if not status_ok then
	return
end
  
telescope_tabs.setup({
  showpreview = true,
  close_tab_shortcut_i = '<leader>d', -- if you're in insert mode
  close_tab_shortcut_n = '<leader>d',     -- if you're in normal mode
})
