""" Wordmatch
""" Bruce Scheibe
""" Highlight matches to the word under cursor. Useful for seeing variable and name usage.


let g:cursor_word_match=1
let g:max_filesize=300000 " Default to 300KB


" Vim commands
ab wordmatch call ToggleWordmatching()
ab maxwordmatch call SetMaxFilesize()

" Colors to be used
hi MyMatch ctermbg=yellow ctermfg=white guidb=darkgreen guifg=white term=underline cterm=bold,underline


autocmd CursorMoved * call HighlightWordmatch()


if has("gui_running")
        amenu Wordmatch.Toggle\ Wordmatching :call ToggleWordMatching()<CR>
        amenu Wordmatch.Adjust\ Max\ Filesize :call SetMaxFilesize()<CR>
endif


" Perform matching after checking against a maximum filesize.
" The regex work to find matches slows Vim down a great deal 
" when viewing large files or raw data.
function! HighlightWordmatch()
        if g:cursor_word_match == 1
                if g:max_filesize > line2byte('$')
                        exe printf('match MyMatch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
                endif
        endif
endfunction


function! ToggleWordMatching()
        let g:cursor_word_match=!g:cursor_word_match
        match
        call HighlightWordmatch()
endfunction


function! setMaxFilesize()
        let g:max_filesize=1000*input('Enter a new maximum filesize for wordmatching (kilobytes): ')
endfunction
