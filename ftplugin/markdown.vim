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
	let ofilename = "markdown-preview.md"
	let nfilename = "markdown-preview.html"
	if has('mac') || has('macunix')
		call writefile(text, "/tmp/" . ofilename)
		call system("multimarkdown /tmp/" . ofilename . " > /tmp/" . nfilename)
		call system("open /tmp/" . nfilename)
	elseif has('unix')
		call writefile(text, "/tmp/" . ofilename)
		call system("multimarkdown /tmp/" . ofilename . " > /tmp/" . nfilename)
		call system("gnome-open /tmp/" . nfilename)
	elseif has('win32') || has('win64') || has('win16')
		let s:vimtmp = $appdata . "\\vim\\tmp"
		if isdirectory(s:vimtmp) == 'FALSE'
			call system("mkdir " . s:vimtmp)
		endif
		call writefile(text, $appdata . '\vim\tmp\' . ofilename)
		call system('multimarkdown "' . $appdata . '\vim\tmp\' . ofilename . '" -o "' . $appdata . '\vim\tmp\' . nfilename . '"')
		call system('"' . $appdata . '\vim\tmp\' . nfilename . '"')
	endif
endfunction

command! -range=% MarkdownPreview call s:ShowMarkdownPreview(<line1>, <line2>)
command! -range=% MdP call s:ShowMarkdownPreview(<line1>, <line2>)
