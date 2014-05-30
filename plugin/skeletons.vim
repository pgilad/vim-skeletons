"early exit if loaded
if exists("skeletons#loaded")
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! SkeletonsReload call skeletons#RegisterSkeletons()

" hook to buffer new to create skeletons
augroup skeletons
    autocmd!
    autocmd BufNewFile * call skeletons#InsertSkeleton()
augroup END

"set script as loaded
let skeletons#loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo
