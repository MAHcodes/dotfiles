local M = {}

---@class logseq.Config
---@field graph_dir string Default directory for Logseq journals
---@field date_format? string Optional default date format for journal filenames
local config = {
	graph_dir = "",
	date_format = "%Y_%m_%d",
}

---@param opts logseq.Config
M.setup = function(opts)
	opts = opts or {}
	config.graph_dir = opts.graph_dir or config.graph_dir
	config.date_format = opts.date_format or config.date_format

	if config.graph_dir == "" then
		vim.notify("[logseq.lua] graph_dir is required.", vim.log.levels.WARN)
	end
end

M.get_journal_path = function()
	if not config.graph_dir or config.graph_dir == "" then
		return nil
	end

	local date = os.date(config.date_format)
	local journal_path = string.format("%s/journals/%s.md", config.graph_dir, date)
	return journal_path
end

M.open_journal = function()
	local journal_path = M.get_journal_path()
	if not journal_path then
		return
	end

	vim.cmd("edit " .. journal_path)
end

return M
