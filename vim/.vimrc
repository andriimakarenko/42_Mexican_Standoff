" ************************************************************************** "
"                                                                            "
"                                                        :::      ::::::::   "
"   .vimrc                                             :+:      :+:    :+:   "
"                                                    +:+ +:+         +:+     "
"   By: amakaren <marvin@42.fr>                    +#+  +:+       +#+        "
"                                                +#+#+#+#+#+   +#+           "
"   Created: 2019/05/09 23:15:46 by amakaren          #+#    #+#             "
"   Updated: 2019/05/09 23:15:46 by amakaren         ###   ########.fr       "
"                                                                            "
" ************************************************************************** "

"Personal preferences
set nu
syntax on
set statusline+=File:\ %F
set colorcolumn=81
hi ColorColumn ctermbg=green guibg=green
nmap <Space> <PageDown>

"C code indent
set cindent
set tabstop=4

"Autoclose parenthesis
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap < <><Esc>i
inoremap { {<Return><Tab><BS>}<Esc>ko<Tab>

"Display the cursor column
set statusline+=,\ Col:\ %c

"Highlighting
highlight ExtraSpaces ctermbg=red guibg=red
match ExtraSpaces '\(^["#/].*\)\@<!\ \{2,}'
autocmd BufWinEnter * syn match WSend excludenl /\s\+$/
autocmd InsertEnter * syn match WSend excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn match WSend excludenl /\s\+$/
highlight WSend ctermbg=red guibg=red

"Backups
silent !mkdir -p ~/.vim/.backup
set backup
set backupdir=~/.vim/.backup//

"Header
noremap <C-c><C-h> :call PutHeader()<CR>
autocmd BufWritePre *.c :call UpdateIfChanged()

function! Update()
	if &modified
		 return 0
	endif
	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let updated = "/* Updated: " . date . " " . hour . " by " . "amakaren"
	let i = 17 - 8
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "### ########.fr       */"
	call setline(9, updated)
endfunction

function! UpdateIfChanged()
	if exists(v:fcs_reason)
		if (v:fcs_reason == 'changed')
			call Update()
		endif
	endif
endfunction

function! GenerateHeader()
	let filename = expand('%:t')
	let author = "amakaren" . " <"
	if exists($MAIL)
		let author = author . ($MAIL)
	else
		let author = author . "marvin@42.fr"
	endif
	let author = author . ">"
	let distance_8 = 55 - 37 - 8
	let h1 = "/* ************************************************************************** */"
	let h2 = "/*                                                                            */"
	let h3 = "/*                                                        :::      ::::::::   */"
	let h4 = "/*   " . filename
	let i = 51 - strwidth(filename)
	while i > 0
		let h4 = h4 . " "
		let i = i - 1
	endwhile
	let h4 = h4 . ":+:      :+:    :+:   */"
	let h5 = "/*                                                    +:+ +:+         +:+     */"
	let h6 = "/*   By: " . author
	let i = 43 - strwidth(author)
	while i > 0
		let h6 = h6 . " "
		let i = i - 1
	endwhile
	let h6 = h6 . "+#+  +:+       +#+        */"
	let h7 = "/*                                                +#+#+#+#+#+   +#+           */"
	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let created = date . " " . hour
	let h8 = "/*   Created: " . created . " by " . "amakaren"
	let i = distance_8
	while i > 0
		let h8 = h8 . " "
		let i = i - 1
	endwhile
	let h8 = h8 . "#+#    #+#             */"
	let i = distance_8 - 1
	let h9 = "/*   Updated: " . created . " by " . "amakaren"
	while i > 0
		let h9 = h9 . " "
		let i = i - 1
	endwhile
	let h9 = h9 . "###   ########.fr       */""
	let h10 = "/*                                                                            */"
	let h11 = "/* ************************************************************************** */"
	let headerlist = [h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11]
	return (headerlist)
endfunction

function Strcmp(str1, str2)
	if a:str1 <# a:str2
		return -1
	elseif a:str1 ==# a:str2
		return 0
	else
		return 1
	endif
endfunction

function PutHeader()
	let newheader = GenerateHeader()
	let h1 = get(newheader, 0, 'Cannot read line 1')
	let h2 = get(newheader, 1, 'Cannot read line 2')
	let h3 = get(newheader, 2, 'Cannot read line 3')
	let h4 = get(newheader, 3, 'Cannot read line 4')
	let h5 = get(newheader, 4, 'Cannot read line 5')
	let h6 = get(newheader, 5, 'Cannot read line 6')
	let h7 = get(newheader, 6, 'Cannot read line 7')
	let h8 = get(newheader, 7, 'Cannot read line 8')
	let h9 = get(newheader, 8, 'Cannot read line 9')
	let h10 = get(newheader, 9, 'Cannot read line 10')
	let h11 = get(newheader, 10, 'Cannot read line 11')
	let oh1 = getline(1)
	let oh2 = getline(2)
	let oh3 = getline(3)
	let oh4 = getline(4)
	let oh5 = getline(5)
	let oh6 = getline(6)
	let oh7 = getline(7)
	let oh8 = getline(8)
	let oh9 = getline(9)
	let oh10 = getline(10)
	let oh11 = getline(11)
	if ((Strcmp(h1, oh1) == 0) && (Strcmp(h2, oh2) == 0) && (Strcmp(h3, oh3) == 0)
\	&& (Strcmp(h4, oh4) == 0) && (Strcmp(h5, oh5) == 0) && (Strcmp(h6, oh6) == 0)
\	&& (Strcmp(h7, oh7) == 0) && (Strcmp(h10, oh10) == 0) && (Strcmp(h11, oh11) == 0))
		return 0
	endif
	call append(0, h1)
	call append(1, h2)
	call append(2, h3)
 	call append(3, h4)
	call append(4, h5)
	call append(5, h6)
	call append(6, h7)
	call append(7, h8)
	call append(8, h9)
	call append(9, h10)
	call UpdateIfChanged()
	call append(10, h11)
	call append(11, "")
endfunction
