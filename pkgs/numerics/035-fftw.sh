#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="numerics"
pkg_name="fftw"
pkg_vers="3.3.2"

pkg_info="FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data."

pkg_desc="FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) 
in one or more dimensions, of arbitrary input size, and of both real and complex data 
(as well as of even/odd data, i.e. the discrete cosine/sine transforms or DCT/DST). 
We believe that FFTW, which is free software, should become the FFT library of choice 
for most applications."

pkg_file="$pkg_name-$pkg_vers.tar.gz"
pkg_urls="http://www.fftw.org/$pkg_file"
pkg_opts="configure"
pkg_uses=""
pkg_reqs=""
pkg_cfg="--enable-threads --enable-sse2"

if [ $BLDR_SYSTEM_IS_OSX -eq 0 ]
then
  pkg_cfg="$pkg_cfg --enable-openmp --enable-avx"
fi

pkg_cflags=""
pkg_ldflags=""

####################################################################################################
# build and install pkg as local module
####################################################################################################

bldr_build_pkg --category    "$pkg_ctry"    \
               --name        "$pkg_name"    \
               --version     "$pkg_vers"    \
               --info        "$pkg_info"    \
               --description "$pkg_desc"    \
               --file        "$pkg_file"    \
               --url         "$pkg_urls"    \
               --uses        "$pkg_uses"    \
               --requires    "$pkg_reqs"    \
               --options     "$pkg_opts"    \
               --cflags      "$pkg_cflags"  \
               --ldflags     "$pkg_ldflags" \
               --config      "$pkg_cfg"


