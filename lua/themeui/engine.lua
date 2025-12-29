local storage = require("themeui.storage")

--- @class ThemeUIEngine
--- @field apply_theme fun(state: ThemeUIState, silent?: boolean)
--- @field apply_background fun(state: ThemeUIState, silent?: boolean)
local engine = {}

--- Apply selected theme to neovim and lualine
--- @param state ThemeUIState
function engine.apply_theme(state)
	local theme = state.themes[state.index]
	vim.cmd("colorscheme " .. theme)

	require("lualine").setup({
		options = {
			theme = theme,
		},
	})

	storage.save(state)
end

--- Apply selected background to neovim
--- @param state ThemeUIState
function engine.apply_background(state)
	vim.api.nvim_set_option_value("bg", state.background, {})
	storage.save(state)
end

return engine
