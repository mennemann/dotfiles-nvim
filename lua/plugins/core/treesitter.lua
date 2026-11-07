return {
    {
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
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                    },
                },
                move = {
                    set_jumps = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end, { desc = "Select outer function" })
            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end, { desc = "Select inner function" })
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end, { desc = "Select outer class" })
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end, { desc = "Select inner class" })
            vim.keymap.set({ "x", "o" }, "aa", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end, { desc = "Select outer parameter" })
            vim.keymap.set({ "x", "o" }, "ia", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end, { desc = "Select inner parameter" })

            local move = require("nvim-treesitter-textobjects.move")
            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                move.goto_next_start("@function.outer", "textobjects")
            end, { desc = "Next function start" })
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                move.goto_next_end("@function.outer", "textobjects")
            end, { desc = "Next function end" })
            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Previous function start" })
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end, { desc = "Previous function end" })

            local swap = require("nvim-treesitter-textobjects.swap")
            vim.keymap.set("n", "<leader>a", function()
                swap.swap_next("@parameter.inner")
            end, { desc = "Swap with next parameter" })
            vim.keymap.set("n", "<leader>A", function()
                swap.swap_previous("@parameter.inner")
            end, { desc = "Swap with previous parameter" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
            mode = "cursor",
            trim_scope = "outer",
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { desc = "Jump to context", silent = true })
        end,
    },
}
