local function test_stuff()
    local parser = vim.treesitter.get_parser()
    local lang = parser:lang()
    print("filetype: " .. lang)

    if lang ~= "python" then
        print("THIS IS ONLY USED FOR PYTHON")
        return
    end

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

    local tree = parser:parse()[1]
    print("got tree")
    for id, node, metadata in query:iter_captures(tree:root()) do
        print("----")
        local name = query.captures[id] -- name of the capture in the query
        print(name)
        -- typically useful info about the node:
        local type = node:type()                                    -- type of the captured node
        print(type)
        local start_row, start_col, end_row, end_col = node:range() -- range of the capture
        print(start_row, start_col, end_row, end_col)
        local text = vim.treesitter.get_node_text(node, 0)
        local replacement = { text .. "EEEEEiiiii" }
        print(replacement)
        -- vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, replacement)
        local buff_file_path = vim.uri_from_bufnr(0)
        print(vim.fn.getcwd())
    end
end

vim.api.nvim_create_user_command("Mycmd", test_stuff, {})
