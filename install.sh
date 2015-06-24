#!/bin/sh

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# OS 判定
if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    OS='Cygwin'
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

# ファンクション: ファイル "~/.dotfiles" を作成
function create_dotdotfiles() {
    pushd $(dirname $0) >/dev/null
    echo "create: ${HOME}/.dotfiles (DOTFILES_HOME=$PWD)"
    echo "export DOTFILES_HOME=$PWD" >$HOME/.dotfiles
    popd >/dev/null
    . ${HOME}/.dotfiles
}

# シンボリックリンクを作成
# $1: ファイル名
# $2: リンク先ディレクトリ
function link_dotfile() {
    file_name=$1
    to_dir=$2

    from_file=${PWD}/dot$file_name
    to_file=$to_dir/$file_name
    # バックアップ作成
    backup_dir=$to_dir/.dot_backup/
    backup_file=$backup_dir$file_name.$timestamp
    if [ -e $to_file -o -L $to_file ]; then
        echo "move: $to_file => $backup_file"
        mkdir -p $backup_dir
        mv $to_file $backup_file
    fi
    echo "link: $from_file => $to_file"
    mkdir -p $to_dir
    ln -s $from_file $to_file
}

# メイン処理
create_dotdotfiles
if [OS == 'Cygwin']; then
    link_dotfile .minttyrc    $HOME
fi
link_dotfile .zshrc           $HOME
link_dotfile .gitconfig       $HOME
link_dotfile .gitignore       $HOME
link_dotfile .keysnail.js     $HOME
echo "Done(˘ω ˘)"
