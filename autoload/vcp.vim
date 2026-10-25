let s:root = expand('<sfile>:p:h:h')

function! s:template_names(dir) abort
  if !isdirectory(a:dir)
    return []
  endif

  let l:names = readdir(a:dir)
  call filter(l:names, {_, name ->
        \ name !~# '^\.' && filereadable(a:dir . '/' . name)})
  return sort(l:names)
endfunction

function! s:insert_templates(paths, ctx, winid, result) abort
  if a:result <= 0
    return
  endif

  let l:path = a:paths[a:result - 1]
  let l:bufnr = a:ctx.bufnr

  if !getbufvar(l:bufnr, '&modifiable')
    echohl ErrorMsg
    echomsg 'vcp: current buffer is not modifiable'
    echohl None
    return
  endif

  let l:lines = readfile(l:path)
  if empty(l:lines)
    return
  endif

  let l:is_empty = !getbufvar(l:bufnr, '&modified')
        \ && getbufline(l:bufnr, 1, '$') ==# ['']

  if l:is_empty
    call setbufline(l:bufnr, 1, l:lines)
    if l:bufnr == bufnr('%')
      call cursor(1, 1)
    endif
  else
    call appendbufline(l:bufnr, a:ctx.lnum, l:lines)
    if l:bufnr == bufnr('%')
      call cursor(a:ctx.lnum + 1, 1)
    endif
  endif
endfunction

function! s:resolve_dir() abort
  for l:var in ['vcp_dir', 'cp_templates_dir']
    let l:value = get(g:, l:var, '')
    if !empty(l:value)
      return expand(l:value)
    endif
  endfor
  return s:root . '/templates'
endfunction

function! vcp#open() abort
  if !has('popupwin')
    echohl ErrorMsg
    echomsg 'vcp: Vim with popupwin support is required'
    echohl None
    return
  endif

  let l:dir = s:resolve_dir()
  if !isdirectory(l:dir)
    echohl ErrorMsg
    echomsg 'vcp: directory does not exist: ' . l:dir
    echohl None
    return
  endif

  let l:names = s:template_names(l:dir)
  if empty(l:names)
    echohl WarningMsg
    echomsg 'vcp: no templates found in ' . l:dir
    echohl None
    return
  endif

  let l:paths = map(copy(l:names), {_, name -> l:dir . '/' . name})
  let l:ctx = {'bufnr': bufnr('%'), 'lnum': line('.')}
  let l:height = min([len(l:names),
        \ get(g:, 'vcp_height', get(g:, 'cp_templates_height', 15))])

  call popup_menu(l:names, {
        \ 'title': ' vCP ',
        \ 'height': l:height,
        \ 'callback': function('s:insert_templates', [l:paths, l:ctx]),
        \ })
endfunction
