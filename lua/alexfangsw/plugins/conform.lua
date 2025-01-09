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

		-- set python formatter (default: yapf)
		local py_formatters = { "yapf", "black" }
		local py_formatters_set = {}
		for _, v in ipairs(py_formatters) do
			py_formatters_set[v] = true
		end

		vim.api.nvim_create_user_command("PyFmt", function(inpt)
			if py_formatters_set[inpt.args] then
				conform.formatters_by_ft.python = { inpt.args }
				print("Set python formatter as: " .. inpt.args)
			else
				print("Unknown formatter, recived: " .. inpt.args)
			end
		end, {
			desc = "Set python formatter",
			nargs = 1,
			complete = function(_, _, _)
				return py_formatters
			end
		})

		conform.setup({
			format_on_save = function()
				-- Disable with a global variable
				if vim.g.disable_autoformat then
					return
				end
				return { timeout_ms = 2500, lsp_fallback = true }
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
