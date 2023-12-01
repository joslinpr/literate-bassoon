# The Book of Knowledge

## GitTips.md

## Odds and Ends for GIT

### List all Files in Repo

If you want to list all the files currently being tracked under the
branch master, you could use this command:

``` bash

git ls-tree -r master --name-only

```

If you want a list of files that ever existed (i.e. including deleted files):

``` bash

git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'

```

### Proxy and Certificates

If you're using a proxy and get an SSL warning, try:

``` bash

 env GIT_SSL_NO_VERIFY=true git ...

```

Git uses the standard environment variables, and proxies can be defined in
config or .gitconfig files.
'
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
