local engine = require("themeui.engine")
local nuiMenu = require("nui.menu")

--- @class ThemeUISelect
--- @field setup fun(config: ThemeUIConfig)
local select = {}

function select.handle_submit(state, item)
	state.index = item.id
	engine.apply_theme(state)
end

--- @param state ThemeUIState
function select.list_menu(state)
	local themes = {}

	for idx, theme in ipairs(state.themes) do
		table.insert(themes, nuiMenu.item(theme, { id = idx }))
	end

	return themes
end

--- @param state ThemeUIState
function select.draw(state)
	local themes = select.list_menu(state)

	local menu = nuiMenu({
		position = "50%",
		relative = "editor",
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "rounded",
			text = {
				top = "[ Select theme ]",
				top_align = "left",
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
	}, {
		lines = themes,
		keymaps = {
			foucs_next = { "j", "<Down>", "<Tab>" },
			foucs_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_submit = function(item)
			select.handle_submit(state, item)
		end,
	})

	return menu
end

--- @param config ThemeUIConfig
function select.setup(config)
	local menu = select.draw(config.state)
	menu:mount()
end

return select
