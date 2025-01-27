local helper = require("themeui.helper")
local ui = require("themeui.ui")
local themes = require("themeui.data").themes

local M = {}

local function is_background_transparent()
	-- gets curent background color
	local normal_bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
	return normal_bg == "NONE" or normal_bg == ""
end

local function set_transparancy()
	vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
	vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
	vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
	vim.cmd("hi NeotreeNormal guibg=NONE ctermbg=NONE")
	vim.cmd("hi NeotreeNormalNC guibg=NONE ctermbg=NONE")
end

local function background_transparancy()
	local colorscheme = vim.g.colors_name
	if colorscheme == "dracula" then
		if is_background_transparent() then
			-- force theme and background color
			vim.cmd("colorscheme " .. colorscheme)
			vim.api.nvim_set_option_value("bg", "dark", {})
		else
			set_transparancy()
		end
	end
end

function M.toggle_background()
	local bg = vim.o.bg
	local colorscheme = vim.g.colors_name

	-- apply light mode for themes except dracula
	if colorscheme ~= "dracula" then
		local newBg = bg == "dark" and "light" or "dark"
		vim.api.nvim_set_option_value("bg", newBg, {})
	else
		background_transparancy()
	end

	helper.save_preferences()
end

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
	helper.apply_theme(next_theme)
end

function M.theme_selector()
	ui.select_theme_ui()
end

return M
