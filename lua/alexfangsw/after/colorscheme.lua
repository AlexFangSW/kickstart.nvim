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

local function evergarden()
    local colors = require('evergarden.colors').fall
    colors.text = "#CACCBE"
    vim.cmd.colorscheme("evergarden")
end

local function transparent_background()
    -- Transparent background
    local transparent = require("transparent")
    transparent.clear_prefix('BufferLine')
    transparent.clear_prefix('NeoTree')
    transparent.clear_prefix('lualine')
    vim.cmd([[:TransparentEnable]])
end

-- gruvbox()
zenbones()
-- evergarden()

transparent_background()
