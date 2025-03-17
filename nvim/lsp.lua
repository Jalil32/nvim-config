local lsp = require("lsp-zero").preset("recommended")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
}

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set

	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "<leader>v", vim.lsp.buf.hover, opts)
	keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	keymap("n", "<leader>h", vim.diagnostic.open_float, opts)
	keymap("n", "[d", vim.diagnostic.goto_next, opts)
	keymap("n", "]d", vim.diagnostic.goto_prev, opts)
	keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>vrr", vim.lsp.buf.references, opts)
	keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

cmp.setup({
	mapping = cmp_mappings,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

vim.diagnostic.config({
	virtual_text = true,
})

require("lspconfig").nixd.setup({})
require("lspconfig").biome.setup({})
require("lspconfig").gopls.setup({})

-- Set up auto-format on save
vim.cmd([[
  augroup lsp
    autocmd!
    autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false, filter = function(client) return client.name == "null-ls" end })
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json lua vim.lsp.buf.format({ async = false, filter = function(client) return client.name == "biome" end })
  augroup END
]])
