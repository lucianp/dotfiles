augroup filetypedetect
" vim-orgmode
au BufNewFile,BufRead *.org setlocal ft=org
" Promela
au BufNewFile,BufRead *.promela,*.prm setlocal ft=promela
" Markdown
au BufNewFile,BufRead *.md,*.mdown setlocal ft=markdown
" Atlassian Confluence Wiki
au BufNewFile,BufRead *.confluencewiki,*.cfwiki setlocal ft=confluencewiki
" PL/SQL
au BufNewFile,BufRead *.psql,*.plsql setlocal ft=plsql
" Java Server Pages Fragment
au BufNewFile,BufRead *.jspf setlocal ft=jsp
" TWiki - the Open Source Enterprise Wiki and Web Application Platform
au BufNewFile,BufRead *.twiki setlocal ft=twiki
augroup END
