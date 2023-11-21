-- configure everforest: hard, medium (default), soft
vim.g.everforest_background = 'hard'

-- configure sonokai: default, andromeda, atlantis, shusia, maia, espresso
vim.g.sonokai_style = 'default'

-- configure edge: default, aura, neon
vim.g.edge_style = "neon"

-- configure material: darker, lighter, oceanic, palenight, deep ocean
vim.g.material_style = "deep ocean"

local colorscheme = "catppuccin-mocha"

vim.cmd("colorscheme " .. colorscheme)
