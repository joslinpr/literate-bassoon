# The Book of Knowledge

## GitCreateRepo.md

## How to Create a Repo from a Directory

- Create Repository in github.com
- Go into the directory containing the project.

``` bash

git init
git add . #    to add all of the relevant files.
git commit
git remote add origin git@git.dhl.com:pjoslin/<repo-name>
git config --global push.default simple
git push --set-upstream origin master
git push

```

## Proxy and Certificates

If you're using a proxy and get an SSL warning, try:

``` bash

 env GIT_SSL_NO_VERIFY=true git ...

```

Git uses the standard environment variables, and proxies can be defined in
config or .gitconfig files.

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
