return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        if vim.fn.has("win32") == 1 then
            vim.g.vimtex_view_method = "general"
        elseif vim.fn.has("unix") == 1 then
            vim.g.vimtex_view_method = "zathura_simple"
        end

        vim.g.vimtex_mappings_prefix = "<leader>l"

        vim.g.vimtex_syntax_enabled = 0
    end,
}
