return {
	-- Color theme
	{
		"gbprod/nord.nvim",
		config = function()
			vim.cmd("colorscheme nord")

			-- Dump all highlight groups and links based on theme:
			-- so $VIMRUNTIME/syntax/hitest.vim
			vim.cmd("hi! link NormalFloat Visual")
			vim.cmd("hi! link CopilotSuggestion NotifyTRACEBorder")
			vim.cmd("hi! link NvimTreeWindowPicker LeapLabelSecondary")
			vim.cmd("hi! WinSeparator guifg=#67738C")
			vim.cmd("hi! @error guibg=NONE gui=italic")
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		opts = {
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
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				filetypes = { "*" },
				mode = "virtualtext",
				virtualtext = "■",
				names = false,
				tailwind = true,
			},
		},
	},
	{
		"rolv-apneseth/tfm.nvim",
		config = function()
			-- Set keymap so you can open the default terminal file manager (yazi)
			vim.api.nvim_set_keymap("n", "<leader>E", "", {
				noremap = true,
				callback = function()
					require("tfm").open(vim.fn.expand("%"))
				end,
			})

			-- vim.api.nvim_set_keymap("n", "<leader>E", "", {
			-- 	noremap = true,
			-- 	callback = function()
			-- 		require("tfm").open()
			-- 	end,
			-- })
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				side = "right",
			},
			git = {
				ignore = false,
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		keys = {
			{ "<leader>e", ":NvimTreeFindFile<cr>" },
		},
		lazy = true,
	},
	-- Smooth scroll
	"psliwka/vim-smoothie",
	-- Tmux
	{
		"christoomey/vim-tmux-navigator",
		init = function()
			vim.g.tmux_navigator_disable_when_zoomed = true
		end,
	},
}
