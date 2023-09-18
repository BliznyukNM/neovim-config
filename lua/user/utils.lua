local status_ok, notify = pcall(require, "notify")
if status_ok then
  vim.opt.termguicolors = true
  vim.notify = notify
end
