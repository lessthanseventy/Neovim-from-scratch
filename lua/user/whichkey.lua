local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["<tab>"] = { "<cmd>b#<cr>", "Previous window" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Find in repo" },
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    "Find files",
  },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  w = {
    name = "Window",
    m = { "<cmd>TZFocus<cr>", "Maximize window" },
    h = { "<C-w>h", "Focus left" },
    j = { "<C-w>j", "Focus down" },
    k = { "<C-w>k", "Focus up" },
    l = { "<C-w>l", "Focus right" },
    d = { "<C-w>c", "Delete window" },
    H = { "<cmd>WinShift left<CR>", "Move left" },
    J = { "<cmd>WinShift down<CR>", "Move down" },
    K = { "<cmd>WinShift up<CR>", "Move up" },
    L = { "<cmd>WinShift right<CR>", "Move right" },
    r = { "<C-w>r", "Rotate windows right" },
    R = { "<C-w>R", "Rotate windows left" },
    ["2"] = { "<C-w>v", "Layout double columns" },
    ["="] = { "<C-w>=", "Balance windows" },
    s = { "<C-w>s", "Split window below" },
    v = { "<C-w>v", "Split window right" },
  },

  g = {
    name = "Git",
    h = {
      name = "+Github",
      c = {
        name = "+Commits",
        c = { "<cmd>GHCloseCommit<cr>", "Close" },
        e = { "<cmd>GHExpandCommit<cr>", "Expand" },
        o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
        p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
        z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      },
      i = {
        name = "+Issues",
        p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      },
      l = {
        name = "+Litee",
        t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      },
      r = {
        name = "+Review",
        b = { "<cmd>GHStartReview<cr>", "Begin" },
        c = { "<cmd>GHCloseReview<cr>", "Close" },
        d = { "<cmd>GHDeleteReview<cr>", "Delete" },
        e = { "<cmd>GHExpandReview<cr>", "Expand" },
        s = { "<cmd>GHSubmitReview<cr>", "Submit" },
        z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      },
      p = {
        name = "+Pull Request",
        c = { "<cmd>GHClosePR<cr>", "Close" },
        d = { "<cmd>GHPRDetails<cr>", "Details" },
        e = { "<cmd>GHExpandPR<cr>", "Expand" },
        o = { "<cmd>GHOpenPR<cr>", "Open" },
        p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
        r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
        t = { "<cmd>GHOpenToPR<cr>", "Open To" },
        z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      },
      t = {
        name = "+Threads",
        c = { "<cmd>GHCreateThread<cr>", "Create" },
        n = { "<cmd>GHNextThread<cr>", "Next" },
        t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      },
    },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    c = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "CodeLens Display" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  x = {
    name = "Trouble",
    x = { "<cmd>Trouble<cr>", "Trouble" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostics" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document diagnostics" },
    l = { "<cmd>Trouble loclist<cr>", "Location List" },
    q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
  },
  s = {
    name = "Search",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    s = { "<cmd>lua require('spectre').open()<CR>", "Search and/or replace" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  -- t = {
  --   name = "Test",
  --   a = { "<Plug>(ultest-run-file)", "Run tests in file" },
  --   t = { "<Plug>(ultest-run-nearest)", "Run focused test" },
  --   l = { "<Plug>(ultest-run-last)", "Re-run last test(s)" },
  --   s = { "<Plug>(ultest-summary-toggle)", "Test summary window" },
  --   d = { "<Plug>(ultest-output-show)", "Test output window" },
  -- },
  T = {
    name = "Toggle",
    g = { "<cmd>GoldenSizeToggle<cr>", "Golden Ratio" },
    b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Git blame" },
    c = { "<cmd>ContextToggle<cr>", "Context" },
    r = { "<cmd>exec &nu==&rnu? 'se nu!' : 'se rnu!'<cr>", "Relative line numbering" },
    z = { "<cmd>TZAtaraxis<cr>", "Zen mode" },
    p = { "<cmd>lua require('hlargs').toggle()<cr>", "Highlight params" }
  },
  y = {
    name = "Yank",
    y = { "<cmd>let @+ = expand('%').':'.line('.')<cr>", "Relative path and line number" },
    f = { "<cmd>let @+ = expand('%')<cr>", "Relative file path" },
    F = { "<cmd>let @+ = expand('%:p')<cr>", "Absolute file path" }
  },
  n = {
    name = "Neorg",
    h = { "<cmd>Trouble neorg<cr>", "Browse headings" },
    m = { "<cmd>Neorg inject-metadata<cr>", "Inject metadata" },
    g = { "<cmd>Neorg gtd views<cr>", "GTD Views" },
    c = { "<cmd>Neorg gtd capture<cr>", "GTD Capture" },
    o = { "<cmd>Neorg workspace default<cr>", "Start default workspace" },
    p = { "<cmd>Neorg presenter start<cr>", "Start presentation" },
    t = { "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<cr>", "Cycle task status" }
  },
  t = {
    name = "Terminal",
    h = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    i = { "<cmd>lua _IEX_TOGGLE()<cr>", "IEx" },
    e = { "<cmd>TermExec cmd='elixir %'<cr>", "Elixir execute current file" },
    m = { "<cmd>TermExec cmd='mix run %'<cr>", "Mix run current file" },
    t = { "<cmd>lua _MIX_TEST_LINE()<cr>", "Mix test current line" },
    f = { "<cmd>lua _MIX_TEST_FILE()<cr>", "Mix test current file" },
    a = { "<cmd>lua _MIX_TEST_ALL()<cr>", "Mix test all" },
    ["="] = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    ["|"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    ["-"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
  },
}
-- t = { "<cmd>TermExec cmd='mix test %:<slnum>'<cr>", "Run test at line" },

which_key.setup(setup)
which_key.register(mappings, opts)
