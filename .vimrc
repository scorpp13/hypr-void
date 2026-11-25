" {{{ Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf.vim'

call plug#end()
" }}}

" {{{ Main
let g:skip_defaults_vim = 1
scriptencoding utf-8

" Format text with Q without recursion
noremap Q gq

" Clear search highlighting with Esc
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" Save file with sudo (replace sudo with doas if you use doas on Void)
command! W execute 'silent! write !sudo tee % >/dev/null' | edit!

" Enable marker folding inside .vimrc
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" {{{ General settings
set nomodeline
set backspace=indent,eol,start
set autoindent
set history=200
set ruler
set number
set numberwidth=3
set viminfo='20,\"500
set shiftwidth=4
set tabstop=4
set nobackup
set nowritebackup
set scrolloff=10
set nowrap
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set cursorline

" Sync Vim yank/delete/paste directly with Hyprland's system clipboard
if has('clipboard')
    set clipboard=unnamedplus
endif

" Proper TrueColor support for Wayland terminals in Hyprland
if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set background=dark
colorscheme tender

filetype plugin indent on
syntax on
set hlsearch
set incsearch
" }}}

" {{{ Completion settings
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
" }}}

" {{{ Encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
" }}}

" {{{ Autocommands
augroup general_autocmds
    autocmd!
    " Limit text width to 78 chars for .txt files
    autocmd BufNewFile,BufRead *.txt
        \ if &tw == 0 && !exists("g:leave_my_textwidth_alone") |
        \     setlocal textwidth=78 |
        \ endif

    " Restore cursor to last known position when opening a file
    autocmd BufReadPost *
        \ if !exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 1 && line("'\"") <= line("$") |
        \         exe "normal! g'\"" |
        \     endif |
        \ endif

    " Allow crontab to be edited properly
    autocmd FileType crontab setlocal backupcopy=yes
    " Highlight the current line only in the active window
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave,BufLeave * setlocal nocursorline

augroup END
" }}}
