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

1. If you're using a proxy and get an SSL warning, try:

    ``` bash

    env GIT_SSL_NO_VERIFY=true git ...

    ```

2. If you get the *ssh: connect to host ssh.github.com port 443: Connection
refused* error, You should be using https:// with a personal authentication
token, not ssh.  Then make sure PROXY is set.

Git uses the standard environment variables, and proxies can be defined in
config or .gitconfig files.

## Fixing "fatal: refusing to merge unrelated histories" Error in Git

The error message "fatal: refusing to merge unrelated histories" occurs when
you try to pull changes from a branch that has a different commit history than
your current branch. This can happen if the repository was initialized
separately or if you are trying to merge two completely different
repositories.

### Steps to Fix the Issue

1. **Open your terminal or command prompt.**
2. **Navigate to your local repository** if you haven't already.
3. **Run the following command:**

```bash
git pull origin master --allow-unrelated-histories
```

### Additional Suggestions

- After merging, check your files and resolve any conflicts that may arise.

- Make sure to commit your changes after resolving any conflicts.

- If you're unsure about merging, consider creating a backup branch before proceeding:

``` bash

git checkout -b backup-branch

```

## Fancy Schmancy Git Configurations

Use these examples to customize Git.

``` config
[alias]
 br = branch -l
 fall = fetch --verbose --all
 last = log -1 HEAD
 lg = log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen<%cd> %C(yellow)%an%Creset %Cgreen<%cr> ' --abbrev-commit --date=local
 pall = push --verbose --all
 pg = diff --shortstat
 progress = diff --stat
 st = status -uno
 track = "!f() { ([ $# -eq 2 ] && ( echo \"Setting tracking for branch \" $1 \" -> \" $2;git branch --set-upstream-to $1 $2; ) || ( git for-each-ref --format=\"local: %(refname:short) <--sync--> remote: %(upstream:short)\" refs/heads && echo --Remotes && git remote -v)); }; f"
 tree = !git lg --graph
 uncommit = reset --soft HEAD^
 unstage = reset HEAD
 visual = !gitk
[commit]
 template = ~/.git-template.txt
[credential]
 helper = cache --timeout=3600
[pull]
 rebase = false
[push]
 default = simple
 autoSetupRemote = true
[user]
 name = Paul R. Joslin (Work)
 email = Paul.Joslin@dhl.com
;  vim: set ai cin noet filetype=gitconfig nu nosi sts=8 sw=8 nospell ts=8 tw=78 :
```

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
