if exists('g:loaded_emoji_complete')
  finish
endif

inoremap <silent> <Plug>(emoji-start-complete) <c-r>=emoji_complete#complete()<cr>

if get( g:, 'emoji_complete_overwrite_standard_keymaps', 1 )
  imap <c-x><c-e> <Plug>(emoji-start-complete)
endif

let g:loaded_emoji_complete = 1

" vim:et:ts=2 sts=2 sw=2
