return {
	{
		"telescope-nvim",
		cmd = { "Telescope find_files" },
		keys = {
			{ "<leader><leader>", ":Telescope find_files<CR>" },
			{ "<leader><backspace>", ":Telescope buffers<CR>" },
			{ "<leader>/", ":Telescope live_grep<CR>" },
			{ "<leader>f.", ":Telescope resume<CR>" },
			{ "<leader>fg", ":Telescope git_status<CR>" },
			{ "<leader>fs", ":Telescope search_history<CR>" },
			{ "<leader>fc", ":Telescope git_bcommits<CR>" },
			{ "<leader>fb", ":Telescope git_branches<CR>" },
			{ "<leader>fr", ":Telescope registers<CR>" },
			{ "<leader>fo", ":Telescope lsp_document_symbols<CR>" },
			{ "<leader>fi", ":Telescope symbols<CR>" },
			{ "<leader>fd", ":Telescope diagnostics<CR>" },
		},
		after = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "flex",
					layout_config = {
						flip_columns = 190,
						prompt_position = "top",
						horizontal = {
							width = 0.8,
						},
						vertical = {
							width = 0.9,
							height = 0.9,
							preview_height = 0.6,
							mirror = true,
						},
					},
					prompt_prefix = "󰱨 ",
					selection_caret = "󰳟 ",
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
			})
		end,
	},
}
