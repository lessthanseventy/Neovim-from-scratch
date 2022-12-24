-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
local M = {}

function M.setup()
  -- stylua: ignore
  local colors = require("tokyonight.colors").setup() -- pass in any of the config options as explained above
  local navic = require("nvim-navic")

  require("lualine").setup({
    options = {
      theme = "tokyonight",
      component_separators = "|",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "" }, right_padding = 2 },
      },
      lualine_b = {
        { "filename", color = { fg = colors.orange, bg = colors.bg } },
        { "branch", color = { fg = colors.orange, bg = colors.bg } },
      },
      lualine_c = {
        {
          navic.get_location,
          cond = navic.is_available,
          color = { fg = colors.orange, bg = colors.bg },
        },
      },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = colors.orange, bg = colors.bg },
        },
        { "diagnostics", color = { fg = colors.orange, bg = colors.bg } },
      },
      lualine_y = {
        { "filetype", color = { fg = colors.orange, bg = colors.bg } },
        { "progress", color = { fg = colors.orange, bg = colors.bg } },
      },
      lualine_z = {
        {
          "location",
          separator = { right = "" },
          left_padding = 2,
          color = { fg = colors.orange, bg = colors.bg },
        },
      },
    },
    tabline = {},
    extensions = {},
  })
end

return M
