#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="compression"
pkg_name="szip"

pkg_default="2.1"
pkg_variants=("2.1")

pkg_info="SZIP is an implementation of the extended-Rice lossless compression algorithm."

pkg_desc="SZIP is an implementation of the extended-Rice lossless compression algorithm. 

The Consultative Committee on Space Data Systems (CCSDS) has adopted the extended-Rice 
algorithm for international standards for space applications[1,6,7]. Szip is reported to 
provide fast and effective compression, specifically for the EOS data generated by the 
NASA Earth Observatory System (EOS)[1]. It was originally developed at University of 
New Mexico (UNM) and integrated with HDF4 by UNM researchers and developers. "

pkg_opts="cmake enable-shared enable-static migrate-build-headers migrate-build-source"
pkg_uses="cmake"
pkg_reqs=""

pkg_cflags=""
pkg_ldflags=""
pkg_cfg=""
pkg_cfg_path=""

####################################################################################################
# register each pkg version with bldr
####################################################################################################

for pkg_vers in ${pkg_variants[@]}
do
     pkg_file="$pkg_name-$pkg_vers.tar.gz"
     pkg_urls="http://www.hdfgroup.org/ftp/lib-external/$pkg_name/$pkg_vers/src/$pkg_file"
     pkg_opts="cmake enable-static migrate-build-headers migrate-build-source"

     bldr_register_pkg                 \
          --category    "$pkg_ctry"    \
          --name        "$pkg_name"    \
          --version     "$pkg_vers"    \
          --default     "$pkg_default" \
          --info        "$pkg_info"    \
          --description "$pkg_desc"    \
          --file        "$pkg_file"    \
          --url         "$pkg_urls"    \
          --uses        "$pkg_uses"    \
          --requires    "$pkg_reqs"    \
          --options     "$pkg_opts"    \
          --cflags      "$pkg_cflags"  \
          --ldflags     "$pkg_ldflags" \
          --config      "$pkg_cfg"     \
          --config-path "$pkg_cfg_path"

     pkg_opts="cmake enable-shared migrate-build-headers migrate-build-source keep-existing-install"

     bldr_register_pkg                 \
          --category    "$pkg_ctry"    \
          --name        "$pkg_name"    \
          --version     "$pkg_vers"    \
          --default     "$pkg_default" \
          --info        "$pkg_info"    \
          --description "$pkg_desc"    \
          --file        "$pkg_file"    \
          --url         "$pkg_urls"    \
          --uses        "$pkg_uses"    \
          --requires    "$pkg_reqs"    \
          --options     "$pkg_opts"    \
          --cflags	"$pkg_cflags"  \
          --ldflags     "$pkg_ldflags" \
          --config	"$pkg_cfg"     \
          --config-path "$pkg_cfg_path"
done

####################################################################################################


