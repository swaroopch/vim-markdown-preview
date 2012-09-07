" Language: Markdown
" Maintainer: Swaroop C H <swaroop@swaroopch.com>
" URL: https://github.com/swaroopch/vim-markdown-preview
" License: WTFPL
" Dependencies: http://fletcherpenney.net/multimarkdown/

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
		call writefile(text, $vimruntime . '\tmp\' . ofilename)
		call system('multimarkdown "' . $vimruntime . '\tmp\' . ofilename . '" -o "' . $vimruntime . '\tmp\' . nfilename . '"')
		call system("powershell start '" . $vimruntime . '\tmp\' . nfilename . "'")
	endif
endfunction

command! -range=% MarkdownPreview call s:ShowMarkdownPreview(<line1>, <line2>)