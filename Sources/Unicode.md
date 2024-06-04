# The Book of Knowled- [The Book of Knowledge](#the-book-of-knowledge)

- [The Book of Knowled- The Book of Knowledge](#the-book-of-knowled--the-book-of-knowledge)
  - [Unicode.md](#unicodemd)
  - [Tips for Unicode](#tips-for-unicode)
  - [Composing Unicode](#composing-unicode)
    - [iconv: convert between encodings](#iconv-convert-between-encodings)
    - [Bash: convert escaped text to unicode](#bash-convert-escaped-text-to-unicode)
    - [Convert unicode to escaped text](#convert-unicode-to-escaped-text)
    - [Vim - Composing](#vim---composing)
    - [Vim - Cut and Paste](#vim---cut-and-paste)

## Unicode.md

## Tips for Unicode

## Composing Unicode

- [The Official Character Code Charts](https://www.unicode.org/charts/)
- [More Unicode than you knew existed](file:///usr/share/X11/locale/en_US.UTF-8/Compose)

### iconv: convert between encodings

Use the ```file``` command to determine the current encoding.  Then use the ```iconv``` command to set a new encoding.

``` bash

$  file GroupList
GroupList: Little-endian UTF-16 Unicode text, with CRLF, CR line terminators
$ iconv  -f utf-16 -t utf-8 GroupList -o GroupList.txt
$  file GroupList.txt
GroupList.txt: UTF-8 Unicode (with BOM) text, with CRLF line terminators)

```

### Bash: convert escaped text to unicode

``` bash

$ printf "%b\n"  "\u00e1"
á
$ printf "It is %s%bF\n" 72 "\u00b0"
It is 72°F
$ printf "%b\n" '\uFF30\uFF21\uFF35\uFF2C'
 ＰＡＵＬ
$ printf "%b\n" '\uFF30\uFF41\uFF55\uFF4C'
 Ｐａｕｌ

#### For an entire file

$ printf '%b\n' "$(<data)"
This is a test
It is 72°F
  ¡ ¢ £ ¤ ¥ ¦ § ¨ ©

```

### Convert unicode to escaped text

``` bash

$:     echo ãçé |
>        while read -n 1 u
>        do [[ -n "$u" ]] && printf '\\u%04x' "'$u"
>        done
\u00e3\u00e7\u00e9

```

### Vim - Composing

To enter Unicode characters in `vim`, you can use the following steps:

1. In command mode, press `Ctrl` + `V`. This will put `vim` into visual block mode.
2. Use the arrow keys to move the cursor to the desired location where you want to enter the Unicode character.
3. Once the cursor is in the desired position, press `u`.
4. Enter the four-digit hexadecimal code for the Unicode character you want to insert. For example, if you want to enter the character 'á' (U+00E1), you would enter `00e1`.
5. Press `Enter` to insert the Unicode character into your `vim` document.

Note: Make sure your `vim` configuration supports Unicode characters.

### Vim - Cut and Paste

Common characters to cut and Paste:

|Name                     | Char | Unicode|
|-------------------------|------|--------|
| CHAR_ARROW_BLOCK_LEFT   | ◀    | 25C0   |
| CHAR_ARROW_BLOCK_RIGHT  | ▶    | 25B6   |
| CHAR_ARROW_HOLLOW_LEFT  | ◁    | 25C1   |
| CHAR_ARROW_HOLLOW_RIGHT | ▷    | 25B7   |
| CHAR_ARROW_POINT_LEFT   | ←    | 2190   |
| CHAR_ARROW_POINT_RIGHT  | →    | 2192   |
| CHAR_CHECK              | ✓    | 2713   |
| CHAR_CIRCLED_STAR       | ✪    | 272A   |
| CHAR_DOUBLE_BACKSLASH   | ⑊    | 244A   |
| CHAR_PISCES             | ♓︎   | 2653   |
| CHAR_QUAD_DIAMOND       | ❖    | 2756   |
| CHAR_SIDEWAYS_HEART     | ❥    | 2765   |
| CHAR_SNOWFLAKE_1        | ✾    | 273E   |
| CHAR_STAR_EMPTY         | ☆    | 2606   |
| CHAR_STAR_FULL          | ★    | 2605   |
| CHAR_WAVY               | ⌇    | 2307   |
| CHAR_X                  | ✗    | 2717   |
| WAVY DDD                | ☷    | 2637   |
| WAVY DDS                | ☴    | 2634   |
| WAVY DSD                | ☵    | 2635   |
| WAVY SDD                | ☶    | 2636   |
| WAVY SDS                | ☲    | 2632   |
| WAVY SSD                | ☱    | 2631   |
| WAVY SSD                | ☳    | 2633   |
| WAVY SSS                | ☰    | 2630   |

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
