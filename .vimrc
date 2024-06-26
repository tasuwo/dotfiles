filetype off
scriptencoding utf-8

" General
set nowritebackup
set nobackup
set noswapfile
set viminfo=
set clipboard+=unnamed,autoselect
set history=50
set virtualedit=block
set backspace=indent,eol,start
set wildmenu
set whichwrap=b,s,h,l,<,>,[,]

" Encoding
set encoding=utf8
set fenc=utf-8

" Indent
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab

" Search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

" View
set shortmess+=I
set noerrorbells
set novisualbell
set visualbell t_vb=
set number
set ruler
set showmatch matchtime=1
set cinoptions+=:0
set title
set cmdheight=1
set laststatus=2
set showcmd
set display=lastline
set list
set listchars=tab:^\ ,trail:~

" Highlighting
if &t_Co > 2 || has('gui_running')
  syntax on
endif

" Color
colorscheme desert
hi Comment ctermfg=Gray
hi SpecialKey ctermfg=Blue guifg=Blue
hi NonText ctermfg=Blue guifg=Blue
hi JpSpace cterm=underline ctermfg=Blue guifg=Blue
hi LineNr ctermfg=Gray
au BufRead,BufNew * match JpSpace /　/"

" Cursor highlight
set cursorline
hi clear CursorLine

" Status line
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L

" Keymap
imap jj <Esc>

" Spell
filetype plugin indent on

" Fastlane
au BufNewFile,BufRead Appfile set ft=ruby
au BufNewFile,BufRead Deliverfile set ft=ruby
au BufNewFile,BufRead Fastfile set ft=ruby
au BufNewFile,BufRead Gymfile set ft=ruby
au BufNewFile,BufRead Matchfile set ft=ruby
au BufNewFile,BufRead Snapfile set ft=ruby
au BufNewFile,BufRead Scanfile set ft=ruby
