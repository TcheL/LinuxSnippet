#!/bin/bash
#===============================================================================
# To install git.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 21 Apr 2021 21:08:39 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver_git=2.31.1

prefix="${HOME}/software/git-${ver_git%.*}"

export CC=`which gcc`

wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-${ver_git}.tar.gz
wget https://mirrors.edge.kernel.org/pub/software/scm/git/sha256sums.asc

cat sha256sums.asc | grep " git-${ver_git}.tar.gz$" | sha256sum -c > /dev/null
if [ $? -ne 0 ]; then
  echo ">> Failed to check git-${ver_git}.tar.gz !"
  exit 1
fi

tar -zpxvf git-${ver_git}.tar.gz

cd git-${ver_git}

yon=
echo "================================================================================"
read -p ">> Ensure to start installing git-${ver_git}? [Y/n]: " -t 30 yon

if [ "${yon}" == "Y" ]; then
  make -C ../ prefix=${prefix} all doc
  make -C ../ prefix=${prefix} install install-doc install-html
else
  echo ">> Nothing to be installed!"
fi

echo "================================================================================"
echo ">> Finish to install git-${ver_git}. \\(^.^)/"
echo "================================================================================"

