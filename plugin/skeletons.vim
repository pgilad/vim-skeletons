"early exit if loaded
if exists("skeletons#loaded")
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

if skeletons#autoRegister
    call skeletons#skeletonsOn()
endif

command! SkeletonsReload call skeletons#RegisterSkeletons()
command! SkeletonsOn call skeletons#skeletonsOn()
command! SkeletonsOff autocmd! skeletons

"set script as loaded
let skeletons#loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo
