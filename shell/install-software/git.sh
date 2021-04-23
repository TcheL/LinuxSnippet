#!/bin/bash
#===============================================================================
# To install git.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 21 Apr 2021 21:08:39 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=2.31.1

prefix="${HOME}/software/git-${ver%.*}"

export CC=`which gcc`

#===============================================================================
# download
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-${ver}.tar.gz
wget https://mirrors.edge.kernel.org/pub/software/scm/git/sha256sums.asc

# check
cat sha256sums.asc | grep " git-${ver}.tar.gz$" | sha256sum -c > /dev/null
if [ $? -ne 0 ]; then
  echo ">> Failed to check git-${ver}.tar.gz !"
  exit 1
fi

# unzip
tar -zpxvf git-${ver}.tar.gz

# prepare
cd git-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing git-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -C ../ prefix=${prefix} all doc
  make -C ../ prefix=${prefix} install install-doc install-html
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install git-${ver}. \\(^.^)/"
echo "================================================================================"

