return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                disabled_filetypes = { "neo-tree" },
            },
            sections = {
                lualine_c = { "filename", "filesize" },
            },
        })
    end,
}
