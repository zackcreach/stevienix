return {
	{
		"gitsigns.nvim",
		after = function()
			local gitsigns = require("gitsigns")

			local function next_hunk()
				-- Move to next hunk
				gitsigns.nav_hunk("next")
				-- center cursor
				-- vim.cmd("normal zz")
				--
			end

			local function prev_hunk()
				-- Move to prev hunk
				gitsigns.nav_hunk("prev")
				-- center cursor
				-- vim.cmd("normal zz")
			end

			gitsigns.setup({
				signs = {
					add = { highlight = "GitSignsAdd", text = "┃" },
					change = { highlight = "GitSignsChange", text = "┃" },
					delete = { highlight = "GitSignsDelete", text = "┃" },
					topdelete = { highlight = "GitSignsDelete", text = "┃" },
					changedelete = { highlight = "GitSignsDelete", text = "┃" },
				},
				on_attach = function()
					local map = vim.keymap.set
					local opts = { silent = true }

					map("n", "]g", next_hunk, opts)
					map("n", "[g", prev_hunk, opts)
					map("n", "<leader>g+", gitsigns.stage_hunk, opts)
					map("n", "<leader>g=", gitsigns.reset_hunk, opts)
					map("n", "<leader>gp", gitsigns.preview_hunk, opts)
					map("n", "<leader>gs", "<CMD>Gvdiffsplit<CR>", opts)
				end,
			})
		end,
	},
	{
		"vim-fugitive",
		after = function()
			local function checkout_main()
				-- Check if we're in a git repository
				if vim.fn.system("git rev-parse --is-inside-work-tree"):match("true") == nil then
					vim.notify("Not in a git repository", vim.log.levels.ERROR)
					return
				end

				local file = vim.fn.expand("%")
				if file == "" then
					vim.notify("No file in current buffer", vim.log.levels.ERROR)
					return
				end

				local escaped_file = vim.fn.shellescape(file)
				local result = vim.fn.system("git checkout main -- " .. escaped_file)
				if vim.v.shell_error ~= 0 then
					vim.notify("Git checkout failed for '" .. file .. "': " .. result, vim.log.levels.ERROR)
				else
					vim.cmd("checktime")
					vim.notify("Restored '" .. file .. "' from main branch", vim.log.levels.INFO)
				end
			end

			local map = vim.keymap.set
			local opts = { silent = true }

			map("n", "<leader>co", checkout_main, opts)
			map("n", "<leader>cr", "<CMD>let @+ = expand('%')<CR>", opts)
			map("n", "<leader>cp", "<CMD>let @+ = expand('%:p')<CR>", opts)
		end,
	},
	{
		"git-messenger-vim",
		cmd = { "GitMessenger" },
	},
}
