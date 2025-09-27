return {
    "ggandor/leap.nvim",
    dependencies = {
        "tpope/vim-repeat",
    },
    config = function()
        vim.keymap.set("n", "<leader>s", "<Plug>(leap)")
    end,
}
