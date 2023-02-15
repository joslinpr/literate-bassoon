#	Book of Knowledge
##	VimTricks.md
##	Vim Tips and Tricks

###	Using Vim as a Pipe:
```
vim - -es +'g/foo/p' +'qa!' --not-a-term
vim < /dev/tty <(cat)
```

###	Simple Math
```
CTRL-A - increment number under cursor
CTRL-X - decrement number under cursor
```

###	Bouncing
```
Matchit - use g% to find next/previous match
          use % to find match to construct under cursor (if, (, ), {, } etc.
```

###	Checking Variables
```
:verbose set variable?
OR
:echo "Variable:" &variable
```

### Changing Case
```g<change><motion>```
> g = go
> *change* = U Upper, u Lower, ~ Invert
> Doubled *change* means "entire line"
> *motion* = G end of Document, j Line Above, w Word

> Examples:
>  ~    : Changes the case of current character
>  guu  : Change current line from upper to lower.
>  gUU  : Change current LINE from lower to upper.
>  guw  : Change to end of current WORD from upper to lower.
>  guaw : Change all of current WORD to lower.
>  gUw  : Change to end of current WORD from lower to upper.
>  gUaw : Change all of current WORD to upper.
>  g~~  : Invert case to entire line
>  g~w  : Invert case to current WORD
>  guG  : Change to lowercase until the end of document.
>  gU)  : Change until end of sentence to upper case
>  gu}  : Change to end of paragraph to lower case
>  gU5j : Change 5 lines below to upper case
>  gu3k : Change 3 lines above to lower case

[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
