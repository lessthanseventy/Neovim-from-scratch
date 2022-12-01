-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
local M = {}

function M.setup()
    -- stylua: ignore
    local colors = require("catppuccin.palettes").get_palette("mocha")

	local bubbles_theme = {
		normal = {
			a = { fg = colors.base, bg = colors.lavender },
			b = { fg = colors.text, bg = colors.mantle },
			c = { fg = colors.base, bg = colors.base },
		},

		insert = { a = { fg = colors.base, bg = colors.blue } },
		visual = { a = { fg = colors.base, bg = colors.sky } },
		replace = { a = { fg = colors.base, bg = colors.red } },
	}

	local navic = require("nvim-navic")

	require("lualine").setup({
		options = {
			theme = "catppuccin",
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = { "filename", "branch" },
			lualine_c = { { navic.get_location, cond = navic.is_available } },
			lualine_x = { "diagnostics" },
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		tabline = {},
		extensions = {},
	})
end

return M
