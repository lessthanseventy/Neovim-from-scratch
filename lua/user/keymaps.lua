local opts = { noremap = true, silent = true }

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
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<C-o>", "<cmd>lua require('telescope').extensions.file_browser.file_browser({grouped = true})<cr>", opts)
keymap("n", "<leader>e", "<cmd>lua require('telescope').extensions.file_browser.file_browser({path = '%:p:h', grouped = true})<cr>", opts)
keymap("n", "<leader><leader>", ":", opts)
keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", 'n', 'n:lua require("specs").show_specs()<CR>', opts)
keymap("n", 'N', 'N:lua require("specs").show_specs()<CR>', opts)

-- Trouble
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)


-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Treesitter navigation
keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)
