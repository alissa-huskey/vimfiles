-- paste handler
--   fixes nvim's paste behavior in replace-mode
--   see :help paste
--
-- print("loading file: paste.lua")

-- global paste function (allows file reload without overwriting paste_fn)
local paste_fn = paste_fn or vim.paste

vim.paste = (function(super)
  return (function(lines, phase)
    local m = vim.api.nvim_get_mode()["mode"]
    -- print(string.format('vim.paste(): mode=%s', m))

    modes = {
      R = (function()
        -- send `CTRL-R*`  (insert contents of clipboard register "*")
        vim.api.nvim_feedkeys("*", "t", false)
      end) ,

      default = (function()
        super(lines, phase)
      end) ,
    }


    func = modes[m] or modes["default"]
    func()

  end)
end)(paste_fn)
