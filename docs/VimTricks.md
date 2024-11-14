# The Book of Knowledge

## VimTricks.md

<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [The Book of Knowledge](#the-book-of-knowledge)
  - [VimTricks.md](#vimtricksmd)
  - [Vim Tips and Tricks](#vim-tips-and-tricks)
    - [Using Vim as a Pipe](#using-vim-as-a-pipe)
    - [Simple Math](#simple-math)
    - [Bouncing](#bouncing)
    - [Checking Variables](#checking-variables)
    - [Formatting](#formatting)
    - [Unicode](#unicode)
    - [Changing Case](#changing-case)
      - [Case Change Examples](#case-change-examples)
    - [Patterns with Line Feeds](#patterns-with-line-feeds)
    - [Coalesce Blank Lines](#coalesce-blank-lines)
    - [Non-breaking Space](#non-breaking-space)
    - [Spelling](#spelling)
      - [Highlighting](#highlighting)
      - [Searching for Misspellings](#searching-for-misspellings)
      - [To add words to your own word list](#to-add-words-to-your-own-word-list)
      - [Finding suggestions for bad words](#finding-suggestions-for-bad-words)
    - [Renumbering Lists](#renumbering-lists)
      - [Renumbering using perl](#renumbering-using-perl)
      - [Renumbering using Visual Mode](#renumbering-using-visual-mode)
      - [Renumbering using Macros](#renumbering-using-macros)
      - [Renumbering using External Programs](#renumbering-using-external-programs)
    - [Perl](#perl)

<!-- TOC end -->

<!-- TOC --><a name="vim-tips-and-tricks"></a>

## Vim Tips and Tricks

<!-- TOC --><a name="using-vim-as-a-pipe"></a>

### Using Vim as a Pipe

``` vim

vim - -es +'g/foo/p' +'qa!' --not-a-term
vim < /dev/tty <(cat)

```

<!-- TOC --><a name="simple-math"></a>

### Simple Math

``` vim

CTRL-A - increment number under cursor
CTRL-X - decrement number under cursor

```

<!-- TOC --><a name="bouncing"></a>

### Bouncing

``` vim

Matchit - use g% to find next/previous match
          use % to find match to construct under cursor (if, (, ), {, } etc.

```

<!-- TOC --><a name="checking-variables"></a>

### Checking Variables

``` vim

:verbose set variable?
OR
:echo "Variable:" &variable

```

<!-- TOC --><a name="formatting"></a>

### Formatting

`gq*direction*` will format a line, paragraph, etc. based on *direction*.  You
can also pipe to `fmt` using *range*!}fmt.  Add the -tu or -c to control
indenting, and -p *prefix* to add a prefix.

<!-- TOC --><a name="unicode"></a>

### Unicode

`Ctrl-Vu HEX` will input the unicode characer HEX.  For Example, insert
a ✓ checkmark when in Insert Mode using `Ctrl-Vu2713`.

<!-- TOC --><a name="changing-case"></a>

### Changing Case

``` vim

g<change><motion>
 g = go
 *change* = U Upper, u Lower, ~ Invert
 Doubled *change* means "entire line"
 *motion* = G end of Document, j Line Above, w Word
To turn one line into title caps (title case), make every first letter of a word uppercase:
   :s/\v<(.)(\w*)/\u\1\L\2/g

```

<!-- TOC --><a name="examples"></a>

#### Case Change Examples

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

<!-- TOC --><a name="patterns-with-line-feeds"></a>

### Patterns with Line Feeds

The regex construct "\_" adds the newline character to the character class.
So if `[\s\d]` matches any whitespace or digit, `\_[\s\d]` matches any
whitespace, digit, or linefeed.  You can also literally add `\n` to a class.

<!-- TOC --><a name="coalesce-blank-lines"></a>

### Coalesce Blank Lines

Allow only 1 blank line between regions with non-blank lines: `:v/\S/,/\S/-j`

<!-- TOC --><a name="non-breaking-space"></a>

### Non-breaking Space

To find out the character code of the non-breaking space, place the
cursor over it and type use the normal mode command `ga`. Vim will
display a legend at the bottom. Note the hex representation. If the hex
representation is 00a0, then you could execute the following command to
do the substitution:

``` vim

    :%s/\%u00a0/\~/g

```

<!-- TOC --><a name="spelling"></a>

### Spelling

To turn on spelling:  `:setlocal spell spelllang=en_us`

<!-- TOC --><a name="highlighting"></a>

#### Highlighting

 Name | Description | Highlight
|---|---
 SpellBad |     word not recognized        | hl-SpellBad
 SpellCap |     word not capitalised    | hl-SpellCap
 SpellRare |  rare word                | hl-SpellRare
 SpellLocal    | wrong spelling for selected region    | hl-SpellLocal

<!-- TOC --><a name="searching-for-misspellings"></a>

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

<!-- TOC --><a name="to-add-words-to-your-own-word-list"></a>

#### To add words to your own word list

 Command | Effect
 ----------------|----------------
*zg* | Add word under the cursor as a good word to the first name in
'spellfile'.  A count may precede the command to indicate the entry in
'spellfile' to be used.  A count of two uses the second entry.
*zw* | Like "zg" but mark the word as a wrong (bad) word. If the word already
appears in 'spellfile' it is turned into a comment line.
*zug* *zuw* | Undo *zw* and *zg*, remove the word from the entry in 'spellfile'.

<!-- TOC --><a name="finding-suggestions-for-bad-words"></a>

#### Finding suggestions for bad words

- *z=* For the word under/after the cursor suggest correctly spelled
   replaced. This may take a long time.  Hit CTRL-C when you get bored.
- *CTRL-Xs* In Insert mode, when the cursor is after a badly spelled word,
   you can use CTRL-X s to find suggestions.  This works like Insert mode
   completion.  Use CTRL-N to use the next suggestion, CTRL-P to go back.

<!-- TOC --><a name="renumbering-lists"></a>

### Renumbering Lists

   There are at least four ways to number or renumber lists:

<!-- TOC --><a name="renumbering-using-perl"></a>

#### Renumbering using perl

``` vim

  :perl $a=0
  :40,44 perldo s/^\d/++$a/e

```

<!-- TOC --><a name="renumbering-using-visual-mode"></a>

#### Renumbering using Visual Mode

Make a blockwise, visual selection on the first character of each list
   item: `^<C-V>2j` for 2 lines, etc. Insert a *0.* at the beginning
   of these lines: `I0. <Esc>` Re-select the visual selection (which is
   now all of the 0s) with *gv* `gvg<C-A>` and increment them as a sequence
   *g\<C-A\>*: The entire sequence: `^<C-V>2jI0. <Esc>gvg<C-A>`.

<!-- TOC --><a name="renumbering-using-macros"></a>

#### Renumbering using Macros

Use *\<C-A\>* to increment the line number.
Use *\<C-x\>* to decrement the line number.

``` vim

i                         # insert mode
<ctrl-Y><ctrl-Y><ctrl-Y>  # copy the first few characters from the line above
<ESC>                     # back to normal mode

|                         # go back to the start of the line
<ctrl-A>                  # increment the number
j                         # down to the next line
q                         # stop recording
or
k                         # Previous line
^yWjP                     # yank word, next line, Put
^<ctrl-a>j                # begining of line, increment, next line

```

Now you can play back the recording with @a (the first time; for subsequent times, you can do @@ to repeat the last-executed macro) and it will add a new incremented number to the start of each line.

<!-- TOC --><a name="renumbering-using-external-programs"></a>

#### Renumbering using External Programs

Use `:<RANGE>!nl -ba` or `:%!cat -n` commands which will add line numbers
   to all the lines in *RANGE*. This is not as useful if *RANGE* is
   already numbered

<!-- TOC --><a name="perl"></a>

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

[//]: #( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
