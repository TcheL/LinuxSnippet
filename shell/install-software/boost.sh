#!/bin/bash
#===============================================================================
# To install boost.
#
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Fri 23 Apr 2021 10:47:44 AM CST
#-------------------------------------------------------------------------------

set -e
# set -x

ver_boost=1.76.0

prefix="${HOME}/software/boost-${ver_boost%.*}"
options=

PYTHON=`which python`
ICUDIR=
export PATH=/path/to/MPI/bin:${PATH}

ver_boost_=${ver_boost//./_}
wget https://dl.bintray.com/boostorg/release/${ver_boost}/source/boost_${ver_boost_}.tar.gz

tar -zpxvf boost_${ver_boost_}.tar.gz

cd boost_${ver_boost_}

./bootstrap.sh --with-python=${PYTHON} --with-icu=${ICUDIR} ${options}
echo "using mpi ;" >> project-config.jam

yon=
echo "================================================================================"
read -p ">> Ensure to start installing boost-${ver_boost}? [Y/n]: " -t 30 yon
if [ "${yon}" == "Y" ]; then
  ./b2 --prefix=${prefix} install
else
  echo ">> Nothing to be installed!"
fi

echo "================================================================================"
echo ">> Finish to install boost_${ver_boost}. \\(^.^)/"
echo "================================================================================"

