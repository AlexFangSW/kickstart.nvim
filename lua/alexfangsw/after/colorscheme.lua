local function zenbones()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("zenbones")
end

local function gruvbox()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme("gruvbox-material")
end

local function vague()
    vim.cmd("colorscheme vague")
end

local function transparent_background()
    -- Transparent background
    local transparent = require("transparent")
    transparent.clear_prefix('BufferLine')
    transparent.clear_prefix('NeoTree')
    transparent.clear_prefix('lualine')
    vim.cmd([[:TransparentEnable]])
end

local function testing()
    -- vim.cmd("colorscheme newsprint")
end

testing()
gruvbox()
-- zenbones()
-- vague()


transparent_background()
