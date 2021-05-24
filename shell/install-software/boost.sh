#!/bin/bash
#===============================================================================
# To install boost.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Fri 23 Apr 2021 10:47:44 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver=1.76.0

prefix="${HOME}/software/boost-${ver%.*}"
options=

PYTHON=`which python`
ICUDIR=
export PATH=/path/to/MPI/bin:${PATH}

#===============================================================================
# download
ver_=${ver//./_}
wget https://boostorg.jfrog.io/artifactory/main/release/${ver}/source/boost_${ver_}.tar.gz

# unzip
tar -zpxvf boost_${ver_}.tar.gz

# prepare
cd boost_${ver_}
./bootstrap.sh --with-python=${PYTHON} --with-icu=${ICUDIR} ${options}
echo "using mpi ;" >> project-config.jam
yon=

# install
echo "================================================================================"
read -p ">> Ensure to start installing boost-${ver}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  ./b2 --prefix=${prefix} install
else
  echo ">> Nothing to be installed!"
fi

# epilogue
echo "================================================================================"
echo ">> Finish to install boost_${ver}. \\(^.^)/"
echo "================================================================================"

