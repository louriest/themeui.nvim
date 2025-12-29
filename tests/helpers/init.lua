local sHelper = dofile("tests/helpers/_storage.lua")
local eHelper = dofile("tests/helpers/_engine.lua")
local nHelper = dofile("tests/helpers/_notify.lua")
local MiniTest = require("mini.test")
local eq = MiniTest.expect.equality

--- @class helpers
--- @field tmp string
--- @field new_child_neovim function
--- @field calls_chcker fun(child: unknown, nos: number, msg: string)
local helpers = {}

helpers.tmp = sHelper.tmp

helpers.calls_chcker = function(child, nos, msg)
	local calls = child.lua_get("vim._notify_calls")
	eq(#calls, nos)
	eq(calls[nos].msg, msg)
end

helpers.new_child_neovim = function()
	local child = MiniTest.new_child_neovim()

	child.setup = function()
		local T = MiniTest.new_set({
			hooks = {
				pre_case = function()
					child.restart({ "-u", "scripts/minimal_init.lua" })
					child.lua([[ M = require("themeui") ]])

					nHelper.inject(child)
					sHelper.inject()
					eHelper.inject(child)
				end,
				post_once = function()
					eHelper.destory(child)
					sHelper.destory()
					nHelper.destory(child)

					child.stop()
				end,
			},
		})
		return T
	end

	return child
end

return helpers
