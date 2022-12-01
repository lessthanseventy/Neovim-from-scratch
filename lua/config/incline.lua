local M = {}

function M.setup()
  local colors = require("catppuccin.palettes").get_palette("mocha")
  require("incline").setup({
    hide = { only_win = false, focused_win = false, cursorline = true },
    ignore = {
      buftypes = "special",
      filetypes = { "sql" },
      floating_wins = true,
      unlisted_buffers = true,
      wintypes = "special",
    },
    render = function(props)
      -- generate name
      local bufname = vim.api.nvim_buf_get_name(props.buf)
      if bufname == "" then
        return "[No name]"
      else
        -- ":." is the filename relative to the PWD (=project)
        -- bufname = vim.fn.fnamemodify(bufname, ":.")
        bufname = vim.fn.fnamemodify(bufname, ":p:h:h:t")
            .. "/"
            .. vim.fn.fnamemodify(bufname, ":p:h:t")
            .. "/"
            .. vim.fn.fnamemodify(bufname, ":t")
      end

      local icon = require("nvim-web-devicons").get_icon(bufname, nil, { default = true })

      local max_len = vim.api.nvim_win_get_width(props.win) / 2

      if #bufname > max_len then
        return {
          " " .. icon .. " …" .. string.sub(bufname, #bufname - max_len, -1) .. " ",
          guibg = colors.maroon,
          guifg = colors.mantle,
        }
      else
        return {
          " " .. icon .. " " .. bufname .. " ",
          guibg = colors.maroon,
          guifg = colors.mantle,
        }
      end
    end,
    window = {
      zindex = 2,
      width = "fit",
      placement = { horizontal = "right", vertical = "top" },
      margin = {
        horizontal = { left = 1, right = 1 },
        vertical = { bottom = 0, top = 0 },
      },
      padding = { left = 1, right = 2 },
      padding_char = " ",
    },
  })
end

return M
