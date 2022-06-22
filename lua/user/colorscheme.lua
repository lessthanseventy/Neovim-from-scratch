vim.cmd [[
try
  colorscheme duskfox
  set scl=yes
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
