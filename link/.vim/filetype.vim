augroup filetypedetect
" Promela
au BufNewFile,BufRead *.promela,*.prm setlocal ft=promela
" Markdown
au BufNewFile,BufRead *.md,*.mdown setlocal ft=markdown
" Atlassian Confluence Wiki
au BufNewFile,BufRead *.confluencewiki,*.cfwiki setlocal ft=confluencewiki
augroup END
