" vim: sw=4 ts=4 sts=4 et

" Load plugins {
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'tpope/vim-fugitive'
        Plug 'fatih/vim-go'
        Plug 'itchyny/lightline.vim'
        Plug 'romainl/vim-cool'
        Plug 'tpope/vim-commentary'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'scrooloose/nerdtree'
        Plug 'raimondi/delimitmate'
        Plug 'qpkorr/vim-bufkill'
        Plug 'jwalton512/vim-blade'
        Plug 'mgee/lightline-bufferline'
        Plug 'w0ng/vim-hybrid'
        Plug 'cocopon/lightline-hybrid.vim'
        Plug 'skywind3000/asyncrun.vim'
        Plug 'tikhomirov/vim-glsl'
        Plug 'SirVer/ultisnips'
        Plug 'godlygeek/tabular'
        Plug 'plasticboy/vim-markdown'
        " Plug 'liuchengxu/vim-which-key' This is nice for beginners
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
        set encoding=utf-8 " set default encoding to utf-8
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
        set grepprg=rg\ --vimgrep
    "}

    " Visuals {
        set number " Enable line numbering
        " set relativenumber " Enable relative numbering
        set ruler
        let g:loaded_matchparen=1 " Stop hightlighting matching brackets when the cursors on them
        set mouse=a " Enable mouse
        set nocursorline
        set nocursorcolumn
        set list    " show trailing whitespace
        set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮
        set showcmd " Prints the commands you type on the fly ( bottom right corner )
        set noshowmode " Shows the mode you are currently in
        set foldmethod=syntax
        set nofoldenable
        set foldlevel=99
        set conceallevel=2


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

            set background=dark
            colorscheme hybrid
        "}

        " Statusline {
            " Make statusline visible when vim is opened
            set laststatus=2
            let g:lightline = {
                  \ 'colorscheme': 'wombat',
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
                return expand('%:h') !=# '' ? expand('%:h') : '[No Name]'
            endfunction
            set showtabline=2

        "}

    " Backup/Swap/Undo/Saving {
        set undolevels=2000
        "
        " Let's save undo info!
        if !isdirectory($HOME."/.vim")
            call mkdir($HOME."/.vim", "", 0770)
        endif
        if !isdirectory($HOME."/.vim/undo-dir")
            call mkdir($HOME."/.vim/undo-dir", "", 0700)
        endif
        set undodir=~/.vim/undo-dir 
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
        " Compile latex upon saving
        function! CompileTex()
            AsyncRun! pdflatex %
            redraw!
        endfunction

        au BufWritePost *.tex call CompileTex()

        function! CompileMarkdown()
            let l:outfile = expand("%:r")
            let l:command = "!pandoc ". expand("%"). " -o " . l:outfile . ".pdf"
            AsyncRun! pandoc "%" -o "%<" ".pdf"
            redraw!
        endfunction

        " Asynchronously convert the markdown file to pdf
        au BufWritePost *.md :AsyncRun! pandoc % -o %<.pdf

        " open :help vertically
        command! -nargs=* -complete=help Help vertical belowright help <args> 
        autocmd FileType help wincmd L

        " Find the current dir's root by looking for the git-root
        function! s:find_git_root()
            return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
        endfunction

        command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(s:find_git_root(), fzf#vim#with_preview(), <bang>0)

        " --column: Show column number
        " --line-number: Show line number
        " --no-heading: Do not show file headings in results
        " --fixed-strings: Search term as a literal string
        " --ignore-case: Case insensitive search
        " --no-ignore: Do not respect .gitignore, etc...
        " --hidden: Search hidden files and folders
        " --follow: Follow symlinks
        " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
        " --color: Search color options

        " Use Ripgrep for searching with fzf.
        " Pop open a preview window with '?'
        " Lastly, the search is going to be project-wide (see find_git_root())
        command! -bang -nargs=* Find call 
                    \ fzf#vim#grep('rg --column --line-number --no-heading ' 
                    \ .'--fixed-strings --ignore-case --no-ignore --hidden '
                    \ .'--follow --glob "!.git/*" --color "always" '
                    \ .shellescape(<q-args>).' '.s:find_git_root().'| tr -d "\017"', 1, <bang>0 ? fzf#vim#with_preview('up:60%')
                    \                                                     : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

        function! s:FindFriendly()
            let temp=input("Search project root for: ")
            if temp != ""
                execute "Find ".temp
            endif
        endfunction

        command! FindF call s:FindFriendly()

        " Closes all buffers but the current one.
        function! s:CloseAllBuffers()
            exe ":wa! | :%bd | e # | bd #"
        endfunction

        " Naive go-to definition for python using ripgrep
        " Looks for 'def <function-name-under-cursor>('
        function! s:GotoDefinitionPython()
            let cword= expand("<cword>")
            let output=system("rg --line-number 'def ". cword . "\\(' " . s:find_git_root())
            let tokens=split(output, ':') 
            silent exe "edit +". tokens[1]. " " .tokens[0]
        endfunction

    "}

    " Filetypes
        autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
        autocmd BufNewFile,BufRead *.tex setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
        autocmd BufNewFile,BufRead *.php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
        autocmd BufNewFile,BufRead *.blade.php setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufRead *.blade.php setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2
        autocmd BufNewFile,BufRead Vagrantfile setlocal expandtab tabstop=2 shiftwidth=2
        autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
        autocmd FileType sh   setlocal noexpandtab shiftwidth=4 tabstop=4
        autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
        autocmd FileType glsl setlocal noexpandtab shiftwidth=4 tabstop=4
        autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
        augroup filetypedetect
            autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
            autocmd BufNewFile,BufRead Vagrantfile setf ruby
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

    " Search and replace all occurences of current word
    :nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/


    " Python specific commands
    augroup python
        " Python go to definition (naive)
        autocmd FileType python nnoremap <Leader>gd :call <SID>GotoDefinitionPython()<CR>
    augroup END

    nmap <Leader>1 <Plug>lightline#bufferline#go(1)
    nmap <Leader>2 <Plug>lightline#bufferline#go(2)
    nmap <Leader>3 <Plug>lightline#bufferline#go(3)
    nmap <Leader>4 <Plug>lightline#bufferline#go(4)
    nmap <Leader>5 <Plug>lightline#bufferline#go(5)
    nmap <Leader>6 <Plug>lightline#bufferline#go(6)
    nmap <Leader>7 <Plug>lightline#bufferline#go(7)
    nmap <Leader>8 <Plug>lightline#bufferline#go(8)
    nmap <Leader>9 <Plug>lightline#bufferline#go(9)
    nmap <Leader>0 <Plug>lightline#bufferline#go(10)
    " Install plugins
    nmap <leader>i :PlugInstall<CR>
    " Faster command
    nmap ! :!

    " Close all buffers but the current one
    nnoremap <leader>o :call <SID>CloseAllBuffers()<cr>

    " Enable tmux-navigator for all modes
    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

    inoremap <silent> <C-h> <Esc>:TmuxNavigateLeft<cr>
    inoremap <silent> <C-j> <Esc>:TmuxNavigateDown<cr>
    inoremap <silent> <C-k> <Esc>:TmuxNavigateUp<cr>
    inoremap <silent> <C-l> <Esc>:TmuxNavigateRight<cr>

    " Source .vimrc
    map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

    " Oh well..
    map ; :

    " ctrlp-alike searching
    map <C-p> :Files <CR>
    map <C-g> :FindF <CR>
    map <C-e> :History<CR>

    " Start/End-of-line
    noremap H ^
    noremap L $

    " Page-down 
    nnoremap <Space> <c-d>zz
    vnoremap <Space> <c-d>zz
    " This can be triggered by <C-Space> as well
    " For more: https://stackoverflow.com/questions/24983372/what-does-ctrlspace-do-in-vim
    nnoremap <C-@> <C-u>zz 
    vnoremap <C-@> <C-u>zz 

    " Search mappings: These will make it so that going to the next one in a
    " search will center on the line it's found in.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Act like D and C (Yank the current line)
    nnoremap Y y$

    " Enter automatically into the files directory
    "autocmd BufEnter * silent! lcd %:p:h

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

    " Toggling NERDTree
    nmap <C-n> :NERDTreeToggle<CR>
    nmap ,n :NERDTreeFind<CR>

    " Open files/folders with 'l'
    " And open recursively with Space
    let g:NERDTreeMapActivateNode="l"
    let g:NERDTreeMapOpenRecursively="<Space>"

    " switch buffers with tab
    nmap <Tab> :bnext<CR>

    " close buffers but not their windows (bufkill)
    nmap <C-D> :BD<CR>

    function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
    endfunction

    " Goes upwards from the current file's directory to find a main.go file
    " and execute it using :GoRun
    " Also avoids *_test.go files
    function! s:find_main_file()
        let l:main_dir = fnamemodify(findfile('main.go', expand("%:p") . ";"), ":h")
        let l:files = system("ls ". l:main_dir . " | grep .go | grep -v '_test.go' | tr '\n' ' ' ")
        execute '!go run '.  l:main_dir . '/' . l:files
    endfunction

    augroup go
        autocmd!

        autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
        autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)

        autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

        autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
        autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

        autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
        autocmd FileType go nmap <silent> <leader>p :cprevious<CR>
        autocmd FileType go nmap <silent> <leader>n :cnext<CR>
        autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
        autocmd FileType go nmap <silent> <leader>r  :call <SID>find_main_file()<CR>
        autocmd FileType go nmap <silent> <leader>lr  :GoRun %<CR>
        autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

        autocmd FileType go nmap <silent> <Leader>c :cclose<CR>:lclose<CR>

        " I like these more!
        autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
        autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
        autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
        autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    augroup END
"}

" Plugins {
    " NERDTree{
        let NERDTreeShowHidden=1
        let NERDTreeRespectWildIgnore=1
    " }
    " Bufkill {
        let g:BufKillCreateMappings=0
    " }
    " vim-go {
        let g:go_fmt_command = "goimports"
        let g:go_def_mode = 'godef'
        let g:go_fmt_fail_silently = 0
        let g:go_highlight_space_tab_error = 0
        let g:go_highlight_array_whitespace_error = 0
        let g:go_highlight_trailing_whitespace_error = 0
        let g:go_highlight_extra_types = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_types = 1
        let g:go_highlight_functions = 1
    "}

    " fzf {
        let g:fzf_history_dir = '~/.local/share/fzf-history'
    " }

    " delimitMate {
        let g:delimitMate_expand_cr = 1
        let g:delimitMate_expand_space = 1
        let g:delimitMate_smart_quotes = 1
        let g:delimitMate_expand_inside_quotes = 0

        " Fix lightline issue, where if lazyredraw is set, it doesnt appear
        let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'
        imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
    " }

    " lightline-bufferline
        let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
        let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
        let g:lightline.component_type   = {'buffers': 'tabsel'}
        let g:lightline#bufferline#show_number=2
        let g:lightline#bufferline#min_buffer_count=0
        let g:lightline#bufferline#filename_modifier=":p:t"
    " }
    " vim-markdown {
        let g:vim_markdown_toc_autofit = 1
        let g:vim_markdown_autowrite = 1
        let g:vim_markdown_no_extensions_in_markdown = 1
        let g:vim_markdown_math = 1
    " }
"}

" Fix lightline issue, where if lazyredraw is set, it doesnt appear
autocmd VimEnter * redraw
