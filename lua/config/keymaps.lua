-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Remap space as leader key
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
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

keymap("n", "<C-h>", function()
  if vim.fn.winnr() == vim.fn.winnr("h") then
    return "<cmd>tabprev<cr>"
  else
    return "<C-w>h"
  end
end, { expr = true, silent = true })

keymap("n", "<C-l>", function()
  if vim.fn.winnr() == vim.fn.winnr("l") then
    return "<cmd>tabnext<cr>"
  else
    return "<C-w>l"
  end
end, { expr = true, silent = true })

keymap("n", "<C-b>", "", opts)
keymap("n", "<C-f>", "", opts)
keymap("i", "<C-b>", "", opts)
keymap("i", "<C-f>", "", opts)

-- Dial (incrementing plugin)
keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })

keymap("n", "<leader><leader>", "<cmd>lua vim.api.nvim_feedkeys(':', 'n', true)<cr>", opts)

-- Clear highlights
keymap("n", "n", 'n:lua require("specs").show_specs()<CR>', opts)
keymap("n", "N", 'N:lua require("specs").show_specs()<CR>', opts)

keymap("n", "<F9>", ":Ttoggle<cr>", opts)
keymap("t", "<F9>", "<C-\\><C-n>:Tclose<cr>", opts)
keymap("t", "j", "j", opts)
keymap("t", "k", "k", opts)
keymap("t", "jk", "<C-\\><C-n>", opts)

keymap("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)

keymap("n", "<C-e>", "<cmd>WinResizerStartResize<CR>", opts)

keymap("n", "<c-d>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-d>"
  end
end, { silent = true, expr = true })

keymap("n", "<c-u>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-u>"
  end
end, { silent = true, expr = true })

-- Visual --
-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<F8>", ":NvimTreeToggle<CR>", opts)

-- Trouble
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)

-- Telescope
keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  opts
)
-- keymap("n", "<C-o>", "<cmd>lua require('telescope').extensions.file_browser.file_browser({grouped = true})<cr>", opts)
keymap(
  "n",
  "<leader>e",
  "<cmd>lua require('telescope').extensions.file_browser.file_browser({path = '%:p:h', grouped = true})<cr>",
  opts
)

-- hlslens

keymap(
  "n",
  "n",
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]],
  { silent = true, noremap = true }
)
keymap(
  "n",
  "N",
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { silent = true, noremap = true }
)
keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { silent = true, noremap = true })
keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { silent = true, noremap = true })
keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { silent = true, noremap = true })
keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], { silent = true, noremap = true })

-- Smart Cursor
keymap("n", "o", 'o<cmd>lua require("smart-cursor").indent_cursor()<cr>', { noremap = true, silent = true })
keymap("n", "O", 'O<cmd>lua require("smart-cursor").indent_cursor()<cr>', { noremap = true, silent = true })

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Visual
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Treesitter navigation
keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)
