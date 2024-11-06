return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	'lewis6991/gitsigns.nvim',
	event = "VeryLazy",
	config = function()
		-- [[ Configure gitsigns ]]
		require('gitsigns').setup {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			current_line_blame_opts = {
				delay = 500,
			},
			current_line_blame_formatter = ' [<abbrev_sha>] <author>, <author_time:%R> - <summary> (<leader>c to copy hash)',
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				map('n', '<leader>gb', gs.toggle_current_line_blame)
			end
		}
	end
}
