local options = {
    formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        python = { "black" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
    },
    formatters = {
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "150",
            },
        },
        shfmt = {
            prepend_args = {
                "-i",
                "2",
                "-bn",
                "-ci",
            },
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_fallback = false,
    },
}

return options
