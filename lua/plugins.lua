local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Plugins
  use({ "wbthomason/packer.nvim" })

  -- Performance
  use({ "lewis6991/impatient.nvim" })
  use({ "nixprime/cpsm" })
  use("romgrk/fzy-lua-native")
  use({
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup()
    end,
  })

  -- Load only when require
  use({ "nvim-lua/plenary.nvim", module = "plenary" })

  -- Notification
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("config.notify").setup()
    end,
  })

  -- Colorscheme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("config.catppuccin").setup()
      vim.api.nvim_command("colorscheme catppuccin")
    end,
  })
  use({
    "NVChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
          css = { css = true }, -- Enable parsing rgb(...) functions in css.
        },
        user_default_options = { mode = "background", names = false },
      })
    end,
  })
  use({
    "rktjmp/lush.nvim",
    cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
  })
  use({
    "nvim-colortils/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  })

  -- Startup screen
  use({
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  })

  -- Discord Presence
  use("andweeb/presence.nvim")

  -- Git
  use("kdheepak/lazygit.nvim")
  use("SmiteshP/nvim-gps")
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("config.neogit").setup()
    end,
  })
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns").setup()
    end,
  })
  use({
    "tpope/vim-fugitive",
    opt = true,
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
    requires = { "tpope/vim-rhubarb", "idanarye/vim-merginal" },
  })
  use({
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    wants = { "vim-fugitive" },
  })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    module = "gitlinker",
    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  })
  use({
    "pwntester/octo.nvim",
    cmd = "Octo",
    wants = { "telescope.nvim", "plenary.nvim", "nvim-web-devicons" },
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  })
  use({
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictChooseTheirs",
      "GitConflictChooseOurs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    config = function()
      require("git-conflict").setup()
    end,
  })
  use({ "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } })
  use({
    "tanvirtin/vgit.nvim",
    config = function()
      require("vgit").setup({ settings = { live_blame = { enabled = false } } })
    end,
    cmd = { "VGit" },
  })

  -- Undo tree
  use({ "mbbill/undotree" })

  -- Pretty pictures of your code
  use({ "segeljakt/vim-silicon", cmd = { "Silicon" } })

  -- WhichKey
  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.whichkey").setup()
    end,
  })

  use({ "mrjones2014/legendary.nvim" })

  -- IndentLine
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indentblankline").setup()
    end,
  })

  -- Better icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  -- Better Comment
  use({
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("config.comment").setup()
    end,
  })

  -- Better surround
  use({ "tpope/vim-surround", event = "BufReadPre" })

  -- Motions
  use({ "andymass/vim-matchup" })
  use({ "wellle/targets.vim" })
  use({ "unblevable/quick-scope" })
  use({ "chaoren/vim-wordmotion" })

  -- Buffer
  use({ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } })
  use({
    "chentoast/marks.nvim",
    config = function()
      require("config.marks").setup()
    end,
  })

  -- IDE
  use({
    "antoinemadec/FixCursorHold.nvim",
    event = "BufReadPre",
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  })
  use({ "winston0410/smart-cursor.nvim" })
  use({
    "monaqa/dial.nvim",
    config = function()
      require("config.dial").setup()
    end,
  })
  use({
    "max397574/better-escape.nvim",
    event = { "InsertEnter" },
    config = function()
      require("better_escape").setup({
        mapping = { "jk" },
        timeout = vim.o.timeoutlen,
        keys = "<ESC>",
      })
    end,
  })
  use({
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
      require("config.neoscroll").setup()
    end,
  })
  use({
    "myusuf3/numbers.vim",
    config = function()
      vim.g.numbers_exclude = {
        "NvimTree",
        "spectre_panel",
        "toggleterm",
        "pr",
        "help",
        "nofile",
      }
    end,
  })
  use({ "google/vim-searchindex", event = "BufReadPre" })
  use({ "tyru/open-browser.vim", event = "BufReadPre" })
  use({
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup({})
    end,
    requires = { "nvim-treesitter/nvim-treesitter", "MunifTanjim/nui.nvim" },
  })
  use({ "tpope/vim-projectionist" })
  use({ "tpope/vim-rails" })
  use({
    "https://codeberg.org/esensar/nvim-dev-container",
    config = function()
      require("devcontainer").setup({})
    end,
  })

  -- Visual
  use("inkarkat/vim-CursorLineCurrentWindow")
  use("folke/lsp-colors.nvim")
  use({
    "petertriho/nvim-scrollbar",
    config = function()
      local clrs = require("catppuccin.palettes").get_palette("mocha")
      require("scrollbar").setup({
        show_in_active_only = true,
        excluded_filetypes = { "prompt", "NvimTree", "TelescopePrompt" },
        handle = { color = clrs.flamingo, search = true },
      })
      require("scrollbar.handlers.search").setup()
    end,
  })
  use("simeji/winresizer")
  use({
    "anuvyklack/windows.nvim",
    requires = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  })
  use("moll/vim-bbye")
  use("romainl/vim-cool")
  use({ "yamatsum/nvim-nonicons", requires = { "kyazdani42/nvim-web-devicons" } })
  use({
    "edluffy/specs.nvim",
    config = function()
      require("config.specs").setup()
    end,
  })
  use({ "kevinhwang91/nvim-hlslens" })

  -- Code documentation
  use({
    "danymat/neogen",
    config = function()
      require("config.neogen").setup()
    end,
    cmd = { "Neogen" },
    module = "neogen",
  })

  -- Jumps
  use({ "rhysd/clever-f.vim" })
  use({
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      leap.set_default_keymaps()
      leap.setup({
        case_insensitive = true,
        special_keys = {
          repeat_search = "<enter>",
          next_match = "<enter>",
          prev_match = "<tab>",
          next_group = "<space>",
          prev_group = "<tab>",
          eol = "<space>",
        },
      })
    end,
  })

  -- Markdown
  use({ "stevearc/gkeep.nvim" })
  use({
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  })
  use({
    "nvim-neorg/neorg",
    config = function()
      require("config.neorg").setup()
    end,
    requires = {
      "nvim-neorg/neorg-telescope",
      "nvim-lua/plenary.nvim",
      "lukas-reineke/headlines.nvim",
      "quantum-booty/neorg-trouble",
      "max397574/neorg-contexts",
      "max397574/neorg-kanban",
      "Pocco81/TrueZen.nvim",
    },
  })
  use({
    "phaazon/mind.nvim",
    config = function()
      require("mind").setup()
    end,
  })

  -- Status line
  -- use({
  -- 	"feline-nvim/feline.nvim",
  -- 	wants = "nvim-web-devicons",
  -- 	config = function()
  -- 		require("config.feline").setup()
  -- 	end,
  -- })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("config.lualine").setup()
    end,
  })

  -- Floating status line (for global statusline)
  use({
    "b0o/incline.nvim",
    config = function()
      require("config.incline").setup()
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end,
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "windwp/nvim-ts-autotag" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "p00f/nvim-ts-rainbow" },
      { "RRethy/nvim-treesitter-textsubjects" },
    },
  })
  use({
    "wellle/context.vim",
    config = function()
      vim.g.context_enabled = 0
    end,
  })
  use({
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  })
  use("mfussenegger/nvim-treehopper")
  use({
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup({ enabled = false })
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    wants = {
      "plenary.nvim",
      "telescope-fzf-native.nvim",
      "telescope-project.nvim",
      "telescope-repo.nvim",
      "telescope-file-browser.nvim",
      "project.nvim",
      "trouble.nvim",
      "telescope-dap.nvim",
      "telescope-frecency.nvim",
      "nvim-neoclip.lua",
      "telescope-smart-history.nvim",
      "telescope-arecibo.nvim",
      "telescope-media-files.nvim",
      "telescope-github.nvim",
      "telescope-zoxide",
      "cder.nvim",
      "telescope-bookmarks.nvim",
      "aerial.nvim",
    },
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-project.nvim",
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        requires = "tami5/sqlite.lua",
      },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("config.project").setup()
        end,
      },
      "nvim-telescope/telescope-dap.nvim",
      {
        "AckslD/nvim-neoclip.lua",
        requires = { { "tami5/sqlite.lua", module = "sqlite" } },
        config = function()
          require("neoclip").setup()
        end,
      },
      "nvim-telescope/telescope-smart-history.nvim",
      {
        "nvim-telescope/telescope-arecibo.nvim",
        rocks = { "openssl", "lua-http-parser" },
      },
      "nvim-telescope/telescope-media-files.nvim",
      "dhruvmanila/telescope-bookmarks.nvim",
      "nvim-telescope/telescope-github.nvim",
      "jvgrootveld/telescope-zoxide",
      "Zane-/cder.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
  })

  -- Nvim-tree
  use({
    "kyazdani42/nvim-tree.lua",
    wants = "nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("config.nvimtree").setup()
    end,
  })

  -- Window management
  use({
    "https://gitlab.com/yorickpeterse/nvim-window",
    config = function()
      require("config.nvim-window").setup()
    end,
  })
  use({
    "sindrets/winshift.nvim",
    config = function()
      require("winshift").setup()
    end,
  })

  -- User interface
  use({ "ray-x/guihua.lua", run = "cd lua/fzy && make", disable = true })
  -- use({
  -- 	"doums/suit.nvim",
  -- 	config = function()
  -- 		require("suit").setup({})
  -- 	end,
  -- })
  use({
    "nanozuki/tabby.nvim",
    config = function()
      require("config.tabby").setup()
    end,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.cmp").setup()
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "tzachar/cmp-tabnine",
      {
        "hrsh7th/cmp-cmdline",
        config = function()
          require("cmp").setup.cmdline(":", {
            sources = { { name = "cmdline" } },
          })
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "lukas-reineke/cmp-rg",
      {
        "L3MON4D3/LuaSnip",
        wants = { "friendly-snippets", "vim-snippets" },
        config = function()
          require("config.snip").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
  })

  -- Auto pairs
  use({
    "windwp/nvim-autopairs",
    opt = true,
    event = "InsertEnter",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("config.autopairs").setup()
    end,
  })

  -- Auto tag
  use({
    "windwp/nvim-ts-autotag",
    opt = true,
    wants = "nvim-treesitter",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({ enable = true })
    end,
  })

  -- End wise
  use({
    "RRethy/nvim-treesitter-endwise",
    opt = true,
    wants = "nvim-treesitter",
    event = "InsertEnter",
  })

  -- LSP
  use({
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  })
  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- })
  use({
    "neovim/nvim-lspconfig",
    wants = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "mason-tool-installer.nvim",
      "cmp-nvim-lsp",
      "neodev.nvim",
      "vim-illuminate",
      "null-ls.nvim",
      "schemastore.nvim",
      "typescript.nvim",
      "nvim-navic",
      "inlay-hints.nvim",
    },
    config = function()
      require("config.lsp").setup()
    end,
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "RRethy/vim-illuminate",
      "jose-elias-alvarez/null-ls.nvim", -- {
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/typescript.nvim",
      {
        "SmiteshP/nvim-navic",
        module = { "nvim-navic" },
        config = function()
          require("nvim-navic").setup({ depth_limit = 5 })
        end,
      },
      {
        "simrat39/inlay-hints.nvim",
        config = function()
          require("inlay-hints").setup()
        end,
      },
      {
        "zbirenbaum/neodim",
        config = function()
          require("config.neodim").setup()
        end,
      },
    },
  })

  -- trouble.nvim
  use({
    "folke/trouble.nvim",
    wants = "nvim-web-devicons",
    config = function()
      require("trouble").setup({ use_diagnostic_signs = true })
    end,
  })

  -- renamer.nvim
  use({
    "filipdutescu/renamer.nvim",
    module = { "renamer" },
    config = function()
      require("renamer").setup({})
    end,
  })

  -- Elixir
  use({ "mhanberg/elixir.nvim" })
  use({ "metakirby5/codi.vim" })

  -- Rust
  use({
    "simrat39/rust-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    opt = true,
    module = "rust-tools",
    ft = { "rust" },
  })
  use({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
      })
    end,
  })

  -- Go
  use({
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  })

  -- Terminal
  use({ "kassio/neoterm" })
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.toggleterm").setup()
    end,
  })

  -- Debugging
  use({
    "mfussenegger/nvim-dap",
    opt = true,
    keys = { [[<leader>d]] },
    module = { "dap" },
    wants = { "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
    requires = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      { "leoluz/nvim-dap-go", module = "dap-go" },
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = function()
      require("config.dap").setup()
    end,
  })
  use({
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup({})
    end,
  })

  -- Test
  use({
    "nvim-neotest/neotest",
    opt = true,
    wants = {
      "plenary.nvim",
      "nvim-treesitter",
      "FixCursorHold.nvim",
      "neotest-python",
      "neotest-plenary",
      "neotest-go",
      "neotest-jest",
      "neotest-vim-test",
      "neotest-rust",
      "vim-test",
      "overseer.nvim",
    },
    requires = {
      "vim-test/vim-test",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-vim-test",
      "rouge8/neotest-rust",
    },
    module = { "neotest", "neotest.async" },
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("config.neotest").setup()
    end,
  })

  -- AI completion
  use({
    "tzachar/cmp-tabnine",
    config = function()
      require("config.tabnine").setup()
    end,
  })

  -- Harpmon
  use({
    "ThePrimeagen/harpoon",
    keys = { [[<leader>j]] },
    module = {
      "harpoon",
      "harpoon.cmd-ui",
      "harpoon.mark",
      "harpoon.ui",
      "harpoon.term",
    },
    wants = { "telescope.nvim" },
    config = function()
      require("config.harpoon").setup()
    end,
  })

  -- Refactoring
  use({
    "ThePrimeagen/refactoring.nvim",
    module = { "refactoring", "telescope" },
    keys = { [[<leader>r]] },
    wants = { "telescope.nvim" },
    config = function()
      require("config.refactoring").setup()
    end,
  })
  use({
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  })
  use({
    "https://gitlab.com/yorickpeterse/nvim-pqf",
    event = "BufReadPre",
    config = function()
      require("pqf").setup()
    end,
  })

  -- Code folding
  use({
    "kevinhwang91/nvim-ufo",
    opt = true,
    keys = { "zc", "zo", "zR", "zm" },
    requires = "kevinhwang91/promise-async",
    config = function()
      require("config.ufo").setup()
    end,
  })

  -- Performance
  use({ "dstein64/vim-startuptime" })
  use({
    "nathom/filetype.nvim",
    cond = function()
      return vim.fn.has("nvim-0.8.0") == 0
    end,
  })

  -- UI goodies
  use({
    "folke/noice.nvim",
    config = function()
      require("config.noice").setup()
    end,
    requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  })
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })
  use({
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({})
    end,
  })

  -- Web
  use({
    "vuki656/package-info.nvim",
    opt = true,
    requires = { "MunifTanjim/nui.nvim" },
    wants = { "nui.nvim" },
    module = { "package-info" },
    ft = { "json" },
    config = function()
      require("config.package").setup()
    end,
  })

  -- Session
  use({
    "jedrzejboczar/possession.nvim",
    config = function()
      require("config.possession").setup()
    end,
    cmd = {
      "PossessionSave",
      "PosessionLoad",
      "PosessionShow",
      "PossessionList",
    },
  })

  -- Todo
  use({
    "folke/todo-comments.nvim",
    config = function()
      require("config.todocomments").setup()
    end,
    cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
  })

  -- Diffview
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  })

  -- Sidebar
  use({
    "liuchengxu/vista.vim",
    cmd = { "Vista" },
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  })
  use({
    "sidebar-nvim/sidebar.nvim",
    cmd = { "SidebarNvimToggle" },
    config = function()
      require("sidebar-nvim").setup({ open = false })
    end,
  })
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  })

  -- REPL
  use({
    "hkupty/iron.nvim",
    config = function()
      require("config.iron").setup()
    end,
  })

  -- Task runner
  use({
    "stevearc/overseer.nvim",
    opt = true,
    cmd = {
      "OverseerToggle",
      "OverseerOpen",
      "OverseerRun",
      "OverseerBuild",
      "OverseerClose",
      "OverseerLoadBundle",
      "OverseerSaveBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerQuickAction",
      "OverseerTaskAction",
    },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "user.run_script" },
      })
    end,
  })
  use({
    "michaelb/sniprun",
    run = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipReset",
      "SnipReplMemoryClean",
      "SnipClose",
      "SnipLive",
    },
    module = { "sniprun", "sniprun.api" },
  })

  -- Database
  use({
    "tpope/vim-dadbod",
    opt = true,
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "abenz1267/nvim-databasehelper",
    },
    wants = { "nvim-databasehelper" },
    config = function()
      require("config.dadbod").setup()
    end,
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
  })
  use({ "vim-scripts/dbext.vim" })
  use({
    "nanotee/sqls.nvim",
    module = { "sqls" },
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  })
  use({
    "dinhhuy258/vim-database",
    run = ":UpdateRemotePlugins",
    cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
  })

  -- Testing
  use({ "protex/better-digraphs.nvim", module = { "better-digraphs" } })
  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
  })

  use({
    "m-demare/attempt.nvim",
    opt = true,
    requires = "nvim-lua/plenary.nvim",
    module = { "attempt" },
    config = function()
      require("config.attempt").setup()
    end,
  })
  use({ "mg979/vim-visual-multi", event = "BufReadPre" })
  use({
    "anuvyklack/hydra.nvim",
    config = function()
      require("config.hydra").setup()
    end,
    requires = "anuvyklack/keymap-layer.nvim",
    module = { "hydra" },
    event = { "BufReadPre" },
  })

  -- Fade inactive buffers
  use({
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({})
    end,
  })

  -- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
