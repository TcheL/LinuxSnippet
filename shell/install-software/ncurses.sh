#!/bin/bash
#===============================================================================
# To install ncurses.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 29 Jul 2021 10:15:32 AM CST
#===============================================================================

set -e
# set -x

toprefix="${HOME}/software"
options="--with-shared"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://invisible-island.net/datafiles/release/ncurses.tar.gz

# unzip
tar -zpxvf ncurses.tar.gz

#---------------------------------------------
ver=`ls -d ncurses-* | awk -F"-" '{print $2}'`
prefix="${toprefix}/ncurses-${ver}"
#---------------------------------------------

# prepare
cd ncurses-${ver}
mkdir mybuild
cd mybuid
../configure --prefix=${prefix} ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing ncurses-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install ncurses-${ver}. \\(^.^)/"
echo "================================================================================"

