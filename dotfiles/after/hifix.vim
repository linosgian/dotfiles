function! MyHighlights() abort
    hi clear LightLineLeft_tabline_tabsel
    hi LightLineLeft_tabline_tabsel ctermfg=Black ctermbg=110
endfunction
augroup MyColors
    autocmd!
    autocmd VimEnter,BufEnter,ColorScheme,BufReadPre * call MyHighlights()
augroup END

colorscheme hybrid
