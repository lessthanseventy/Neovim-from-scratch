local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local gps = require("nvim-gps")

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local components = {
  active = { {}, {}, {} },
  inactive = { {}, {}, {} },
}

local colors = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  magenta = '#c14a4a',
  cyan = "#DDB6F2",
  violet = "#F5C2E7",
  red = "#F28FAD",
  maroon = "#E8A2AF",
  orange = "#F8BD96",
  yellow = "#FAE3B0",
  green = "#ABE9B3",
  oceanblue = "#96CDFB",
  skyblue = "#89DCEB",
  teal = "#B5E8E0",
  lavender = "#C9CBFF",
  white = "#D9E0EE",
  gray2 = "#C3BAC6",
  fg = "#988BA2",
  gray0 = "#6E6C7E",
  black4 = "#575268",
  bg = "#302D41",
  black = "#302D41",
  black2 = "#1E1E2E",
  black1 = "#1A1826",
  black0 = "#161320",
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  CONFIRM = 'red',
  VISUAL = 'skyblue',
  LINES = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = '<|',
  OP = '<|',
  INSERT = '|>',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = '<|',
  SHELL = '<|',
  TERM = '<|',
  NONE = '<>',
  CONFIRM = '|>'
}

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}

-- LEFT

-- fileIcon
-- components.active[1][1] = {
--   provider = function()
--     local filename  = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon      = require 'nvim-web-devicons'.get_icon(filename, extension)
--     if icon == nil then
--       icon = ''
--     end
--     return icon
--   end,
--   hl = function()
--     local val        = {}
--     local filename   = vim.fn.expand('%:t')
--     local extension  = vim.fn.expand('%:e')
--     local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
--     if icon ~= nil then
--       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
--     else
--       val.fg = 'white'
--     end
--     val.bg = 'bg'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' '
-- }
--
-- -- fileType
-- components.active[1][2] = {
--   provider = 'file_type',
--   hl = function()
--     local val        = {}
--     local filename   = vim.fn.expand('%:t')
--     local extension  = vim.fn.expand('%:e')
--     local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
--     if icon ~= nil then
--       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
--     else
--       val.fg = 'white'
--     end
--     val.bg = 'bg'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' '
-- }
--
-- components.active[1][3] = {
--   provider = function()
--     return vi_mode_text[vi_mode_utils.get_vim_mode()]
--   end,
--   hl = function()
--     local val = {}
--     val.fg = vi_mode_utils.get_mode_color()
--     val.bg = 'bg'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' '
-- }
--
-- -- filename
-- components.active[1][4] = {
--   provider = function()
--     return vim.fn.expand("%:F")
--   end,
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = {
--     str = ' > ',
--     hl = {
--       fg = 'white',
--       bg = 'bg',
--       style = 'bold'
--     },
--   }
-- }
-- -- nvimGps
-- components.active[1][5] = {
--   provider = function() return gps.get_location() end,
--   enabled = function() return gps.is_available() end,
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   }
-- }
--
-- -- MID
--
-- -- gitBranch
-- components.active[2][1] = {
--   provider = 'git_branch',
--   hl = {
--     fg = 'yellow',
--     bg = 'bg',
--     style = 'bold'
--   }
-- }
-- -- diffAdd
-- components.active[2][2] = {
--   provider = 'git_diff_added',
--   hl = {
--     fg = 'green',
--     bg = 'bg',
--     style = 'bold'
--   }
-- }
-- -- diffModfified
-- components.active[2][3] = {
--   provider = 'git_diff_changed',
--   hl = {
--     fg = 'orange',
--     bg = 'bg',
--     style = 'bold'
--   }
-- }
-- -- diffRemove
-- components.active[2][4] = {
--   provider = 'git_diff_removed',
--   hl = {
--     fg = 'red',
--     bg = 'bg',
--     style = 'bold'
--   },
-- }
-- -- diagnosticErrors
-- components.active[2][5] = {
--   provider = 'diagnostic_errors',
--   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
--   hl = {
--     fg = 'red',
--     style = 'bold'
--   }
-- }
-- -- diagnosticWarn
-- components.active[2][6] = {
--   provider = 'diagnostic_warnings',
--   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
--   hl = {
--     fg = 'yellow',
--     style = 'bold'
--   }
-- }
-- -- diagnosticHint
-- components.active[2][7] = {
--   provider = 'diagnostic_hints',
--   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
--   hl = {
--     fg = 'cyan',
--     style = 'bold'
--   }
-- }
-- -- diagnosticInfo
-- components.active[2][8] = {
--   provider = 'diagnostic_info',
--   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
--   hl = {
--     fg = 'skyblue',
--     style = 'bold'
--   }
-- }
--
-- -- RIGHT
--
-- -- LspName
-- components.active[3][1] = {
--   provider = 'lsp_client_names',
--   hl = {
--     fg = 'yellow',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
-- components.active[3][3] = {
--   provider = 'position',
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
-- -- scrollBar
-- components.active[3][4] = {
--   provider = 'scroll_bar',
--   hl = {
--     fg = 'yellow',
--     bg = 'bg',
--   },
-- }
--
-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'fg',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'fg',
      bg = 'bg',
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'fg',
        bg = 'bg',
      }
    },
    ' '
  }
}

components.inactive[1][2] = {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = 'fg',
    bg = 'bg',
    style = 'bold'
  },
}

local cat_components = require('catppuccin.core.integrations.feline')
cat_components.inactive = components.inactive

require('feline').setup({
  theme = colors,
  vi_mode_colors = vi_mode_colors,
  force_inactive = force_inactive,
  components = cat_components
})
