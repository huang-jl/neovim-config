-- goimports and gofumpt is extremely slow and gopls itself already supports formatting.
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local disable_packages = { "goimports", "gofumpt" }
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return not vim.tbl_contains(disable_packages, pkg)
      end, opts.ensure_installed or {})
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      -- ensure the tables exist
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = opts.formatters_by_ft.go or {}
      local remove_sources = { "goimports", "gofumpt" }
      opts.formatters_by_ft.go = vim.tbl_filter(function(formatter)
        return not vim.tbl_contains(remove_sources, formatter)
      end, opts.formatters_by_ft.go or {})
    end,
  },
}
