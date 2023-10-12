local status_ok, bqf = pcall(require, "bqf")
if not status_ok then
  return
end

bqf.setup({
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  preview = {
    win_height = 20,
    win_vheight = 12,
    delay_syntax = 80,
    winblend = 0,
    show_title = true,
    border = "rounded",
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match('^fugitive://') then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end
  },
})
