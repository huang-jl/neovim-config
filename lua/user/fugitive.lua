
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

-- Function to determine the current mode and get the selected range if in visual mode
local function get_line_range()
  -- Get the current mode
  local mode = vim.fn.mode()
  
  -- Check if the current mode is visual mode (either 'v' for visual mode or 'V' for visual line mode)
  if mode == 'v' or mode == 'V' then
    -- Get the start and end positions of the visual selection
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    -- Extract the line numbers
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    vim.print(start_line, end_line)

    -- Return the line numbers
    return start_line, end_line
  else
    -- Return nil if not in visual mode
    local line_number = vim.fn.line('.')
    return line_number, line_number
  end
end

function get_history_of_current_line()
  local start_line, end_line = get_line_range()
  local filename = vim.api.nvim_buf_get_name(0)
  vim.cmd(string.format(
    [[ Git log -L %d,%d:%s ]],
      start_line, end_line, filename
  ))
end
