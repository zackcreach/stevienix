local yank_group = vim.api.nvim_create_augroup("yank_group", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = yank_group,
	callback = function()
		vim.highlight.on_yank({ timeout = 400 })
	end,
})
