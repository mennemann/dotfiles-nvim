return {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")
        peek.setup({ app = { "firefox", "--new-window" } })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(args)
                vim.keymap.set("n", "<leader>ll", function()
                    if peek.is_open() then
                        peek.close()
                    else
                        peek.open()
                    end
                end, { buffer = args.buf, desc = "Toggle markdown preview" })
            end,
        })
    end,
}
