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
			transparent_background = true,
			variant = 'hard', -- 'hard'|'medium'|'soft'
		},
	},
}
