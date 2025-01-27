local M = {}

M.themes = {}

function M.get_themes()
	return M.themes
end

function M.update_themes(themes)
	for _, theme in ipairs(themes) do
		table.insert(M.themes, theme)
	end
end

return M
