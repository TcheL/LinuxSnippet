#!/bin/bash
#===============================================================================
# To install fftw.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Tue 30 Jul 2024 03:00:22 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=3.3.10
cmplr=gnu

prefix="${HOME}/software/fftw-${ver}-${cmplr}"
options="--enable-shared --enable-openmp"
ncores=4

if [ "${cmplr}" == "gnu" ]; then
  export CC=`which gcc`
  export FC=`which gfortran`
  export F77=`which gfortran`
  export CXX=`which g++`
elif [ "${cmplr}" == "intel" ]; then
  export CC=`which icc`
  export FC=`which ifort`
  export F77=`which ifort`
  export CXX=`which icpc`
fi

#===============================================================================
function toinstall() {
  if [ $# -ge 1 ]; then
    enl=${1}
    exopt="--enable-${enl}"
  else
    enl=
    exopt=
  fi
  echo ">> To install fftw3-${ver}-${enl} ..."
  echo "================================================================================"
  mkdir -p mybuild-${enl}
  cd mybuild-${enl}
  ../configure --prefix=${prefix} ${options} ${exopt}
  make -j${ncores}
  make install
  cd ..
}

#===============================================================================
# download
wget --no-check-certificate http://www.fftw.org/fftw-${ver}.tar.gz
wget --no-check-certificate http://www.fftw.org/fftw-${ver}.tar.gz.md5sum

# check
cat fftw-${ver}.tar.gz.md5sum | md5sum -c > /dev/null
if [ $? -ne 0 ]; then
  echo ">> Failed to check fftw-${ver}.tar.gz!"
  exit 1
fi

# unzip
tar -zpxvf fftw-${ver}.tar.gz

# prepare
cd fftw-${ver}
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing fftw? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  toinstall
  toinstall float
  toinstall long-double
  toinstall quad-precision
else
  echo "Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install fftw-${ver}. \\(^.^)/"
echo "================================================================================"

