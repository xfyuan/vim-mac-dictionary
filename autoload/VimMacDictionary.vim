let s:BUFFER_NAME = '-VIM-MAC-DICTIONARY-'

function! s:open()
    if bufexists(s:BUFFER_NAME)
        let dictwin = bufwinnr(s:BUFFER_NAME)
        if dictwin == -1
            execute "sbuffer " . bufnr(s:BUFFER_NAME)
        else
            execute dictwin . ' wincmd w'
        endif
    else
        execute "new " . s:BUFFER_NAME
    setlocal ft=vimmacdictionary
    endif

    normal! gg0dG
endfunction

let s:plugindir = expand('<sfile>:p:h:h')

function! s:isUsePopup()
    if !exists('g:vim_mac_dictionary_use_popup')
        return v:true
    endif
    return g:vim_mac_dictionary_use_popup == 1
endfunction

function! s:isUseBuffer()
    if !exists('g:vim_mac_dictionary_use_buffer')
        return v:true
    endif
    return g:vim_mac_dictionary_use_buffer == 1
endfunction

function! s:isUseFormat()
    if !exists('g:vim_mac_dictionary_use_format')
        return v:true
    endif
    return g:vim_mac_dictionary_use_format == 1
endfunction

function! s:isUseApp()
    if !exists('g:vim_mac_dictionary_use_app')
        return v:false
    endif
    return g:vim_mac_dictionary_use_app == 1
endfunction

function! s:printBuffer(result)
    silent call s:open()
    silent call s:setLocalSetting()
    silent call setline(1, a:result)

    if s:isUseFormat()
        silent! %s/\v\.\s(\S+)1\./.\r\1\r  1./g
        silent! %s/\v(\S+\s*)(1\.)/\1\r  \2/g
        silent! %s/\v(\d+\.)/\r  \1/g
        silent! %s/\v(\D\.)/\1\r/g
        silent! %s/\v\s?▸/\r    ▸/g
        silent! %g/^\s*$/d
        silent! %s/\%x00//g
    endif

    silent normal! gg

    let lastLine = 1 + line('$')
    echom lastLine
    if lastLine <= 10
        execute "resize " . lastLine
    else
        resize 10
    endif

    return
endfunction

function! s:printPopup(result)
    let x = substitute(a:result, '\v.*(swift|Consumed)', '', 'g')
    let x = substitute(x, '\v(.*)extension(.*)', '\1\2', 'g')
    let x = substitute(x, '\v\.\s(\S+)1\.', '.\r\1\r  1.', 'g')
    let x = substitute(x, '\v(\S+\s*)(1\.)', '\1\r  \2', 'g')
    let x = substitute(x, '\v(\d+\.)', '\r  \1', 'g')
    let x = substitute(x, '\v(\D\.)', '\1\r', 'g')
    let x = substitute(x, '\v\s?▸', '\r    ▸', 'g')
    let x = substitute(x, '\%x00', '', 'g')

    let whole = filter(split(x, "\r"), 'len(v:val)!=0')
    let content = []
    call map(whole, {_,l -> extend(content, split(l, '.\{60}\zs'))})

    let opts = {"close":"button", "title":"Mac Dictionary"}
    let g:quickui_color_scheme = 'borland'
    call quickui#textbox#open(content, opts)
    return
endfunction

function! VimMacDictionary#find(word)

    let l:result = system(s:plugindir . "/dictionary.swift " . a:word)

    if s:isUseApp()
        silent! call system('open dict://"' . a:word . '"')
        return
    endif
    if s:isUseBuffer()
        call s:printBuffer(l:result)
        return
    endif

    echo l:result
endfunction

function! VimMacDictionary#popup(word)

    let l:result = system(s:plugindir . "/dictionary.swift " . a:word)

    if s:isUsePopup()
        call s:printPopup(l:result)
        return
    endif

    echo l:result
endfunction

function! s:setLocalSetting()

    setlocal bufhidden=wipe
    setlocal buftype=nofile
    setlocal buftype=nowrite
    setlocal noswapfile
    setlocal listchars=
    setlocal laststatus=2
    setlocal fileencodings=utf-8
    setlocal lazyredraw
    setlocal nofoldenable
    syntax on

    retab
endfunction

