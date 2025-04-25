
# The Book of Knowledge

## VimTables.md

## Working with Markdown Tables in Vim

``` code

These macros assume a Markdown table in the following format.
1. Header Line
2. Table Description Line
   - Any Easy Way To Create This:
      - Put cursor on Header Line
      - `:.t.` To Duplicate It
      - `:s/[^|]/-/g` To Replace All Non-Pipes With '-'.
3. One Or More Table Lines

Each line must begin and end with the Pipe character (|).

| Header1 | Header2 |
|----|-|
| Col1 Item1 | Col2 Item1 |
| Col1  Item2 |    Col2 Item2 |

After running \ta:

| Header1    | Header2    |
|------------|------------|
| Col1 Item2 | Col2 Item2 |
| Col1 Item1 | Col2 Item1 |

```

Note that either is a valid Markdown table.  The Second example is more readable.

Include the following in your .vimrc.

| Command | Effect                                          |
|---------|-------------------------------------------------|
| \\tx    | Pretty Print Markdown-Style Tables, No Sort     |
| \\ta    | Fancier Table Cleanup - Sorted By Reverse Col 1 |

``` vim

" \ta Fancier Table Cleanup - sort -r
function! CleanMDTable()
   normal! :set cmdheight=4
   normal! vip:s@[-]\{5,\}@-----@ge
   normal! vip:s@\s\+@ @ge
   ?|---?+1,/^$/!sort -r
   ?|---
   normal! vip
   '<,'>!column -c 200 -t -W 4 -s '|' -o '|'
   normal! vip
   ?----?s![^|-]!-!g
   nohlsearch
   normal! 
   normal! :set cmdheight=1
endfunction
map <silent> <Leader>ta :call CleanMDTable()<CR>
" \tc TitleCase Line
nnoremap <silent> <Leader>tc :.s/\([- ][a-z]\)/\U\1/ge<CR>:.s/^\([a-z]\)/\U\1/e<CR>:noh<CR>
" \tf Format Paragraph
map <Leader>tf vip<CR>!fmt -u<CR>`{<CR>
" \tr Renumber Paragraph
map <Leader>tr :perl $a=0<CR>vip:perldo s/^\d+/++$a/e<CR>
" \ts Toggle Spelling
map <silent><Leader>ts :setlocal spell!<CR>
" \tx Pretty Print Markdown-Style Tables, No Sort
map <Leader>tx vip:s@[-]\{5,\}@----@ge<CR>vip:s/\s\+/ /ge<CR>vip!column -c 200 -t -s "\|" -o "\|"<CR>/----<CR>:.s/[^\|]/-/g<CR>:noh<CR>
" \tw TitleCase Word
nnoremap <silent><Leader>tw gUllguwb

" \xs trims spaces at end of line
nnoremap <silent><Leader>xs :%s/\s\+$//e<CR>

```

| Command | Effect                      |
|---------|-----------------------------|
| \\xs    | Trims Spaces At End Of Line |
| \\tw    | TitleCase Word              |
| \\ts    | Toggle Spelling             |
| \\tr    | Renumber Paragraph          |
| \\tf    | Format Paragraph            |
| \\tc    | TitleCase line              |
