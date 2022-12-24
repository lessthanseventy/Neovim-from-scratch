local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    rainbow = { enable = true, extended_mode = true, max_file_lines = nil },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    indent = { enable = true, disable = { "python", "css", "yaml" } },

    -- vim-matchup
    matchup = { enable = true },

    -- nvim-treesitter-textsubjects
    textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },

    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },

      swap = {
        enable = true,
        swap_next = { ["<leader>cx"] = "@parameter.inner" },
        swap_previous = { ["<leader>cX"] = "@parameter.inner" },
      },

      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },

      -- lsp_interop = {
      --   enable = true,
      --   border = "none",
      --   peek_definition_code = {
      --     ["<leader>cf"] = "@function.outer",
      --     ["<leader>cF"] = "@class.outer",
      --   },
      -- },
    },

    -- endwise
    endwise = { enable = true },

    -- autotag
    autotag = { enable = true },

    -- context_commentstring
    context_commentstring = {
      enable = true,
      -- enable_autocmd = false,
    },

    -- indent
    -- yati = { enable = true },
  })

  --   elixir_query = [[
  -- [
  --   ","
  --   ";"
  -- ] @punctuation.delimiter

  -- [
  --   "("
  --   ")"
  --   "<<"
  --   ">>"
  --   "["
  --   "]"
  --   "{"
  --   "}"
  -- ] @punctuation.bracket

  -- [
  --   "%"
  -- ] @punctuation.special

  -- (ERROR) @error

  -- (identifier) @variable

  -- ((identifier) @comment (#match? @comment "^_"))

  -- (comment) @comment
  -- (comment) @spell

  -- [
  --   (string)
  --   (atom)
  --   (quoted_atom)
  -- ] @string
  -- (string) @spell

  -- (alias) @type

  -- [
  --   (keyword)
  --   (quoted_keyword)
  -- ] @symbol

  -- (interpolation ["#{" "}"] @string.special)

  -- (escape_sequence) @string.escape

  -- (integer) @number

  -- (float) @float

  -- [
  --   (char)
  --   (charlist)
  -- ] @character

  -- (boolean) @boolean

  -- (nil) @constant.builtin

  -- (operator_identifier) @operator

  -- (unary_operator operator: _ @operator)

  -- (binary_operator operator: _ @operator)

  -- (binary_operator operator: "|>" right: (identifier) @function)

  -- (dot operator: _ @operator)

  -- (stab_clause operator: _ @operator)

  -- (call target: (identifier) @function.call)

  -- (call target: (dot left: [
  --   (atom) @type
  --   (_)
  -- ] right: (identifier) @function.call) (arguments))

  -- (call target: ((identifier) @keyword.function (#any-of? @keyword.function
  --   "def"
  --   "defdelegate"
  --   "defexception"
  --   "defguard"
  --   "defguardp"
  --   "defimpl"
  --   "defmacro"
  --   "defmacrop"
  --   "defmodule"
  --   "defn"
  --   "defnp"
  --   "defoverridable"
  --   "defp"
  --   "defprotocol"
  --   "defstruct"
  -- )) (arguments [
  --   (identifier) @function
  --   (binary_operator left: (identifier) @function operator: "when")])?)

  -- (call target: ((identifier) @keyword (#any-of? @keyword
  --   "alias"
  --   "case"
  --   "catch"
  --   "cond"
  --   "else"
  --   "for"
  --   "if"
  --   "import"
  --   "quote"
  --   "raise"
  --   "receive"
  --   "require"
  --   "reraise"
  --   "super"
  --   "throw"
  --   "try"
  --   "unless"
  --   "unquote"
  --   "unquote_splicing"
  --   "use"
  --   "with"
  -- )))

  -- ((identifier) @constant.builtin (#any-of? @constant.builtin
  --   "__CALLER__"
  --   "__DIR__"
  --   "__ENV__"
  --   "__MODULE__"
  --   "__STACKTRACE__"
  -- ))

  -- [
  --   "after"
  --   "catch"
  --   "do"
  --   "end"
  --   "fn"
  --   "rescue"
  --   "when"
  --   "else"
  -- ] @keyword

  -- [
  --   "and"
  --   "in"
  --   "not in"
  --   "not"
  --   "or"
  -- ] @keyword.operator

  -- (unary_operator
  --   operator: "&"
  --   operand: [
  --     (integer) @operator
  --     (binary_operator
  --       left: [
  --         (call target: (dot left: (_) right: (identifier) @function))
  --         (identifier) @function
  --       ] operator: "/" right: (integer) @operator)
  --   ])

  -- (sigil
  --   "~" @string.special
  --   ((sigil_name) @string.special) @_sigil_name
  --   quoted_start: _ @string.special
  --   quoted_end: _ @string.special
  --   ((sigil_modifiers) @string.special)?
  --   (#not-any-of? @_sigil_name "s" "S"))

  -- (sigil
  --   "~" @string
  --   ((sigil_name) @string) @_sigil_name
  --   quoted_start: _ @string
  --   (quoted_content) @string
  --   quoted_end: _ @string
  --   ((sigil_modifiers) @string)?
  --   (#any-of? @_sigil_name "s" "S"))

  -- (unary_operator
  --   operator: "@"
  --   operand: [
  --     (identifier)
  --     (call target: (identifier))
  --   ] @constant) @constant

  -- (unary_operator
  --   operator: "@"
  --   operand: (call
  --     target: ((identifier) @_identifier (#any-of? @_identifier "moduledoc" "typedoc" "shortdoc" "doc")) @comment
  --     (arguments [
  --       (string)
  --       (boolean)
  --       (charlist)
  --       (sigil
  --         "~" @comment
  --         ((sigil_name) @comment)
  --         quoted_start: _ @comment
  --         (quoted_content) @comment
  --         quoted_end: _ @comment)
  --     ] @comment))) @comment
  --   ]]

  --   require("vim.treesitter.query").set_query("elixir", "highlights", elixir_query)
end

return M
