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
--
--
local function setInlayHintHL()
  local has_hl, hl = pcall(vim.api.nvim_get_hl_by_name, "LspInlayHint", true)
  -- if has_hl and (hl["foreground"] or hl["background"]) then
  --   return
  -- end

  hl = vim.api.nvim_get_hl_by_name("Comment", true)
  local foreground = string.format("#%06x", hl["foreground"] or 0)
  if #foreground < 3 then
    foreground = ""
  end

  -- hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
  -- local background = string.format("#%06x", hl["background"] or 0)
  -- if #background < 3 then
  --   background = ""
  -- end

  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = '#828189', bg = '#2f3640' })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("_InlayHintsColorscheme", {}),
  pattern = "*",
  callback = setInlayHintHL,
})

setInlayHintHL()

local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end


rt.setup({
  tools = {
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "LspInlayHint",
    },
  },
  server = {
    standalone = true,
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  }
})

-- local opts = {
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   },
-- }
-- 
-- return opts
