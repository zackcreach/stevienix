return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- all possible variables:
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L1
			local ls = require("luasnip")
			local s = ls.snippet
			local i = ls.insert_node
			local rep = extras.rep
			local fmt = require("luasnip.extras.fmt").fmt

			ls.config.set_config({
				history = true,
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			-- Javascript
			local jssnippets = {
				s("log", fmt("console.log('----- {} -----', {})", { i(1, "title"), i(2, "variable") })),
				s("imp", fmt("import {{ {} }} from '{}'", { i(2, "variable(s)"), i(1, "dependency") })),
			}

			local jsxsnippets = {
				s("log", fmt("console.log('----- {} -----', {})", { i(1, "title"), i(2, "variable") })),
				s("imp", fmt("import {{ {} }} from '{}'", { i(2, "variable(s)"), i(1, "dependency") })),
				s("cs", fmt("{{/*", {})),
				s("ce", fmt("*/}}", {})),
			}

			ls.add_snippets("javascript", jssnippets)
			ls.add_snippets("typescript", jssnippets)
			ls.add_snippets("typescriptreact", jsxsnippets)
			ls.add_snippets("javascriptreact", jsxsnippets)

			-- Lua
			ls.add_snippets("lua", {
				s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
			})
		end,
	},
}
