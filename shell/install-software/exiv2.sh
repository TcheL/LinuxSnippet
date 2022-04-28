#!/bin/bash
#===============================================================================
# To install exiv2.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 27 Apr 2022 10:17:02 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=0.27.5

prefix="${HOME}/software/exiv2-${ver%.*}"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://github.com/Exiv2/exiv2/archive/refs/tags/v${ver}.tar.gz \
  -O exiv2-${ver}.tar.gz

# unzip
tar -zpxvf exiv2-${ver}.tar.gz

# prepare
cd exiv2-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing exiv2-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  mkdir -p mybuild
  cd mybuild
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ..
  cmake --build .
  cmake --install .
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install exiv2-${ver}. \\(^.^)/"
echo "================================================================================"

