return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    active = true,
    exclude_dirs = {"*/node_modules/*"},
    show_hidden = true,
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension("projects")
  end,
}
