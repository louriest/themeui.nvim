--- @class ThemeUIKeymaps
--- @field setup fun()
local keymaps = {}

function keymaps.setup()
	--- @type keymaps[]
	local defaults = {
		{
			mode = "n",
			key = "<leader>tn",
			cmd = "<CMD>ThemeUINext<CR>",
			desc = "Switch to next theme",
		},
		{
			mode = "n",
			key = "<leader>tp",
			cmd = "<CMD>ThemeUIPrev<CR>",
			desc = "Switch to previous theme",
		},
		{
			mode = "n",
			key = "<leader>bg",
			cmd = "<CMD>ThemeUIToggleBackground<CR>",
			desc = "Toggle background mode",
		},
		{
			mode = "n",
			key = "<leader>th",
			cmd = "<CMD>ThemeUISelect<CR>",
			desc = "Open a select menu to select a theme.",
		},
	}

	for _, k in ipairs(defaults) do
		vim.keymap.set(k.mode, k.key, k.cmd, { desc = k.desc })
	end
end

return keymaps
