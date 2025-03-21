local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.biome, -- Biome formatter
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
