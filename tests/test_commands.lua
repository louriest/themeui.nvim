local helpers = dofile("tests/helpers/init.lua")
local MiniTest = require("mini.test")

local child = helpers.new_child_neovim()
local T = child.setup()
local new_set, eq = MiniTest.new_set, MiniTest.expect.equality
local calls_chcker = helpers.calls_chcker

T["commands"] = new_set()

T["commands"]["check if ThemeUINext() is called correctly"] = function()
	child.lua([[ M.setup({
    state = {
      themes = { "one", "two", "three" },
      index = 1,
      background = "dark"
    }
  }) ]])

	child.cmd([[ ThemeUINext ]])
	eq(child.lua_get("M.config.state.index"), 2)
	calls_chcker(child, 1, "Applying two colorscheme")

	child.cmd([[ ThemeUINext ]])
	child.cmd([[ ThemeUINext ]])
	eq(child.lua_get("M.config.state.index"), 1)
	calls_chcker(child, 3, "Applying one colorscheme")
end

T["commands"]["check if ThemeUIPrev() is called correctly"] = function()
	child.lua([[ M.setup({
    state = {
      themes = { "one", "two", "three" },
      index = 1,
      background = "dark"
    }
  }) ]])

	child.cmd([[ ThemeUIPrev ]])
	eq(child.lua_get("M.config.state.index"), 3)
	calls_chcker(child, 1, "Applying three colorscheme")
	child.cmd([[ ThemeUIPrev ]])
	child.cmd([[ ThemeUIPrev ]])
	eq(child.lua_get("M.config.state.index"), 1)
	calls_chcker(child, 3, "Applying one colorscheme")
end

T["commands"]["check if ThemeUIToggleBackground() is called correctly"] = function()
	child.lua([[ M.setup({
    state = {
      themes = { "one", "two", "three" },
      index = 1,
      background = "dark"
    }
  }) ]])

	child.cmd([[ ThemeUIToggleBackground ]])
	eq(child.lua_get("M.config.state.background"), "light")
	child.cmd([[ ThemeUIToggleBackground ]])
	eq(child.lua_get("M.config.state.background"), "dark")
end

T["commands"]["check if ThemeUIState() is called correctly"] = function()
	child.lua([[M.setup({
      state = {
        themes = { "one", "two", "three" },
        index = 1,
        background = "dark"
      }
    })
  ]])

	child.cmd([[ ThemeUIState ]])

	local calls = child.lua_get("vim._notify_calls")
	eq(#calls, 1)
	eq(calls[1].msg, '[{"colorscheme":"one"},{"background":"dark"}]')
end

return T
