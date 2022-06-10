local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
-- keymap("n", "<C-p>", ":e ", opts)
keymap("n", "<C-o>", "<cmd>lua require('telescope').extensions.file_browser.file_browser({grouped = true})<cr>", opts)
keymap("n", "<leader>e", "<cmd>lua require('telescope').extensions.file_browser.file_browser({path = '%:p:h', grouped = true})<cr>", opts)
keymap("n", "<leader><leader>", ":", opts)
keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", 's', ':HopChar2<CR>', opts)
keymap("n", 'n', 'n:lua require("specs").show_specs()<CR>', opts)
keymap("n", 'N', 'N:lua require("specs").show_specs()<CR>', opts)
keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)

-- Resize with meta + arrows
keymap("n", "<D-Up>", ":resize -2<CR>", opts)
keymap("n", "<D-Down>", ":resize +2<CR>", opts)
keymap("n", "<D-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<D-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Trouble
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
