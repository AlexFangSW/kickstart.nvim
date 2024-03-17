return {
	-- Autoformat
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		-- [[ Configure Conform (autoformat)]]
		local conform = require("conform")
		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				-- lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "yapf" }, -- need to pip install yapf
				-- Use a sub-list to run only the first available formatter
				-- javascript = { { "prettierd", "prettier" } },
				javascript = { "prettier" },
				go = {
					"gofmt", "goimports"
				}
			},
		})

		-- customize yapf
		conform.formatters.yapf = {
			prepend_args = function(_, _)
				return { "--style", "{based_on_style: google, indent_width: 4}" }
			end,
		}
	end
}
