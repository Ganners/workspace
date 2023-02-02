" Vim-plug Setup
call plug#begin()

    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'tpope/vim-fugitive'
    Plug 'gregsexton/gitv'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'fatih/vim-go'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tsaleh/vim-align'
    Plug 'tpope/vim-markdown'
    Plug 'majutsushi/tagbar'
    Plug 'itchyny/lightline.vim'
    Plug 'godlygeek/tabular'
    Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
    Plug 'davidhalter/jedi-vim'
    Plug 'hashivim/vim-terraform'
    Plug 'nvie/vim-flake8'

    " https://github.com/artur-shaik/jc.nvim
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'puremourning/vimspector'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'artur-shaik/jc.nvim'

" Call plug#end to update &runtimepath and initialize plugin system
call plug#end()

filetype plugin indent on

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
        highlight Visual term=reverse ctermbg=0 ctermfg=NONE guibg=#000000
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

    " Java
    lua require('jc').setup{}
