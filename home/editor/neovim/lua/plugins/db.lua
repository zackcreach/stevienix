return {
	{
		"vim-dadbod",
		before = function()
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_execute_on_save = false
			vim.g.db_ui_save_location = "./creachignore"
			vim.g.db_ui_disable_mappings = true
		end,
	},
}
