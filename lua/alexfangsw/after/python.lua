-- [[ Python settings ]]
-- autoformat is done by Conform

-- indentation
local pythonIndentGroup = vim.api.nvim_create_augroup('PythonIndentGroup', { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    callback = function()
        vim.cmd([[:setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab]])
    end,
    group = pythonIndentGroup,
    pattern = '*.py'
})

-- Run lsp restart when creating a new buffer for python files.
-- Or else, pyright will raise error when importing the new file.
-- This will only trigger once per-file, :q or switching between files
-- will not trigger it again :)
local pythonLSPGroup = vim.api.nvim_create_augroup('PythonLSPGroup', { clear = true })
vim.api.nvim_create_autocmd({ "BufNew" }, {
    callback = function()
        vim.cmd([[:LspRestart]])
    end,
    group = pythonLSPGroup,
    pattern = '*.py'
})

-- RELATIVE IMPORT
-- modify absolute import from pyright to relative import
local function relative_import()
    -- load parser an check langurage
    local parser = vim.treesitter.get_parser()
    local lang = parser:lang()

    if lang ~= "python" then
        print("THIS IS ONLY USED FOR PYTHON")
        print("current filetype: " .. lang)
        return
    end

    -- prepare treesitter query to get all import module paths
    local query = vim.treesitter.query.parse(lang,
        [[
        (import_from_statement
          module_name: (dotted_name) @import_path)

        (import_statement
          name: (dotted_name) @import_path)

        (import_statement
          name: (aliased_import
                  name: (dotted_name) @import_path ))
        ]]
    )

    -- cwd and current buffer file path
    local cwd = vim.fn.getcwd()
    local file_path = vim.uri_from_bufnr(0)

    -- parse the query to get those imports
    local tree = parser:parse()[1]
    for _, node, _ in query:iter_captures(tree:root(), 0, 0, -1) do
        local start_row, start_col, end_row, end_col = node:range() -- range of the capture
        local text = vim.treesitter.get_node_text(node, 0)

        -- organize input
        local input = {
            cwd, file_path, text, ""
        }

        channel_id = vim.fn.jobstart({ "python3", "~/.config/nvim/bin/pyrelative.py" }, {
            stdin = "pipe",
            on_stdout = function(_, data)
                if data then
                    print(vim.inspect(data))
                    -- appliy changes to the current buffer
                    -- vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
                end
            end,
            on_stderr = function(_, data)
                if data then
                    print("Error: " .. vim.inspect(data))
                end
            end,
            stdout_buffered = true,
            stderr_buffered = true
        })
        if channel_id ~= 0 or channel_id ~= -1 then
            -- pipe to our python script to get there relative import
            print(vim.inspect(input))
            vim.fn.chansend(channel_id, input)
        end
    end
end

vim.api.nvim_create_user_command("PyRelative", relative_import, {})
