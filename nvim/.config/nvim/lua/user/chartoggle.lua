local status_ok, chartoggle = pcall(require, "chartoggle")
if not status_ok then
	return
end

chartoggle.setup ({
  leader = '<localleader>', -- you can use any key as Leader
  keys = {',', ';', '.', } -- Which keys will be toggle end of the line
})
