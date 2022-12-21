local fn = vim.fn

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
vim.opt.runtimepath:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Plugins
local plugins = {
  -- Performance
  { "lewis6991/impatient.nvim" },
  { "nixprime/cpsm" },
  "romgrk/fzy-lua-native",
  {
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup()
    end,
  },

  -- Load only when require

  "nvim-lua/plenary.nvim",

  -- Notification

  {
    "rcarriga/nvim-notify",
    config = function()
      require("config.notify").setup()
    end,
  }, -- Colorscheme

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("config.catppuccin").setup()
      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
  {
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
  },
  {
    "rktjmp/lush.nvim",
    cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
  },
  {
    "nvim-colortils/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  }, -- Startup screen
  {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  }, -- Discord Presence
  "andweeb/presence.nvim", -- Git
  "kdheepak/lazygit.nvim",
  "SmiteshP/nvim-gps",
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("config.neogit").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
    dependencies = { "tpope/vim-rhubarb", "idanarye/vim-merginal" },
  },
  { "rbong/vim-flog", cmd = { "Flog", "Flogsplit", "Floggit" } },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
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
  },
  { "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } },
  {
    "tanvirtin/vgit.nvim",
    config = function()
      require("vgit").setup({ settings = { live_blame = { enabled = false } } })
    end,
    cmd = { "VGit" },
  }, -- Undo tree
  { "mbbill/undotree" }, -- Pretty pictures of your code
  { "segeljakt/vim-silicon", cmd = { "Silicon" } }, -- WhichKey
  {
    "folke/which-key.nvim",
    config = function()
      require("config.whichkey").setup()
    end,
  },
  { "mrjones2014/legendary.nvim" }, -- IndentLine
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indentblankline").setup()
    end,
  }, -- Better icons
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  }, -- Better Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("config.comment").setup()
    end,
  }, -- Better surround
  { "tpope/vim-surround" }, -- Motions
  { "andymass/vim-matchup" },
  { "wellle/targets.vim" },
  { "unblevable/quick-scope" },
  { "chaoren/vim-wordmotion" }, -- Buffer
  { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },
  {
    "chentoast/marks.nvim",
    config = function()
      require("config.marks").setup()
    end,
  }, -- IDE
  {
    "antoinemadec/FixCursorHold.nvim",
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
  { "winston0410/smart-cursor.nvim" },
  {
    "monaqa/dial.nvim",
    config = function()
      require("config.dial").setup()
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" },
        timeout = vim.o.timeoutlen,
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("config.neoscroll").setup()
    end,
  },
  {
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
  },
  { "google/vim-searchindex" },
  { "tyru/open-browser.vim" },
  {
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  { "tpope/vim-projectionist" },
  { "tpope/vim-rails" },
  {
    url = "https://codeberg.org/esensar/nvim-dev-container",
    config = function()
      require("devcontainer").setup({})
    end,
  }, -- Visual
  "inkarkat/vim-CursorLineCurrentWindow",
  "folke/lsp-colors.nvim",
  {
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
  },
  "simeji/winresizer",
  {
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  "moll/vim-bbye",
  "romainl/vim-cool",
  { "yamatsum/nvim-nonicons", dependencies = { "kyazdani42/nvim-web-devicons" } },
  {
    "edluffy/specs.nvim",
    config = function()
      require("config.specs").setup()
    end,
  },
  { "kevinhwang91/nvim-hlslens" }, -- Code documentation
  {
    "danymat/neogen",
    config = function()
      require("config.neogen").setup()
    end,
    cmd = { "Neogen" },
  }, -- Jumps
  { "rhysd/clever-f.vim" },
  {
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
  }, -- Markdown
  { "stevearc/gkeep.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  },
  {
    "nvim-neorg/neorg",
    config = function()
      require("config.neorg").setup()
    end,
    dependencies = {
      "nvim-neorg/neorg-telescope",
      "nvim-lua/plenary.nvim",
      "lukas-reineke/headlines.nvim",
      "quantum-booty/neorg-trouble",
      "max397574/neorg-contexts",
      "max397574/neorg-kanban",
      "Pocco81/TrueZen.nvim",
    },
  },
  {
    "phaazon/mind.nvim",
    config = function()
      require("mind").setup()
    end,
  },

  -- Status line
  -- {
  -- 	"feline-nvim/feline.nvim",
  -- 	wants = "nvim-web-devicons",
  -- 	config = function()
  -- 		require("config.feline").setup()
  -- 	end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    config = function()
      require("config.lualine").setup()
    end,
  }, -- Floating status line (for global statusline)
  {
    "b0o/incline.nvim",
    config = function()
      require("config.incline").setup()
    end,
  }, -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup({ enable = false })
        end,
      },
      "RRethy/nvim-treesitter-textsubjects",
    },
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  "mfussenegger/nvim-treehopper",
  {
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup({ enabled = false })
    end,
  }, -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = "tami5/sqlite.lua",
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
        dependencies = { "tami5/sqlite.lua" },
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
  }, -- Nvim-tree
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("config.nvimtree").setup()
    end,
  }, -- Window management
  {
    url = "https://gitlab.com/yorickpeterse/nvim-window",
    config = function()
      require("config.nvim-window").setup()
    end,
  },
  {
    "sindrets/winshift.nvim",
    config = function()
      require("winshift").setup()
    end,
  }, -- User interface
  { "ray-x/guihua.lua", build = "cd lua/fzy && make", disable = true }, -- {
  -- 	"doums/suit.nvim",
  -- 	config = function()
  -- 		require("suit").setup({})
  -- 	end,
  -- },
  {
    "nanozuki/tabby.nvim",
    config = function()
      require("config.tabby").setup()
    end,
  }, -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.cmp").setup()
    end,
    dependencies = {
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
        config = function()
          require("config.snip").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
  }, -- Auto pairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("config.autopairs").setup()
    end,
  }, -- Auto tag
  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    config = function()
      require("nvim-ts-autotag").setup({ enable = true })
    end,
  }, -- End wise
  { "RRethy/nvim-treesitter-endwise", lazy = true }, -- LSP
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp").setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "RRethy/vim-illuminate",
      "jose-elias-alvarez/null-ls.nvim", -- {
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/typescript.nvim",
      {
        "SmiteshP/nvim-navic",
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
  }, -- trouble.nvim
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({ use_diagnostic_signs = true })
    end,
  }, -- renamer.nvim
  {
    "filipdutescu/renamer.nvim",
    config = function()
      require("renamer").setup({})
    end,
  }, -- Elixir
  { "mhanberg/elixir.nvim" },
  { "metakirby5/codi.vim" }, -- Rust
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    lazy = true,
    ft = { "rust" },
  },
  {
    "saecki/crates.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
      })
    end,
  }, -- Go
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  }, -- Terminal
  { "kassio/neoterm" },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.toggleterm").setup()
    end,
  }, -- Debugging
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      "leoluz/nvim-dap-go",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("config.dap").setup()
    end,
  },
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup({})
    end,
  }, -- Test
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
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
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("config.neotest").setup()
    end,
  }, -- AI completion
  {
    "tzachar/cmp-tabnine",
    build = "bash install.sh",
    config = function()
      require("config.tabnine").setup()
    end,
  }, -- Harpmon
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("config.harpoon").setup()
    end,
  }, -- Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("config.refactoring").setup()
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      require("pqf").setup()
    end,
  }, -- Code folding
  -- {
  -- 	"kevinhwang91/nvim-ufo",
  -- 	lazy = true,
  -- 	dependencies = "kevinhwang91/promise-async",
  -- 	config = function()
  -- 		require("config.ufo").setup()
  -- 	end,
  -- }, -- Performance
  { "dstein64/vim-startuptime" },
  {
    "nathom/filetype.nvim",
    cond = function()
      return vim.fn.has("nvim-0.8.0") == 0
    end,
  }, -- UI goodies
  {
    "folke/noice.nvim",
    config = function()
      require("config.noice").setup()
    end,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({})
    end,
  }, -- Web
  {
    "vuki656/package-info.nvim",
    lazy = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "json" },
    config = function()
      require("config.package").setup()
    end,
  }, -- Session
  {
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
  }, -- Todo
  {
    "folke/todo-comments.nvim",
    config = function()
      require("config.todocomments").setup()
    end,
    cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
  }, -- Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  }, -- Sidebar
  {
    "liuchengxu/vista.vim",
    cmd = { "Vista" },
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  },
  {
    "sidebar-nvim/sidebar.nvim",
    cmd = { "SidebarNvimToggle" },
    config = function()
      require("sidebar-nvim").setup({ open = false })
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  },

  -- REPL
  {
    "hkupty/iron.nvim",
    config = function()
      require("config.iron").setup()
    end,
  },

  -- Task runner
  {
    "stevearc/overseer.nvim",
    lazy = true,
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
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipReset",
      "SnipReplMemoryClean",
      "SnipClose",
      "SnipLive",
    },
  }, -- Database
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "abenz1267/nvim-databasehelper",
    },
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
  },
  "vim-scripts/dbext.vim",
  {
    "nanotee/sqls.nvim",
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  },
  {
    "dinhhuy258/vim-database",
    build = ":UpdateRemotePlugins",
    cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
  },
  "protex/better-digraphs.nvim",
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
  },
  {
    "m-demare/attempt.nvim",
    lazy = true,
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("config.attempt").setup()
    end,
  }, -- Multiple cursors
  { "mg979/vim-visual-multi" }, -- Fade inactive buffers
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({})
    end,
  },
}
require("lazy").setup(plugins)
-- https://github.com/WhoIsethDaniel/toggle-lsp-diagnostics.nvim
