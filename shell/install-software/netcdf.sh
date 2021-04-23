#!/bin/bash
#===============================================================================
# To install netcdf-{c, fortran, cxx}.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Thu 18 Mar 2021 18:12:52 PM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver_c=4.7.4
ver_f=4.5.3
ver_cxx=4.3.1

cmplr=gnu
todir="${HOME}/software/netcdf-${ver_c}-${cmplr}"
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

#===============================================================================
function toinstall() {
  # -pre
  cd netcdf-${1}-${2}
  mkdir mybuild
  cd mybuild
  ../configure --prefix=${todir} ${options} ${3}
  yon=

  # -do
  echo "================================================================================"
  read -p ">> Ensure to start installing ${1}? [Y/n]: " -t 30 yon
  if [ "${yon}" == "Y" ]; then
    make -j
    make install
  else
    echo "Nothing to be installed!"
  fi
  cd ../../

  # -post
  echo "================================================================================"
  read -p ">> Finish to install netcdf-${1}-${2}. Press any key to continue: "
  echo "================================================================================"
}

#===============================================================================
# download
wget https://github.com/Unidata/netcdf-c/archive/v${ver_c}.tar.gz -O netcdf-c-${ver_c}.tar.gz
wget https://github.com/Unidata/netcdf-fortran/archive/v${ver_f}.tar.gz -O netcdf-fortran-${ver_f}.tar.gz
wget https://github.com/Unidata/netcdf-cxx4/archive/v${ver_cxx}.tar.gz -O netcdf-cxx-${ver_cxx}.tar.gz

# unzip
tar -zpxvf netcdf-c-${ver_c}.tar.gz
tar -zpxvf netcdf-fortran-${ver_f}.tar.gz
tar -zpxvf netcdf-cxx-${ver_cxx}.tar.gz

exit
# TODO: to be finished ...

# for c
install c ${ver_c} ""

# for fortran
install fortran ${ver_f} "..."

# for cxx
install cxx ${ver_cxx} "..."

