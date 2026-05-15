return {
    url = "https://codeberg.org/andyg/leap.nvim",
    dependencies = {
        "tpope/vim-repeat",
    },
    config = function()
        vim.keymap.set("n", "<leader>s", "<Plug>(leap)", { desc = "Leap motion" })
    end,
}
