local M = {}

local utils = require "utils"
local api = vim.api

M.highlight = true

function M.toggle()
  M.highlight = not M.highlight
  if M.highlight then
    utils.info("Enabled document highlight", "Document Highlight")
  else
    utils.warn("Disabled document highlight", "Document Highlight")
  end
end

function M.highlight(client, bufnr)
  if M.highlight then
    if client.server_capabilities.documentHighlightProvider then
      local present, _ = pcall(require, "illuminate")
      if not present then
        local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
      end
    end
  end
end

function M.setup(client, bufnr)
  M.highlight(client, bufnr)
end

return M
