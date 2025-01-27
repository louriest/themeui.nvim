local theme = require("themeui.config")

local M = {}

function M.set_keys(opts)
	opts = opts or {}

	local default_keys = {
		{
			mode = "n",
			key = opts.toggle_background or "<leader>bg",
			action = theme.toggle_background,
			desc = "Toggle background",
		},
		{
			mode = "n",
			key = opts.switch_theme or "<leader>ts",
			action = theme.switch_theme,
			desc = "Toggle colorscheme",
		},
		{
			mode = "n",
			key = opts.theme_selector or "<leader>th",
			action = theme.theme_selector,
			desc = "Select colorscheme",
		},
	}

	for _, keymap in ipairs(default_keys) do
		vim.keymap.set(keymap.mode, keymap.key, keymap.action, { desc = keymap.desc })
	end
end

return M
