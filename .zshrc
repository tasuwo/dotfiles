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
# emacs モードで使用
bindkey -e


#################
# cd強化
#################
# cd先をディレクトリスタックに自動追加
# `cd + <Tsb>` で履歴に移動
setopt auto_pushd
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
# Git Setting
#   http://qiita.com/mollifier/items/8d5a627d773758dd8078
#################
# # vcs_info 設定
# RPROMPT=""
# autoload -Uz vcs_info
# autoload -Uz add-zsh-hook
# autoload -Uz is-at-least
# autoload -Uz colors
# # 以下の3つのメッセージをエクスポートする
# #   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
# #   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
# #   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
# zstyle ':vcs_info:*' max-exports 3
# zstyle ':vcs_info:*' enable git svn hg bzr

# # 標準のフォーマット(git 以外で使用)
# # misc(%m) は通常は空文字列に置き換えられる
# zstyle ':vcs_info:*' formats '(%s)-[%b]'
# zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
# zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
# zstyle ':vcs_info:bzr:*' use-simple true
# if is-at-least 4.3.10; then
#     # git 用のフォーマット
#     # git のときはステージしているかどうかを表示
#     zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
#     zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
#     zstyle ':vcs_info:git:*' check-for-changes true
#     zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
#     zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
# fi

# # hooks 設定
# if is-at-least 4.3.11; then
#     # git のときはフック関数を設定する
#     # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
#     # のメッセージを設定する直前のフック関数
#     # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
#     # 各関数が最大3回呼び出される。
#     zstyle ':vcs_info:git+set-message:*' hooks \
#            git-hook-begin \
#            git-untracked \
#            git-push-status \
#            git-nomerge-branch \
#            git-stash-count

#     # フックの最初の関数
#     # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
#     # (.git ディレクトリ内にいるときは呼び出さない)
#     # .git ディレクトリ内では git status --porcelain などがエラーになるため
#     function +vi-git-hook-begin() {
#         if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
#             # 0以外を返すとそれ以降のフック関数は呼び出されない
#             return 1
#         fi
#         return 0
#     }

#     # untracked ファイル表示
#     #
#     # untracked ファイル(バージョン管理されていないファイル)がある場合は
#     # unstaged (%u) に ? を表示
#     function +vi-git-untracked() {
#         # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#         if [[ "$1" != "1" ]]; then
#             return 0
#         fi
#         if command git status --porcelain 2> /dev/null \
#                 | awk '{print $1}' \
#                 | command grep -F '??' > /dev/null 2>&1 ; then
#             # unstaged (%u) に追加
#             hook_com[unstaged]+='?'
#         fi
#     }

#     # push していないコミットの件数表示
#     #
#     # リモートリポジトリに push していないコミットの件数を
#     # pN という形式で misc (%m) に表示する
#     function +vi-git-push-status() {
#         # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#         if [[ "$1" != "1" ]]; then
#             return 0
#         fi
#         if [[ "${hook_com[branch]}" != "master" ]]; then
#             # master ブランチでない場合は何もしない
#             return 0
#         fi
#         # push していないコミット数を取得する
#         local ahead
#         ahead=$(command git rev-list origin/master..master 2>/dev/null \
#                        | wc -l \
#                        | tr -d ' ')
#         if [[ "$ahead" -gt 0 ]]; then
#             # misc (%m) に追加
#             hook_com[misc]+="(p${ahead})"
#         fi
#     }

#     # マージしていない件数表示
#     #
#     # master 以外のブランチにいる場合に、
#     # 現在のブランチ上でまだ master にマージしていないコミットの件数を
#     # (mN) という形式で misc (%m) に表示
#     function +vi-git-nomerge-branch() {
#         # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#         if [[ "$1" != "1" ]]; then
#             return 0
#         fi
#         if [[ "${hook_com[branch]}" == "master" ]]; then
#             # master ブランチの場合は何もしない
#             return 0
#         fi
#         local nomerged
#         nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')
#         if [[ "$nomerged" -gt 0 ]] ; then
#             # misc (%m) に追加
#             hook_com[misc]+="(m${nomerged})"
#         fi
#     }

#     # stash 件数表示
#     #
#     # stash している場合は :SN という形式で misc (%m) に表示
#     function +vi-git-stash-count() {
#         # zstyle formats, actionformats の2番目のメッセージのみ対象にする
#         if [[ "$1" != "1" ]]; then
#             return 0
#         fi
#         local stash
#         stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
#         if [[ "${stash}" -gt 0 ]]; then
#             # misc (%m) に追加
#             hook_com[misc]+=":S${stash}"
#         fi
#     }
# fi
# function _update_vcs_info_msg() {
#     local -a messages
#     local prompt
#     LANG=en_US.UTF-8 vcs_info
#     if [[ -z ${vcs_info_msg_0_} ]]; then
#         # vcs_info で何も取得していない場合はプロンプトを表示しない
#         prompt=""
#     else
#         # vcs_info で情報を取得した場合
#         # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
#         # それぞれ緑、黄色、赤で表示する
#         [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
#         [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
#         [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

#         # 間にスペースを入れて連結する
#         prompt="${(j: :)messages}"
#     fi
#     RPROMPT="$prompt"
# }
# add-zsh-hook precmd _update_vcs_info_msg
#################
# Git Setting ends here.
#################


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
# ... で2つ上移動
alias ...='cd ../..'
# .... で3つ上へ移動
alias ....='cd ../../..'
# その他の Alias
alias e='emacsclient -nw -a '\'''\'''
alias g='git'


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
