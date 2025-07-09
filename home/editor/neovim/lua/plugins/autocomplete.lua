local source_icons = {
	codecompanion = "󱚧",
	codeium = "󰚩",
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
		event = "User DeferredUIEnter",
		after = function()
			require("codeium").setup({})
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
					default = { "lsp", "path", "snippets", "buffer", "dadbod", "codeium" },
					per_filetype = {
						codecompanion = { "codecompanion" },
					},
					providers = {
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
						codeium = { name = "Codeium", module = "codeium.blink", async = true },
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
