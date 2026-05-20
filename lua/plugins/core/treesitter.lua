return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match)
                local available_langs = ts.get_available()
                if vim.tbl_contains(available_langs, lang) then
                    ts.install(lang):await(function()
                        vim.schedule(function()
                            pcall(vim.treesitter.start, ev.buf, lang)
                        end)
                    end)
                end
            end,
        })
    end,
}
