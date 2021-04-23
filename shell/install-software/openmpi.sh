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
cmplr=gnu
todir="${HOME}/software/openmpi-${ver}-${cmplr}"
options=

if [ "${cmplr}" == "gnu" ]; then
  export CC=`which gcc`
  export FC=`which gfortran`
  export CXX=`which g++`
elif [ "${cmplr}" == "intel" ]; then
  export CC=`which icc`
  export FC=`which ifort`
  export CXX=`which icpc`
fi

# download
wget https://download.open-mpi.org/release/open-mpi/v${ver%.*}/openmpi-${ver}.tar.gz

# unzip
tar -zpxvf openmpi-${ver}.tar.gz

# prepare
cd openmpi-${ver}
mkdir mybuild
cd mybuild
../configure --prefix=${todir} ${options}

# install
echo "================================================================================"
read -p ">> Ensure to start installing openmpi? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo "Nothing to be installed!"
fi

