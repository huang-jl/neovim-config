-- an example of .nvimrc in per-project root
-- lua << EOF
--   local nvim_lsp = require('lspconfig')
-- 
--   -- print(vim.inspect(nvim_lsp.rust_analyzer))
--   nvim_lsp.rust_analyzer.manager.config.settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         features = {"backend-mmap", "backend-atomic"},
--         allFeatures = false,
--       }
--     }
--   }
-- EOF

-- available settings: https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc

local opts = {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

return opts
