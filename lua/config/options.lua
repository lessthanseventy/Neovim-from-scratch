vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = true -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 150 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4 -- set number column width to 4
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wildmenu = false
vim.opt.wrap = true -- display lines as one long line
vim.opt.fillchars.eob = " "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.guifont = { "Caskaydia Cove Nerd Font Complete", ":h16" }
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.laststatus = 3
vim.opt.mousemodel = "extend"
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
vim.opt.splitkeep = "screen"
vim.g.catppuccin_flavour = "mocha"

vim.g.context_add_mappings = 0 -- disable vim.context keybindings

vim.g["test#neovim#start_normal"] = 1
vim.g["test#neovim#term_position"] = "belowright"

vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_use_nerd_fonts = 1

vim.g.neoterm_default_mod = "belowright"

vim.g.python3_host_prog = "/usr/bin/python"
-- vim.cmd([[let $PATH = '/home/andrew/.asdf/installs/nodejs/18.9.1 ' . $PATH]])
vim.g.node_host_prog = "/home/andrew/.asdf/installs/nodejs/18.9.1/bin/neovim-node-host"
vim.g.loaded_perl_provider = 0

-- -- If the current system shell or the `shell` option is set to /usr/bin/fish then revert to sh
-- if os.getenv("SHELL") == "/usr/bin/fish" or vim.opt.shell == "/usr/bin/fish" then
-- 	vim.opt.shell = "/usr/bin/zsh"
-- else
-- 	-- Else default to the system current shell.
-- 	vim.opt.shell = os.getenv("SHELL")
-- end

vim.cmd([[
  let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp
  let g:dasht_filetype_docsets['elixir'] = ['phoenix', 'phoenix_html', 'ecto']
]])
