-- Get path of current buffer and copy it to clipbord
-- https://www.reddit.com/r/neovim/comments/u221as/how_can_i_copy_the_current_buffers_relative_path/
vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
vim.keymap.set("n", "<leader><leader>", ":CopyRelPath<CR>")

-- reset indentation
vim.api.nvim_create_user_command("ResetIndent", ":setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab", {})

-- DiffviewOpen workaround for single commit
-- https://github.com/sindrets/diffview.nvim/issues/514
-- :DiffviewOpen <hash>~1..<hash>
local function viewSingleCommit(params)
    local commit_hash = params.args
    local command = ":DiffviewOpen " .. commit_hash .. "~1.." .. commit_hash
    vim.cmd(command)
end

vim.api.nvim_create_user_command("ViewCommit", viewSingleCommit, { nargs = 1 })
