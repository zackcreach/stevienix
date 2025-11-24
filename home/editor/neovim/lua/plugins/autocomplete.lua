local source_icons = {
	codecompanion = "󱚧",
	minuet = "󰚩",
	nvim_lsp = "󰡦",
	lsp = "󰡦",
	buffer = "",
	luasnip = "",
	snippets = "",
	path = "",
	git = "",
	tags = "",
	cmdline = "󰘳",
	fallback = "",
}

return {
	{
		"blink-cmp",
		event = "InsertEnter",
		after = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 2048,
				notify = false,
				request_timeout = 2,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://symphony:11434/v1/completions",
						model = "qwen2.5-coder:7b",
						optional = {
							max_tokens = 128,
							top_p = 0.9,
						},
					},
				},
			})
			require("blink.cmp").setup({
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<Tab>"] = { "select_and_accept" },
					["<C-p>"] = { "select_prev" },
					["<C-n>"] = { "select_next" },
					["<C-b>"] = { "scroll_documentation_up" },
					["<C-f>"] = { "scroll_documentation_down" },
					["<C-k>"] = { "show_signature", "hide_signature" },
					["<C-e>"] = { "hide" },
				},
				fuzzy = {
					prebuilt_binaries = { download = false },
					implementation = "rust",
				},
				completion = {
					ghost_text = {
						enabled = false,
						show_without_selection = true,
					},
					documentation = {
						auto_show = true,
					},
					menu = {
						auto_show = true,
						draw = {
							columns = {
								{ "kind_icon", gap = 2 },
								{ "label", "label_description", gap = 1 },
								{ "source_icon" },
							},
							components = {
								source_icon = {
									ellipsis = false,
									text = function(ctx)
										return source_icons[ctx.source_name:lower()] or source_icons.fallback
									end,
									highlight = "BlinkCmpSource",
								},
							},
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "minuet", "dadbod" },
					per_filetype = {
						codecompanion = { "codecompanion" },
					},
					providers = {
						minuet = {
							name = "minuet",
							module = "minuet.blink",
							async = true,
							timeout_ms = 5000,
							score_offset = 50,
						},
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					},
				},
				snippets = { preset = "luasnip" },
				appearance = {
					use_nvim_cmp_as_default = true,
					kind_icons = {
						Text = "",
						Method = "󰆧",
						Function = "●",
						Constructor = " ",
						Field = "󰇽",
						Variable = "󰂡",
						Class = "󰫅 ",
						Interface = "",
						Module = "󰫈 ",
						Property = "󰜢",
						Unit = "",
						Value = "󰎠",
						Enum = " ",
						Keyword = "󰌋",
						Snippet = "",
						Color = " ",
						File = "󰈙",
						Reference = "",
						Folder = " ",
						EnumMember = " ",
						Constant = "󰏿",
						Struct = "",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰅲",
					},
				},
			})
		end,
	},
}
