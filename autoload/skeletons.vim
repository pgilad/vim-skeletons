scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

func! s:GetType(file)
    if fnamemodify(a:file, ':e:e') =~ '\.'
        return fnamemodify(a:file, ':e:e:r')
    else
        return 'default'
    endif
endfunc

func! s:GetExt(file)
    return fnamemodify(a:file, ':e')
endfunc

func! s:RegisterSkeleton(file)
    let fileExt = s:GetExt(a:file)
    if !has_key(g:skeletons, fileExt)
        let g:skeletons[fileExt] = []
    endif
    call add(g:skeletons[fileExt], a:file)
endfunc

func! skeletons#RegisterSkeletons()
    " get all files in skeleton dir
    let l:files = split(glob(g:skeletons.skeletonsDir . "/skeleton.*"), "\n")
    for l:file in l:files
        call s:RegisterSkeleton(l:file)
    endfor
endfunc

func! skeletons#ChooseSkeleton(fileExt)
    if !has_key(g:skeletons, a:fileExt)
        " No skeleton for this filetype
        return 0
    endif
    let skeletonsList = g:skeletons[a:fileExt]
    if len(skeletonsList) == 0
        return 0
    elseif len(skeletonsList) == 1
        return skeletonsList[0]
    else
        " gather types
        let types = []
        for type in skeletonsList
            call add(types, s:GetType(type))
        endfor

        " ask user for which type to use
        let mappedTypes = map(copy(types), '"&" . v:val')
        let choice = confirm("Select the skeleton type for " . a:fileExt, join(mappedTypes, "\n"), 1, "Question")
        return skeletonsList[choice - 1]
    endif
endfunc

func! skeletons#InsertSkeleton()
    " grab file extension of current new file
    let fileExt = expand('%:e')
    let skeletonFile = skeletons#ChooseSkeleton(fileExt)
    if len(skeletonFile)>0 && filereadable(skeletonFile)
        let l:snippet = join(readfile(skeletonFile), "\n")
        call UltiSnips#Anon(l:snippet)
    else
        " empty dictionary for filetype or error
    endif
endfunc

let &cpo = s:save_cpo
unlet s:save_cpo
