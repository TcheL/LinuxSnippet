#!/bin/bash
#===============================================================================
# To install Nomacs.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 27 Apr 2022 10:02:59 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=3.16.224
EXIV2_HOME="${HOME}/software/exiv2"
LIBRAW_HOME="${HOME}/software/libraw"
OPENCV_HOME="${HOME}/software/opencv"

prefix="${HOME}/software/nomacs-${ver%.*}"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://github.com/nomacs/nomacs/archive/refs/tags/${ver}.tar.gz \
  -O nomacs-${ver}.tar.gz

# unzip
tar -zpxvf nomacs-${ver}.tar.gz

# prepare
cd nomacs-${ver}
yon=

export PKG_CONFIG_PATH=${EXIV2_HOME}/lib64/pkgconfig:${PKG_CONFIG_PATH}
export PKG_CONFIG_PATH=${LIBRAW_HOME}/lib/pkgconfig:${PKG_CONFIG_PATH}
export CMAKE_PREFIX_PATH=${OPENCV_HOME}:${CMAKE_PREFIX_PATH}
export CXXFLAGS="-I${LIBRAW_HOME}/include"

# install
echo "================================================================================"
read -p ">> Ensure to start installing nomacs-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  mkdir -p mybuild
  cd mybuild

  cmake -DCMAKE_INSTALL_PREFIX=${prefix} -DENABLE_QUAZIP=false ../ImageLounge/.
  make -j4
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install nomacs-${ver}. \\(^.^)/"
echo "================================================================================"

