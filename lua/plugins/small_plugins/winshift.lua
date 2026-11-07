return {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    config = function()
        require("winshift").setup({
            highlight_moving_win = true,
        })
    end,
}
