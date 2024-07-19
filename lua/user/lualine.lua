local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local function toggleterm_number()
  local ft = vim.bo.filetype
  if ft == "toggleterm" then
    return 'Toggleterm #' .. vim.b.toggle_number
  else
    return ""
  end
end

local function location()
  local line = vim.fn.line('.')
  local total_lines = vim.fn.line("$")
  local col = vim.fn.charcol('.')
  return string.format('%3d/%d:%-2d', line, total_lines, col)
end

local filename = {
  'filename',
  file_status = true,
  path = 1,
  shorting_target = 40,
  symbols = {
    modified = '[+]',      -- Text to show when the file is modified.
    readonly = '[󰌾]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]',     -- Text to show for newly created file before first write
  },
}

-- cool function for progress
-- local progress = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- local fn_context = function() 
--   local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter")
--   if not status_ok then
--     return ""
--   end
--   return nvim_treesitter.statusline({
--     indicator_size = 60,
--     type_patterns = {'class', 'function', 'method', 'interface'},
--     transform_fn = function(line, _node) return line:gsub('%s*[%[%(%{]*%s*$', '') end,
--     allow_duplicates = false,
--     separator = ' -> ',
--   })
-- end


lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
      statusline = { "dashboard", "NvimTree", "Outline" },
    },
		always_divide_middle = true,
    globalstatus = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { mode },
		lualine_c = { filename },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { 
      -- progress
    },
	},
	inactive_sections = {
		lualine_a = { toggleterm_number },
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
  winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    }
  },
	tabline = {},
	extensions = {
    "toggleterm",
  },
})
