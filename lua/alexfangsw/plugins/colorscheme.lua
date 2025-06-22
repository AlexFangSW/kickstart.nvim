-- =====================================================================
-- Better to move things in config function to 'after.colorscheme' folder
-- =====================================================================

return {
	{
		"sainnhe/gruvbox-material",
	},
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		'comfysage/evergarden',
		opts = {
			theme = {
				variant = 'fall',
				accent = 'green',
			},
			editor = {
				transparent_background = true,
			}
		},
	},
}
