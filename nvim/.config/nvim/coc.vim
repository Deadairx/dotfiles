" Give space for disploying messages
set cmdheight=2

" Shorter updatetime (4000ms default)
set updatetime=300

set signcolumn=yes

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

" GoTo navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Code Lens on current line
nmap <leader>cl <Plug>(coc-codelens-action)


