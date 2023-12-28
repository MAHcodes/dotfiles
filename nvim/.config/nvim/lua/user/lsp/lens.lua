local status_ok, lens = pcall(require, "lsp-lens")
if not status_ok then
  return
end

lens.setup({
  enable = false,
  include_declaration = false, -- Reference include declaration
  sections = {                 -- Enable / Disable specific request
    definition = true,
    references = true,
    implements = true,
  },
  ignore_filetype = {
    "prisma",
  },
})
