return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require('gitsigns')

        gitsigns.setup({
            preview_config = {
                style = 'minimal',
            }
        })

        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)

        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)

        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)

        vim.keymap.set('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        vim.keymap.set('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

    end,
}
