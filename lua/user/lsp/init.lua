local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end


require "user.lsp.mason"
-- require "user.lsp.rust-tools"
require("user.lsp.handlers").setup()
require "user.lsp.log"
require("user.lsp.inlay-hints").enable_inlay_hints_autocmd()
-- require "user.lsp.null-ls"
