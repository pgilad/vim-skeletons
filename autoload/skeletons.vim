scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" taken from https://github.com/Shougo/neomru.vim/blob/master/autoload/neomru.vim
function! skeletons#setDefault(var, val, ...)  "{{{
    if !exists(a:var)
        let alternate_var = get(a:000, 0, '')
        let {a:var} = exists(alternate_var) ? {alternate_var} : a:val
    endif
endfunction "}}}

function! skeletons#skeletonsOn()
    augroup skeletons
        autocmd!
        autocmd BufNewFile * call skeletons#InsertSkeleton()
    augroup END
endfunction

let s:defaults = {
            \ 'skeletonsDir': ['~/.vim/skeletons'],
            \ 'autoRegister' : 0,
            \ 'skeletonGlob': '/skeleton.*'
            \ }

call skeletons#setDefault('g:skeletons#skeletonsDir', s:defaults.skeletonsDir)
call skeletons#setDefault('g:skeletons#autoRegister', s:defaults.autoRegister)
call skeletons#setDefault('g:skeletons#skeletonGlob', s:defaults.skeletonGlob)

let s:skeletons = {
            \ 'candidates' : {},
            \ 'skeletonsDir': g:skeletons#skeletonsDir,
            \ 'autoRegister': g:skeletons#autoRegister,
            \ 'skeletonGlob' : g:skeletons#skeletonGlob,
            \ 'loaded' : 0
            \ }

function! s:skeletons.getType(file)
    if fnamemodify(a:file, ':e:e') =~ '\.'
        return fnamemodify(a:file, ':e:e:r')
    else
        return 'default'
    endif
endfunc

function! s:skeletons.getExt(file)
    return fnamemodify(a:file, ':e')
endfunc

function! s:skeletons.registerSkeleton(file)
    let fileExt = self.getExt(a:file)
    if !has_key(self.candidates, fileExt)
        let self.candidates[fileExt] = []
    endif
    call add(self.candidates[fileExt], a:file)
endfunc

function! s:skeletons.registerSkeletons()
    let self.loaded = 1
    "if directory is a string - make it a list
    if type(self.skeletonsDir) == type("")
        let self.skeletonsDir = [self.skeletonsDir]
    endif

    " iterate every skeletons dir
    for skelDir in self.skeletonsDir
        " get all files in skeleton dir
        let l:files = split(glob(skelDir . self.skeletonGlob, "\n"))
        for l:file in l:files
            call self.registerSkeleton(l:file)
        endfor
    endfor
endfunc

function! s:skeletons.chooseSkeleton(fileExt)
    if !has_key(self.candidates, a:fileExt)
        " No skeleton for this filetype
        return 0
    endif
    let skeletonsList = self.candidates[a:fileExt]
    if len(skeletonsList) == 0
        return 0
    elseif len(skeletonsList) == 1
        return skeletonsList[0]
    else
        " gather types
        let types = []
        for type in skeletonsList
            call add(types, self.getType(type))
        endfor

        " ask user for which type to use
        let mappedTypes = map(copy(types), '"&" . v:val')
        let choice = confirm("Select the skeleton type for " . a:fileExt, join(mappedTypes, "\n"), 1, "Question")
        return skeletonsList[choice - 1]
    endif
endfunc

function! s:skeletons.insertSkeleton()
    if !self.loaded
        call self.registerSkeletons()
    endif
    " grab file extension of current new file
    let fileExt = expand('%:e')
    let skeletonFile = self.chooseSkeleton(fileExt)
    if len(skeletonFile)>0 && filereadable(skeletonFile)
        let l:snippet = join(readfile(skeletonFile), "\n")
        " TODO: handle no UltiSnips
        call UltiSnips#Anon(l:snippet)
    else
        " empty dictionary for filetype or error
    endif
endfunc

function! skeletons#registerSkeletons()
    call s:skeletons.registerSkeletons()
endfunc

function! skeletons#InsertSkeleton()
    call s:skeletons.insertSkeleton()
endfunc

let &cpo = s:save_cpo
unlet s:save_cpo
