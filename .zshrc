# .zshrc


####################
# 環境変数
####################
# 文字コード設定
export LC_ALL="en_US.UTF-8"
# ls したときの色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# 履歴にタイムスタンプ追加
export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
# 履歴の件数を増やす
export HISTSIZE=5000


#################
# 基本設定
#################
# <Tab>による補完機能を利用する
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select
# 大文字，小文字を区別せずに補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
# emacs モードで使用
bindkey -e



#################
# cd強化
#################
# cd先をディレクトリスタックに自動追加
# `cd + <Tsb>` で履歴に移動
DIRSTACKSIZE=100
setopt auto_pushd
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
# ディレクトリが既にスタックに積まれていれば，追加しない
setopt pushd_ignore_dups
# 入力コマンドが存在せず，かつディレクトリ名と一致するなら cd
setopt auto_cd
# cdしたら自動でlsする
function chpwd() {
  [[ $JUST_BEFORE_PWD != $PWD ]] && ls
   JUST_BEFORE_PWD=$PWD
}

#################
# Alias
#################
# -p : ディレクトリの最後に`\`を付加
# -G : 結果を色付きで表示
# -a : ドットファイルを含んだ全てのファイルを表示
# -l : ファイルの詳細(タイプ，パーミッション等)
alias ls='ls -G -p'
alias la='ls -G -p -a'
alias ll='ls -G -p -l'
alias l1='ls -G -1 -p'
alias l1a='ls -G -1 -a -p'
# ... で2つ上移動
alias ...='cd ../..'
# .... で3つ上へ移動
alias ....='cd ../../..'
# その他の Alias
alias e='emacsclient -nw -a '\'''\'''
alias g='git'
# zshmarks
alias bk='bookmark'
alias sb='showmarks'
alias db='deletemark'
alias j='jump'
# cd-gitroot
alias cu='cd-gitroot'
alias c='cd'

#################
# 履歴
#################
# history コマンドで見れる履歴関連
# 保存ファイル
HISTFILE=~/.zsh_history
# メモリへの保存数
HISTSIZE=5000
# ファイルへの保存数
SAVEHIST=5000
# 実行時間を保存
setopt extended_history
# 直前と同じコマンドは保存しない
setopt hist_ignore_dups
# 余分なスペースは削除して保存
setopt hist_reduce_blanks
# !を使って直前のコマンド実行を展開
setopt bang_hist
# プロセス間で履歴を共有
setopt share_history


#################
# 補完
#################
autoload -Uz compinit
compinit -u
# 補完候補一覧表示
setopt auto_list
# 候補をTABで順に切り替え
setopt auto_menu
# 補完候補を詰めて表示
setopt list_packed
# 一覧でファイルの種別をマーク表示
setopt list_types
# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete
# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#################
# fuck
#################
eval "$(thefuck --alias)"


#################
# rbenv
#################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


#################
# 色
#################
autoload colors
colors


#################
# Powerline
#################
export TERM="xterm-256color"
#export PATH=$PATH:~/Library/Python/2.7/bin
#powerline-daemon -q
#. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh


#################
# Antigen
#################
if [ -e ~/.antigen/antigen.zsh ]; then
    source ~/.zshrc.antigen
fi
