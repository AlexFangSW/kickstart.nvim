return {
	'numToStr/Comment.nvim',
	config = function()
		require("Comment").setup({
			toggler = {
				line = '<C-\\>',
				block = "*******"
			},
			opleader = {
				line = '<C-\\>',
				block = "*******"
			}
		})
	end
}
