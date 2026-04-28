return {
  {
    "mfussenegger/nvim-lint",
    opts = function()
      -- markdownlint-cli2 reads buffers via stdin from nvim-lint, and in that
      -- mode it does not walk parent directories looking for config. Resolve
      -- the closest config from the buffer's directory upward and pass it
      -- explicitly, falling back to the global ~/.markdownlint-cli2.jsonc.
      local cli2 = require("lint").linters["markdownlint-cli2"]
      if not cli2 then
        return
      end
      local names = {
        ".markdownlint-cli2.jsonc",
        ".markdownlint-cli2.yaml",
        ".markdownlint-cli2.cjs",
        ".markdownlint-cli2.mjs",
        ".markdownlint.jsonc",
        ".markdownlint.json",
        ".markdownlint.yaml",
        ".markdownlint.yml",
      }
      cli2.args = function()
        local start = vim.fn.expand("%:p:h")
        if start == "" then
          start = vim.loop.cwd()
        end
        local found = vim.fs.find(names, { upward = true, path = start, type = "file" })[1]
          or vim.fn.expand("~/.markdownlint-cli2.jsonc")
        return { "--config", found, "-" }
      end
    end,
  },
}
