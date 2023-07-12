local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, {})
    vim.keymap.set("n", "<leader>hb", function() gs.blame_line({full=true}) end, {})
    vim.keymap.set("n", "<leader>hd", gs.diffthis, {})

  end
    
  
}

vim.cmd([[
  function! s:add_mappings() abort
    nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    " Reset quickfix height. Sometimes it messes up after selecting another item
    11copen
    wincmd p
  endfunction

  function s:diff_current_quickfix_entry() abort
    " Cleanup windows
    for window in getwininfo()
      if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
        exe 'bdelete' window.bufnr
      endif
    endfor
    cc
    call s:add_mappings()
    let qf = getqflist({'context': 0, 'idx': 0})
    if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
      let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
      echom string(reverse(range(len(diff))))
      for i in reverse(range(len(diff)))
        exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
        call s:add_mappings()
      endfor
    endif
  endfunction

  function! s:view_git_history() abort
    Git difftool --name-only ! !^@
    call s:diff_current_quickfix_entry()
    " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
    " There's probably a better way to map this without changing the window
    copen
    nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
    wincmd p
  endfunction

  command! DiffHistorycall call s:view_git_history()
]])
