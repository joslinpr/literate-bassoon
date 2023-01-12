#	Book of Knowledge
##	GreatHtml.md
###	100 Bytes of CSS to look great everywhere
[Source](https://www.swyx.io/css-100-bytes/)

```
html {
    max-width: 70ch;
    padding: 3em 1em;
    margin: auto;
    line-height: 1.75;
    font-size: 1.25rem;
}
```

###	and 100 more bytes:

```
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

###	Responsive Grid

The following code gives us a responsive grid where the number of columns
is determined by the amount of available space, based on a minimum item
width which is either 350px or 100%, whichever is smaller (using the
min() function — so when the container size is below 350px the cards
will be stacked vertically):

```
.grid {
  grid-template-columns: repeat(auto-fit, minmax(min(350px, 100%), 1fr));
}
```

###	Responsive Flexbox
When you want a component to be flexible; to grow and shrink.
However, You only want the items to take up either 33% or 100% of
the container/parent element's width. The easy part is ensuring the
elements never take up less than 33% or more than 100%.  [Holy Albatross](https://codepen.io/heydon/pen/JwwZaX)
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
