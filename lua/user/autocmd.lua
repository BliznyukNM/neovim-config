vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "Fastfile,Fastlane,Appfile",
  callback = function()
    vim.api.nvim_command("set filetype=ruby")
  end
})
