return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      opts.server.default_settings["rust-analyzer"].procMacro.ignored["async-trait"] = nil
      -- this is too fucking slow
      opts.server.default_settings["rust-analyzer"].checkOnSave = false
      opts.server.default_settings["rust-analyzer"].diagnostics.enable = true
      -- to set features of project, create .vscode/settings.json and use:
      -- {
      --   "rust-analyzer.cargo": {
      --     "features": [],
      --   }
      -- }
      --
      opts.server.default_settings["rust-analyzer"].cargo.allFeatures = nil
      opts.server.on_attach = function(_, bufnr)
        -- vim.keymap.set("n", "<leader>cR", function()
        --   vim.cmd.RustLsp("codeAction")
        -- end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("flyCheck")
        end, { desc = "Rust Check", buffer = bufnr })
      end
    end,
  },
}
