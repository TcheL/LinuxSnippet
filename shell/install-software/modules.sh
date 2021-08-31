#!/bin/bash
#===============================================================================
# To install environment-modules.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Tue 31 Aug 2021 03:38:18 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=4.8.0

TclHOME=/path/to/tcl
prefix="${HOME}/software/modules-${ver%.*}"
options=

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://sourceforge.net/projects/modules/files/Modules/modules-${ver}/modules-${ver}.tar.gz/download \
  -O modules-${ver}.tar.gz

# unzip
tar -zpxvf modules-${ver}.tar.gz

# prepare
cd modules-${ver}
./configure --prefix=${prefix} --with-tcl=${TclHOME}/lib ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing environment-modules? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo "Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install modules-${ver}. \\(^.^)/"
echo "================================================================================"

