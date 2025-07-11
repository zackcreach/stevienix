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
}
