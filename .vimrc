" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: amakaren <marvin@42.fr>                    +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2018/12/15 15:01:17 by amakaren          #+#    #+#              "
"    Updated: 2018/12/16 06:56:18 by amakaren         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"Personal preferences
set nu
syntax on
set statusline+=File:\ %F
set colorcolumn=81
hi ColorColumn ctermbg=blue guibg=blue
nmap <Space> <PageDown>

"C code indent
set cindent

"Autoclose parenthesis
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap < <><Esc>i
inoremap { {<Tab><Return><BS>}<Esc>ko

"Display the cursor column
set statusline+=,\ Col:\ %c

"Highlighting
highlight ExtraSpaces ctermbg=red guibg=red
match ExtraSpaces "\ \{2,}"
autocmd BufWinEnter * syn match WSend excludenl /\s\+$/
autocmd InsertEnter * syn match WSend excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn match WSend excludenl /\s\+$/
highlight WSend ctermbg=red guibg=red

"Backups
silent !mkdir -p ~/.vim/.backup
set backup
set backupdir=~/.vim/.backup//

"Header
imap <C-c><C-h>:call PutHeader()<CR>
autocmd BufWritePre *.c :call Update()
autocmd BufNewFile *.c :call Header()

function! Update()
 	if &modified
		return 0
	endif
	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let updated = "/* Updated: " . date . " " . hour . " by " . $USER
	let i = 17 - strwidth($USER)
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "### ########.fr       */"
	call setline(9, updated)
endfunction

function! GenerateHeader()
	let filename = 
	let author = 
	let created =
	let distance_8 = 55 - 37 - strwidth(author)
	let h1 = "/* ************************************************************************** */"
	let h2 = "/*                                                                            */"
	let h3 = "/*                                                        :::      ::::::::   */"
	let h4 =
	let h5 = "/*                                                    +:+ +:+         +:+     */"
	let h6 =
	let h7 = "/*                                                +#+#+#+#+#+   +#+           */"
	let i = distance_8
	let h8 = "/*   Created: " . created . " by " . $USER
	while i > 0
		h8 = h8 . " "
		i = i - 1
	endwhile
	h8 = h8 . "#+#    #+#             */"
	i = distance_8 - 1
	let h9 = "/*   Updated: " . created . " by " . $USER
 	while i > 0
		h8 = h8 . " "
		i = i - 1
	endwhile
	h9 = h9 . "###   ########.fr       */""
	call Udpate()
	let h10 = "/*                                                                            */"
	let h11 = "/* ************************************************************************** */"
endfunction
