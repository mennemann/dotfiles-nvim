return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"python",
			"c",
			"cpp",
			"bash",
			"fish",
			"rust",
			"hyprlang",
			"javascript",
			"java",
            "latex",
            "asm",
            "bibtex",
            "cmake",
            "csv",
            "css",
            "gitcommit",
            "html",
            "json",
            "toml",
            "yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "*" },
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
