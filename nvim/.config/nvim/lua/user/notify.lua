local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

notify.setup {
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  render = "compact",
  timeout = 175,
  -- background_colour = "#000000",
  minimum_width = 10,
  top_down = true,
  level = 2,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "",
  },
}

local telescope_status_ok, telescope = pcall(require, "telescope")
if telescope_status_ok then
  telescope.load_extension("notify")
end

vim.notify = notify
