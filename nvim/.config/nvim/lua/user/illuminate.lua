-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<a-p>",
  '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
  { noremap = true }
)

local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end

illuminate.configure {
  filetypes_denylist = {
    "mason",
    "harpoon",
    "DressingInput",
    "NeogitCommitMessage",
    "qf",
    "dirvish",
    "oil",
    "minifiles",
    "fugitive",
    "alpha",
    "NvimTree",
    "lazy",
    "NeogitStatus",
    "Trouble",
    "netrw",
    "lir",
    "DiffviewFiles",
    "Outline",
    "Jaq",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "TelescopePrompt",
  },
}
