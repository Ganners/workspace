" NeoBundle Setup
    if has('vim_starting')
        if &compatible
            set nocompatible
        endif

        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#begin(expand('~/.vim/bundle'))

        " Let NeoBundle manage NeoBundle
        NeoBundleFetch 'Shougo/neobundle.vim'

        " Add or remove your Bundles here:
        NeoBundle 'scrooloose/nerdtree'
        NeoBundle 'jistr/vim-nerdtree-tabs'
        NeoBundle 'Shougo/neosnippet.vim'
        NeoBundle 'Shougo/neosnippet-snippets'
        NeoBundle 'tpope/vim-fugitive'
        NeoBundle 'gregsexton/gitv'
        NeoBundle 'ctrlpvim/ctrlp.vim'
        NeoBundle 'fatih/vim-go'
        NeoBundle 'terryma/vim-multiple-cursors'
        NeoBundle 'tsaleh/vim-align'
        NeoBundle 'tpope/vim-markdown'
        NeoBundle 'majutsushi/tagbar'
        NeoBundle 'itchyny/lightline.vim'
        NeoBundle 'godlygeek/tabular'
        NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
        NeoBundle 'davidhalter/jedi-vim'
        NeoBundle 'hashivim/vim-terraform'
        NeoBundle 'nvie/vim-flake8'

    call neobundle#end()

    filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Misc configuration

    " Fix backspace
        set backspace=indent,eol,start

" NERDTree configuration
    autocmd vimenter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Multiple-cursors configuration
    let g:multi_cursor_use_default_mapping=0
    let g:multi_cursor_next_key='<C-d>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

" Vim-lightline configuration

    let g:lightline = {
        \     'mode_map': { 'c': 'NORMAL' },
        \     'active': {
        \       'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \     },
        \     'component_function': {
        \       'modified': 'LightLineModified',
        \       'fileformat': 'LightLineFileformat',
        \       'filetype': 'LightLineFiletype',
        \       'fileencoding': 'LightLineFileencoding',
        \       'mode': 'LightLineMode',
        \     },
        \ }

    function! LightLineModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightLineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! LightLineFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! LightLineFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

" Misc. Mappings (Try to keep fairly vanilla)
    map <C-n> :NERDTreeToggle<CR>
    map <tab><tab> <C-w><C-w>
    map gb :call Browser()<CR>
    nmap <F8> :TagbarToggle<CR>

" Themes and colours
    set t_Co=256
    syntax enable
    syntax on

    " Highlight characters that go over 120 columns
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        match OverLength /\%121v.\+/

    " The UI settings
        set number
        set cul
        set laststatus=2
        set nohlsearch
        set incsearch
        set ignorecase
        set ruler
        set showmatch

" Text formatting
    set autoindent
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround
    set expandtab
    set smarttab
    set nowrap
    set listchars=tab:>-,trail:-
    set list

" Programming language specific

    " Go(lang)
        let g:go_fmt_command = "goimports"

    " Python
        let g:jedi#popup_on_dot = 0
        let g:jedi#popup_select_first = 0
        let g:jedi#show_call_signatures = "1"
        let g:jedi#goto_command = "gd"

        " Make Flake8 linter execute on save
        autocmd BufWritePost *.py call Flake8()
