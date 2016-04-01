" Send selection to MARI
" Last Change:	2016 Apr 01
" Maintainer:	Michitaka Inoue
" License:	This vim script is placed in the public domain.


if exists("g:loaded_vtom")
  finish
endif
let g:loaded_typecorr = 1

let s:save_cpo = &cpo
set cpo&vim

let $VIMTOMARI_LOCATION = expand('<sfile>:p:h')

function! RunMariPython()
python << EOF
import vim, sys
if vim.eval("$VIMTOMARI_LOCATION") in sys.path:
    pass
else:
    sys.path.append(vim.eval("$VIMTOMARI_LOCATION"))
import vtomri
reload(vtomri)
cmd = vtomri.getCmd(vim.eval("$VIMTOMARI_LOCATION"))
vtomri.send(cmd)
EOF
endfunction

function! SendToMari() range
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  try
    '<,'>w! $VIMTOMARI_LOCATION/tmpScript.py
  catch
    echo "Failed to save tmp file"
  endtry
  try
    call RunMariPython()
  catch
    echo "failed to run python script"
  endtry
endfunction

let &cpo = s:save_cpo
