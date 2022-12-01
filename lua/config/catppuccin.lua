local M = {}

function M.setup()
  local colors = require("catppuccin.palettes").get_palette("mocha")

  require("catppuccin").setup({
    flavor = "mocha",
    custom_highlights = function(mocha)
      return {
        DiagnosticVirtualTextError = {
          fg = mocha.red,
          style = { "italic" },
        },
        DiagnosticVirtualTextWarn = {
          fg = mocha.yellow,
          style = { "italic" },
        },
        DiagnosticVirtualTextInfo = { fg = mocha.sky, style = { "italic" } },
        DiagnosticVirtualTextHint = {
          fg = mocha.teal,
          style = { "italic" },
        },
      }
    end,
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      lsp_trouble = false,
      cmp = true,
      lsp_saga = false,
      gitgutter = true,
      gitsigns = true,
      telescope = true,
      mason = true,
      noice = true,
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
      indent_blankline = { enabled = true, colored_indent_levels = true },
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
      ts_rainbow = true,
    },
  })
  require("catppuccin.lib.highlighter").syntax({
    VertSplit = { fg = colors.flamingo },
  })
end

return M
