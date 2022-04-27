
# How to Write A Git Commit Message

[source](https://cbea.ms/git-commit/)

## The seven rules of a great Git commit message

Keep in mind: This has all been said before.

1.  Separate subject from body with a blank line
1.  Limit the subject line to 50 characters
1.  Capitalize the subject line
1.  Do not end the subject line with a period
1.  Use the imperative mood in the subject line
1.  Wrap the body at 72 characters
1.  Use the body to explain what and why vs. how

## Example:
```
Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequences of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

 - Bullet points are okay, too

 - Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
```
## How to Install:
```
# For Dotfiles:
# Copy template to .git config directory
$ cp commit-template.txt ~/.cfg/
# Tell git to use it
$ config config --local commit.template ~/.cfg/commit-template.txt

# For Repos:
$ cd REPO
# Copy template to .git config directory
$ cp commit-template.txt .git/
# Tell git to use it
$ config config --local commit.template .git/commit-template.txt
```