local status_ok, tsc = pcall(require, "tsc")
if not status_ok then
  return
end

tsc.setup({
  auto_open_qflist = true,
  auto_close_qflist = false,
  enable_progress_notifications = true,
  hide_progress_notifications_from_history = true,
})
