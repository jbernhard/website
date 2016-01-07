" rebuild on file write
autocmd BufWritePost * !make --no-print-directory --directory '<sfile>:p:h'
