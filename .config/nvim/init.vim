au! BufWritePost $VIMRC source %

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
let g:python3_host_prog = $PYTHON3

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'sainnhe/everforest'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1
filetype plugin indent on
syntax enable

set termguicolors
colorscheme everforest

set hidden
set nobackup
set nowritebackup
set splitbelow
set splitright
set number
set relativenumber
set mouse=inv
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set smartindent
set autoindent
set foldmethod=indent
set showtabline=2
set updatetime=100
set timeoutlen=500
set shortmess+=c
set clipboard=unnamedplus
set formatoptions=tcl

augroup common
  autocmd!
  autocmd BufNewFile,BufRead *.jl setlocal filetype=julia
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc
  autocmd BufNewFile,BufRead deno.lock setlocal filetype=json

  autocmd FileType markdown setlocal suffixesadd=.md
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType lua,ruby,html,javascript,typescript,css,json,vue,vim,yaml setlocal shiftwidth=2 tabstop=2
  " need to debug: autocmd FileType tex inoremap ` `'<C-g>U
augroup end

" ~functions~
func! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunc

func! DeleteTrailingWS() abort
  exe "normal! mz"
  %s/\s\+$//ge
  exe "normal! 'z"
  echo "Trailing whitespace removed."
endfunc

" TODO include this function and DeleteTrailingWS() in save all and quit
" remaps
func! SaveAllAndCleanup()
  silent call DeleteTrailingWS()
  wa
  echo "All buffers saved."
endfunc
command! SaveAllAndCleanup call SaveAllAndCleanup()

    " mapping notation cheat sheet:
    "	<BS>           Backspace
    "	<Tab>          Tab
    "	<CR>           Enter
    "	<Enter>        Enter
    "	<Return>       Enter
    "	<Esc>          Escape
    "	<Space>        Space
    "	<Up>           Up arrow
    "	<Down>         Down arrow
    "	<Left>         Left arrow
    "	<Right>        Right arrow
    "	<F1> - <F12>   Function keys 1 to 12
    "	#1, #2..#9,#0  Function keys F1 to F9, F10
    "	<Insert>       Insert
    "	<Del>          Delete
    "	<Home>         Home (start of line)
    "	<End>          End (end of line)
    "	<PageUp>       Page-Up
    "	<PageDown>     Page-Down
    "	<bar>          the '|' character, which otherwise needs to be escaped '\|'
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:session_file = $NVIM

func! SaveSession()
  execute 'mksession! ' . $NVIMSESSIONFILE
endfunction

" Just saving
" write all changed buffers
nnoremap <Leader>w :wa<CR>
" Closing
" close currently loaded buffer
nnoremap <Leader>c :call SaveSession()<CR>:q<CR>
" write all changed buffers and close all buffers
nnoremap <Leader>q :call SaveSession()<CR>:wa<CR>:qa<CR>
" close all buffers without writing
nnoremap <Leader>fq :call SaveSession()<CR>:qa!<CR>
nnoremap <Leader>fj :%!python -m json.tool<CR>
inoremap ;; <Esc>la
" use alt + hjkl to resize windows TODO : FIGURE OUT M/ALT OR A DIFFERENT MAP
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
inoremap gf <Esc>
inoremap fg <Esc>
inoremap FG <Esc>
inoremap GF <Esc>
inoremap ;; <Esc>la
nnoremap <Leader>0 <C-w>v
nnoremap <Leader>9 <C-w>s
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>o :bnext<CR>
nnoremap <Leader>i :bprev<CR>
nnoremap <Leader>m :bdelete<CR>
nnoremap <Leader>b :bfirst<CR>
nnoremap <Leader>n :blast<CR>
nnoremap <Leader>a :call FzfBufferAdd()<CR>
function! FzfBufferAdd()
    let l:path = system('fzf')
    if l:path != ''
        execute 'badd ' . fnameescape(l:path)
    endif
endfunction
nnoremap <Leader>ff /
nnoremap <Leader>fr :%s/
nnoremap <expr> <Leader>fl ":<C-u>" . line(".") . "," . (line(".")) . "+"
nnoremap <Leader>fs :s/
nnoremap zz :FZF<CR>
nnoremap zf :Files<CR>
nnoremap zg :Rg<CR>
nnoremap zl :Lines<CR>


" ~<air, tmux>line~
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1 "enable the list of buffers
let g:tmuxline_powerline_separators = 0
