return {
	-- Autoformat
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		-- [[ Configure Conform (autoformat)]]
		local conform = require("conform")

		vim.api.nvim_create_user_command("FormatDisable", function()
			vim.g.disable_autoformat = true
			print("Disable autoformat-on-save")
		end, {
			desc = "Disable autoformat-on-save"
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.g.disable_autoformat = false
			print("Re-enable autoformat-on-save")
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		conform.setup({
			format_on_save = function()
				-- Disable with a global variable
				if vim.g.disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			formatters_by_ft = {
				-- lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "yapf" }, -- need to pip install yapf
				-- Use a sub-list to run only the first available formatter
				-- javascript = { { "prettierd", "prettier" } },
				-- javascript = { "prettier" },
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
