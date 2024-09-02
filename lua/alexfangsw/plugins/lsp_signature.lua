-- return {
-- 	"ray-x/lsp_signature.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		-- [[ Configure lsp signature]]
-- 		local lsp_signature = require("lsp_signature")
-- 		lsp_signature.setup({
-- 			hint_enable = false
-- 		})
-- 	end
--
-- }
return {
	"hrsh7th/cmp-nvim-lsp-signature-help",
	event = "VeryLazy",
	config = function()
		local lsp_signature = require("cmp")
		lsp_signature.setup({
			sources = {
				{ name = 'nvim_lsp_signature_help' }
			}
		})
	end
}
