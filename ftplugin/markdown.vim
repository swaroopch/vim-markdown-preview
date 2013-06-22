" Language: Markdown
" Maintainer: Swaroop C H <swaroop@swaroopch.com>
" URL: https://github.com/swaroopch/vim-markdown-preview
" License: WTFPL
" Dependencies: http://fletcherpenney.net/multimarkdown/

if exists("b:loaded_markdown_preview")
	finish
endif
let b:loaded_markdown_preview = 1


function! s:ShowMarkdownPreview(line1, line2)
	let text = getline(a:line1, a:line2)

	" Set names for temp files.
	let mkdfile = "markdown-preview.md"
	let htmfile = "markdown-preview.html"

	if has('unix')
		" Set path to temp files.
		let mkdfile = "/tmp/" . mkdfile
		let htmfile = "/tmp/" . htmfile

		" Convert Markdown to HTML.
		call writefile(text, mkdfile)
		if has('win32unix')
			call system("multimarkdown c:/cygwin" . mkdfile . " > c:/cygwin" . htmfile)
		else
			call system("multimarkdown " . mkdfile . " > " . htmfile)
		endif

		" Open HTML.
		if has('mac') || has('macunix')
			call system("open " . htmfile)
		elseif has('win32unix')
			call system("cygstart " . htmfile)
		else
			call system("xdg-open " . htmfile)
		endif

	elseif has('win32') || has('win64')
		let mkdfile = $temp . "\\" . mkdfile
		let htmfile = $temp . "\\" . htmfile

		" Convert Markdown to HTML.
		call writefile(text, mkdfile)
		call system('multimarkdown "' . mkdfile . '" -o "' . htmfile . '"')

		" Open HTML.
		call system('"' . htmfile . '"')
	endif
endfunction


command! -range=% MarkdownPreview call s:ShowMarkdownPreview(<line1>, <line2>)
command! -range=% MdP call s:ShowMarkdownPreview(<line1>, <line2>)
