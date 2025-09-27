return {
    "sindrets/winshift.nvim",
    config = function()
        require("winshift").setup({
            highlight_moving_win = true,
        })
    end,
}
