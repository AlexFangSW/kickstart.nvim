-- Get path of current buffer and copy it to clipbord
-- https://www.reddit.com/r/neovim/comments/u221as/how_can_i_copy_the_current_buffers_relative_path/
vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
vim.keymap.set("n", "<leader><leader>", ":CopyRelPath<CR>")

-- reset indentation
vim.api.nvim_create_user_command("ResetIndent", ":setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab", {})

-- DiffviewOpen workaround for single commit
-- https://github.com/sindrets/diffview.nvim/issues/514
-- :DiffviewOpen <hash>~1..<hash>
local function view_single_commit(params)
    local commit_hash = params.args
    local command = ":DiffviewOpen " .. commit_hash .. "~1.." .. commit_hash
    vim.cmd(command)
end

vim.api.nvim_create_user_command("ViewCommit", view_single_commit, { nargs = 1 })

-- Copy commit hash for current line
-- git blame -L 1,1 --abbrev=6 -- README.md | awk '{print $1}'
local function get_commit()
    local win_id = vim.api.nvim_get_current_win()
    local file_path = vim.fn.expand('%')
    local line_number = vim.api.nvim_win_get_cursor(win_id)[1]
    local command = {
        "git blame",
        "-L",
        line_number .. "," .. line_number,
        " --abbrev=6",
        file_path,
        "|",
        "awk",
        "'{print $1}'"
    }
    local concate_command = table.concat(command, " ")
    local commit_hash = vim.fn.system(concate_command)
    if string.match(commit_hash, "^^") then
        vim.notify_once("GetCommit: this is a init commit, can't be viewed using ViewCommit !!")
    end
    -- set commit hash to clipbord
    vim.fn.setreg('+', commit_hash)
end

vim.api.nvim_create_user_command("GetCommit", get_commit, {})
vim.keymap.set("n", "<leader>c", ":GetCommit<CR>")

-- Copilot accept suggestion
vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
