#
# 環境変数
#
# 文字コード設定
export LC_ALL="en_US.UTF-8"
# ls したときの色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# 履歴にタイムスタンプ追加
export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
# 履歴の件数を増やす
export HISTSIZE=500

#
# 音
#
# 音は鳴らさない
unsetopt BEEP

#
# 補完
#
# 補完機能を有効にする
autoload -Uz compinit && compinit
# 補完候補をメニュー形式で表示
zstyle ':completion:*:default' menu select
# 大文字，小文字を区別せずに補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 部分一致を有効にする
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=**'
# 補完候補に説明を表示
zstyle ':completion:*:descriptions' format '%B%d%b'
# ディレクトリ名の補完を有効にし、階層を表示する
zstyle ':completion:*:*:(all-|)files' file-sort name
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
# ヒストリ補完を有効にする
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# 補完候補一覧表示
setopt auto_list
# 候補をTABで順に切り替え
setopt auto_menu
# 補完候補を詰めて表示
setopt list_packed
# 一覧でファイルの種別をマーク表示
setopt list_types

#
# 色
#
autoload -U colors && colors

#
# Alias
#
# -p : ディレクトリの最後に`\`を付加
# -G : 結果を色付きで表示
# -a : ドットファイルを含んだ全てのファイルを表示
# -l : ファイルの詳細(タイプ，パーミッション等)
alias ls='ls -G -p'
alias la='ls -G -p -a'
alias ll='ls -G -p -l'
alias l1='ls -G -1 -p'
alias l1a='ls -G -1 -a -p'
# .. で1つ上移動
alias ..='cd ..'
# ... で2つ上移動
alias ...='cd ../..'
# .... で3つ上へ移動
alias ....='cd ../../..'
# その他の Alias
alias g='git'

#
# 履歴
#
# history コマンドで見れる履歴関連
# 保存ファイル
HISTFILE=~/.zsh_history
# メモリへの保存数
HISTSIZE=5000
# ファイルへの保存数
SAVEHIST=5000
# 直前と同じコマンドは保存しない
setopt hist_ignore_dups
# 余分なスペースは削除して保存
setopt hist_reduce_blanks
# プロセス間で履歴を共有
setopt share_history

#
# Vim mode
#
bindkey -v

#
# Prompt
#
# - %F{color}-%f: テキスト色
# - %B-%b: 太字
# - %n: ユーザ名
# - %m: マシン名
# - vcs_info_msg_0_: ブランチ名。vcs_infoによって設定される
#
# Git情報取得のための関数をロードする
autoload -Uz vcs_info
# プロンプト設定内でのコマンド置換、変数展開を有効にする
setopt prompt_subst
# Gitリポジトリの変更監視
zstyle ':vcs_info:git:*' check-for-changes true
# ステージングエリアに変更がある場合は!を表示
zstyle ':vcs_info:git:*' stagedstr "%F{green}+"
# ステージングされていない変更がある場合は+を表示
zstyle ':vcs_info:git:*' unstagedstr "%F{red}!"
# プロンプトのフォーマット
# - %c: ステージングされた変更
# - %u: ステージングされていない変更
# - %b: ブランチ名
zstyle ':vcs_info:*' formats "[%b]%c%u"
# プロンプトのアクション時(リベース/マージ時等)のフォーマット
# - %b: ブランチ名
# - %a: VCSアクション名
zstyle ':vcs_info:*' actionformats '[%b|%a]'
# プロンプト表示の度に実行される関数
# `vcs_info` を毎回呼び出すことで、`vcs_info_msg_0_` の内容を最新にする
precmd () { vcs_info }
# プロンプトカスタマイズ
PROMPT='
%F{cyan}%~%f %(?..%F{red}[✗] %f)$vcs_info_msg_0_
%F{yellow}$%f '

#
# Keybind
#
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank