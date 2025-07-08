return {
	{
		"codecompanion.nvim",
		cmd = { "CodeCompanionChat" },
		keys = {
			{ "<leader>ai", "<CMD>CodeCompanionChat<CR>" },
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
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "http://192.168.1.200:11434",
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
									default = "devstral:24b",
									choices = {
										"codellama",
										"llama3",
										"llama3.1",
										"deepseek-coder",
										"qwen2.5-coder",
										"mistral",
										"phi3",
										"devstral:24b",
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
			})
		end,
	},
}
