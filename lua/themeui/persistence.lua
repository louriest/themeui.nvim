local M = {}

--- Check if file exists
--- @param filepath string
--- @return boolean True if file exists, false otherwise
local function file_exists(filepath)
	local f = io.open(filepath, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

--- Save colorscheme & background preferences to the file
function M.save_preferences()
	local bg = vim.o.bg
	local colorscheme = vim.g.colors_name
	local filePath = ""

	if vim.fn.has("win32") == 1 then
		local home = vim.fn.expand("$USERPROFILE")
		filePath = home .. "\\AppData\\Local\\nvim_preferences"
	elseif vim.fn.has("linux") == 1 then
		local home = os.getenv("HOME")
		filePath = home .. "/.nvim_preferences"
	end

	-- Create file if it doesn't exist
	if not file_exists(filePath) then
		if vim.fn.has("win32") == 1 then
			os.execute("echo.> " .. filePath)
		else
			os.execute("touch " .. filePath)
		end
	end

	vim.fn.writefile({ colorscheme, bg }, filePath)
end

return M
