local helper = require("themeui.helper")
local data = require("themeui.data")

local M = {}
local themes = data.get_themes()

function M.select_theme_ui()
	local Menu = require("nui.menu")

	-- Store themes inside menu list
	local themeOptions = {}
	for _, theme in ipairs(themes) do
		table.insert(themeOptions, Menu.item(theme))
	end

	-- handle selector theme change
	local function handle_input(theme)
		helper.apply_theme(theme)
	end

	local menu = Menu({
		position = "50%",
		relative = "editor",
		size = {
			width = 25,
			height = #themes,
		},
		border = {
			style = "rounded",
			text = {
				top = " Select theme ",
				top_align = "left",
			},
		},
	}, {
		lines = themeOptions,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "q" },
			submit = { "<CR>" },
		},
		on_submit = function(item)
			handle_input(item.text)
		end,
	})

	-- mount the component
	menu:mount()
end

return M
