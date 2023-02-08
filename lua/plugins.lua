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
vim.opt.runtimepath:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Plugins
local plugins = {
  -- Performance
  "romgrk/fzy-lua-native",
  {
    "monkoose/matchparen.nvim",

    config = function()
      require("matchparen").setup()
    end,
  }, -- Load only when require
  "nvim-lua/plenary.nvim", -- Notification
  {
    "rcarriga/nvim-notify",

    config = function()
      require("config.notify").setup()
    end,
  }, -- Colorscheme
  {
    dir = "/home/andrew/projects/tokyonight.nvim",

    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      })
    end,
  },
  {
    "NVChad/nvim-colorizer.lua",

    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
        },
        user_default_options = {
          mode = "background",
          names = false,
          css = true,
          css_fn = true,
          tailwind = true,
        },
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
    "terrortylor/nvim-comment",

    config = function()
      require("nvim_comment").setup()
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
  }, -- {
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
  "inkarkat/vim-CursorLineCurrentWindow", -- {
  {
    "dstein64/nvim-scrollview",

    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree" },
        on_startup = true,
        auto_workarounds = true,
        current_only = true,
        base = "right",
        column = 2,
      })
    end,
    -- vim.api.nvim_set_hl(0, "InputHighlight", {
    --   fg = "#ff0000",
    --   ctermfg = 255,
    --   bg = "#00ff00",
    --   ctermbg = 14,
    -- }),
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
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
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
    "epwalsh/obsidian.nvim",

    config = function()
      require("obsidian").setup({
        dir = "~/.vault",
        notes_subdir = "notes",
        daily_notes = { folder = "dailies" },
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
      })
    end,
  },
  {
    "phaazon/mind.nvim",
    config = function()
      require("mind").setup()
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
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
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
      "RRethy/vim-illuminate",
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
      {
        "lalitmee/browse.nvim",
        config = function()
          require("browse").setup({ provider = "duckduckgo" })
        end,
      },
      { "lessthanseventy/tailiscope.nvim" },
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
      "hrsh7th/cmp-nvim-lsp",
      "lukas-reineke/cmp-rg",
    },
  },
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  "rafamadriz/friendly-snippets",
  "honza/vim-snippets",
  { "onsails/lspkind.nvim" }, -- Auto pairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("config.autopairs").setup()
    end,
  }, -- Auto tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }, -- End wise
  { "RRethy/nvim-treesitter-endwise" }, -- LSP
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
      "jose-elias-alvarez/null-ls.nvim",
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/typescript.nvim",
      {
        "SmiteshP/nvim-navic",
        config = function()
          require("config.navic").setup()
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
    "dnlhc/glance.nvim",
    config = function()
      local glance = require("glance")
      local actions = glance.actions

      glance.setup({
        height = 18, -- Height of the window
        zindex = 45,
        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["<C-h>"] = actions.enter_win("preview"), -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<C-l>"] = actions.enter_win("list"), -- Focus list window
          },
        },
        hooks = {
          before_open = function(results, open, jump, method)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
              local target_uri = results[1].uri or results[1].targetUri

              if target_uri == uri then
                jump(results[1])
              else
                open(results)
              end
            else
              open(results)
            end
          end,
        },
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = false, -- Automatically fold list on startup
        },
        indent_lines = { enable = true, icon = "│" },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      })
    end,
  },
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
  -- {
  --   "mhanberg/elixir.nvim",
  --   config = function()
  --     require("elixir").setup({
  --       cmd = "/home/andrew/.local/share/nvim/mason/packages/elixir-ls/debugger.sh",
  --       settings = require("elixir").settings({
  --         dialyzerEnabled = false,
  --         fetchDeps = false,
  --         enableTestLenses = true,
  --         suggestSpecs = false,
  --       }),
  --     })
  --   end,
  -- },
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
    "rareitems/printer.nvim",
    config = function()
      require("printer").setup({
        keymap = "gp", -- Plugin doesn't have any keymaps by default
        formatters = {
          -- you can define your formatters for specific filetypes
          -- by assigning function that takes two strings
          -- one text modified by 'add_to_inside' function
          -- second the variable (thing) you want to print out
          -- see examples in lua/formatters.lua
          lua = function(inside, variable)
            return string.format('print("%s: " .. %s)', inside, variable)
          end,
          elixir = function(inside, variable)
            return string.format('IO.inspect(%s, label: "\\n%s\\n")', variable, inside)
          end,
          ruby = function(inside, variable)
            return string.format('pp "%s = ", %s', inside, variable)
          end,
        },
        -- function which modifies the text inside string in the print statement, by default it adds the path and line number
        add_to_inside = function(text)
          return string.format("[%s:%s] %s", vim.fn.expand("%"), vim.fn.line("."), text)
        end,
        -- set to to indenity function to turn off the default behaviour
        -- add_to_inside = function(text)
        --     return text
        -- end,
      })
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
  },
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
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("config.ufo").setup()
    end,
  }, -- Performance
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
      vim.keymap.set("n", "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set("n", "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end, { silent = true, expr = true })
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
      require("colorful-winsep").setup({
        -- timer refresh rate
        interval = 30,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = {
          "TelescopePrompt",
          "mason",
          "CompetiTest",
          "NvimTree",
          "prompt",
          "ultestsummary",
          "spectre_panel",
          "toggleterm",
          "pr",
          "help",
          "telescope",
          "dbout",
          "dbui",
          "sql",
          "csv",
          "neoterm",
          "noice",
        },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      })
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
  { "/mechatroner/rainbow_csv" },
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
require("lazy").setup(plugins, {
  defaults = { lazy = false },
  checker = { enabled = true },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})
-- https://github.com/WhoIsethDaniel/toggle-lsp-diagnostics.nvim
