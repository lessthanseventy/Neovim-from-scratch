local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use {
    "stevearc/dressing.nvim",
    config = function()
      require('dressing').setup({
        input = {
          -- When true, <Esc> will close the modal
          insert_only = true,
        }
      })
    end
  }
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use {
    "ur4ltz/surround.nvim",
    config = function()
      require "surround".setup { mappings_style = "surround" }
    end
  }
  use {
    "yamatsum/nvim-nonicons",
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use { "feline-nvim/feline.nvim" }

  use {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.mix_task = {
        type = 'executable',
        command = '/home/andrew/.local/share/nvim/lsp_servers/elixir/elixir-ls/debugger.sh', -- debugger.bat for windows
        args = {}
      }
      dap.configurations.elixir = {
        {
          type = "mix_task",
          name = "mix test",
          task = 'test',
          taskArgs = { "--trace" },
          request = "launch",
          startApps = true, -- for Phoenix projects
          projectDir = "${workspaceFolder}",
          requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs"
          }
        },
      }
    end
  }

  use {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        dimming = {
          alpha = 0.45, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 25
      }
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup()
    end
  }
  use "anuvyklack/nvim-keymap-amend"
  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end
  }
  use {
    "sindrets/winshift.nvim",
    config = function() require("winshift").setup() end
  }
  use {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup({
        signcolumn = false,
        excluded_filetypes = { "UltestSummary", "spectre_panel", "toggleterm" }
      })
    end }
  use {
    "karb94/neoscroll.nvim",
    config = function() require("neoscroll").setup() end
  }

  use {
    "edluffy/specs.nvim",
    config = function() require('specs').setup {
        show_jumps       = true,
        min_jump         = 30,
        popup            = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          winhl = "PMenu",
          fader = require('specs').pulse_fader,
          resizer = require('specs').slide_resizer
        },
        ignore_filetypes = {},
        ignore_buftypes  = {
          nofile = true,
        },
      }
    end
  }
  use {
    "j-hui/fidget.nvim",
    config = function() require("fidget").setup() end
  }
  use "rhysd/clever-f.vim"
  use "chaoren/vim-wordmotion"
  use "romainl/vim-cool"
  use "wellle/targets.vim"
  use "andweeb/presence.nvim"
  use {
    "nvim-pack/nvim-spectre",
    config = function() require("spectre").setup() end
  }
  use "SmiteshP/nvim-gps"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  use {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        commentStyle = "italic",
        functionStyle = "NONE",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        -- dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        globalStatus = false, -- adjust window separators highlight for laststatus=3
        colors = {},
        overrides = {},
      })
    end
  }
  use "EdenEast/nightfox.nvim" -- Packer
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = "italic",
              hints = "italic",
              warnings = "italic",
              information = "italic",
            },
            underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
            },
          },
          lsp_trouble = false,
          cmp = true,
          lsp_saga = false,
          gitgutter = true,
          gitsigns = true,
          telescope = true,
          nvimtree = {
            enabled = true,
            show_root = false,
            transparent_panel = false,
          },
          neotree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
          },
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          dashboard = true,
          neogit = true,
          vim_sneak = false,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          hop = true,
          notify = true,
          telekasten = true,
          symbols_outline = true,
          ts_rainbow = true
        }
      })
    end
  }
  use {
    "sunjon/Shade.nvim",
    config = function()
      require 'shade'.setup({
        overlay_opacity = 50,
        opacity_step = 1,
        keys = {
          brightness_up   = '<C-Up>',
          brightness_down = '<C-Down>',
          toggle          = '<Leader>Ts',
        }
      })
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }

  use "rcarriga/nvim-notify"

  use {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({
        modes = { ':', '/', '?' },
        next_key = '<C-k>',
        previous_key = '<C-j>',
      })

      local gradient = {
        '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
        '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
        '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
        '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
      }

      for i, fg in ipairs(gradient) do
        gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
      end

      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = function(ctx, arg)
              if string.find(arg, '.') ~= nil then
                return { 'fdfind', '-tf', '-H' }
              else
                return { 'fdfind', '-tf' }
              end
            end,
            dir_command = { 'fd', '-td' },
            filters = { 'cpsm_filter' },
          }),
          wilder.substitute_pipeline({
            fuzzy = 2,
            pipeline = wilder.python_search_pipeline({
              skip_cmdtype_check = 1,
              pattern = wilder.python_fuzzy_pattern({
                start_at_boundary = 0,
              }),
            }),
          }),
          wilder.cmdline_pipeline({
            fuzzy = 2,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          {
            wilder.check(function(ctx, x) return x == '' end),
            wilder.history(),
          },
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern({
              start_at_boundary = 0,
            }),
          })
        ),
      })

      local popupmenu_renderer = wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          border = 'rounded',
          empty_message = wilder.popupmenu_empty_message_with_spinner(),
          highlighter = wilder.highlighter_with_gradient({
            wilder.lua_fzy_highlighter(),
          }),
          highlights = {
            gradient = gradient, -- must be set
          },
          left = {
            ' ',
            wilder.popupmenu_devicons(),
            wilder.popupmenu_buffer_flags({
              flags = ' a + ',
              icons = { ['+'] = '', a = '', h = '' },
            }),
          },
          right = {
            ' ',
            wilder.popupmenu_scrollbar(),
          },
          max_height = '25%',
          reverse = 1,        -- if 1, shows the candidates from bottom to top
        })
      )

      local wildmenu_renderer = wilder.wildmenu_renderer({
        highlights = {
          gradient = gradient, -- must be set
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.lua_fzy_highlighter(),
        }),
        separator = ' · ',
        left = { ' ', wilder.wildmenu_spinner(), ' ' },
        right = { ' ', wilder.wildmenu_index() },
      })

      wilder.set_option('renderer', wilder.renderer_mux({
        [':'] = popupmenu_renderer,
        ['/'] = wildmenu_renderer,
        substitute = wildmenu_renderer,
      }))
    end
  }
  use "romgrk/fzy-lua-native"
  use "nixprime/cpsm"
  use {
    "phaazon/hop.nvim",
    config = function()
      require('hop').setup()
    end
  }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp"
  } -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "tzachar/cmp-tabnine"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP and formatting
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use { 'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup({
        keep_indentation = false,
        fill_char = '━',
        sections = {
          left = {
            '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
          },
          right = {
            '┫ ', 'number_of_folded_lines', ' ┣━━',
          }
        }
      })
      require('pretty-fold.preview').setup({ key = 'l' })
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require('telescope').setup {
        -- see :help telescope.setup()
        defaults = {
          mappings = {
            i = {
              ["<Esc>"] = require('telescope.actions').close,
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
            }
          },
          -- The below pattern is lua regex and not wildcard
          file_ignore_patterns = { "node_modules", "%.out" },
          prompt_prefix = "🔍 ",
        }
      }
    end
  }
  use {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      require('telescope').load_extension('media_files')
    end
  }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require('telescope').load_extension('file_browser')
    end
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        }
      }
    end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "mfussenegger/nvim-treehopper"
  use {
    "haringsrob/nvim_context_vt",
    config = function()
      require('nvim_context_vt').setup({
        -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
        -- Default: true
        enabled = false,
      })
    end
  }
  use { "kevinhwang91/nvim-hlslens",
    config = function()
      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end
  }
  use {
    "winston0410/smart-cursor.nvim",
    config = function()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'o',
        'o<cmd>lua require("smart-cursor").indent_cursor()<cr>', kopts)
      vim.api.nvim_set_keymap('n', 'O',
        'O<cmd>lua require("smart-cursor").indent_cursor()<cr>', kopts)
    end
  }

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "kdheepak/lazygit.nvim"

  --Neorg
  use {
    "nvim-neorg/neorg",
    config = function()
      local neorg_callbacks = require("neorg.callbacks")

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.find_linkable" },
          },
          i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
            { "<C-f>", "core.integrations.telescope.insert_file_link" },
          },
        },
          {
            silent = true,
            noremap = true,
          })
      end)

      require('neorg').setup {
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.gtd.base"] = {
            config = {
              workspace = "home"
            }
          },
          ["core.presenter"] = {
            config = {
              zen_mode = "truezen"
            }
          },
          ["core.integrations.telescope"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/.org/work",
                home = "~/.org/home",
              }
            }
          }
        }
      }
    end,
    requires = "nvim-neorg/neorg-telescope"
  }
  use "Pocco81/TrueZen.nvim"
  use "quantum-booty/neorg-trouble"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
