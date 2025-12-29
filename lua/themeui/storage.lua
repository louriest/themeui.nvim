--- @class ThemeUIHelper
--- @field file_exist fun(filePath: string): boolean
--- @field get_file_path fun(): string
--- @field save fun(state: ThemeUIState)
--- @field load fun(): ThemeUIState
local helper = {}

--- Check if file exists
--- @param filePath string
--- @return boolean
function helper.file_exist(filePath)
	local file = io.open(filePath, "r")
	if file ~= nil then
		io.close(file)
		return true
	end

	return false
end

--- Internal function to provide path
--- created for testing and mocking support
--- @return string dirPath
function helper._path_provider()
	return vim.fn.stdpath("cache") .. "/themeui" .. vim.fn.getcwd()
end

--- Get state file path depending on OS
--- create file if it doesn't exist
--- @return string filePath
function helper.get_file_path()
	local dirPath = helper._path_provider()
	local filePath = dirPath .. "/themes.json"

	if not helper.file_exist(filePath) then
		pcall(vim.fn.mkdir, dirPath, "p")
		vim.fn.writefile({}, filePath)
	end

	return filePath
end

--- Save state to file
--- @param state ThemeUIState
function helper.save(state)
	local filePath = helper.get_file_path()
	local file = io.open(filePath, "w")
	if not file then
		return
	end
	file:write(vim.json.encode({ themes = state.themes, index = state.index, background = state.background }))
	file:close()
end

--- Load state to file
--- @return ThemeUIState state
function helper.load()
	local data = vim.fn.readblob(helper.get_file_path())
	return vim.json.decode(data)
end

return helper
