local M = {}

local types = require("cmp.types")

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
  Text = " ",
  Method = "m ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

function M.setup()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local has_words_before = function()
    unpack = unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
        cmp.TriggerEvent.InsertEnter,
      },
      completeopt = "menuone,noinsert,noselect",
      keyword_length = 1,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = lspkind.cmp_format({
        mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        menu = { -- showing type in menu
          nvim_lsp = "[LSP]",
          path = "[Path]",
          buffer = "[Buffer]",
          vsnip = "[Snip]",
        },
        before = function(entry, vim_item) -- for tailwind css autocomplete
          if vim_item.kind == "Color" and entry.completion_item.documentation then
            local _, _, r, g, b =
            string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
            if r then
              local color = string.format("%02x", r)
                  .. string.format("%02x", g)
                  .. string.format("%02x", b)
              local group = "Tw_" .. color
              if vim.fn.hlID(group) < 1 then
                vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
              end
              vim_item.kind = "■" -- or "⬤" or anything
              vim_item.kind_hl_group = group
              return vim_item
            end
          end
          -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
          -- or just show the icon
          vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
          return vim_item
        end,
      }),
    },

    mapping = {
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(
        cmp.mapping.complete({
          sources = {
            { name = "nvim_lsp" },
            { name = "vsnip", keyword_length = 0 },
          },
        }),
        { "i", "c" }
      ),

      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    },
    -- formatting = {
    --   fields = { "kind", "abbr", "menu" },
    --   format = function(entry, vim_item)
    --     vim_item.kind = kind_icons[vim_item.kind]
    --     vim_item.menu = ({
    --       cmp_tabnine = "| AI|",
    --       nvim_lsp = "| LSP|",
    --       ["vim-dadbod-completion"] = "|🗒️DB|",
    --       luasnip = "| Snippet|",
    --       path = "| Path|",
    --     })[entry.source.name]
    --     return vim_item
    --   end,
    -- },
    reason = cmp.ContextReason.Manual,
    sources = cmp.config.sources({
      { name = "cmp_tabnine" },
      { name = "nvim_lsp" },
      { name = "vim-dadbod-completion" },
      { name = "vsnip", keyword_length = 0 },
      { name = "path" },
    }),
    confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = { ghost_text = true },
  })

  -- Auto pairs
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
