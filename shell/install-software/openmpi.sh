#!/bin/bash
#===============================================================================
# To install openmpi.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 18 Mar 2021 16:35:21 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=4.1.0
sha256sum=228467c3dd15339d9b26cf26a291af3ee7c770699c5e8a1b3ad786f9ae78140a
cmplr=gnu

prefix="${HOME}/software/openmpi-${ver}-${cmplr}"
options="--with-ucx=/usr"

if [ "${cmplr}" == "gnu" ]; then
  export CC=`which gcc`
  export FC=`which gfortran`
  export CXX=`which g++`
elif [ "${cmplr}" == "intel" ]; then
  export CC=`which icc`
  export FC=`which ifort`
  export CXX=`which icpc`
fi

#===============================================================================
# download
wget https://download.open-mpi.org/release/open-mpi/v${ver%.*}/openmpi-${ver}.tar.gz

# check
echo "${sha256sum} openmpi-${ver}.tar.gz" | sha256sum -c > /dev/null
if [ $? -ne 0 ]; then
  echo ">> Failed to check openmpi-${ver}.tar.gz!"
  exit 1
fi

# unzip
tar -zpxvf openmpi-${ver}.tar.gz

# prepare
cd openmpi-${ver}
mkdir mybuild
cd mybuild
../configure --prefix=${prefix} ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing openmpi? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo "Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install openmpi-${ver}. \\(^.^)/"
echo "================================================================================"

