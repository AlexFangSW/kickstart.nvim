-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- local function double_hover()
    --     vim.lsp.buf.hover()
    --     vim.lsp.buf.hover()
    -- end

    nmap('gh', vim.lsp.buf.hover, '[G]et [H]elp Hover Documentation')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
    gopls = {},
    pyright = {},
    jsonls = {},
    dockerls = {},
    bashls = {},
    tsserver = {
        javascript = {
            format = {
                semicolons = "remove"
            }
        }
    },
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    helm_ls = {
        yamlls = {
            path = "yaml-language-server",
        }
    },
    yamlls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    },
    -- eslint = {}
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

-- LSP Setups
local function default_setup(server_name)
    require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
    }
end

-- Yamlls dosen't work well with helm files...
-- disable diagnostic for buffer with filetypes == helm
local function helm_setup(server_name)
    require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            vim.diagnostic.enable(false, { bufnr = bufnr })
        end,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
    }
end

-- This is a workaround on the tsserver deprication warnning....
-- Somehow lspconfig wants to change the server name ... from "tsserver" to "ts_ls" ... WTF
-- https://github.com/neovim/nvim-lspconfig/pull/3232#issuecomment-2331025714
local function ts_setup(server_name)
    require('lspconfig')["ts_ls"].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
    }
end

local function set_table_default(table)
    local mt = {
        __index = function()
            return default_setup
        end
    }
    setmetatable(table, mt)
end

local lsp_setup_table = {
    ["helm_ls"] = helm_setup,
    ["tsserver"] = ts_setup,
}

set_table_default(lsp_setup_table)

mason_lspconfig.setup_handlers {
    function(server_name)
        lsp_setup_table[server_name](server_name)
    end,
}
