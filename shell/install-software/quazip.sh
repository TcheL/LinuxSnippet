#!/bin/bash
#===============================================================================
# To install QuaZIP.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 28 Apr 2022 10:57:35 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=1.3

prefix="${HOME}/software/quazip-${ver}"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://github.com/stachenov/quazip/archive/refs/tags/v${ver}.tar.gz \
  -O quazip-${ver}.tar.gz

# unzip
tar -zpxvf quazip-${ver}.tar.gz

# prepare
cd quazip-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing quazip-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  mkdir -p mybuild
  cd mybuild

  cmake -DCMAKE_INSTALL_PREFIX=${prefix} ..
  make -j4
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install quazip-${ver}. \\(^.^)/"
echo "================================================================================"

