local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      -- suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  win = {
    border = "rounded", -- none, single, double, shadow
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    wo = {
      winblend = 10,
    }
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "t", mode = "n" },
  },
  -- triggers = {"<leader>"} -- or specify a list manually
}

-- local opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "<leader>",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }

-- local mappings = {
--   b = {
--     "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--     "Buffers",
--   },
--   ["e"] = { "<cmd>NvimTreeToggle<cr>", "which_key_ignore" },
--   ["w"] = { "<cmd>w!<CR>", "Save" },
--   ["q"] = { "<cmd>q!<CR>", "Quit" },
--   ["<leader>"] = { '<cmd>let @/ = ""<CR>', "which_key_ignore" },
--   c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
--   f = {
--     name = "Telescope",
--     f = {
--       "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--       "Find files",
--     },
--     g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
--     h = { "<cmd>Telescope help_tags <cr>", "Help Tags" },
--     t = { "<cmd>lua require('telescope-tabs').list_tabs() <cr>", "Find Tabs"},
--     p = { "<cmd>lua require('telescope-tabs').go_to_previous() <cr>", "Go to Previous Tabs"},
--   -- ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
--   },
--   r = { "<cmd>Telescope lsp_references <cr>", "Goto Reference"},
--   i = { "<cmd>Telescope lsp_implementations <cr>", "Goto Implementation"},
--   t = { "<cmd>Telescope lsp_type_definitions <cr>", "Goto Type Definition" },
--   o = { "<cmd>SymbolsOutline <cr>", "Symbol Outline" },
--   p = {
--     name = "Packer",
--     c = { "<cmd>PackerCompile<cr>", "Compile" },
--     i = { "<cmd>PackerInstall<cr>", "Install" },
--     s = { "<cmd>PackerSync<cr>", "Sync" },
--     S = { "<cmd>PackerStatus<cr>", "Status" },
--     u = { "<cmd>PackerUpdate<cr>", "Update" },
--   },
--
--   g = {
--     name = "Git",
--     g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
--     j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
--     k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
--     l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
--     p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
--     r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
--     R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
--     s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
--     u = {
--       "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
--       "Undo Stage Hunk",
--     },
--     o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
--     b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
--     c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
--     d = {
--       "<cmd>Gitsigns diffthis HEAD<cr>",
--       "Diff with head",
--     },
--     h = { "<cmd>Git log --oneline -n 100 %<cr>", "Current files's history" },
--   },
--
--   l = {
--     name = "LSP",
--     a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
--     d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
--     w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
--     f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
--     i = { "<cmd>LspInfo<cr>", "Info" },
--     I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
--     j = {
--       "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
--       "Next Diagnostic",
--     },
--     k = {
--       "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
--       "Prev Diagnostic",
--     },
--     l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
--     q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
--     r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
--     s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
--     S = {
--       "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
--       "Workspace Symbols",
--     },
--   },
--   s = {
--     name = "Search",
--     b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
--     c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
--     h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
--     M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
--     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--     R = { "<cmd>Telescope registers<cr>", "Registers" },
--     k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
--     C = { "<cmd>Telescope commands<cr>", "Commands" },
--   },
--   ["'"] = { "Marks" },
--   ["\""] = { "Registers" },
-- }

local spec = {
  { '<leader>"', desc = "Registers", nowait = true, remap = false },
  { "<leader>'", desc = "Marks", nowait = true, remap = false },
  { "<leader><leader>", '<cmd>let @/ = ""<CR>', hidden = true, nowait = true, remap = false },
  { "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers", nowait = true, remap = false },
  { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", hidden = true, nowait = true, remap = false },

  { "<leader>d", group = "Diff texts", nowait = true, remap = false },
  { "<leader>dt", "<cmd>windo diffthis<CR>", desc = "Enable diff in current window", nowait = true, remap = false },
  { "<leader>do", "<cmd>windo diffoff<CR>", desc = "Disable diff in current window", nowait = true, remap = false },
  { "<leader>db", "<cmd>enew<CR>", desc = "Create a new buffer", nowait = true, remap = false },
  { "<leader>dv", "<cmd>vnew<CR>", desc = "Create a new buffer in vertical split window", nowait = true, remap = false },

  { "<leader>f", group = "Telescope", nowait = true, remap = false },
  { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files", nowait = true, remap = false },
  { "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Find Text", nowait = true, remap = false },
  { "<leader>fc", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({layout_strategy = 'vertical', layout_config = { preview_cutoff = 1 }}) <cr>", desc = "Fuzzy in current buffer", nowait = true, remap = false },
  { "<leader>fh", "<cmd>Telescope help_tags <cr>", desc = "Help Tags", nowait = true, remap = false },
  { "<leader>fp", "<cmd>lua require('telescope-tabs').go_to_previous() <cr>", desc = "Go to Previous Tabs", nowait = true, remap = false },
  { "<leader>ft", "<cmd>lua require('telescope-tabs').list_tabs() <cr>", desc = "Find Tabs", nowait = true, remap = false },

  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff with head", nowait = true, remap = false },
  { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = true, remap = false },
  { "<leader>gh", "<cmd>Git log --oneline -n 100 %<cr>", desc = "Current files's history", nowait = true, remap = false },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
  {
    mode = { "n", "v" },
    { "<leader>gL", "<cmd>lua get_history_of_current_line()<cr>", desc = "Log of lines", nowait = true, remap = false },
  },

  { "<leader>i", "<cmd>Telescope lsp_implementations <cr>", desc = "Goto Implementation", nowait = true, remap = false },
  { "<leader>r", "<cmd>Telescope lsp_references <cr>", desc = "Goto Reference", nowait = true, remap = false },
  { "<leader>t", "<cmd>Telescope lsp_type_definitions <cr>", desc = "Goto Type Definition", nowait = true, remap = false },

  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
  { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", nowait = true, remap = false },
  {
    mode = { "n", "v" },
    {"<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format", nowait = true, remap = false },
  },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
  { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic", nowait = true, remap = false },
  { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
  { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
  { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
  { "<leader>lci", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming Calls", nowait = true, remap = false },
  { "<leader>lco", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing Calls", nowait = true, remap = false },

  { "<leader>o", "<cmd>Outline <cr>", desc = "Toggle Symbol Outline", nowait = true, remap = false },

  { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },

  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },

  { "<leader>j", "<cmd>Telescope jumplist<CR>", desc = "Save", nowait = true, remap = false },

  { "th", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "Toggle htop term", nowait = true, remap = false },
  { "tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "Toggle python term", nowait = true, remap = false },
  { "ts", "<cmd>TermSelect<CR>", desc = "Toggleterm Select", nowait = true, remap = false },
}

which_key.setup(setup)
-- which_key.register(mappings, opts)
which_key.add(spec)
