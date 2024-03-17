return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- [[ Configure harpoon ]]
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = false,
				key = function()
					return vim.loop.cwd()
				end,
			},
		})
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-j>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-k>", function() harpoon:list():next() end)
	end
}
