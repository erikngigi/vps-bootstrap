local lint = require("lint")

lint.linters_by_ft = {
    html = { "htmlhint" },
    javascript = { "eslint_d" },
    lua = { "luacheck" },
    markdown = { "proselint" },
    sh = { "shellcheck" },
    scss = { "stylelint" },
}

lint.linters.luacheck.args = {
    unpack(lint.linters.luacheck.args),
    "--globals",
    "love",
    "vim",
}

lint.linters.shellcheck.args = {
    unpack(lint.linters.shellcheck.args),
    "--severity=style",
    "--enable=all",
}
