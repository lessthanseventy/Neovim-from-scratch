local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
    [[                _             _             _                  _              _             _       _  ]],
    [[               _\ \          / /\          /\_\               /\ \     _    /\ \           / /\    / /\]],
    [[              /\__ \        / /  \        / / /         _    /  \ \   /\_\ /  \ \         / / /   / / /]],
    [[             / /_ \_\      / / /\ \       \ \ \__      /\_\ / /\ \ \_/ / // /\ \ \       / /_/   / / / ]],
    [[            / / /\/_/     / / /\ \ \       \ \___\    / / // / /\ \___/ // / /\ \ \     / /\ \__/ / /  ]],
    [[           / / /         / / /  \ \ \       \__  /   / / // / /  \/____// / /  \ \_\   / /\ \___\/ /   ]],
    [[          / / /         / / /___/ /\ \      / / /   / / // / /    / / // / /    \/_/  / / /\/___/ /    ]],
    [[         / / / ____    / / /_____/ /\ \    / / /   / / // / /    / / // / /          / / /   / / /     ]],
    [[        / /_/_/ ___/\ / /_________/\ \ \  / / /___/ / // / /    / / // / /________  / / /   / / /      ]],
    [[       /_______/\__\// / /_       __\ \_\/ / /____\/ // / /    / / // / /_________\/ / /   / / /       ]],
    [[       \_______\/    \_\___\     /____/_/\/_________/ \/_/     \/_/ \/____________/\/_/    \/_/        ]],
    [[                                                                                                       ]],
    [[                                                                                                       ]],
    [[                           _            _              _      _                _                       ]],
    [[                          / /\         /\ \           /\ \   /\_\             /\ \                     ]],
    [[                         / /  \       /  \ \         /  \ \ / / /         _   \_\ \                    ]],
    [[                        / / /\ \__   / /\ \ \       / /\ \ \\ \ \__      /\_\ /\__ \                   ]],
    [[                       / / /\ \___\ / / /\ \ \     / / /\ \ \\ \___\    / / // /_ \ \                  ]],
    [[                       \ \ \ \/___// / /  \ \_\   / / /  \ \_\\__  /   / / // / /\ \ \                 ]],
    [[                        \ \ \     / / /    \/_/  / / /   / / // / /   / / // / /  \/_/                 ]],
    [[                    _    \ \ \   / / /          / / /   / / // / /   / / // / /                        ]],
    [[                   /_/\__/ / /  / / /________  / / /___/ / // / /___/ / // / /                         ]],
    [[                   \ \/___/ /  / / /_________\/ / /____\/ // / /____\/ //_/ /                          ]],
    [[                    \_____\/   \/____________/\/_________/ \/_________/ \_\/                           ]],
  }

  dashboard.section.buttons.val = {
    dashboard.button(
      "f",
      "  Find file",
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{cwd = '/home/andrew', previewer = false})<cr>"
    ),
    dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("r", "  Find repo", ":Telescope repo list <CR>"),
    dashboard.button("o", "  Norg Start", ":Neorg workspace work<CR>"),
    dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- NOTE: requires the fortune-mod package to work
    local handle = io.popen("fortune -s | cowsay -n -f vader")
    local fortune = handle:read("*a")
    handle:close()
    return fortune
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
  alpha.setup(dashboard.opts)
end

return M
