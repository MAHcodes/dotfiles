local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
  return
end

diffview.setup({
  enhanced_diff_hl = false,
})
