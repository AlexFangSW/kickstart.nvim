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

		-- set python formatter (default: ruff_format)
		local py_formatters = {
			["yapf"] = { "yapf" },
			["black"] = { "black" },
			["ruff"] = { "ruff_fix", "ruff_organize_imports", "ruff_format" }
		}
		local py_formatters_set = {}
		for k, _ in pairs(py_formatters) do
			table.insert(py_formatters_set, k)
		end

		vim.api.nvim_create_user_command("PyFmt", function(inpt)
			local formatter_setting = py_formatters[inpt.args]
			if formatter_setting ~= nil then
				conform.formatters_by_ft.python = formatter_setting
				print("Set python formatter as: " .. inpt.args)
			else
				print("Unknown formatter, recived: " .. inpt.args)
			end
		end, {
			desc = "Set python formatter",
			nargs = 1,
			complete = function(_, _, _)
				return py_formatters_set
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
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				-- Use a sub-list to run only the first available formatter

				-- :MasonInstall prettierd
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				go = {
					"gofmt", "goimports"
				},
				css = {
					"css_beautify "
				}

			},
		})

		-- customize yapf
		conform.formatters.yapf = {
			prepend_args = { "--style", "{based_on_style: google, indent_width: 4}" }
		}
	end
}
