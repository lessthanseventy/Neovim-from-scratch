local M = {}

local icons = require("config.icons")

function M.setup()
	local notify = require("notify")
	notify.setup({
		top_down = false,
		background_color = { bg = "#a6e3a1" },
		icons = {
			ERROR = icons.ui.Fire,
			WARN = icons.diagnostics.Warning,
			INFO = icons.diagnostics.Information,
			DEBUG = icons.ui.Bug,
			TRACE = icons.ui.Pencil,
		},
	})
end

return M
