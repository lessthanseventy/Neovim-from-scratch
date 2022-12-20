local M = {}

function M.setup()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal_int, -- nonnegative decimal number (0, 1, 2, 3, ...)
      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
      augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
      -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
      augend.constant.new({
        elements = { "and", "or" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      }),
      augend.constant.new({
        elements = { "true", "false" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      }),
      augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
    },
  })
end

return M
