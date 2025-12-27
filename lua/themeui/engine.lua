local helpers = require("themeui.helpers")

--- @class ThemeUIEngine
--- @field apply_theme fun(state: ThemeUIState, silent?: boolean)
--- @field apply_background fun(state: ThemeUIState, silent?: boolean)
local engine = {}

--- Apply selected theme to neovim and lualine
--- @param state ThemeUIState
--- @param silent? boolean Default: false
function engine.apply_theme(state, silent)
	local theme = state.themes[state.index]
	vim.cmd("colorscheme " .. theme)

	require("lualine").setup({
		options = {
			theme = theme,
		},
	})

	helpers.save(state)
	if not silent then
		vim.notify("Applying " .. theme .. " colorscheme", vim.log.levels.INFO, {})
	end
end

--- Apply selected background to neovim
--- @param state ThemeUIState
--- @param silent? boolean Default: false
function engine.apply_background(state, silent)
	vim.api.nvim_set_option_value("bg", state.background, {})
	if not silent then
		vim.notify("Switched to " .. state.background .. " mode", vim.log.levels.INFO, {})
	end
	helpers.save(state)
end

return engine
