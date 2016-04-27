let s:save_cpo = &cpo
set cpo&vim

let s:emoji_path = expand('<sfile>:p:h:h') . '/emoji.json'
let s:emoji_inited = 0

func! s:init_emojis_once()
  if s:emoji_inited
    return
  endif
  unlet! s:emojis
  let s:emojis = []
  for emoji in eval( join( readfile( s:emoji_path ), '' ) )
    if !has_key( emoji, 'emoji' )
      continue
    endif
    for alias in emoji['aliases']
      call add( s:emojis, s:emoji_to_candidate( emoji, alias ) )
    endfor
  endfor
  let s:emoji_inited = 1
endfunc

func! s:emoji_to_candidate( emoji, alias )
  return {
  \ 'emoji' : a:emoji['emoji'],
  \ 'word' : a:alias,
  \ 'kind' : a:emoji['emoji'] . ' ',
  \ 'menu' : a:emoji['description'],
  \ 'icase' : 1,
  \ 'dup' : 1,
  \ }
endfunc

func! emoji_complete#complete()
  if v:version < 704
    echomsg 'emoji_complete: Sorry, this plug-in requires VIM verson 7.4 or above.'
    return ""
  endif
  call s:init_emojis_once()
  " The text from the beginning of the line up until before the cursor.
  let line = getline('.')[ : col('.')-2]
  let s:complete_start = match(line, '\(-1\|+1\|[-a-zA-Z0-9_]*\)$')
  if s:complete_start >= 0
    augroup emoji_complete_done
      au!
      au CompleteDone <buffer> call s:emoji_expand()
    augroup end
    let prefix = line[s:complete_start : ]
    let matches = []
    for emoji in s:emojis
      if emoji['word'] =~? '^' . prefix
        call add( matches, emoji )
      endif
    endfor
    call complete( s:complete_start+1, matches )
    return ""
  endif
  return ""
endfunc

func! s:emoji_expand()
  augroup emoji_complete_done
    au!
  augroup end
  let line = getline('.')
  if s:complete_start > 0
    let pre = line[ : s:complete_start-1 ]
  else
    let pre = ''
  endif
  let query = line[ s:complete_start : col('.')-2 ]
  let post = line[ col('.')-1 : ]
  for emoji in s:emojis
    if query == emoji['word']
      call setline( line('.'), pre . emoji['emoji'] . post )
      call cursor( line('.'), len( pre . emoji['emoji'] ) + 1 )
      return
    endif
  endfor
endfunc

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:et:ts=2 sts=2 sw=2
