return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope find_files" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-symbols.nvim",
		},
		keys = {
			{ "<leader><leader>", ":Telescope find_files<CR>" },
			{ "<leader><backspace>", ":Telescope buffers<CR>" },
			{ "<leader>/", ":Telescope live_grep<CR>" },
			{ "<leader>f.", ":Telescope resume<CR>" },
			{ "<leader>fg", ":Telescope git_status<CR>" },
			{ "<leader>fs", ":Telescope git_stash<CR>" },
			{ "<leader>fr", ":Telescope registers<CR>" },
			{ "<leader>fo", ":Telescope lsp_document_symbols<CR>" },
			{ "<leader>fi", ":Telescope symbols<CR>" },
		},
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				prompt_prefix = "󰱨 ",
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				live_grep = {
					vimgrep_arguments = {
						"rg",
						"-g",
						"!.git",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
				},
			},
		},
	},
}
