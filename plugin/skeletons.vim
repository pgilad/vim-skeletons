"early exit if loaded
if exists("g:skeletons.loaded")
    finish
endif

let s:defaults = {
            \ 'skeletonsDir': '~/.vim/skeletons',
            \ 'autoRegister' : 1,
            \ 'skeletonGlob': '/skeleton.*'
            \}

" get global var or make a new one
let g:skeletons = get(g:, "skeletons", {})

" set skeletons dir
if !exists("g:skeletons.skeletonsDir")
    let g:skeletons.skeletonsDir = expand(s:defaults.skeletonsDir)
endif

" should skeletons auto register file types
if !exists("g:skeletons.autoRegister")
    let g:skeletons.autoRegister = s:defaults.autoRegister
endif

command! SkeletonsReload call skeletons#RegisterSkeletons()

"register skeletons
call skeletons#RegisterSkeletons()
"set script as loaded
let g:skeletons.loaded = 1

if g:skeletons.autoRegister
    augroup skeletons_autoregister
        autocmd!
        autocmd BufNewFile * call skeletons#InsertSkeleton()
    augroup END
endif
