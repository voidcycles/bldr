#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="developer"
pkg_name="expat"
pkg_vers="2.1.0"
pkg_info="Expat is an XML parser library written in C."

pkg_desc="Expat is an XML parser library written in C. It is a stream-oriented parser 
in which an application registers handlers for things the parser might find in the 
XML document (like start tags). "

pkg_file="$pkg_name-$pkg_vers.tar.gz"
pkg_urls="http://prdownloads.sourceforge.net/$pkg_name/$pkg_vers/$pkg_file?download"
pkg_opts="configure"
pkg_reqs="pkg-config/latest zlib/latest"
pkg_uses="tar/latest tcl/latest m4/latest autoconf/latest automake/latest $pkg_reqs"

pkg_cflags="-I$BLDR_LOCAL_PATH/internal/zlib/latest/include"
pkg_ldflags="-L$BLDR_LOCAL_PATH/internal/zlib/latest/lib:-lz"

pkg_cfg=""
pkg_patch=""

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
               --patch       "$pkg_patch"   \
               --cflags      "$pkg_cflags"  \
               --ldflags     "$pkg_ldflags" \
               --config      "$pkg_cfg"

