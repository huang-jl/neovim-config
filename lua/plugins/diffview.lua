-- Custom picker: show all commits
local function pick_commit_all(prompt, cb)
  local Snacks = require("snacks")
  Snacks.picker.pick(nil, {
    title = prompt,
    layout = "select",
    format = "text",
    finder = function(config, ctx)
      return require("snacks.picker.source.proc").proc({
        cmd = "git",
        args = {
          "--no-pager",
          "log",
          "--all",
          "--decorate=short",
          "--pretty=format:%h\t%s\t%d",
        },
        transform = function(item)
          -- optional: trim newline etc.
          local hash, subj, dec = item.text:match("^([^%s]+)\t([^\t]+)\t?(.*)$")
          local disp = hash .. " " .. subj
          if dec and dec ~= "" then
            disp = disp .. " " .. dec -- show "(main, feature)"
          end
          item.text = disp
          item.value = hash
        end,
      }, ctx)
    end,
    confirm = function(picker, item)
      picker:close()
      cb(item.value)
    end,
  })
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    keys = {
      {
        "<leader>gD",
        function()
          pick_commit_all("Choose first commit", function(sha1)
            pick_commit_all("Choose second commit", function(sha2)
              -- I do not understand why this is necessary, but it works
              -- use vim.cmd directly will cause error
              vim.schedule(function()
                vim.cmd("DiffviewOpen " .. sha1 .. ".." .. sha2)
              end)
            end)
          end)
        end,
        mode = "n",
        desc = "Open git diff view",
      },
    },
  },
}
