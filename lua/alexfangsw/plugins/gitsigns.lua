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
				-- Git blame
				map('n', '<leader>gb', gs.toggle_current_line_blame)

				-- Hunk related actions
				map('n', '<leader>hs', gs.stage_hunk)
				map('n', '<leader>hr', gs.reset_hunk)
				map('n', '<leader>hi', gs.preview_hunk_inline)

				map('v', '<leader>hs', function()
					gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end)
				map('v', '<leader>hr', function()
					gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end)
			end
		}
	end
}
