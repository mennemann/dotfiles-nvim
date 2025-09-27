return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "ruff", "pyright", "clangd", "ltex" },
		})

		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					lineLength = 320,
					lint = {
						select = { "ALL" },
                        ignore = { "D", "CPY", "F401", "E501", "S101", "PLR2004", "ANN", "C901", "T20", "FA", "PLR0911", "PLR0912", "E303", "E225", "E226", "E227", "E228", "E231", "FBT", "ERA", "S311", "ARG" },
					},
					format = {
						preview = true,
					},
				},
			},
		})

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
	end,
}
