#!/bin/bash
#===============================================================================
# To install mpich.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 01 Dec 2021 10:28:58 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=3.4.2
cmplr=gnu

prefix="${HOME}/software/mpich-${ver}-${cmplr}"
options=

if [ "${cmplr}" == "gnu" ]; then
  export CC=`which gcc`
  export FC=`which gfortran`
  export F77=`which gfortran`
  export CXX=`which g++`
  export FFLAGS="-fallow-argument-mismatch"
elif [ "${cmplr}" == "intel" ]; then
  export CC=`which icc`
  export FC=`which ifort`
  export F77=`which ifort`
  export CXX=`which icpc`
fi

#===============================================================================
# download
wget --no-check-certificate http://www.mpich.org/static/downloads/${ver}/mpich-${ver}.tar.gz

# unzip
tar -zpxvf mpich-${ver}.tar.gz

# prepare
cd mpich-${ver}
mkdir mybuild
cd mybuild
../configure --prefix=${prefix} ${options}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing mpich? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  make -j
  make install
else
  echo "Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install mpich-${ver}. \\(^.^)/"
echo "================================================================================"

