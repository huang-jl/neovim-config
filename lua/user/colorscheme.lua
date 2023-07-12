vim.cmd [[
try
  colorscheme kanagawa-wave
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
