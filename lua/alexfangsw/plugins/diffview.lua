return {
	'sindrets/diffview.nvim',
	config = function()
		-- [[ Configure Diffview ]]
		local actions = require("diffview.actions")

		function gf_and_close()
			-- close the diffview tab on gf
			actions.goto_file_edit()
			vim.cmd([[:tabclose #]])
		end

		require("diffview").setup({
			diff_binaries = false, -- Show diffs for binaries
			enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
			git_cmd = { "git" },   -- The git executable followed by default args.
			hg_cmd = { "hg" },     -- The hg executable followed by default args.
			use_icons = true,      -- Requires nvim-web-devicons
			show_help_hints = true, -- Show hints for how to open the help panel
			watch_index = true,    -- Update views and index buffers when the git index changes.
			icons = {              -- Only applies when use_icons is true.
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			keymaps = {
				view = {
					{ "n", "gf", gf_and_close, { desc = "Open the file in the previous tabpage, and close diffview tab." } },
				},
				file_panel = {
					{ "n", "gf", gf_and_close, { desc = "Open the file in the previous tabpage, and close diffview tab." } },
				},
				file_history_panel = {
					{ "n", "gf", gf_and_close, { desc = "Open the file in the previous tabpage, and close diffview tab." } },
				}
			},
			view = {
				-- Configure the layout and behavior of different types of views.
				-- Available layouts:
				--  'diff1_plain'
				--    |'diff2_horizontal'
				--    |'diff2_vertical'
				--    |'diff3_horizontal'
				--    |'diff3_vertical'
				--    |'diff3_mixed'
				--    |'diff4_mixed'
				-- For more info, see ':h diffview-config-view.x.layout'.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_horizontal",
					winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
				},
				merge_tool = {
					-- Config for conflicted files in diff views during a merge or rebase.
					layout = "diff3_horizontal",
					disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
					winbar_info = true,    -- See ':h diffview-config-view.x.winbar_info'
				},
				file_history = {
					-- Config for changed files in file history views.
					layout = "diff2_horizontal",
					winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
				},
			},
			file_panel = {
				listing_style = "tree",       -- One of 'list' or 'tree'
				tree_options = {              -- Only applies when listing_style is 'tree'
					flatten_dirs = true,        -- Flatten dirs that only contain one single dir
					folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
				},
				win_config = {                -- See ':h diffview-config-win_config'
					position = "left",
					width = 25,
					win_opts = {}
				},
			},
			file_history_panel = {
				win_config = { -- See ':h diffview-config-win_config'
					position = "bottom",
					height = 5,
					win_opts = {}
				},
			},
		})
	end
}
