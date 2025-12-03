local map = vim.keymap.set

vim.diagnostic.config({
	underline = false,
	virtual_text = {
		prefix = " ",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = "󰒡 ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)

map("n", "<C-g>", vim.diagnostic.open_float)
