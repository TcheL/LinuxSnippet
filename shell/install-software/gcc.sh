#!/bin/bash
#===============================================================================
# To install gcc.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 21 Apr 2021 11:55:08 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver_gcc=10.2.0
ver_gmp=6.1.0
ver_mpc=1.0.3
ver_mpfr=3.1.4

debug=on

prefix="${HOME}/software/gcc-${ver_gcc%.*}"
options=

export CC=`which gcc`
export CXX=`which g++`

mirror=http://ftp.tsukuba.wide.ad.jp/software/gcc/
# mirror=https://bigsearcher.com/mirrors/gcc/

#===============================================================================
function tocheck() {
  cat ${1} | grep ${2} | sha512sum -c > /dev/null
  if [ $? -ne 0 ]; then
    echo ">> Failed to check ${2%$} !"
    exit 1
  fi
}

function toinstall() {
  # -pre
  cd ${1}
  rm -rf mybuild
  mkdir mybuild
  cd mybuild
  ../configure --prefix=${prefix} ${options} ${2}
  if [ -n "${debug}" ]; then
    yon=
    echo "================================================================================"
    read -p ">> Ensure to start installing ${1}? [Y/n]: " -t 30 yon
  else
    yon=Y
  fi

  # -do
  if [ "${yon}" == "Y" ]; then
    make -j
    make install
  else
    echo ">> Nothing to be installed!"
  fi

  # -post
  if [ -n "${debug}" ]; then
    echo "================================================================================"
    read -p ">> Finish to install ${1}. Press any key to continue: "
    echo "================================================================================"
  fi
  cd ../../
}

#===============================================================================
# prepare
mkdir -p to_install_gcc
cd to_install_gcc

# download
wget ${mirror}releases/gcc-${ver_gcc}/gcc-${ver_gcc}.tar.gz
wget ${mirror}releases/gcc-${ver_gcc}/sha512.sum -O gcc.sha512.sum
wget ${mirror}infrastructure/gmp-${ver_gmp}.tar.bz2
wget ${mirror}infrastructure/mpfr-${ver_mpfr}.tar.bz2
wget ${mirror}infrastructure/mpc-${ver_mpc}.tar.gz
wget ${mirror}infrastructure/sha512.sum -O infra.sha512.sum

# check
tocheck gcc.sha512.sum   " gcc-${ver_gcc}.tar.gz$"
tocheck infra.sha512.sum " gmp-${ver_gmp}.tar.bz2$"
tocheck infra.sha512.sum " mpfr-${ver_mpfr}.tar.bz2$"
tocheck infra.sha512.sum " mpc-${ver_mpc}.tar.gz$"

# unzip
tar -zpxvf gcc-${ver_gcc}.tar.gz
tar -jpxvf gmp-${ver_gmp}.tar.bz2
tar -jpxvf mpfr-${ver_mpfr}.tar.bz2
tar -zpxvf mpc-${ver_mpc}.tar.gz

# install
export LD_LIBRARY_PATH=${prefix}/lib:$LD_LIBRARY_PATH
toinstall gmp-${ver_gmp}
toinstall mpfr-${ver_mpfr} "--with-gmp=${prefix}"
toinstall mpc-${ver_mpc} "--with-gmp=${prefix} --with-mpfr=${prefix}"
toinstall gcc-${ver_gcc} "--with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix}"

