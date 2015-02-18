""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The .vimrc file of Lucian Pestritu
" Check http://github.com/lucianp/dotfiles for the latest version.
"
" Sections:
" 1. General .................. General Vim behavior
" 2. Events ................... General autocmd events
" 3. Colors and schemes ....... Colors and colorschemes
" 4. Vim UI ................... User interface behavior
" 5. Vim GUI (gVim, MacVim) ... Graphical user interface options (fonts, etc.)
" 6. Text formatting .......... Mostly tab and indentation related options
" 7. Key mappings ............. Key mappings
" 8. Plugins .................. Various plugin-specific options
" 9. Modules .................. Sourcing other files (like .vimrc.local)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 1. General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " get rid of Vi compatibility mode (should be set first)
" silent! is used to suppress error messages if the config line references
" plugins/colorschemes that might be missing
silent! call pathogen#infect() " call pathogen plugin management
set clipboard=unnamed " use the system clipboard

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 2. Events
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load files for specific filetypes
filetype on
filetype indent on
filetype plugin on
" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" For Java display guide line at column 100 (instead of 80; see below)
autocmd FileType java setlocal colorcolumn=100
" For TeX do not display guide line at all
autocmd FileType tex setlocal colorcolumn=
" Save folds on exit
autocmd BufWinLeave * if expand("%") != "" | mkview | endif
autocmd BufWinEnter * if expand("%") != "" | loadview | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 3. Colors and schemes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " enable syntax highlighting (previously syntax on).
set t_Co=256  " 256 color terminal support
"set t_Co=16  " 16-color (useful for some colorschemes when running in CLI)
"set term=builtin_ansi
set background=light " force-set the background to light (colorscheme-dependent)
"set background=dark " force-set the background to dark (colorscheme-dependent)
silent! colorscheme solarized
"silent! colorscheme zenburn
"silent! colorscheme django


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 4. Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number          " show line numbers
set cul             " highlight current line
set laststatus=2    " last window always has a statusline
set hlsearch        " highlight searched phrases
set incsearch       " highlight as you type your search
set ignorecase      " make searches case-insensitive
set ruler           " always show info along bottom
"set showmatch      " when a paren is inserted, briefly jump to the matching one
" Cool status line
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)
set statusline+=\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set colorcolumn=80  " display guide line at column 80
set spell           " enable spell checking


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 5. Vim GUI (gVim, MacVim)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    " Set font (different syntax depending on the platform)
    if has("gui_gtk2")
        set guifont=Source\ Code\ Pro\ 11
    elseif has("gui_macvim")
        set guifont=Source\ Code\ Pro:h11
    elseif has("gui_kde")
        set guifont=Source\ Code\ Pro/11/-1/5/50/0/0/0/1/0
    elseif has("gui_photon")
        set guifont=Source\ Code\ Pro:s11
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        set guifont=Consolas:h11:cDEFAULT
        "set guifont=Source\ Code\ Pro:h11:cDEFAULT
        "set guifont=DejaVu\ Sans\ Mono:h11:cDEFAULT
    endif
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    set guioptions-=r "remove right-hand scroll bar
    set guioptions-=R "remove right-hand scroll bar
    set guioptions-=l "remove left-hand scroll bar
    set guioptions-=L "remove left-hand scroll bar
    set lines=40 columns=104 " set width and height of the window
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 6. Text formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent      " auto-indent (does not conflict with filetype indent on)
set tabstop=4       " tab spacing
set softtabstop=4   " unify
set shiftwidth=4    " indent/outdent by 4 columns
set shiftround      " always indent/outdent to the nearest tabstop
set expandtab       " use spaces instead of tabs
"set smarttab       " use tabs at the start of a line, spaces elsewhere
set nowrap          " do not wrap text
set backspace=indent,eol,start " Enable backspace in insert mode


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 7. Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not place comments on the same line with *map commands!
" Press jj instead of <Esc> to exit insert mode
imap jj <Esc>
" Y yanks the current inner word into the "y register
noremap Y "yyiw
" S replaces the current inner word with the "y register
noremap S diw"yP


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 8. Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
"let g:syntastic_html_tidy_ignore_errors=['trimming empty']
"let g:syntastic_disabled_filetypes=['html']

" NERDTree
"autocmd vimenter * NERDTree  " start NERDTree when Vim starts
let g:NERDTreeWinPos = "left" " set the position of the NERDTree window to left


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 9. Modules
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

