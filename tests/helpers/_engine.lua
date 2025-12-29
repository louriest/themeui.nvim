--- @class engineHelper
--- @field inject function
--- @field destory function
local engineHelper = {}

engineHelper.inject = function(child)
	child.lua([[
    local engine = require("themeui.engine")
    local _original_apply_theme = engine.apply_theme
    local _original_apply_background = engine.apply_background

    engine.apply_theme = function(state, _)
      require("themeui.storage").save(state)
    end

    engine.apply_background = function(state, _)
      require("themeui.storage").save(state)
    end
  ]])
end

engineHelper.destory = function(child)
	child.lua([[
    local engine = require("themeui.engine")
    engine.apply_theme = _original_apply_theme
    engine.apply_background = _original_apply_background
  ]])
end

return engineHelper
