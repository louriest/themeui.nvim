local M = {}

-- handle file check
local function file_exists(filepath)
	local f = io.open(filepath, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

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

	if not file_exists(filePath) then
		os.execute("touch " .. filePath)
	end

	vim.fn.writefile({ colorscheme, bg }, filePath)
end

function M.apply_theme(theme)
	vim.cmd("colorscheme " .. theme)

	-- applies dark mode for dracula theme
	if theme == "dracula" then
		vim.api.nvim_set_option_value("bg", "dark", {})
	end

	-- changes lualine theme to match main theme
	require("lualine").setup({
		options = {
			theme = theme,
		},
	})

	M.save_preferences()
end

return M
