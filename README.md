# Install

```
$ cd $HOME
$ git clone https://github.com/tasuwo/dotfiles.git
$ cd dotfiles
$ ~/dotfiles/install.sh
```

# Antigen

Manage your shell (zsh) plugins, called bundles.

>[zsh-users/antigen](https://github.com/zsh-users/antigen)

# Powerline

## Install

Install python.

```bash
brew install python
python --version
pip --version
```

If the version isn't 2.7, you need to modify the path written in `.zshrc`.

<!-- Install powerline. -->

<!-- ```bash -->
<!-- pip install --user powerline-status -->
<!-- ``` -->

<!-- If error occured, make `~/.pydistutils.cfg` as follow. -->

<!-- ```bash -->
<!-- [install] -->
<!-- prefix= -->
<!-- ``` -->

>[tmux - Powerline導入例 - Qiita](http://qiita.com/tkhr/items/8cc17c02dea1803be9c6)

## fonts

Install Ricty Font.

``` shell
$ brew tap sanemat/font
$ brew reinstall --with-powerline ricty
$ cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
```

for windows.

>[Windows7&CygwinでRictyフォント生成 - Qiita](http://qiita.com/ll_kuma_ll/items/97b4fa5af8cde9d74d03)

# Theme

for Terminal

>[chriskempson/tomorrow-theme](https://github.com/chriskempson/tomorrow-theme)

for Mintty

>[oumu/mintty-color-schemes](https://github.com/oumu/mintty-color-schemes)
