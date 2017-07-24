" Bail quickly if the plugin was loaded, disabled or compatible is set
if (exists("g:loaded_leanbuftabline") && g:loaded_leanbuftabline) || &cp
  finish
endif
let g:loaded_leanbuftabline = 1

function SwitchBuffer(bufnr, clicks, button, modifiers)
  exec 'buffer ' . a:bufnr
endfunction

function! Tabline()
  let s = ''
  for i in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let bufnr = i
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    if has('tablineat')
      let s .= '%' . bufnr . '@SwitchBuffer@'
    endif
    let s .= (bufnr == bufnr('%') ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . bufnr .' '
    let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')

    if bufmodified
      let s .= ' [+]'
    endif

    let s .= '%X '
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()
set showtabline=2
