#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="storage"
pkg_name="h5fddsm"

pkg_default="0.9.9"
pkg_variants=("0.9.9")
pkg_mirrors=("https://hpcforge.org/frs/download.php/59")

pkg_info="H5F-DDSM is a Virtual File Driver for HDF5 which uses parallel communication to transfer data between applications using the HDF5 IO API and a distributed shared memory (DSM) buffer."

pkg_desc="H5F-DDSM is a Virtual File Driver for HDF5 which uses parallel communication 
to transfer data between applications using the HDF5 IO API and a distributed shared 
memory (DSM) buffer."

pkg_opts="cmake"
pkg_reqs="szip zlib szip openmpi hdf5-vfd"
pkg_uses="$pkg_reqs"

####################################################################################################
# satisfy pkg dependencies and load their environment settings
####################################################################################################

bldr_satisfy_pkg                \
  --category    "$pkg_ctry"     \
  --name        "$pkg_name"     \
  --version     "$pkg_default"  \
  --requires    "$pkg_reqs"     \
  --uses        "$pkg_uses"     \
  --options     "$pkg_opts"

####################################################################################################

pkg_cflags=""
pkg_ldflags=""

####################################################################################################

pkg_cfg="-DMAKESTATIC=1:-DLINKSTATIC=1"
pkg_cfg="$pkg_cfg:-DMPI_INCLUDE_PATH=$BLDR_OPENMPI_INCLUDE_PATH"
pkg_cfg="$pkg_cfg:-H5FD_DSM_BUILD_FORTRAN=OFF"                                           
pkg_cfg="$pkg_cfg:-H5FD_DSM_BUILD_STEERING=ON"
pkg_cfg="$pkg_cfg:-HDF5_DIR=$BLDR_HDF5_VFD_SHARE_PATH/cmake/hdf5-version"

####################################################################################################
# register each pkg version with bldr
####################################################################################################

let pkg_idx=0
for pkg_vers in ${pkg_variants[@]}
do
    pkg_file="$pkg_name-$pkg_vers.tar.bz2"
    pkg_host=${pkg_mirrors[$pkg_idx]}
    pkg_urls="$pkg_host/$pkg_file"

    bldr_register_pkg                \
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
