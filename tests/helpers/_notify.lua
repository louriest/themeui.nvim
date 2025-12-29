--- @class notifyHelper
--- @field inject function
--- @field destory function
local notifyHelper = {}

notifyHelper.inject = function(child)
	child.lua([[
    local _original_notify = vim.notify
    vim._notify_calls = {}

    vim.notify = function(msg, level, opts)
      table.insert(vim._notify_calls, {
        msg = msg,
        level = level,
        opts = opts,
      })
    end
  ]])
end

notifyHelper.destory = function(child)
	child.lua([[
    vim.notify = _original_notify
    vim._notify_calls = nil
  ]])
end

return notifyHelper
