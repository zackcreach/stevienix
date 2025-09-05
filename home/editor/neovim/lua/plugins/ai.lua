return {
	{
		"codecompanion.nvim",
		event = "User DeferredUIEnter",
		keys = {
			{ "<leader>ai", "<CMD>CodeCompanionActions<CR>" },
			{ "<leader>ac", "<CMD>CodeCompanionChat<CR>" },
		},
		after = function()
			require("codecompanion").setup({
				log_level = "DEBUG",
				show_defaults = false,
				strategies = {
					chat = {
						adapter = "ollama",
					},
					inline = {
						adapter = "ollama",
					},
					cmd = {
						adapter = "ollama",
					},
				},
				adapters = {
					http = {
						ollama = function()
							return require("codecompanion.adapters").extend("ollama", {
								env = {
									url = "http://symphony:11434",
								},
								headers = {
									["Content-Type"] = "application/json",
								},
								parameters = {
									sync = true,
								},
								opts = {
									allow_insecure = true,
								},
								schema = {
									model = {
										default = "Qwen3-Coder-30B-A3B",
										choices = {
											"Qwen3-Coder-30B-A3B",
											"gemma3:27b",
										},
									},
									num_ctx = {
										default = 16384,
									},
									num_predict = {
										default = -1,
									},
								},
							})
						end,
					},
				},
			})

			vim.api.nvim_create_user_command("CC", function()
				vim.cmd("CodeCompanion")
			end, {})
		end,
	},
	{
		"render-markdown.nvim",
		after = function()
			require("render-markdown").setup({
				file_types = { "markdown", "codecompanion" },
				signs = { enabled = false },
				heading = {
					icons = { "󰎦  ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", " 󰎵 " },
					sign = false,
					position = "inline",
				},
				link = {
					custom = { youtube = { pattern = ".+youtu%.be.+", icon = " " } },
				},
				code = {
					sign = false,
					position = "right",
					width = "block",
					min_width = 80,
					border = "thick",
				},
				bullet = {
					icons = { "•", "∘" },
				},
				checkbox = {
					bullet = true,
					unchecked = {
						icon = "󰄱 ",
					},
					checked = {
						icon = "󰄲 ",
					},
					custom = {
						migrated = { raw = "[>]", rendered = " ", highlight = "@string.special" },
						logged = { raw = "[<]", rendered = " ", highlight = "@string.special" },
						delegated = { raw = "[/]", rendered = " ", highlight = "@text.todo.unchecked" },
						inspirational = { raw = "[!]", rendered = " ", highlight = "@string" },
						priority = { raw = "[*]", rendered = " ", highlight = "@function" },
					},
				},
			})
		end,
		ft = { "markdown", "codecompanion" },
	},
}
