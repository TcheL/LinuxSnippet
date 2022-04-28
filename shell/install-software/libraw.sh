#!/bin/bash
#===============================================================================
# To install LibRaw.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 28 Apr 2022 10:30:10 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=0.20.2

prefix="${HOME}/software/libraw-${ver%.*}"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget --no-check-certificate https://www.libraw.org/data/LibRaw-${ver}.tar.gz

# unzip
tar -zpxvf LibRaw-${ver}.tar.gz

# prepare
cd LibRaw-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing LibRaw-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  mkdir -p mybuild
  cd mybuild

  autoreconf --install ..
  ../configure --prefix=${prefix}
  make -j4
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install LibRaw-${ver}. \\(^.^)/"
echo "================================================================================"

