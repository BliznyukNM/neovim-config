local lsp = require 'vim.lsp'
local api = vim.api
local jdtls = require 'jdtls'


local M = {}
local lsps = {}


-- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
local key_mappings = {
    {"document_formatting", "n", "ff", "<Cmd>lua vim.lsp.buf.formatting()<CR>"},
    {"document_range_formatting", "v", "ff", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
    {"find_references", "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>"},
    {"hover", "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
    {"implementation", "n", "gi",  "<Cmd>lua vim.lsp.buf.implementation()<CR>"},
    {"signature_help", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
    {"workspace_symbol", "n", "gW", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"},
}


-- common function for every lsp backend
local function on_attach(client, bufnr)
    api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id) -- wtf is that?
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { silent = true; }

    for _, mappings in pairs(key_mappings) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end

    api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "]w", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "[w", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    if client.resolved_capabilities['document_highlight'] then
        api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
end


local function jdt_on_attach(client, bufnr)
    on_attach(client, bufnr)

    local opts = {silent = true;}
    jdtls.setup.add_commands()
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>ri", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>tm", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end


local function mk_config()
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities.workspace.configuration = true
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        flags = {
            allow_incremental_sync = true,
        };
        capabilities = capabilities;
        on_attach = on_attach;
    }
end


local function add_client_by_cfg(config, root_markers)
    local root_dir = jdtls.setup.find_root(root_markers)
    if not root_dir then return end

    local cmd = config.cmd[1]
    if tonumber(vim.fn.executable(cmd)) == 0 then
        api.nvim_command(string.format(
            ':echohl WarningMsg | redraw | echo "No LSP executable: %s" | echohl None', cmd))
        return
    end
    config.root_dir = root_dir
    local lsp_id = tostring(vim.bo.filetype) .. "?" .. root_dir
    local client_id = lsps[lsp_id]
    if not client_id then
        client_id = lsp.start_client(config)
        lsps[lsp_id] = client_id
        print(string.format('Starting %s LSP server on root %s', config.name, root_dir))
    end
    local bufnr = api.nvim_get_current_buf()
    lsp.buf_attach_client(bufnr, client_id)
    api.nvim_set_current_dir(root_dir)
end


function M.add_client(cmd, opts)
    local config = mk_config()
    config.name = opts and opts.name or cmd[1]
    config.cmd = cmd
    add_client_by_cfg(config, opts and opts.root or {'.git'})
end


function M.start_lua_ls()
    local config = mk_config()
    config.settings = {
        Lua = {
            diagnostics = {
                globals = {'vim', 'it', 'describe'}
            },
            runtime = {version = "LuaJIT"},
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                }
            },
        }
    }
    local root_path = vim.fn.expand('$HOME/.config/nvim/backends/lua-language-server/')
    local binary_path = root_path..'bin/macOS/lua-language-server'
    config.name = 'luals'
    config.cmd = {binary_path, root_path..'main.lua'}
    add_client_by_cfg(config, {'.git'})
end


function M.start_clangd()
    local config = mk_config()
    config.cmd = {'clangd', '--background-index'}
    config.name = 'clangd'
    add_client_by_cfg(config, {'compile_commands.json', '.git'})
end


function M.start_pylsp()
    local config = mk_config()
    config.cmd = {'pylsp'}
    config.name = 'pylsp'
    add_client_by_cfg(config, {'.git'})
end


function M.start_jdt()
    local config = mk_config()
    local root_dir = jdtls.setup.find_root({'.git', 'pom.xml', 'mvnw*'})
    api.nvim_set_current_dir(root_dir)
    config.cmd = {vim.fn.expand('$HOME/.config/nvim/java-lsp.sh')}
    config.on_attach = jdt_on_attach
    jdtls.start_or_attach(config)
end


function M.start_lemminx()
    local config = mk_config()
    config.cmd = {vim.fn.expand('$HOME/.config/nvim/backends/lemminx')}
    config.name = 'lemminx'
    add_client_by_cfg(config, {'.'})
end


return M
