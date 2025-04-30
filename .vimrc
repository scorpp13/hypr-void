" {{{ Vim-Plug
call plug#begin()

" List your plugins here
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf.vim'

call plug#end()
" }}}


" {{{ Main
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
scriptencoding utf-8
" Don't use Ex mode, use Q for formatting
map Q gq
" We don't want VIM to load their own built-in defaults, preferring ours here
" instead. This option cannot apply to minimal builds, so it is guarded by a
" test that's guaranteed to fail for those, owing to the lack of +eval.
if 1
	let g:skip_defaults_vim = 1
endif
" Save file with sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" }}}


" {{{ General settings
set nocompatible		" Use Vim defaults (much better!)
set nomodeline			" Disable modeline settings
set bs=2				" Allow backspacing over everything in insert mode
set ai					" Always set auto-indenting on
set history=50			" keep 50 lines of command history
set ruler				" Show the cursor position all the time
set number				" Add numbers to each line on the left-hand side
set viminfo='20,\"500	" Keep a .viminfo file
"set cursorline			" Highlight cursor line underneath the cursor horizontally
"set cursorcolumn		" Highlight cursor line underneath the cursor vertically
set shiftwidth=4		" Set shift width to 4 spaces
set tabstop=4			" Set tab width to 4 columns
"set expandtab			" Use space characters instead of tabs
set nobackup			" Do not save backup files
set scrolloff=10		" Do not let cursor scroll below or above N number of lines when scrolling
set nowrap				" Do not wrap lines. Allow long lines to extend as far as the line goes
set ignorecase			" Ignore capital letters during search
set smartcase			" Override the ignorecase option if searching for capital letters
set showcmd				" Show partial command you type in the last line of the screen
set showmode			" Show the mode you are on the last line
set showmatch			" Show matching words during a search
set t_Co=256			" 256-colors terminal
set background=dark
"colorscheme PaperColor

filetype on				" Enable type file detection
filetype plugin on		" Enable plugins for the detected file type
filetype indent on		" Load plugin for the detected file type

" When displaying line numbers, don't use an annoyingly wide number column. This
" doesn't enable line numbers -- :set number will do that. The value given is a
" minimum width to use for the number column, not a fixed size.
if v:version >= 700
	set numberwidth=3
endif
" }}}


" {{{ Completition settings
" Enable auto completion menu after pressing TAB
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
" }}}


" {{{ Locale settings
" Try to come up with some nice sane GUI fonts. Also try to set a sensible
" value for fileencodings based upon locale. These can all be overridden in
" the user vimrc file.
if v:lang =~? "^ko"
	set fileencodings=euc-kr
	set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~? "^ja_JP"
	set fileencodings=euc-jp
	set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~? "^zh_TW"
	set fileencodings=big5
	set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~? "^zh_CN"
	set fileencodings=gb2312
	set guifontset=*-r-*
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
	set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
	let g:added_fenc_utf8 = 1
	set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
if &fileencodings !~? "default"
	set fileencodings+=default
endif
" }}}


" {{{ Syntax highlighting settings
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	set incsearch
endif
" We don't want VIM to load their own built-in defaults, preferring ours here
" instead. This option cannot apply to minimal builds, so it is guarded by a
" test that's guaranteed to fail for those, owing to the lack of +eval.
if 1
	let g:skip_defaults_vim = 1
	endif
" }}}


" {{{ Fix &shell, see bug #101665.
if "" == &shell
	if executable("/bin/bash")
		set shell=/bin/bash
	elseif executable("/bin/sh")
		set shell=/bin/sh
	endif
endif
"}}}


" {{{ Autocommands
if has("autocmd")

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt
        \ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
        \     setlocal textwidth=78 |
        \ endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 0 && line ("'\"") <= line("$") |
        \         exe "normal! g'\"" |
        \     endif |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug #53437.
  autocmd FileType crontab set backupcopy=yes

  " If we previously detected that the default encoding is not UTF-8
  " (g:added_fenc_utf8), assume that a file with only ASCII characters (or no
  " characters at all) isn't a Unicode file, but is in the default encoding.
  " Except of course if a byte-order mark is in effect.
  autocmd BufReadPost *
        \ if exists("g:added_fenc_utf8") && &fileencoding == "utf-8" && 
        \    ! &bomb && search('[\x80-\xFF]','nw') == 0 && &modifiable |
        \       set fileencoding= |
        \ endif

endif " has("autocmd")
" }}}

