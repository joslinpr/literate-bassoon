#      Book of Knowledge
##     Tips for Unicode
###    Book of Knowledge

Bash, convert escaped text to unicode

```
$ printf "%b\n"  "\u00e1"
á
$ printf "It is %s%bF\n" 72 "\u00b0"
It is 72°F
# For an entire file:
$ printf '%b\n' "$(<data)"
This is a test
It is 72°F
  ¡ ¢ £ ¤ ¥ ¦ § ¨ ©
```

Convert unicode to escaped text
