local M = {}

--- Get file path for the preferences file
--- @return string filePath
local function get_file_path()
	local filePath = ""
	if vim.fn.has("win32") == 1 then
		local home = vim.fn.expand("$USERPROFILE")
		filePath = home .. "\\AppData\\Local\\nvim_preferences"
	elseif vim.fn.has("linux") == 1 then
		local home = os.getenv("PWD")
		filePath = home .. "/.nvim_preferences"
	end

	return filePath
end

--- Check if file exists
--- @param filepath string
--- @return boolean exist True if file exists, false otherwise
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
	local filePath = get_file_path()

	-- Create file if it doesn't exist
	if not file_exists(filePath) then
		if vim.fn.has("win32") == 1 then
			os.execute("echo.> " .. filePath)
		else
			os.execute("touch " .. filePath)
		end
	end

	local themeData = vim.fn.json_encode({ theme = colorscheme, background = bg })

	vim.fn.writefile({ themeData }, filePath)
end

--- Load colorscheme & background preferences from the file
function M.load_preferences()
	local filePath = get_file_path()

	-- Early exit if file doesn't exist
	if not file_exists(filePath) then
		return
	end

	local rawData = table.concat(vim.fn.readfile(filePath))
	local success, data = pcall(vim.json.decode, rawData)

	-- Early exit if json not valid
	if not success then
		return
	end

	-- Set theme if it exists
	if not data.theme ~= nil then
		vim.cmd("colorscheme " .. data.theme)
		require("lualine").setup({
			options = {
				theme = data.theme,
			},
		})
	end

	-- Set background preference (dark/light) if it exists
	if not data.background ~= nil then
		vim.api.nvim_set_option_value("bg", data.background, {})
	end
end

return M
