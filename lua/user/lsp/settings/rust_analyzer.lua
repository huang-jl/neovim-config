-- Add a .rust-analyzer.json to your project root (the path you open neovim) like:
-- for more option, please check https://rust-analyzer.github.io/book/configuration.html
-- {
--   "cargo": {
--     "features": [ "stm32f479" ]
--   },
--   "cfg": {
--     "setTest": false
--   }
-- }

function get_project_rustanalyzer_settings()
  local handle = io.open(vim.fn.resolve(vim.fn.getcwd() .. '/./.rust-analyzer.json'))
  if not handle then
    return {}
  end
  local out = handle:read("*a")
  handle:close()
  local config = vim.json.decode(out)
  if type(config) == "table" then
    return config
  end
  return {}
end

local opts = {
  settings = {
    ['rust-analyzer'] = vim.tbl_deep_extend(
      "force",
      {
        -- Defaults (can be overridden by .rust-analyzer.json
        cargo = {
          features = "all",
        },
      },
      get_project_rustanalyzer_settings(),
      {
        -- Overrides (forces these regardless of what's in .rust-analyzer.json
        procMacro = { enable = true },
      }
      )
  }
}

return opts
