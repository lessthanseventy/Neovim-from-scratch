local M = {}

function M.setup()
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
		}, { silent = true, noremap = true })
	end)

	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.norg.concealer"] = {},
			["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
			["core.norg.journal"] = {},
			["core.gtd.base"] = { config = { workspace = "home" } },
			["core.presenter"] = { config = { zen_mode = "truezen" } },
			["core.integrations.telescope"] = {},
			["core.integrations.treesitter"] = {
				config = { configure_parsers = true, install_parsers = true },
			},
			["core.norg.dirman"] = {
				config = {
					workspaces = { work = "~/.norg/work", home = "~/.norg/home" },
				},
			},
			["external.context"] = {},
			["external.kanban"] = {},
		},
	})
end

return M
