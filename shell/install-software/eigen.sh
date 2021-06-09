#!/bin/bash

#===============================================================================
# To install eigen.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 09 Jun 2021 12:19:34 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=3.3.9

prefix="${HOME}/software/eigen-${ver%.*}"
options=

#===============================================================================
# download
wget https://gitlab.com/libeigen/eigen/-/archive/${ver}/eigen-${ver}.tar.gz

# unzip
tar -zpxvf eigen-${ver}.tar.gz

# prepare
cd eigen-${ver}
mkdir mybuild
cd mybuild
cmake ../ -DCMAKE_INSTALL_PREFIX=${prefix} \
  -DINCLUDE_INSTALL_DIR=include/ ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing eigen-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install eigen-${ver}. \\(^.^)/"
echo "================================================================================"

