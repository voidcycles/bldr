#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="spatial"
pkg_name="libspatialindex"

pkg_default="trunk"
pkg_variants=("trunk")
pkg_mirrors=("git://github.com/libspatialindex/libspatialindex.git")

pkg_info="libspatialindex provides a C++ implementation various spatial data structures with a C API."

pkg_desc="libspatialindex provides a C++ implementation various spatial data structures, including R*-tree, an MVR-tree and a TPR-tree 

The purpose of this library is to provide:
* An extensible framework that will support robust spatial indexing methods.
* Support for sophisticated spatial queries. Range, point location, nearest neighbor and k-nearest neighbor as well as parametric queries (defined by spatial constraints) should be easy to deploy and run.
* Easy to use interfaces for inserting, deleting and updating information.
* Wide variety of customization capabilities. Basic index and storage characteristics like the page size, node capacity, minimum fan-out, splitting algorithm, etc. should be easy to customize.
* Index persistence. Internal memory and external memory structures should be supported. Clustered and non-clustered indices should be easy to be persisted.

Features
* Generic main memory and disk based storage managers.
* R*-tree index (also supports linear and quadratic splitting).
* MVR-tree index (a.k.a. PPR-tree).
* TPR-tree index.
* Advanced query capabilities, using Strategy and Visitor patterns.
* Arbitrary shaped range queries, by defining generic geometry interfaces.
* Large parameterization capabilities, including dimensionality, fill factor, node capacity, etc.
* STR packing / bulk loading.
"
pkg_opts="configure enable-static enable-shared force-bootstrap"
pkg_uses="zlib m4 automake autoconf libtool"
pkg_reqs="$pkg_reqs"

pkg_cfg=""
pkg_cflags=""
pkg_ldflags=""

####################################################################################################
# register each pkg version with bldr
####################################################################################################

let pkg_idx=0
for pkg_vers in ${pkg_variants[@]}
do
     pkg_file="$pkg_name-$pkg_vers-$BLDR_TIMESTAMP.tar.gz"
     pkg_host=${pkg_mirrors[$pkg_idx]}
     pkg_urls="$pkg_host"

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

    let pkg_idx++
done

####################################################################################################
