vim.keymap.set({'n', 'x', 'o'}, 'f',  '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'F',  '<Plug>(leap-backward)')
-- Use the traversal keys to repeat the previous motion without
-- explicitly invoking Leap:
require('leap.user').set_repeat_keys('<enter>', '<backspace>')

local links = {
  LeapBackdrop = "Comment",
  LeapMatch = "Search",
  LeapLabel = "Substitute",
}

for hl_group, link in pairs(links) do
  vim.api.nvim_set_hl(0, hl_group, { link = link })
end


