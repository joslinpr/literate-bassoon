# The Book of Knowledge

## VimTricks.md

## Vim Tips and Tricks

### Using Vim as a Pipe

``` vim
vim - -es +'g/foo/p' +'qa!' --not-a-term
vim < /dev/tty <(cat)
```

### Simple Math

``` vim
CTRL-A - increment number under cursor
CTRL-X - decrement number under cursor
```

### Bouncing

``` vim
Matchit - use g% to find next/previous match
          use % to find match to construct under cursor (if, (, ), {, } etc.
```

### Checking Variables

``` vim
:verbose set variable?
OR
:echo "Variable:" &variable
```

### Formatting

`gq*direction*` will format a line, paragraph, etc. based on *direction*.  You
can also pipe to `fmt` using *range*!}fmt.  Add the -tu or -c to control
indenting, and -p *prefix* to add a prefix.

### Changing Case

``` vim
g<change><motion>
 g = go
 *change* = U Upper, u Lower, ~ Invert
 Doubled *change* means "entire line"
 *motion* = G end of Document, j Line Above, w Word
```

#### Examples

 Command | Effect
 ----------------|----------------
 ~     | Changes the case of current character
 guu   | Change current line from upper to lower.
 gUU   | Change current LINE from lower to upper.
 guw   | Change to end of current WORD from upper to lower.
 guaw  | Change all of current WORD to lower.
 gUw   | Change to end of current WORD from lower to upper.
 gUaw  | Change all of current WORD to upper.
 g~~   | Invert case to entire line
 g~w   | Invert case to current WORD
 guG   | Change to lowercase until the end of document.
 gU)   | Change until end of sentence to upper case
 gu}   | Change to end of paragraph to lower case
 gU5j  | Change 5 lines below to upper case
 gu3k  | Change 3 lines above to lower case

### Non-breaking Space

To find out the character code of the non-breaking space, place the
cursor over it and type use the normal mode command `ga`. Vim will
display a legend at the bottom. Note the hex representation. If the hex
representation is 00a0, then you could execute the following command to
do the substitution:

``` vim
    :%s/\%u00a0/\~/g
```

### Spelling

To turn on spelling:  `:setlocal spell spelllang=en_us`

#### Highlighting

 Name | Description | Highlight
---|---|---
 SpellBad |     word not recognized        | hl-SpellBad
 SpellCap |     word not capitalised    | hl-SpellCap
 SpellRare |  rare word                | hl-SpellRare
 SpellLocal    | wrong spelling for selected region    | hl-SpellLocal

#### Searching for Misspellings

 Command | Effect
 ----------------|----------------
*]s* | Move to next misspelled word after the cursor. A count before the
command can be used to repeat. 'wrapscan' applies.
*[s* | Like *]s* but search backwards, find the misspelled word before the
cursor.  Doesn't recognize words split over two lines, thus may stop at words
that are not highlighted as bad.  Does not stop at word with missing capital
at the start of a line.
*]S* | Like *]s* but only stop at bad words, not at rare words or words for
another region.
*[S* | Like *]S* but search backwards.

#### To add words to your own word list

 Command | Effect
 ----------------|----------------
*zg* | Add word under the cursor as a good word to the first name in
'spellfile'.  A count may precede the command to indicate the entry in
'spellfile' to be used.  A count of two uses the second entry.
*zw* | Like "zg" but mark the word as a wrong (bad) word. If the word already
appears in 'spellfile' it is turned into a comment line.
*zug* *zuw* | Undo *zw* and *zg*, remove the word from the entry in 'spellfile'.

#### Finding suggestions for bad words

* *z=* For the word under/after the cursor suggest correctly spelled
   words.  This also works to find alternatives for a word that is
   not highlighted as a bad word, e.g., when the word after it is
   bad. In Visual mode the highlighted text is taken as the word to
   be replaced. The results are sorted on similarity to the word being
   replaced. This may take a long time.  Hit CTRL-C when you get bored.
* *CTRL-Xs* In Insert mode, when the cursor is after a badly spelled word,
   you can use CTRL-X s to find suggestions.  This works like Insert mode
   completion.  Use CTRL-N to use the next suggestion, CTRL-P to go back.

### Perl

If `vim` is compiled with perl support, you can run perl commands at the ex
command prompt! To see what version of Perl you have: `:perl print $^V` or
`vim --version | grep -i perl`.

Execute Perl command {cmd} for each line in the [range], with \$\_
being set to the text of each line in turn, without a trailing \<EOL\>.
Setting $_ will change the text, but note that it is not possible to
add or delete lines using this command. The default for [range] is the
whole file: "1,$".  Here are some things you can try:

``` vim
:[range]perld[o] {cmd}
:perl $a=1
:perldo $_ = reverse($_);1
:perl VIM::Msg("hello")
:perl $line = $curbuf->Get(42)
```

[//]: #( vim: set ai et nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)