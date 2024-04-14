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
    -- get buffer number to prevent writting to wrong buffer on ':wqa'
    local cwd = vim.fn.getcwd()
    local bufnum = vim.api.nvim_get_current_buf()
    local file_path = vim.uri_from_bufnr(bufnum)

    -- parse the query to get those imports
    local tree = parser:parse()[1]
    for _, node, _ in query:iter_captures(tree:root(), 0, 0, -1) do
        local start_row, start_col, end_row, end_col = node:range() -- range of the capture
        local original_import_path = vim.treesitter.get_node_text(node, 0)

        -- organize input
        -- [install pyrelative.py /usr/local/bin]
        local input = cwd .. "\n" .. file_path .. "\n" .. original_import_path
        local pycmd = "pyrelative.py"
        local command = "echo " .. "'" .. input .. "'" .. " | " .. pycmd

        vim.fn.jobstart({ "bash", "-c", command }, {
            stdin = "pipe",
            on_stdout = function(_, data)
                for _, new_import_path in pairs(data) do
                    if new_import_path ~= "" and new_import_path ~= original_import_path then
                        -- appliy changes to the current buffer
                        if vim.api.nvim_buf_is_valid(bufnum) then
                            vim.api.nvim_buf_set_text(bufnum, start_row, start_col, end_row, end_col, { new_import_path })
                        end
                    end
                end
            end,
            on_stderr = function(_, data)
                for _, v in pairs(data) do
                    if v ~= "" then
                        print("Error: " .. v)
                    end
                end
            end,
            stdout_buffered = true,
            stderr_buffered = true
        })
    end
end

vim.api.nvim_create_user_command("PyRelative", relative_import, {})

local activate_relative_import = true
local function py_relative_toggle()
    activate_relative_import = not activate_relative_import
    if activate_relative_import then
        print("PyRelative is active")
    else
        print("PyRelative is disabled")
    end
end
vim.api.nvim_create_user_command("PyRelativeToggle", py_relative_toggle, {})


-- Change to relative import on save
local py_on_save = vim.api.nvim_create_augroup('PyOnSave', { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        if activate_relative_import then
            vim.cmd([[:PyRelative]])
        end
    end,
    group = py_on_save,
    pattern = '*.py'
})
