local M = {}

function M.setup()
  local g = vim.g
  g.indent_blankline_char = "┊"
  g.indent_blankline_filetype_exclude = { "help", "packer" }
  g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
  g.indent_blankline_show_trailing_blankline_indent = false

  local indent_blankline = require("indent_blankline")
  indent_blankline.setup({
    char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = false,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "help", "packer", "NvimTree" },
  })
end

return M
