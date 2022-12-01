local M = {}

function M.setup()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype)
					return { "lsp", "treesitter", "indent" }
				end,
			})
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
end

return M
