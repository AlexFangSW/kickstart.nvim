local function current_formatter()
	-- must install conform
	local conform = require('conform')
	local formatters = conform.list_formatters_for_buffer()

	-- check if formatter is set in conform
	if formatters and #formatters > 0 then
		local names = {}
		for _, formatter_name in ipairs(formatters) do
			table.insert(names, formatter_name)
		end
		return table.concat(names, ' ')
	end

	-- check if lsp formatter exists
	local bufnr = vim.api.nvim_get_current_buf()
	local lsp_format = require("conform.lsp_format")
	local lsp_formatter_exist = not vim.tbl_isempty(lsp_format.get_format_clients({ bufnr = bufnr }))
	if lsp_formatter_exist then
		return 'LSP Formatter'
	end

	return ''
end

local function correct_color()
	if (vim.g.colors_name == 'vague') then
		return { fg = '#C3C3D5FF' }
	elseif (vim.g.colors_name == "gruvbox-material") then
		return { fg = '#D2BD94FF' }
	else
		return nil
	end
end

return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_a = {
				{

					"mode",
					color = correct_color
				}
			},
			lualine_x = { 'encoding', 'filetype', current_formatter },
			lualine_z = {
				{
					"location",
					color = correct_color,
				}
			},
		},
	},
}
