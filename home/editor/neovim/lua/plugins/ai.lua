return {
	{
		"codecompanion.nvim",
		event = "User DeferredUIEnter",
		after = function()
			require("codecompanion").setup({
				log_level = "DEBUG",
				show_defaults = false,
				strategies = {
					chat = {
						adapter = "zionlab",
					},
					inline = {
						adapter = "zionlab",
					},
					cmd = {
						adapter = "zionlab",
					},
				},
				adapters = {
					http = {
						zionlab = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://zaia.zionlab.online",
								},
								headers = {
									["Content-Type"] = "application/json",
									["CF-Access-Client-Secret"] = "1173efff73f6ac66ea47915b60604b5818ec6a4057d2ab8819d801d3a279bbbe",
									["CF-Access-Client-Id"] = "5cc18046a45d6d91b838654e25ac6993.access",
								},
								parameters = {
									sync = true,
								},
								opts = {
									allow_insecure = true,
								},
								schema = {
									model = {
										default = "qwen3-coder:30b-a3b",
										choices = {
											"qwen3-coder:30b-a3b",
											"gpt-oss:120b",
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
