#!/bin/bash
#===============================================================================
# To install OpenCV.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 28 Apr 2022 09:33:38 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=4.5.5

prefix="${HOME}/software/opencv-${ver%.*}"

export CC=`which gcc`
export CXX=`which g++`

#===============================================================================
# download
wget https://github.com/opencv/opencv/archive/${ver}.zip -O opencv-${ver}.zip

# unzip
unzip opencv-${ver}

# prepare
cd opencv-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing opencv-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  mkdir -p mybuild
  cd mybuild

  cmake -DCMAKE_INSTALL_PREFIX=${prefix} ..
  cmake --build .
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install opencv-${ver}. \\(^.^)/"
echo "================================================================================"

