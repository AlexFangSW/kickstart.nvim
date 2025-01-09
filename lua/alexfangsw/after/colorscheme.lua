local function zenbones()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("zenbones")
    -- colorcolumn and background color
    vim.opt.termguicolors = true
    vim.cmd("highlight ColorColumn guibg=#272725")
    -- vim.cmd("highlight Normal guibg=#E0E0E0")
end

local function gruvbox()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme("gruvbox-material")
end

local function evergarden()
    local colors = require('evergarden.colors').colors()
    colors.text = "#CACCBE"
    vim.cmd.colorscheme("evergarden")
end

-- gruvbox()
-- zenbones()
evergarden()
