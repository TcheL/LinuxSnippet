#!/bin/bash
#===============================================================================
# To install cmake.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Fri 23 Apr 2021 02:45:54 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=3.20.1

prefix="${HOME}/software/cmake-${ver%.*}"
options=
ncores=4

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://github.com/Kitware/CMake/releases/download/v${ver}/cmake-${ver}.tar.gz
wget https://github.com/Kitware/CMake/releases/download/v${ver}/cmake-${ver}-SHA-256.txt -O cmake-SHA256.txt

# check
cat cmake-SHA256.txt | grep " cmake-${ver}.tar.gz$" | sha256sum -c > /dev/null
if [ $? -ne 0 ]; then
  echo ">> Failed to check cmake-${ver}.tar.gz!"
  exit 1
fi

# unzip
tar -zpxvf cmake-${ver}.tar.gz

# prepare
cd cmake-${ver}
mkdir mybuild
cd mybuild
../bootstrap --parallel=${ncores} --prefix=${prefix}
yon=

# install
gmake
echo "================================================================================"
read -p ">> Ensure to start installing cmake-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install cmake-${ver}. \\(^.^)/"
echo "================================================================================"

