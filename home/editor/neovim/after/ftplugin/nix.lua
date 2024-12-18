if vim.fn.executable("nil") then
	vim.lsp.start({
		name = "nil",
		cmd = { "nil" },
		filetypes = { "nix" },
		root_dir = vim.fs.dirname(vim.fs.find({ "flake.nix", ".git" }, { upward = true })[1]),
		settings = {
			["nil"] = {
				nix = { flake = { autoArchive = true } },
			},
		},
	})
end
