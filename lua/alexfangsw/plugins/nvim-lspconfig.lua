return {
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ 'williamboman/mason.nvim',           config = true },
		{ 'williamboman/mason-lspconfig.nvim', version = "v1.32.0" },
		'folke/neodev.nvim',
	},
}
