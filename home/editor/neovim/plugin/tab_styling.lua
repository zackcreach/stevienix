function _G.get_tabline()
	local s = ""
	for tabnr = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(tabnr)
		local buflist = vim.fn.tabpagebuflist(tabnr)[winnr]
		local bufname = vim.fn.bufname(buflist)
		local bufname_short = vim.fn.fnamemodify(bufname, ":t")
		if tabnr == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#" .. " " .. tabnr .. ": " .. bufname_short .. " "
		else
			s = s .. "%#TabLine#" .. " " .. tabnr .. ": " .. bufname_short .. " "
		end
	end
	s = s .. "%#TabLineFill#"
	return s
end

vim.o.tabline = "%!v:lua.get_tabline()"
