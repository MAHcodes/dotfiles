local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 100
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint", "info" },
  symbols = { error = " ", warn = "  ", hint = "  ", info = "  " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "[" .. str:sub(0, 1) .. "]"
  end,
}

local noice_status_ok, noice = pcall(require, "noice")
if not noice_status_ok then
  print("noice not found")
  return
end

local command = {
  noice.api.status.command.get,
  cond = noice.api.status.command.has,
  icon = "󰘳",
}

local filetype = {
  "filetype",
  icons_enabled = true,
  colored = true,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

local progress = {
  "progress",
  fmt = function()
    return "%P/%L"
  end,
}

local filename = {
  'filename',
  file_status = true,     -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 0,               -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '[+]',      -- Text to show when the file is modified.
    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]',     -- Text to show for new created file before first writting
  }
}

local spaces = function()
  return "ﲖ " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. ""
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" },
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      "fileformat",
      mode,
      filename,
      "filesize"
    },
    lualine_b = { branch },
    lualine_c = { diff },
    lualine_x = { diagnostics, },
    lualine_y = { command, filetype, spaces, "encoding" },
    lualine_z = { location, progress },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
