#      Book of Knowledge

## Vim Tips and Tricks

### Using Vim as a  Pipe:
```
vim - -es +'g/foo/p' +'qa!' --not-a-term
vim < /dev/tty <(cat)
```

### Simple Math
```
CTRL-A - increment number under cursor
CTRL-X - decrement number under cursor
```

### Bouncing
```
Matchit - use g% to find next/previous match
          use % to find match to construct under cursor (if, (, ), {, } etc.
```

[//]: <> (vim: set ai et nu  cindent softtabstop=4 shiftwidth=4 tabstop=4 textwidth=78 filetype=markdown :)
