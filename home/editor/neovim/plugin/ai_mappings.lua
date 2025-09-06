local map = vim.keymap.set

local function open_split(program, args)
	local relative_path = vim.fn.expand("%")
	if relative_path == "" then
		vim.notify("No file in current buffer", vim.log.levels.WARN)
		return
	end

	local command = string.format('tmux split-window -h "%s %s@%s"', program, args or "", relative_path)
	vim.fn.system(command)
end

map("v", "<leader>ag", "!aichat -r grammar<CR>")
map("n", "<leader>ac", "<CMD>CodeCompanionChat<CR>")
map("n", "<leader>ai", function()
	open_split("claude")
end)
map("n", "<leader>ao", function()
	open_split("opencode")
end)
