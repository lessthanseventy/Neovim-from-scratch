vim.cmd [[
try
  " highlight NormalNC guibg=#181821
  " colorscheme dayfox
  colorscheme duskfox
  " colorscheme catppuccin
  " colorscheme kanagawa
  set scl=yes
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
