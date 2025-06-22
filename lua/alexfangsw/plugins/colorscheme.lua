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
		"vague2k/vague.nvim"
	},
}
