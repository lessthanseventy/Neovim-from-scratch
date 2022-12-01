## LaunchScout.nvim
A Neovim Distribution for polyglots. Particularly nice for Elixir ;)

## Core Ideas
It is based around the concept of space as a leader key. Whichkey is used to display a helpful menu with the shortcuts.

- `Ctrl+hjkl` moves between windows.
- `HL` moves left and right between tabs.
- `F1` gives you a builtin help search.
- `<F8>` displays a tree-view of whatever project you are in.
- `<F9>` displays a pop-up terminal.
- `gd` to go to the definition of whatever your cursor is on.
- `gr` to display a quickfix list of references to whatever your cursor is on.
- `K` to get help for whatever your cursor is on.
- `<Space> g g` to get a pop-up window displaying [Lazygit]("https://github.com/jesseduffield/lazygit#configuration")

## Install Neovim nightly
```sh
asdf plugin add neovim
asdf install neovim nightly
asdf global neovim nightly
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/lessthanseventy/neovim-config/ ~/.config/nvim
```

Run `nvim` press colon to enter command mode. Then enter `PackerSync` and press enter to install the plugins.

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

**NOTE** Checkout this file for some predefined keymaps: [keymaps](https://github.com/lessthanseventy/neovim-config/blob/master/lua/config/keymaps.lua)

**NOTE** Checkout this file for the whichkey keymaps: [keymaps](https://github.com/lessthanseventy/neovim-config/blob/master/lua/config/whichkey.lua)


## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work: 

- On mac

  ```sh
  brew install ripgrep
  ```

- On ubuntu

  ```sh
  brew install ripgrep
  ```
---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed through asdf.


## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP, Formatter, or Linter

First Enter:

```
:Mason
```

and press `i` on what you wish to install. Press `g?` to get additional help.

### Plugins

You can install new plugins here: [plugins](https://github.com/lessthanseventy/neovim-config/blob/master/lua/plugins.lua)

---

## Plugins

- "wbthomason/packer.nvim"
- "lewis6991/impatient.nvim"
- "nixprime/cpsm"
- "romgrk/fzy-lua-native"
- "monkoose/matchparen.nvim"
- "nvim-lua/plenary.nvim"
- "rcarriga/nvim-notify"
- "catppuccin/nvim"
- "NVChad/nvim-colorizer.lua"
- "background"
- "rktjmp/lush.nvim"
- "nvim-colortils/colortils.nvim"
- "goolord/alpha-nvim"
- "andweeb/presence.nvim"
- "kdheepak/lazygit.nvim"
- "SmiteshP/nvim-gps"
- "TimUntersberger/neogit"
- "lewis6991/gitsigns.nvim"
- "tpope/vim-fugitive"
- "rbong/vim-flog"
- "ruifm/gitlinker.nvim"
- "pwntester/octo.nvim"
- "akinsho/git-conflict.nvim"
- "f-person/git-blame.nvim"
- "tanvirtin/vgit.nvim"
- "mbbill/undotree"
- "segeljakt/vim-silicon"
- "folke/which-key.nvim"
- "mrjones2014/legendary.nvim"
- "lukas-reineke/indent-blankline.nvim"
- "kyazdani42/nvim-web-devicons"
- "numToStr/Comment.nvim"
- "tpope/vim-surround"
- "andymass/vim-matchup"
- "wellle/targets.vim"
- "unblevable/quick-scope"
- "chaoren/vim-wordmotion"
- "kazhala/close-buffers.nvim"
- "chentoast/marks.nvim"
- "antoinemadec/FixCursorHold.nvim"
- "winston0410/smart-cursor.nvim"
- "monaqa/dial.nvim"
- "max397574/better-escape.nvim"
- "karb94/neoscroll.nvim"
- "myusuf3/numbers.vim"
- "google/vim-searchindex"
- "tyru/open-browser.vim"
- "bennypowers/nvim-regexplainer"
- "tpope/vim-projectionist"
- "tpope/vim-rails"
- "https://codeberg.org/esensar/nvim-dev-container"
- "inkarkat/vim-CursorLineCurrentWindow"
- "folke/lsp-colors.nvim"
- "petertriho/nvim-scrollbar"
- "simeji/winresizer"
- "anuvyklack/windows.nvim"
- "moll/vim-bbye"
- "romainl/vim-cool"
- "yamatsum/nvim-nonicons"
- "edluffy/specs.nvim"
- "kevinhwang91/nvim-hlslens"
- "danymat/neogen"
- "rhysd/clever-f.vim"
- "ggandor/leap.nvim"
- "stevearc/gkeep.nvim"
- "iamcco/markdown-preview.nvim"
- "nvim-neorg/neorg"
- "phaazon/mind.nvim"
- "feline-nvim/feline.nvim"
- "nvim-lualine/lualine.nvim"
- "b0o/incline.nvim"
- "nvim-treesitter/nvim-treesitter"
- "wellle/context.vim"
- "m-demare/hlargs.nvim"
- "mfussenegger/nvim-treehopper"
- "haringsrob/nvim_context_vt"
- "nvim-telescope/telescope.nvim"
- "kyazdani42/nvim-tree.lua"
- "https://gitlab.com/yorickpeterse/nvim-window"
- "sindrets/winshift.nvim"
- "ray-x/guihua.lua"
- "doums/suit.nvim"
- "nanozuki/tabby.nvim"
- "hrsh7th/nvim-cmp"
- "windwp/nvim-autopairs"
- "windwp/nvim-ts-autotag"
- "RRethy/nvim-treesitter-endwise"
- "folke/neodev.nvim"
- "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
- "neovim/nvim-lspconfig"
- "folke/trouble.nvim"
- "filipdutescu/renamer.nvim"
- "mhanberg/elixir.nvim"
- "metakirby5/codi.vim"
- "simrat39/rust-tools.nvim"
- "saecki/crates.nvim"
- "ray-x/go.nvim"
- "kassio/neoterm"
- "akinsho/toggleterm.nvim"
- "mfussenegger/nvim-dap"
- "andrewferrier/debugprint.nvim"
- "nvim-neotest/neotest"
- "tzachar/cmp-tabnine"
- "ThePrimeagen/harpoon"
- "ThePrimeagen/refactoring.nvim"
- "nvim-pack/nvim-spectre"
- "https://gitlab.com/yorickpeterse/nvim-pqf"
- "kevinhwang91/nvim-ufo"
- "dstein64/vim-startuptime"
- "nathom/filetype.nvim"
- "folke/noice.nvim"
- "j-hui/fidget.nvim"
- "vuki656/package-info.nvim"
- "jedrzejboczar/possession.nvim"
- "folke/todo-comments.nvim"
- "sindrets/diffview.nvim"
- "liuchengxu/vista.vim"
- "sidebar-nvim/sidebar.nvim"
- "stevearc/aerial.nvim"
- "hkupty/iron.nvim"
- "stevearc/overseer.nvim"
- "user.run_script"
- "michaelb/sniprun"
- "tpope/vim-dadbod"
- "vim-scripts/dbext.vim"
- "nanotee/sqls.nvim"
- "dinhhuy258/vim-database"
- "protex/better-digraphs.nvim"
- "ziontee113/icon-picker.nvim"
- "m-demare/attempt.nvim"
- "mg979/vim-visual-multi"
- "anuvyklack/hydra.nvim"
- "levouh/tint.nvim"
---
