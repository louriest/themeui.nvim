local helper = require("themeui.persistence")
local data = require("themeui.data")

local M = {}
local themes = data.get_themes()

--- checks if current background is transparent
--- @return boolean True if background is transparent, false otherwise.
local function is_background_transparent()
	--- get current background color
	local normal_bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
	return normal_bg == "NONE" or normal_bg == ""
end

--- Set traparancy for variouse UI elements
--- Ensures that the background of key higlights groups is transparent
local function set_transparancy()
	-- traparancy fixes for neovim
	vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
	vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
	vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
	vim.cmd("hi NeotreeNormal guibg=NONE ctermbg=NONE")
	vim.cmd("hi NeotreeNormalNC guibg=NONE ctermbg=NONE")
end

--- Handles background transparency for dracula theme
local function background_transparancy()
	-- handle traparancy for dracula theme
	local colorscheme = vim.g.colors_name
	if colorscheme == "dracula" then
		if is_background_transparent() then
			-- if background is transparent, set it to normal
			vim.cmd("colorscheme " .. colorscheme)
			vim.api.nvim_set_option_value("bg", "dark", {})
			vim.api.nvim_notify("Switched to normal mode", vim.log.levels.INFO, {})
		else
			-- otherwise, set it to transparent
			set_transparancy()
			vim.api.nvim_notify("Switched to transparent mode", vim.log.levels.INFO, {})
		end
	end
end

--- Toggles between light and dark background mode
--- If "dracula" theme is applied, it will toggle transparency
function M.toggle_background()
	local bg = vim.o.bg
	local colorscheme = vim.g.colors_name

	-- apply light mode for themes
	if colorscheme ~= "dracula" then
		-- handle background for all non-dracula themes
		bg = bg == "dark" and "light" or "dark"
		vim.api.nvim_set_option_value("bg", bg, {})
		vim.api.nvim_notify("Switched to " .. bg .. " mode", vim.log.levels.INFO, {})
	else
		-- handle transparency for dracula theme
		background_transparancy()
	end

	helper.save_preferences()
end

--- Switches to next available theme from theme list
function M.switch_theme()
	local current_theme = vim.g.colors_name
	local next_index = 1

	for i, theme in ipairs(themes) do
		if theme == current_theme then
			next_index = (i % #themes) + 1
			break
		end
	end

	local next_theme = themes[next_index]
	M.apply_theme(next_theme)
end

--- Applies selected colorscheme to UI elements
--- @param theme string Name of the theme to apply
function M.apply_theme(theme)
	vim.cmd("colorscheme " .. theme)

	-- Ensures dark mode is forced for dracula theme
	if theme == "dracula" then
		vim.api.nvim_set_option_value("bg", "dark", {})
	end

	-- Apply theme to lualine
	require("lualine").setup({
		options = {
			theme = theme,
		},
	})

	vim.api.nvim_notify("Applied " .. theme .. " colorscheme", vim.log.levels.INFO, {})
	helper.save_preferences()
end

return M
