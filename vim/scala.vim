 autocmd BufWritePost *.scala silent :EnTypeCheck
 nnoremap <localleader>t :EnType<CR>
 au FileType scala nnoremap <localleader>df :EnDeclaration<CR>
 
