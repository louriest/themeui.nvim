local storage = require("themeui.storage")

--- @class storageHelper
--- @field tmp string
--- @field inject function
--- @field destory function
local storageHelper = {}

local original = storage.get_file_path

storageHelper.tmp = vim.fn.tempname()
vim.fn.mkdir(storageHelper.tmp, "p")

storageHelper.inject = function()
	storage._path_provider = function()
		return storageHelper.tmp
	end
end

storageHelper.destory = function()
	storage._path_provider = original
end

return storageHelper
