-- [[ Keymaps that don't need plugings ]]
-- [[ Keymaps that don't need plugings ]]
-- [[ Keymaps that don't need plugings ]]
-- [[ Keymaps that don't need plugings ]]

-- [[
-- If you want to find and replace multiple files:
-- This will open all matched files in nvim buffer.
-- nvim `find . -name '*.txt' -exec grep -le 'Alex' {} +`
-- -l lists all matched filename
-- -e means regex
-- Then you can use 'bufdo <command>' to replace words in all buffers
-- Ex: bufdo %s/Alex/Grace/gc
-- It's like replacing word in file, but on all buffers
-- Remamber to 'bufdo w' to save changes on all files
-- ]]

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
vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>")

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
