return {
	{
		"codecompanion.nvim",
		keys = {
			{ "<leader>q", "<CMD>CodeCompanionChat<CR>" },
		},
		after = function()
			require("codecompanion").setup({
				log_level = "DEBUG", -- or "TRACE"
			})
		end,
	},
}
