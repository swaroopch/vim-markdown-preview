" Language: Markdown
" Maintainer: Swaroop C H <swaroop@swaroopch.com>
" URL: https://github.com/swaroopch/vim-markdown-preview
" License: WTFPL
" Dependencies: http://fletcherpenney.net/multimarkdown/

if exists("b:loaded_markdown_preview")
    finish
endif

let b:loaded_markdown_preview = 1

function! s:open_file(filename)
    if has('mac') || has('macunix')
        call system("open " . fnameescape(a:filename))
    elseif has('unix')
        call system("gnome-open " . fnameescape(a:filename))
    endif
endfunction

function! s:ShowMarkdownPreview(line1, line2)
    let text = getline(a:line1, a:line2)
    let output_text_filename = "/tmp/markdown-preview.md"
    let output_html_filename = "/tmp/markdown-preview.html"
    call writefile(text, output_text_filename)
    call system("multimarkdown " . output_text_filename . " > " . output_html_filename)
    call s:open_file(output_html_filename)
endfunction

command! -range=% MarkdownPreview call s:ShowMarkdownPreview(<line1>, <line2>)
