local M = {}

local util = require("tabby.util")

local tab_name = require("tabby.feature.tab_name").get
local mocha = require("catppuccin.palettes").get_palette("mocha")
local hl_tabline = { fg = mocha.pink, bg = mocha.base }
local hl_tabline_sel = { fg = mocha.base, bg = mocha.pink }
local hl_tabline_fill = { fg = mocha.pink, bg = mocha.base }

local function tab_label(tabid, active)
	local icon = active and "" or ""
	local number = vim.api.nvim_tabpage_get_number(tabid)
	local name = tab_name(tabid)
	return string.format(" %s %d: %s ", icon, number, name)
end

local tabline = {
	hl = "lualine_c_normal",
	layout = "tab_only",
	head = {
		{ "  ", hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
		{ "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
	},
	active_tab = {
		label = function(tabid)
			return {
				tab_label(tabid, true),
				hl = {
					fg = hl_tabline_sel.fg,
					bg = hl_tabline_sel.bg,
					style = "bold",
				},
			}
		end,
		left_sep = {
			"",
			hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg },
		},
		right_sep = {
			"",
			hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg },
		},
	},
	inactive_tab = {
		label = function(tabid)
			return {
				tab_label(tabid, false),
				hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
			}
		end,
		left_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
		right_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
	},
}

function M.setup()
	require("tabby").setup({ tabline = tabline })
end

return M
