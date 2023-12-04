# The Book of Knowledge

   * [GreatHtml.md](#greathtmlmd)
      + [100 Bytes of CSS to look great everywhere](#100-bytes-of-css-to-look-great-everywhere)
      + [and 100 more bytes](#and-100-more-bytes)
      + [Responsive Grid](#responsive-grid)
      + [Responsive Flexbox](#responsive-flexbox)
   * [Tufte CSS](#tufte-css)
      + [Getting Started](#getting-started)

## GreatHtml.md

### 100 Bytes of CSS to look great everywhere

[Source](https://www.swyx.io/css-100-bytes/)

``` bash

html {
    max-width: 70ch;
    padding: 3em 1em;
    margin: auto;
    line-height: 1.75;
    font-size: 1.25rem;
}

```

### and 100 more bytes

``` bash

h1,h2,h3,h4,h5,h6 {
    margin-bottom: 1em;
    margin-top: 3em;
}
p,ul,ol {
    margin-bottom: 2em;
    color: #1d1d1d;
    font-family: sans-serif;
}

```

### Responsive Grid

The following code gives us a responsive grid where the number of columns
is determined by the amount of available space, based on a minimum item
width which is either 350px or 100%, whichever is smaller (using the
min() function — so when the container size is below 350px the cards
will be stacked vertically):

```bash

.grid {
  grid-template-columns: repeat(auto-fit, minmax(min(350px, 100%), 1fr));
}

```

### Responsive Flexbox

[Holy Albatross](https://codepen.io/heydon/pen/JwwZaX)
When you want a component to be flexible; to grow and shrink.
However, You only want the items to take up either 33% or 100% of
the container/parent element's width. The easy part is ensuring the
elements never take up less than 33% or more than 100%.

## Tufte CSS

[Tufte-css](https://edwardtufte.github.io/tufte-css/)

### Getting Started

To use Tufte CSS, copy tufte.css and the et-book directory of font
files to your project directory, then add the following to your HTML
document’s head block:

``` bash

<link rel="stylesheet" href="tufte.css"/>

```

Now you just have to use the provided CSS rules, and the Tufte CSS
conventions described in this document. For best results, View Source
and Inspect Element frequently.
[//]: # ( vim: set ai noet nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
