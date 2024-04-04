vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set default indent
vim.opt.ts = 2
vim.opt.sts = 2
vim.opt.sw = 2
vim.opt.et = true

-- Set cursor style
vim.opt.guicursor = "n-v-c-i:block-Cursor"

-- Set fold
-- Use za to toggle fold
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"


-- Set no wrap
vim.opt.wrap = false

-- Set highlight on search
vim.o.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"

-- Make line numbers default
vim.wo.number = true

-- relative line numbers
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.opt.swapfile = false
vim.opt.backup = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  If you see 'no clipboard tool found' in :checkhealth, you might need to install 'xclip' first
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
