
# The Book of Knowledge

- [Dotfiles.md](#dotfilesmd)
- [LinuxDotfiles - DotFiles For Linux/Unix Accounts](#linuxdotfiles---dotfiles-for-linuxunix-accounts)
  - [Directory Structure](#directory-structure)
  - [Installing On A New Server](#installing-on-a-new-server)
    - [Requires Git, .ssh/id_github](#requires-git-sshid_github)
  - [How To](#how-to)
  - [tools to install](#tools-to-install)

## Dotfiles.md

## LinuxDotfiles - DotFiles For Linux/Unix Accounts

### Directory Structure

- Bin/ - Tools
- PerfBin/ - Performance Tools
- PersonalTools/ - Notes To Self, Non-work Tools
- Projects/ - Stuff I'm Working On. Edit .gitignore If You Want Projects
 added To Repo.
- TextBin/ - Tools To Modify Files, Often Using Vim
- .ssh - SSH Public Keys
- .vim - Vim Customization

### Installing On A New Server

#### Requires Git, .ssh/id_github

Create a bare git repository in $HOME/.cfg. A bare repo stores its files
in its base directory, not its subdirectory .git. You'll tell git to
ignore that directory. You'll need your ssh key for the repo to clone it.

### How To

``` bash

REPO=$HOME/.cfg
[ -d $REPO ] || mkdir $REPO
echo ".cfg" >> .gitignore

```

Now clone the dotfiles into your repo

``` bash

git clone --bare git@github.com:joslinpr/LinuxDotfiles.git $REPO
git clone --bare git@git.dhl.com:pjoslin/PPRJLinuxDotfiles.git $REPO

```

Use the "config" command when you're changing your local files. this is
so you can still use "git" on your other projects. this alias is in the
~/.alias file, but we don't have that yet.

``` bash

     alias config='/usr/bin/git --git-dir=$REPO/ --work-tree=$HOME'

```

Don't clutter up your status messages with files you don't care about. see
email and name.

``` bash

config config --global status.showUntrackedFiles no
config config --global user.email "Paul.Joslin@weirdness.com"
config config --global user.name  "Paul R. joslin"
config config --global pull.rebase false  #    merge (the default strategy)

```

Create a branch for this host and checkout.  The checkout copies the
files from the repo into their proper place.

``` bash

TS=$(date +%Y%m%d)
export tS=$(hostname -s).$TS
config checkout -b $TS

```

[Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
[Source](./PersonalTools/GitInstall)

### tools to install

- fdupes - remove duplicate files
- git - configuration control
- glow - terminal markdown viewer
- python markdown - markdown (pip install markdown)
- imagemagick - image processing
- screen - multiplex terminal.  Yes, there are better, but this is what work uses.
- shellCheck - analyze shell scripts.
[Source](PersonalTools/Tools.md)
[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
