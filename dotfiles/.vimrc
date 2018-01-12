" vim: sw=4 ts=4 sts=4 et

" Load plugins {
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'fatih/molokai'
        Plug 'tpope/vim-fugitive'
        Plug 'fatih/vim-go'
        Plug 'itchyny/lightline.vim'
        Plug 'romainl/vim-cool'
        Plug 'tpope/vim-commentary'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'scrooloose/nerdtree'
	Plug 'dbakker/vim-projectroot'
    call plug#end()
"}

" General config {
    set nocompatible

    syntax on
    filetype off
    filetype plugin indent on
    " QOL / Terminal {
        set ttyfast " Make the terminal faster, improves smoothness.
        set noerrorbells " No annoying error bells
        set updatetime=300
        set nospell " Disable spell-checking
        set encoding=utf-8              " set default encoding to utf-8
        set lazyredraw " an optimization for plugin redraw.

        " Time out on key codes but not mappings.
        " Basically this makes terminal Vim work sanely.
        if !has('gui_running')
            set notimeout
            set ttimeout
            set ttimeoutlen=10
            augroup FastEscape
                autocmd!
                au InsertEnter * set timeoutlen=0
                au InsertLeave * set timeoutlen=1000
            augroup END
        endif

        set hidden " Handles buffers better.
    "}

    set backspace=indent,eol,start " Make backspace work as 'intented'
	set shiftround " 'Smart indent'

    " Autocomplete menu {
        set wildmenu " show preview of completion-suggestions
        set wildmode=list:longest " Complete files like a shell
        " Ignore certain file extensions
        set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**
    "}
    " Searching {
        set ignorecase " Case-insensitive searching
        set hlsearch " Highlight findings
        set incsearch " Highlight findings as you type
        set wrapscan " Wrap search findings
        set smartcase " Unless a capital case letter is given
    "}

    " Visuals {
        set number " Enable line numbering
        set ruler
        let g:loaded_matchparen=1 " Stop hightlighting matching brackets when the cursors on them
        set mouse=a " Enable mouse
        set nocursorline
        set list    " show trailing whitespace
        set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮
        set showcmd " Prints the commands you type on the fly ( bottom right corner )
        set noshowmode " Shows the mode you are currently in

        " Wrapping {
            " Avoid line wrapping
            set nowrap 
            set textwidth=0
            set wrapmargin=0
            set formatoptions-=t
        "}

        " Coloring {
            syntax enable
            if $COLORTERM == 'gnome-terminal'
                set t_Co=256
            endif
            set t_ut=

            let g:rehash256 = 1
            set background=dark
            colorscheme molokai
            let g:molokai_original = 1
        "}

        " Statusline {
            " Make statusline visible when vim is opened
            set laststatus=2 
            let g:lightline = {
                  \ 'colorscheme': 'one',
                  \ 'active': {
                  \   'left': [ [ 'mode', 'paste' ],
                  \             [ 'readonly', 'filename', 'gitbranch'] ]
                  \ },
                  \ 'component_function': {
                  \   'filename': 'LightlineGetCwd',
                  \   'gitbranch': 'fugitive#head',
                  \ },
                  \ }
            function! LightlineGetCwd()
                return expand('%') !=# '' ? expand('%') : '[No Name]'
            endfunction

        "}

    " Backup/Swap/Undo/Saving {
        set undolevels=2000
        set undodir=/tmp// " Save undo to /tmp so everything gets deleted upon reboot
        set undofile " Enable persistent undo ( writes to disk )

        set noswapfile " Disable swap files
        set nobackup " Do not create annoying backup files
        set autowrite " Autowrite when several commands occur ( e.g. :make :next etc.)
        set autoread " Auto reload files changed on disk ( an external command has to be issued in order to reload the subject file , e.g. :checktime )
        set history=9000 
    "}

    " Splits {
        set splitright " Split right of the current window
        set splitbelow " Split below current window
        "}

    " Custom commands {
        " open :help vertically
        command! -nargs=* -complete=help Help vertical belowright help <args> 
        autocmd FileType help wincmd L

        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    "}

    " Filetypes
        autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
        autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
        autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
        augroup filetypedetect
            autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
            autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
        augroup END

        " put quickfix window always to the bottom
        autocmd FileType qf wincmd J
        augroup quickfix
            autocmd!
            autocmd FileType qf setlocal wrap
        augroup END
"}

" Mappings {
    let mapleader = ","

    " Faster command
    nmap ! :!

    " Source .vimrc
    map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

    " Oh well..
    map ; :

    " ctrlp-alike searching
    function! s:find_git_root()
	      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
      endfunction

      command! ProjectFiles execute 'Files' s:find_git_root()

    nmap <C-p> :ProjectFiles <CR>

    " Start/End-of-line
    noremap H ^
    noremap L $

    " Page-down 
    nnoremap <Space> <c-d>

    " Search mappings: These will make it so that going to the next one in a
    " search will center on the line it's found in.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Act like D and C (Yank the current line)
    nnoremap Y y$

    " Enter automatically into the files directory
    autocmd BufEnter * silent! lcd %:p:h

    " Prevent the q: window from showing 
    map q: :q
    map q; :q

    " Visual Mode */# from Scrooloose {{{
    " Select text in vmode, then press * or # to search for it in the file
    function! s:VSetSearch()
        let temp = @@
        norm! gvy
        let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
        let @@ = temp
    endfunction

    vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
    vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>
"}

" Plugins {
    " vim-go {
        let g:go_highlight_space_tab_error = 0
        let g:go_highlight_array_whitespace_error = 0
        let g:go_highlight_trailing_whitespace_error = 0
        let g:go_highlight_extra_types = 0
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_types = 1
        let g:go_highlight_functions = 1
    "}
    " buftabline {
    " }
"}
