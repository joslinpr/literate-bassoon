
# The Book of Knowledge

- [StyleTest.md](#styletestmd)
- [StyleTest, a Markdown example file for testing glow .json style files](#styletest-a-markdown-example-file-for-testing-glow-json-style-files)
  - ["block_quote"](#block_quote)
  - ["code_block"](#code_block)
  - ["code"](#code)
  - ["document"](#document)
  - ["emph"](#emph)
  - ["enumeration"](#enumeration)
  - ["h1"](#h1)
  - ["h2"](#h2)
  - ["h3"](#h3)
  - ["h4"](#h4)
  - ["h5"](#h5)
  - ["heading"](#heading)
  - ["hr"](#hr)
  - ["image"](#image)
  - ["image_text"](#image_text)
  - ["item"](#item)
  - ["link": &   "link_text"](#link----link_text)
  - ["list"](#list)
  - ["paragraph"](#paragraph)
  - ["strikethrough"](#strikethrough)
  - ["strong"](#strong)
  - ["table"](#table)
  - ["task"](#task)
  - ["text"](#text)

## StyleTest.md

## StyleTest, a Markdown example file for testing glow .json style files

### "block_quote"

  > "block_quote": { "color": "200", "indent": 2, "indent_token": " > " }
incididunt ut labore et dolore magna aliqua. Enim praesent elementum
facilisis leo vel. Orci dapibus ultrices in iaculis nunc sed augue lacus
viverra. Felis

### "code_block"

``` html

"code_block": { "color": "10", "theme": "solarized-dark", "margin" : 4 }

```

### "code"

This is inline `"code": { "color": "1", "margin": 4 }`.  This follows inline
code.

### "document"

"document": { "color": "2", "block_prefix": "\n", "block_suffix": "\n" }

### "emph"

"emph": { "color": "3", "italic": true }

### "enumeration"

"enumeration": { "block_prefix": ". " }
1. "item": { "block_prefix": "• " }
  - "item": { "block_prefix": "• " }
1. "item": { "block_prefix": "• " }
  - "item": { "block_prefix": "• " }

### "h1"

"h1": { "prefix": "==> 1 ", "color": "3" }

### "h2"

"h2": { "prefix": "==> 2 ", "color": "3" }

#### "h3"

"h3": { "prefix": "==> 3 ", "color": "3" }

##### "h4"

"h4": { "prefix": "==> 4 ", "color": "3" }

###### "h5"

"h5": { "prefix": "==> 5 ", "color": "3" }

### "heading"

"heading": { "color": "5" }

### "hr"

"hr": { "block_prefix": "---------" }

------

### "image"

"image": { "color": "123", "block_prefix": "[Image: ", "block_suffix": "]" }
![Image](https://charm.sh/logo.png).

### "image_text"

"image_text": { "color": "8" }

### "item"

- "item": { "block_prefix": "• " }
  - "item": { "block_prefix": "• " }
- "item": { "block_prefix": "• " }
  - "item": { "block_prefix": "• " }

### "link": &   "link_text"

"link": { "color": "123", "underline": true, "block_prefix": "(", "block_suffix": ")" }
"link_text": { "color": "123", "bold": true }
At github.com - automatic! [GitHub](http://github.com)

### "list"

"list": { "color": "15",  "level_indent": 4 }

### "paragraph"

"paragraph": { "margin": 4, "color": "5" }
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Enim praesent elementum facilisis
leo vel. Orci dapibus ultrices in iaculis nunc sed augue lacus viverra. Felis
donec et odio pellentesque. Mauris in aliquam sem fringilla ut morbi
tincidunt. Mollis aliquam ut porttitor leo a diam. At erat pellentesque
adipiscing commodo elit at imperdiet. Aliquam faucibus purus in massa. Leo vel
fringilla est ullamcorper eget nulla. Eros donec ac odio tempor orci dapibus.
Volutpat sed cras ornare arcu dui vivamus arcu felis. Dolor purus non enim
praesent elementum facilisis leo vel.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Enim praesent elementum facilisis
leo vel. Orci dapibus ultrices in iaculis nunc sed augue lacus viverra. Felis
donec et odio pellentesque. Mauris in aliquam sem fringilla ut morbi
tincidunt. Mollis aliquam ut porttitor leo a diam. At erat pellentesque
adipiscing commodo elit at imperdiet. Aliquam faucibus purus in massa. Leo vel
fringilla est ullamcorper eget nulla. Eros donec ac odio tempor orci dapibus.
Volutpat sed cras ornare arcu dui vivamus arcu felis. Dolor purus non enim
praesent elementum facilisis leo vel.

### "strikethrough"

~~"strikethrough": { "crossed_out": true }~~

### "strong"

**"strong": { "bold": true }*

### "table"

"table": { "margin": 4 }

Col1 | Col2
--------|----
One | Two
Three | Four

### "task"

- [ ] "task": { "unticked": "__ ", "ticked": "✗  " }
- [x] "task": { "unticked": "__ ", "ticked": "✗  " }

### "text"

- "text": { "color": "2" }

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Enim praesent
elementum facilisis

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=100 filetype=markdown :)
