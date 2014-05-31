"early exit if loaded
if exists("skeletons#loaded")
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

function! s:skeletonsAutoRegister
    " hook to buffer new to create skeletons
    augroup skeletons
        autocmd!
        autocmd BufNewFile * call skeletons#InsertSkeleton()
    augroup END
endfunc

if skeletons#autoRegister
    call s:AutoRegister()
endif

command! SkeletonsReload call skeletons#RegisterSkeletons()
command! SkeletonsOn call s:skeletonsAutoRegister()
command! SkeletonsOff autocmd! skeletons

"set script as loaded
let skeletons#loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo
