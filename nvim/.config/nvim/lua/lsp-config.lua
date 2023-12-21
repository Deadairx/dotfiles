-- Native LSP Setup

local commonLspKeymaps = function()
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Show hover' })
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to definition' })
    vim.keymap.set('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to type definition' })
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to implementation' })
    vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to references' })
    vim.keymap.set('n', '<leader>dj', '<cmd>lua vim.diagnostic.goto_next()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to next diagnostic' })
    vim.keymap.set('n', '<leader>dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', { buffer = 0, noremap = true, silent = true, desc = 'List diagnostics' })
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Rename symbol' })
    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = 0, noremap = true, silent = true, desc = 'Code Action' })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.gopls.setup{ -- connect to GO LSP server
    capabilities = capabilities,
    on_attach = commonLspKeymaps,
} 
require'lspconfig'.tsserver.setup{ -- connect to TS LSP server
    capabilities = capabilities,
    on_attach = commonLspKeymaps,
}
require'lspconfig'.rust_analyzer.setup{ -- connect to Rust LSP server
    capabilities = capabilities,
    on_attach = commonLspKeymaps,
    settings = {
        ["rust-analyzer"] = {
            procMacro = {
                enable = true
            },
            diagnostics = {
                disabled = {"unresolved-proc-macro"}
            },
        }
    }
} 

function UpdateRustAnalyzerTarget(newTarget)
    require('lspconfig').rust_analyzer.setup({
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    target = newTarget
                },
            }
        }
    })

    -- Restart rust-analyzer 
    vim.lsp.stop_client(vim.lsp.get_active_clients({name = "rust-analyzer"}))
    vim.cmd([[edit]])
end

vim.cmd([[
    command! -nargs=1 RustTarget lua UpdateRustAnalyzerTarget(<f-args>)
]])

local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function RustTargetPicker()
    local targets = {
        "wasm32-unknown-unknown",
        "x86_64-unknown-linux-gnu",
    }

    pickers.new({}, {
        prompt_title = 'Rust Analyzer Target',
        finder = finders.new_table {
            results = targets,
        },
        sorter = require('telescope.config').values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                UpdateRustAnalyzerTarget(selection.value)
            end)

            return true
        end,
    }):find()
end

function SelectRustTarget()
    local targets = {
        "wasm32-unknown-unknown",
        "x86_64-unknown-linux-gnu",
    }
    local choice = vim.fn.inputlist(targets)
    if choice > 0 then
        UpdateRustAnalyzerTarget(targets[choice])
    end 
end
vim.cmd([[
    command! RustSelectTarget call v:lua.RustTargetPicker()
]])

vim.diagnostic.config({
    virtual_text = false,
})

-- LSP autocomplete
vim.opt.completeopt={"menu", "menuone", "noselect"} -- setting vim completion options

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

-- Telescope Setup
