" Plugins: {{{
call plug#begin('~/.vim/plugged')
" Colorful status bar
Plug 'itchyny/lightline.vim' 

" VimWiki, for note taking
Plug 'vimwiki/vimwiki' 

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sleuth'
" Syntax Error Debuging
Plug 'scrooloose/syntastic'
Plug 'kshenoy/vim-signature'
Plug 'airblade/vim-gitgutter'

" Indent Guidelines
Plug 'nathanaelkane/vim-indent-guides' 

" SQL Connection
Plug 'vim-scripts/dbext.vim' 

" File Explorer
Plug 'scrooloose/nerdtree' 

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 

Plug 'tpope/vim-dispatch', { 'for': 'cs' }
Plug 'OrangeT/vim-csharp', { 'for': 'cs' }
Plug 'PProvost/vim-ps1',   { 'for': 'ps1' }
Plug 'chrisbra/csv.vim',   { 'for': 'csv' }
Plug 'etdev/vim-hexcolor', { 'for': 'css' }
Plug 'kurocode25/mdforvim', { 'for': 'markdown' }
Plug 'myhere/vim-nodejs-complete', { 'for': 'javascript' }

" Color Themes
Plug 'altercation/vim-colors-solarized' 
Plug 'Heorhiy/VisualStudioDark.vim'
Plug 'morhetz/gruvbox'
Plug 'dsolstad/vim-wombat256i'

" Show open buffers
Plug 'bling/vim-bufferline' 
call plug#end()

scriptencoding utf-8

syntax on
filetype plugin on
filetype plugin indent on
"}}}
" Sets: {{{
set autoindent
set nobomb
set scrolloff=5
"set lazyredraw
set synmaxcol=800
set title
set listchars=trail:·,tab:»\ ,extends:>,precedes:\<
set nowrap
set number
set relativenumber "reletive line number
" lightline
set laststatus=2
set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set splitright
set splitbelow
set cursorline 
set fillchars=vert:│,fold:─
set wildmode=longest,list,full
set wildmenu
set noshowmode "hides '--INSERT--' since lightline shows it
set encoding=utf-8 "display Unicode
set background=dark
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Guides
"set colorcolumn=120
"set colorcolumn=80
"highlight ColorColumn ctermbg=DarkCyan
"let g:indent_guides_enable_on_vim_startup = 1

" Folding
if @% =~# 'vimrc' || @% =~# 'gvimrc'
	set foldmethod=marker
	set foldlevel=0
	set foldlevelstart=0
else
	set foldmethod=indent
	set foldlevel=2
endif

set foldnestmax=10
set nofoldenable

" Cursor Block for cygwin
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
cabbrev ~? ~/
cabbrev 5s %s
"}}}
" Mapings: {{{
let mapleader = ","

" NERDTree
map <leader>nt :NERDTree<CR>

" File and Window Management 
	inoremap <leader>w <Esc>:w<CR>
	nnoremap <leader>w :w<CR>

	inoremap <leader>q <ESC>:q<CR>
	nnoremap <leader>q :q<CR>

	inoremap <leader>x <ESC>:x<CR>
	nnoremap <leader>x :x<CR>

	" Exit Insert Mode
	inoremap jk <ESC>

	nnoremap <leader>e :Ex<CR>
	nnoremap <leader>t :tabnew<CR>:Ex<CR>
	nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
	nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
	
" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" ===VimWiki===
let wiki = {}
let wiki.path = '~/Google Drive/personalWiki'
let wiki.nested_syntaxes = {'cs': 'cs'}
let g:vimwiki_list = [wiki]

" Create todo item
map <leader>td I* [ ] 

" }}}
" Functions: {{{
function! DeleteHiddenBuffers()
  let tpbl = []
  let nClosed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')

  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val) == -1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let nClosed += 1
    endif
  endfor

  if nClosed > 0
    echo "Closed " . nClosed . " hidden buffers."
  else
    redraw!
  endif
endfunction

function! DeleteStringLead()
	" Delete beginning of string that has a '_' in it
	normal! yy
	if @" =~ "_"
		execute ":s/\"\a*_/\"/"
	endif
endfunction

"if exists('*OpenInBrowser')
"  nnoremap <leader>w :call OpenInBrowser()<cr>
"endif

function! TidyCurrent()
  :!tidy -m -wrap 0 %
endfunction

nnoremap <leader>t :call TidyCurrent()<cr>

function! WhatIsMyLeaderKey()
  :echo 'Map leader is' (exists('g:mapleader')? g:mapleader : '\')
endfunction

function! SynStack()
  if !exists('*synstack')
    return
  endif

  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

if exists('*SynStack')
  nmap <leader>s :call SynStack()<cr>
endif

function! GetCurrentByteOffset()
  echo eval(line2byte(line("."))+col(".")-1)
endfunction

"function! LintVimrc()
"  call vimlint#vimlint($MYVIMRC, {'output': 'quickfix'})
"  source $MYVIMRC
"endfunction
"}}}
" SQL {{{
" SQL Server
let g:dbext_default_profile_local = 'type=SQLSRV:user=vim:passwd=qjkCTW4!:host=localhost:dbname=vimDB'
"}}}
" vsvim {{{
" g commands
:nnoremap gi :vsc ReSharper.ReSharper_GotoImplementations<CR>
:nnoremap gr :vsc Edit.FindAllReferences<CR>

:nmap <leader>imp :vsc ReSharper_GenerateImplementations<CR>
:nmap <leader>tod :vsc ReSharper.ReSharper_ShowTodoExplorer<CR>
:nmap <leader>rt :vsc ReSharper.ReSharper_UnitTestRunFromContext<CR>
:nmap <leader>rT :vsc Resharper.Resharper_UnitTestRunSolution<CR>

"nmap <leader>rt :vsc TestExplorer.DebugAllTestsInContext<CR>
:map <leader>cc :vsc Edit.CommentSelection<CR>
:map <leader>cu :vsc Edit.UncommentSelection<CR>
:nmap <leader>far :vsc Edit.FindAllReferences<CR>
"Open in gvim - http://vim.wikia.com/wiki/Integrate_gvim_with_Visual_Studio
:nmap <leader>vim :vsc Tools.ExternalCommand1<CR> 
:nmap <leader>sd :vsc Debug.StopDebugging<CR>
:nmap <leader>bp :vsc Debug.ToggleBreakpoint<CR>
:nmap <leader>in :vsc Test.UseCodedUITestBuilder<CR>
:nmap <leader>mo :vsc Edit.CollapsetoDefinitions<CR>
:nmap <leader>gd :vsc Edit.PeekDefinition<CR>
:map <leader>cl :vsc CodeLens.LogAuthorsDoubleClick<CR>
:map <leader>gl :vsc File.GetLatestSolutionFiles<CR>
:map <leader>kto :vsc Window.KeepTabOpen<CR>
:map <leader>se :vsc View.SolutionExplorer<CR>
" }}}
