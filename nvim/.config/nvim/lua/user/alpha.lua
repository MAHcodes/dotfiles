local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local banner = [[


   ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ 
    █  █▀   ▀  █   █      █  ██ █ █ █ 
██   █ ██▄▄    █   █ █     █ ██ █ ▄ █ 
█ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ 
█  █ █ ▀███▀           █  █   ▐    █  
█   ██                  █▐        ▀   


]]


local function greeting(name)
  local tableTime = os.date("*t")
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "  Sleep well",
    [2] = "  Good morning",
    [3] = "  Good afternoon",
    [4] = "  Good evening",
    [5] = "󰖔  Good night",
  }
  local greetingIndex = 0
  if hour == 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 21 then
    greetingIndex = 4
  elseif hour >= 21 then
    greetingIndex = 5
  end
  return greetingsTable[greetingIndex] .. ", " .. name .. "!"
end

local function generateDateTime()
  local date = os.date(" %d-%m-%Y")
  local time = os.date(" %H:%M")
  local devider = " | "

  return time .. devider .. date
end

local function generateFooter()
  local version = vim.version()
  local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return nvim_version_info
end

local header = {
  type = "text",
  val = vim.split(banner, "\n"),
  opts = {
    hl = "@alpha.header",
    position = "center",
  },
}


local function button(sc, txt, keybind)
  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 3,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "@alpha.shortcut",
    hl = "@alpha.text",
  }
  if keybind then
    opts.keymap = { "n", sc, keybind, { noremap = true, silent = true, nowait = true } }
  end
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("t", "  TODO", ":e ~/notes/TODO/index.md<CR>"),
    button("f", "  Find file", ":Telescope find_files<CR>"),
    button("e", "  New file", ":ene <BAR> startinsert<CR>"),
    button("p", "  Find project", ":Telescope projects theme=dropdown <CR>"),
    button("s", "󱝩  Find Session", ":Telescope persisted theme=dropdown<CR>"),
    button("l", "  Load Session", ":SessionLoad<CR>"),
    button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
    button("F", "  Find text", ":Telescope live_grep<CR>"),
    button("c", "  Configuration", ":e $MYVIMRC<CR>"),
    button("u", "  Update", ":PackerSync<CR>"),
    button("q", "  Quit", ":qa<CR>"),
  },
  opts = {
    position = "center",
    spacing = 1,
  },
}

local footer = {
  type = "text",
  val = {
    generateFooter(),
  },
  opts = {
    hl = "@alpha.footer",
    position = "center",
  },
}

local datetime = {
  type = "text",
  val = { generateDateTime() },
  opts = {
    hl = "@alpha.title",
    position = "center",
  }
}

local greet = {
  type = "text",
  val = { greeting("MAHcodes") },
  opts = {
    hl = "@alpha.title",
    position = "center",
  },
}

local section = {
  header = header,
  datetime = datetime,
  greeting = greet,
  buttons = buttons,
  footer = footer,
}

local opts = {
  layout = {
    { type = "padding", val = 1 },
    section.header,
    -- { type = "padding", val = 2 },
    -- section.datetime,
    -- { type = "padding", val = 1 },
    -- section.greeting,
    { type = "padding", val = 2 },
    section.buttons,
    { type = "padding", val = 2 },
    section.footer,
  },
  opts = {
    margin = 44,
    noautocmd = true,
  },
}

alpha.setup(opts)
