homedir=~/tmp/homedircopy
rm -rf $homedir
mkdir $homedir
cp ~/.bashrc $homedir/.bashrc
cp ~/.bash_profile $homedir/.bash_profile
cp ~/.gvimrc $homedir/.gvimrc
cp ~/.vimrc $homedir/.vimrc
cp ~/.viminfo $homedir/.viminfo
cp ~/.ctags $homedir/.ctags

cp -r ~/.vim  $homedir/.vim
cp -r ~/bin $homedir/bin
