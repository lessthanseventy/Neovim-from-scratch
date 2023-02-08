local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
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

    -- lsp_interop = {
    --   enable = true,
    --   border = "none",
    --   peek_definition_code = {
    --     ["<leader>cf"] = "@function.outer",
    --     ["<leader>cF"] = "@class.outer",
    --   },
    -- },

    -- endwise
    endwise = { enable = true },

    -- autotag
    autotag = {
      enable = true,
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "html-heex",
        "elixir",
        "heex",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
      },
    },

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
