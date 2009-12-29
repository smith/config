" Plugin to run a "lint" command based on the file type
" Author: Nathan L Smith <nlloyds@gmail.com>

" Distributable under the same terms as Vim itself (see :help license)

command! -range Lint <line1>,<line2>call s:Lint()
command! LintClear call s:LintClear()

" TODO: Ranges
function! s:Lint()
  if &filetype == "php"
    exe "PHPLint"
  elseif &filetype == "javascript"
    exe "JSLint"
    " TODO: JavaScript lint also
  else
    echo "No Lint program available for the" &filetype "filetype."
  endif
endfunction

function! s:LintClear()
  if &filetype == "php"
    exe "PHPLintClear"
  elseif &filetype == "javascript"
    exe "JSLintClear"
    exe "JavaScriptLintClear"
  endif
endfunction
