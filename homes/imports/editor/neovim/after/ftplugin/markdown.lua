local run_code_block = function()
	if vim.api.nvim_get_mode()["mode"] == "n" then
		vim.cmd('normal vib"vy')
	else
		vim.cmd('normal "vy')
	end
	vim.cmd("call VimuxRunCommand(@v)")
end

vim.keymap.set("n", "<C-c><C-c>", run_code_block, { buffer = true })
