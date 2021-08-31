#!/bin/bash
#===============================================================================
# To install Tcl.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Tue 31 Aug 2021 04:04:33 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=8.6.11

prefix="${HOME}/software/Tcl-${ver%.*}"
options=

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://prdownloads.sourceforge.net/tcl/tcl${ver}-src.tar.gz

# unzip
tar -zpxvf tcl${ver}-src.tar.gz

# prepare
cd tcl${ver}/unix
mkdir mybuild
cd mybuild
../configure --prefix=${prefix} ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing Tcl? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo "Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install Tcl-${ver}. \\(^.^)/"
echo "================================================================================"

