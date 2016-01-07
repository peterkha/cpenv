homedir=~/tmp/homedircopy
rm -rf $homedir
mkdir $homedir
cp ~/.bashrc $homedir/.bashrc
cp ~/.bash_profile $homedir/.bash_profile
cp ~/.gvimrc $homedir/.gvimrc
cp ~/.vimrc $homedir/.vimrc
cp ~/.ctags $homedir/.ctags
cp ~/ctags.cnf $homedir/ctags.cnf

mkdir $homedir/dev
cp ~/dev/cscope-gen $homedir/dev
cp ~/dev/ctags-filegen $homedir/dev

cp -r ~/.vim  $homedir/.vim
cp -r ~/bin $homedir/bin
