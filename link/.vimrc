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
"set clipboard=unnamed " use the system clipboard

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 2. Events
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable file type detection
filetype on
" Enable the loading of indent files for specific file types
filetype indent on
" Enable the loading of plugin files for specific file types
filetype plugin on
" Save folds before exiting
autocmd BufWinLeave * if expand("%") != "" | mkview | endif
autocmd BufWinEnter * if expand("%") != "" | loadview | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 3. Colors and schemes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " enable syntax highlighting (previously syntax on)
set t_Co=256  " 256 color terminal support
"set t_Co=16  " 16-color (useful for some colorschemes when running in CLI)
"set term=builtin_ansi
" Set background to light or dark depending on where Vim is running, GUI or CLI
"if has("gui_running")
"    set background=light
"else
"    set background=dark
"endif
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
        set guifont=Source\ Code\ Pro:h13
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
" Change formatting slightly, depending on the file type
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType org setlocal tabstop=2 softtabstop=2 shiftwidth=2
    \ wrap linebreak tw=0 colorcolumn= concealcursor= 
autocmd FileType sql setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType plsql setlocal tabstop=2 softtabstop=2 shiftwidth=2
" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" For Java display guide line at column 100 (instead of 80; see below)
autocmd FileType java setlocal colorcolumn=100
" For TeX do not display guide line at all
autocmd FileType tex setlocal colorcolumn=


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 7. Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" !!! Comments should not be placed on the same line with *map commands
" Set the leader key(s) to space (the default is backslash \)
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
" Press jj instead of <Esc> to exit insert mode
imap jj <Esc>
" Y yanks the current inner word into the "y register
noremap Y "yyiw
" S replaces the current inner word with the "y register
noremap S diw"yP
" Press <Space>w to save file (normal mode)
nnoremap <Leader>w :w<CR>
" Press <Space>f to switch to the last used buffer (normal mode)
nnoremap <Leader>f :b#<CR>
" Copy to system clipboard with <Space>y (visual mode)
vmap <Leader>y "+y
" Cut to system clipboard with <Space>d (visual mode)
vmap <Leader>d "+d
" Paste from system clipboard with <Space>p or <Space>P (normal mode)
nmap <Leader>p "+p
nmap <Leader>P "+P
" Paste from system clipboard with <Space>p or <Space>P (visual mode)
vmap <Leader>p "+p
vmap <Leader>P "+P
" Enter visual line mode with <Space><Space>
nmap <Leader><Leader> V


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 8. Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers=['jsl']
let g:syntastic_check_on_open=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
"let g:syntastic_html_tidy_ignore_errors=['trimming empty']
"let g:syntastic_disabled_filetypes=['html']
let g:syntastic_mode_map = { 'mode': 'passive' }

" NERDTree
"autocmd vimenter * NERDTree  " start NERDTree when Vim starts
let g:NERDTreeWinPos="left" " set the position of the NERDTree window to left

" vim-orgmode
" Custom todo keywords, tailored to my current workflow: the first set is for
" usual tasks (including bugs), the second set is for support tickets, and the
" third is for code review tasks
let g:org_todo_keywords = [['TODO(t)', 'IN_PROGRESS(p)', 'ON_HOLD(h)',
    \  'IN_REVIEW(r)', '|', 'DONE(d)', 'CANCELED(c)'],
    \ ['SP_OPEN(o)', 'SP_ONGOING(g)', 'SP_WAITING_FOR_USER(u)', '|',
    \  'SP_WAITING_FOR_PROJ_MGMT(m)', 'SP_RESOLVED(s)', 'SP_DELEGATED(e)'],
    \ ['RV_ASSIGNED(A)', 'RV_STARTED(S)', 'RV_UPDATED(U)', '|',
    \  'RV_COMPLETED(C)']]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" 9. Modules
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

