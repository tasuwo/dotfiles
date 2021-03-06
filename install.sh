#!/bin/sh

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# シンボリックリンクを作成
# $1: ファイル名
# $2: リンク先ディレクトリ
function link_dotfile() {
    file_name=$1
    to_dir=$2

    from_file=${PWD}/$file_name
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
if [ ! -e ~/.antigen ]; then
    git clone https://github.com/zsh-users/antigen.git ~/.antigen
fi
if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
if [ "$(expr substr $(uname -s) 1 10)" == 'CYGWIN_NT-' ]; then
    link_dotfile .minttyrc    $HOME
fi
link_dotfile .zshrc           $HOME
link_dotfile .zshrc.antigen   $HOME
link_dotfile .gitconfig       $HOME
link_dotfile .gitignore       $HOME
link_dotfile .gitmessage      $HOME
link_dotfile .keysnail.js     $HOME
link_dotfile .screenrc        $HOME
link_dotfile .tmux.conf       $HOME
link_dotfile .eslintrc        $HOME
link_dotfile .tern-config     $HOME
link_dotfile .xvimrc          $HOME
link_dotfile .vimrc           $HOME
link_dotfile .ideavimrc       $HOME
link_dotfile .vrapperrc       $HOME
link_dotfile .alacritty.yml   $HOME
XCODE_KEYBIND_SETTING_DIR="${HOME}/Library/Developer/Xcode/UserData/KeyBindings"
if [ -d "$XCODE_KEYBIND_SETTING_DIR" ]; then
    link_dotfile tasuwo.idekeybindings $XCODE_KEYBIND_SETTING_DIR
fi
CONFIG_DIR="${HOME}/.config"
ln -s ${PWD}/karabiner ${CONFIG_DIR}
launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

echo "Done!"
