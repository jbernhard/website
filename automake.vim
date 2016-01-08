" save path
let s:root_dir = expand('<sfile>:p:h')

" run make, print output only if error
function s:Make()
  let l:output = system('make -C ' . s:root_dir)
  if v:shell_error
    echo l:output
  endif
endfunction

" rebuild on file write
autocmd BufWritePost * call s:Make()
