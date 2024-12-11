local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx =
        math.max(math.min(vim.api.nvim_win_get_width(0), width - 1) - curWidth - sufWidth, 0)
    suffix = ("·"):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

ufo.setup({
  open_fold_hl_timeout = 150,
  preview = {
      win_config = {
          border = "rounded",
          winhighlight = 'Normal:Folded',
          winblend = 0
      },
      mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
      }
  },
  fold_virt_text_handler = handler,
})

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'K', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.lsp.buf.hover()
    end
end)

vim.keymap.set("n", 'zk', ufo.goPreviousClosedFold, { desc= "UFO: go to previous closed fold" })
vim.keymap.set("n", 'zj', ufo.goNextClosedFold, { desc= "UFO: go to next closed fold" })

---@param num integer Set the fold level to this number
local set_buf_foldlevel = function(num)
    vim.b.ufo_foldlevel = num
    ufo.closeFoldsWith(num)
end

-- local max_foldlevel = 0
-- local total_lines = vim.api.nvim_buf_line_count(0)
--
-- for i = 1, total_lines do
--   local foldlevel = vim.fn.foldlevel(i)
--   if foldlevel > max_foldlevel then
--     max_foldlevel = foldlevel
--   end
-- end
--
-- print("Maximum fold level in buffer:", max_foldlevel)
-- vim.b.ufo_foldlevel = max_foldlevel

---@param num integer The amount to change the UFO fold level by
local change_buf_foldlevel_by = function(num)
    local foldlevel = vim.b.ufo_foldlevel or 0
    -- Ensure the foldlevel can't be set negatively
    if foldlevel + num >= 0 then
        foldlevel = foldlevel + num
    else
        foldlevel = 0
    end
    set_buf_foldlevel(foldlevel)
end

-- Keymaps
vim.keymap.set("n", "zm", function()
    local count = vim.v.count
    if count == 0 then
        count = 1
    end
    change_buf_foldlevel_by(-(count))
end, { desc = "UFO: Fold More" })

vim.keymap.set("n", "zr", function()
    local count = vim.v.count
    if count == 0 then
        count = 1
    end
    change_buf_foldlevel_by(count)
end, { desc = "UFO: Fold Less" })

-- 99% sure `zS` isn't mapped by default
vim.keymap.set("n", "zS", function()
    if vim.v.count == 0 then
        vim.notify("No foldlevel given to set!", vim.log.levels.WARN)
    else
        set_buf_foldlevel(vim.v.count)
    end
end, { desc = "UFO: Set Foldlevel" })
