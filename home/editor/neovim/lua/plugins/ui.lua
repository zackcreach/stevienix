return {
	-- Color theme
	{
		"gbprod-nord",
		after = function()
			vim.cmd("colorscheme nord")

			-- Dump all highlight groups and links based on theme:
			-- so $VIMRUNTIME/syntax/hitest.vim
			-- vim.cmd("hi! link NormalFloat Visual")
			vim.cmd("hi! link NvimTreeWindowPicker LeapLabelSecondary")
			vim.cmd("hi! WinSeparator guifg=#67738C")
			vim.cmd("hi! @error guibg=NONE gui=italic")

			require("nord").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
				borders = true, -- Enable the border between verticaly split windows visible
				errors = { mode = "bg" }, -- Display mode for errors and diagnostics
				-- values : [bg|fg|none]
				search = { theme = "vim" }, -- theme for highlighting search results
				-- values : [vim|vscode]
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = {},
					functions = {},
					variables = {},

					-- To customize lualine/bufferline
					bufferline = {
						current = {},
						modified = { italic = true },
					},
				},

				-- Override the default colors
				---@param colors Nord.Palette
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with all highlights and the colorScheme table
				---@param colors Nord.Palette
				on_highlights = function(highlights, colors) end,
			})
		end,
	},
	-- Status line
	{
		"lualine.nvim",
		after = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "nord",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{
		"nvim-colorizer.lua",
		after = function()
			require("colorizer").setup({
				user_default_options = {
					filetypes = { "*" },
					mode = "virtualtext",
					virtualtext = "■",
					names = false,
					tailwind = true,
				},
			})
		end,
	},
	{
		"nvim-tree-lua",
		after = function()
			require("nvim-tree").setup({
				view = {
					side = "right",
					width = 35,
				},
				git = {
					ignore = false,
				},
				renderer = {
					indent_width = 1,
				},
			})
		end,
		keys = {
			{ "<leader>e", ":NvimTreeFindFile<cr>" },
		},
	},
	-- Smooth scroll
	{ "vim-smoothie" },
	-- Tmux
	{
		"vim-tmux-navigator",
		before = function()
			vim.g.tmux_navigator_disable_when_zoomed = true
		end,
	},
	{
		"aerial.nvim",
		cmd = "AerialToggle",
		keys = {
			{ "<leader>E", "<CMD>AerialToggle<CR>" },
		},
		after = function()
			require("aerial").setup({
				show_guides = true,
				open_automatic = false,
				layout = {
					width = 35,
				},
				keymaps = {
					["<2-LeftMouse>"] = "actions.jump",
					["<C-j>"] = "actions.down_and_scroll",
					["<C-k>"] = "actions.up_and_scroll",
					["<C-s>"] = "actions.jump_split",
					["<C-v>"] = "actions.jump_vsplit",
					["<CR>"] = "actions.jump",
					["?"] = "actions.show_help",
					["H"] = "actions.tree_close_recursive",
					["L"] = "actions.tree_open_recursive",
					["M"] = "actions.tree_close_all",
					["O"] = "actions.tree_toggle_recursive",
					["R"] = "actions.tree_open_all",
					["[["] = "actions.prev_up",
					["]]"] = "actions.next_up",
					["g?"] = "actions.show_help",
					["h"] = "actions.tree_close",
					["l"] = "actions.tree_open",
					["o"] = "actions.tree_toggle",
					["p"] = "actions.scroll",
					["q"] = "actions.close",
					["{"] = "actions.prev",
					["}"] = "actions.next",
					[false] = "actions.tree_close",
					[false] = "actions.tree_close_recursive",
					[false] = "actions.tree_decrease_fold_level",
					[false] = "actions.tree_increase_fold_level",
					[false] = "actions.tree_open",
					[false] = "actions.tree_open_recursive",
					[false] = "actions.tree_sync_folds",
					[false] = "actions.tree_sync_folds",
					[false] = "actions.tree_toggle",
					[false] = "actions.tree_toggle_recursive",
				},
				icons = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰅴",
					Event = "",
					Operator = "󰆕",
				},
			})
		end,
	},
}
