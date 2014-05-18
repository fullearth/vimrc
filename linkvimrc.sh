#!/usr/bin/bash

#絶対パス取得
scriptPath=`readlink -f $0`
scriptDir=`dirname $scriptPath`
#echo $scriptDir

#$HOMEに.vimrc,.gvimrcシンボリックリンクを作成
dotfileNames=("vimrc" "gvimrc")

for file in ${dotfileNames[@]};do
  echo $file
  echo "${HOME}/.${file}"
  if [ ! -e "${HOME}/.${file}" ];then
    echo "${HOME}/.${file}"
    ln -s "${scriptDir}/_${file}" "${HOME}/.${file}"
  else
    echo "${HOME}/.${file}が存在するのでバックアップします。-> ${HOME}/old_${file}"
    mv "${HOME}/.${file}" "${HOME}/old_${file}"
    ln -s "${scriptDir}/_${file}" "${HOME}/.${file}"
  fi
done

#neobundle
if [ ! -d "${HOME}/.vim/.bundle/neobundle.vim/" ];then
  git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/.bundle/neobundle.vim
fi
