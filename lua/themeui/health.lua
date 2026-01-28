local health = {}

function health.report_system()
	vim.health.start("System")
	local required_executables = { "git" }
	for _, executable in ipairs(required_executables) do
		if vim.fn.executable(executable) == 0 then
			vim.health.error(executable .. " is not installed.")
		else
			vim.health.ok(executable .. " is installed.")
		end
	end
end

function health.report_themes()
	vim.health.start("Installed themes")
	local tu = require("themeui")
	local themes = tu.config.state.themes
	for _, theme in ipairs(themes) do
		vim.health.ok(theme .. " ready.")
	end
end

function health.check()
	health.report_system()
	health.report_themes()
end

return health
