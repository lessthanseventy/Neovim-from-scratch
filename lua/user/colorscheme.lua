vim.cmd [[
try
  colorscheme catppuccin
  set scl=yes
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
