-- Fuzzy Finder (files, lsp, etc)
return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require('telescope').setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
				sorting_strategy = "ascending", -- display results top->bottom
				layout_strategy = 'vertical',
				layout_config = {
					prompt_position = "top", -- search bar at the top
					mirror = true,
					preview_cutoff = 1,
					height = 0.99,
					width = 0.99
				},
				file_ignore_patterns = {
					".git/",
					".venv/",
					"venv/",
					"env/",
					"__pycache__",
					".ruff_cache/",
					".next/",
					"node_modules/",
				}
			},
			pickers = {
				find_files = { hidden = true, previewer = false },

				current_buffer_tags = { fname_width = 0.99, },

				jumplist = { fname_width = 0.99, },

				loclist = { fname_width = 0.99, },

				lsp_definitions = { fname_width = 0.99, },

				lsp_document_symbols = { fname_width = 0.99, },

				lsp_dynamic_workspace_symbols = { fname_width = 0.99, },

				lsp_implementations = { fname_width = 0.99, },

				lsp_incoming_calls = { fname_width = 0.99, },

				lsp_outgoing_calls = { fname_width = 0.99, },

				lsp_references = { fname_width = 0.99, },

				lsp_type_definitions = { fname_width = 0.99, },

				lsp_workspace_symbols = { fname_width = 0.99, },

				quickfix = { fname_width = 0.99, },

				tags = { fname_width = 0.99, },

			}
		}

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')

		local function find_files_all()
			require('telescope.builtin').find_files {
				no_ignore = true,
				hidden = true,
			}
		end

		vim.keymap.set('n', '<C-p>', find_files_all, { desc = 'Search Files' })
		vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<C-f>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
			{ desc = '[S]earch [D]iagnostics' })
	end
}
