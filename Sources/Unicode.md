# The Book of Knowledge

## Unicode.md

## Tips for Unicode

## Composing Unicode

* [The Official Character Code Charts](https://www.unicode.org/charts/)
* [More Unicode than you knew existed](file:///usr/share/X11/locale/en_US.UTF-8/Compose)

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

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
