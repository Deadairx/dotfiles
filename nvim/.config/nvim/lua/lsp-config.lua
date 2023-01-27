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
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
} 

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
