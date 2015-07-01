#Install

```
$ cd $HOME
$ git clone https://github.com/tasuwo/dotfiles.git
$ cd dotfiles
$ ~/dotfiles/install.sh
```

#Powerline

Install python.

```bash
brew install python
python --version
pip --version
```

If the version isn't 2.7, you need to modify the path written in `.zshrc`.

Install powerline.

```bash
pip install --user powerline-status
```

If error occured, make `~/.pydistutils.cfg` as follow.

```bash
[install]
prefix=
```

#Powerline-fonts

Install fonts.

```
git clone git@github.com:powerline/fonts.git
open fonts
```

Select and set the favorite font for your terminal.
