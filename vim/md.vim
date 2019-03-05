au FileType mkd setlocal textwidth=120
au FileType mkd setlocal wrap linebreak nolist spell
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

let g:markdown_fenced_languages = ['javascript', 'html', 'vim', 'json', 'diff', 'scala']
let g:vim_markdown_fenced_languages = ['javascript=js', 'html=html', 'json=json', 'scala=scala']
