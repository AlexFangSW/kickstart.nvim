vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'Q', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'q', '<Nop>', { silent = true })

-- resize window.
-- 'M' == alt
vim.keymap.set("n", '<M-k>', ":resize +2<CR>")
vim.keymap.set("n", '<M-j>', ":resize -2<CR>")
vim.keymap.set("n", '<M-l>', ":vertical resize +10<CR>")
vim.keymap.set("n", '<M-h>', ":vertical resize -10<CR>")

-- MarkdownPreview
vim.keymap.set("n", "<leader>p", ":MarkdownPreviewToggle<CR>", { desc = "Toggle MarkdownPreview" })

-- horizontal move
vim.keymap.set("n", "<C-l>", "zL")
vim.keymap.set("n", "<C-h>", "zH")

-- toggle nvim tree
-- vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>")
vim.keymap.set("n", "<C-b>", ":Oil <CR>")

-- multiple functions for <esc>
vim.keymap.set("n", "<esc>", "<esc>:nohl<CR>")

-- don't lose yanked on past
vim.keymap.set("x", "p", [["_dP]])

-- moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- moving up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- open git diff current vs head
-- use :DiffviewOpen <old>..<new> to see all changes merged in specified range of commit
vim.keymap.set("n", "<F2>", ":DiffviewOpen<CR>")

-- open git commit graph
vim.keymap.set("n", "<F3>", ":Flog<CR>")

-- open current file's commit history
vim.keymap.set("n", "<F4>", ":DiffviewFileHistory %<CR>")

-- restart lsp
vim.keymap.set("n", "<F5>", ":LspRestart<CR>")

-- close tab
vim.keymap.set("n", "<leader><Tab>q", ":tabclose<CR>")

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>gh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- surround word in visual mode
-- `> and `< goes to the previous selections "end" and "start"
-- then we do the insert and use 'gv' to return to visual mode
-- https://www.reddit.com/r/neovim/comments/18r5lbn/make_it_so_using_on_selected_text_surrounds_it/
vim.keymap.set("v", "(", "<esc>`>a)<esc>`<i(<esc>gv", { remap = false })
vim.keymap.set("v", "{", "<esc>`>a}<esc>`<i{<esc>gv", { remap = false })
vim.keymap.set("v", "[", "<esc>`>a]<esc>`<i[<esc>gv", { remap = false })
vim.keymap.set("v", "\"", "<esc>`>a\"<esc>`<i\"<esc>gv", { remap = false })
vim.keymap.set("v", "'", "<esc>`>a'<esc>`<i'<esc>gv", { remap = false })
vim.keymap.set("v", "`", "<esc>`>a`<esc>`<i`<esc>gv", { remap = false })
vim.keymap.set("v", "**", "<esc>`>a**<esc>`<i**<esc>gv", { remap = false })

-- show undotree
vim.keymap.set('n', '<F6>', ':UndotreeShow<CR>')

-- quickfix list movements
vim.keymap.set("n", "<C-s>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-a>", "<cmd>cprev<CR>zz")
