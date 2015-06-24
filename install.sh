#!/bin/sh

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

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
if [ "$(expr substr $(uname -s) 1 10)" == 'CYGWIN_NT-' ]; then
    link_dotfile .minttyrc    $HOME
fi
link_dotfile .zshrc           $HOME
link_dotfile .gitconfig       $HOME
link_dotfile .gitignore       $HOME
link_dotfile .keysnail.js     $HOME
echo "Done!"
