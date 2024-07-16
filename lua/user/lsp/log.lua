-- Function to check file size and rotate it if necessary
local function check_and_rotate_file(filepath, size_limit)
  local file = io.open(filepath, "r")
  if not file then
    return
  end

  -- Get the file size
  local file_size = file:seek("end")
  file:close()

  -- Check if the file size exceeds the limit
  if file_size > size_limit then
    -- Rename the file
    local new_filepath = filepath .. ".old"
    os.rename(filepath, new_filepath)

    print("File rotated: " .. filepath .. " -> " .. new_filepath)
  end
end

-- Example usage:
-- Define the file path and size limit (in bytes)
local filepath = vim.lsp.get_log_path()
local size_limit = 128 * 1024 * 1024 -- 128 MB

-- Call the function to check and rotate the file
check_and_rotate_file(filepath, size_limit)

