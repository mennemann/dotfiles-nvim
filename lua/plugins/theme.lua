local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				all = {
					base = "#282a36",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

return catppuccin
