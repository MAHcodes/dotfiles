local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  return
end

-- configure catppuccin flavour: latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha"

catppuccin.setup({
  custom_highlights = function(colors)
    return {
      -- alpha
      ["@alpha.title"] = { fg = colors.yellow, style = { "bold" } },
      ["@alpha.text"] = { fg = colors.blue },
      ["@alpha.shortcut"] = { fg = colors.red, style = { "italic" } },
      ["@alpha.header"] = { fg = colors.lavender },
      ["@alpha.footer"] = { fg = colors.peach, style = { 'bold' } },

      -- noice
      NoiceCmdlinePopupBorder = { fg = colors.blue },
      NoiceVirtualText = { fg = colors.yellow },
      NoiceLspProgressSuccess = { fg = colors.green },
      NoiceLspProgressSpinner= { fg = colors.yellow },

      -- glance
      GlancePreviewNormal = { bg = colors.mantle },
      GlancePreviewMatch = { bg = colors.surface1 },
      GlancePreviewBorderBottom = { bg = colors.mantle, fg = colors.blue },
      GlancePreviewLineNr = { bg = colors.mantle },
      GlancePreviewCursorLine = { bg = colors.mantle },
      GlancePreviewEndOfBuffer = { bg = colors.mantle },
      GlancePreviewSignColumn = { bg = colors.mantle },

      GlanceWinBarTitle = { bg = colors.surface0 },
      GlanceWinBarFilename = { bg = colors.surface0, fg = colors.blue, style = { "bold" } },
      GlanceWinBarFilepath = { bg = colors.surface0, fg = colors.lavender },

      GlanceListNormal = { bg = colors.base },
      GlanceListFilename = { fg = colors.blue, style = { "bold" } },
      GlanceListCount = { fg = colors.blue, style = { "bold" } },
      GlanceListCursorLine = { bg = colors.base },
      GlanceListMatch = { bg = colors.surface1 },
      GlanceListEndOfBuffer = { bg = colors.base },
      GlanceListBorderBottom = { bg = colors.mantle, fg = colors.blue },


      GlanceFoldIcon = { fg = colors.blue },
      GlanceIndent = { fg = colors.surface0 },
      GlanceBorderTop = { bg = colors.mantle, fg = colors.blue },
    }
  end,
  integrations = {
    alpha = true,
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    octo = true,
    notify = true,
    markdown = true,
    harpoon = true,
    fidget = true,
    illuminate = true,
    mason = true,
    neogit = true,
    noice = true,
    symbols_outline = true,
    lsp_trouble = true,
    which_key = true,
    barbecue = {
      dim_dirname = true,
      bold_basename = true,
      dim_context = false,
      alt_background = false,
    },
    telescope = {
      enabled = true,
    },
    dap = {
      enabled = true,
      enable_ui = true,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    navic = {
      enabled = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
  }
})
